import math # 로그 계산만을 위한 라이브러리입니다.
DEFAULT_BIAS = 2 ** 28 - 1

class Fnum:
    # 생성자
    def __init__(self, sign, num):
        self.carry = "0"
        self.pNum = num
        self.num = abs(num)
        self.sign = sign
        self.intPart = self.setIntToDec()
        self.fracPart = self.setFrcToDec()
        self.intPart, self.fracPart, self.bias = self.setFloating()
        self.exp = self.initExp()
        self.man = self.initMan()
    
    # 이진수 전용 더하기 메소드입니다. 올림(carry)도 관리합니다.
    def binAdd(self, n1, n2):
        result = int(n1) + int(n2) + int(self.carry)
        if (result == 2):
            self.carry = "1"
            return "0"
        elif (result == 3):
            self.carry = "1"
            return "1"
        else:
            self.carry = "0"
            return str(result)

    # 2의 보수로 만들어주는 메소드입니다.
    def complement(self):
        temp = []
        max = len(self.man)
        for i in range(0, max, 1):
            if (self.man[i] == "0"):
                temp.append("1")
            else:
                temp.append("0")
        # 2의 보수이므로 보수 취한것에 1을 더해준다.
        temp[max-1] = self.binAdd(temp[max-1], "1")
        for i in range(max-2, -1, -1):
            temp[i] = self.binAdd(temp[i], "0")
        # overflow 처리
        if (self.carry == "1"):
            temp.insert(0, self.carry)
            temp.pop()
        return temp
    
    # 정수 부분을 이진수로 만들어주는 메소드입니다.
    def setIntToDec(self):
        n = int(self.num)
        if (n < 1): # 정수 부분이 0보다 작을 시 0만 가지고 있게 한다.
            return "0"
        else:
            cnt = int(math.log2(n))
            temp = ""
            for i in range(cnt, -1, -1):
                temp += str(n >> i & 1)
            return temp

    # 소수 부분을 이진수로 만들어주는 메소드입니다.
    def setFrcToDec(self):
        n = self.num - int(self.num)
        if (n == 0): # 소수 부분이 없을 경우 0만 가지고 있게 한다.
            return "0"
        else:
            tempStr = ""
            tempInt = 0
            while True:
                n *= 2
                tempInt = int(n // 1)
                tempStr += str(tempInt)
                if (n == 1.0):
                    break
                else:
                    n -= tempInt
            return tempStr

    # 부동소수 표현으로 변경해주는 메소드입니다.
    def setFloating(self):
        i = list(self.intPart)
        f = list(self.fracPart)
        bia = DEFAULT_BIAS
        if(self.intPart == "0" and self.fracPart != "0"): # 정수 부분이 0일 경우
            while(i.count("1") == 0): # 정수 부분에 1이 들어가자마자 종료
                i.append(f.pop(0))
                bia -= 1
                i.pop(0)
        else: # 정수 부분이 1일 경우
            while(len(i) > 1): # 정수 부분에 1만 남았을 경우 종료
                f.insert(0, i.pop())
                bia += 1
                if (len(f) > 70):
                    f.pop()
        if(len(f) == 0): # 소수 부분 리스트를 다 썼을 경우 0을 채워준다.
            f.append("0")
        return i, f, bia

    # 지수부(Exponent)를 만들어주는 메소드입니다.
    def initExp(self):
        temp = []
        for i in range(28, -1, -1):
            temp.append(str(self.bias >> i & 1))
        return temp

    # 가수부(Mantissa)를 만들어주는 메소드입니다.
    def initMan(self):
        temp = []
        for i in range(0, len(self.fracPart), 1):
            temp.append(self.fracPart[i])
        for i in range(0, 70 - len(self.fracPart), 1):
            temp.append("0")
        return temp

    # 지수부가 다를 때 지수부를 맞춰주는 메소드입니다.
    def reExp(self, newBias):
        diff = newBias - self.bias
        self.bias = newBias
        self.exp = self.initExp()
        self.man.insert(0, self.intPart.pop())
        self.man.pop()
        self.intPart.append("0")
        for i in range(diff - 1):
            self.man.insert(0, "0")
            self.man.pop()

    # 다시 정규화를 해주는 메소드입니다.
    def normalize(self, newVal):
        self.intPart, self.fracPart, self.bias = self.setFloating()
        self.bias = newVal
        self.exp = self.initExp()
        self.man = self.initMan()
    
    # 보수정수 부분을 보수취해주는 메소드입니다.
    def intCom(self):
        self.man = self.complement()
        if (self.intPart[0] == "0"):
            self.intPart[0] = "1"
        else:
            self.intPart[0] = "0"

# 지수부를 맞춰주기 위해 사전 준비를 하는 함수입니다.
def setMax(fp1:Fnum, fp2:Fnum):
    if (fp1.bias < fp2.bias):
        fp1.reExp(fp2.bias)
        return fp2.bias
    elif (fp1.bias > fp2.bias):
        fp2.reExp(fp1.bias)
        return fp1.bias
    else: # 지수부가 같을 경우
        return fp1.bias

# 100bit의 두 부동소수를 더해주는 함수입니다.
def FADD(fp1:Fnum, fp2:Fnum):
    temp = Fnum(fp1.sign, 0)
    # 0. 두 수의 원본을 더했을 때 0이면 바로 종료
    if (fp1.pNum + fp2.pNum == 0):
        return temp
    # 0. 지수부 맞춰주기
    max = setMax(fp1, fp2)
    # 1. 같은 부호끼리의 연산
    if (fp1.sign == fp2.sign):
        temp.sign = fp1.sign
        # 소수부분 덧셈
        temp.fracPart = ["0" for i in range (70)]
        for i in range(69, -1, -1):         
            temp.fracPart[i] = temp.binAdd(fp1.man[i], fp2.man[i])
        # 정수부분 덧셈
        temp.intPart[0] = temp.binAdd(fp1.intPart[0], fp2.intPart[0])
        # 남은 캐리 처리
        if (temp.carry == "1"):
            temp.intPart.insert(0, temp.carry)
        temp.normalize(max + int(temp.carry)) # 정규화

    # 2. 다른 부호끼리의 연산
    else:
        # 절대값 비교해서 작은 쪽에 보수 취하기 & 정수부분 덧셈
        if (fp1.num > fp2.num):
            temp.sign = fp1.sign
            fp2.intCom()
        else:
            temp.sign = fp2.sign
            fp1.intCom()
        # 소수부분 덧셈
        temp.fracPart = ["0" for i in range(70)]
        for i in range(69, -1, -1):         
            temp.fracPart[i] = temp.binAdd(fp1.man[i], fp2.man[i])
        # 정수부분 덧셈
        temp.intPart[0] = temp.binAdd(fp1.intPart[0], fp2.intPart[0])
        # 보수와 더할 경우 캐리처리 필요X (1+1 = 0이 반복된다)
        temp.normalize(max) # 정규화
    return temp

# 초기 값을 입력받는 함수입니다.
def setNum(order):
    num = float(input("Input {} number --> ".format(order)))
    if (num >= 0):
        sign = 0
    else:
        sign = 1
    return sign, num

# 프로그램 시작점입니다. 출력을 테스트합니다.
if __name__ == '__main__':
    print("=====================INPUTNUM=====================")
    sign1, num1 = setNum("first")
    sign2, num2 = setNum("second")
    fnum1 = Fnum(sign1, num1)
    fnum2 = Fnum(sign2, num2)
    print("\n=======================Num1=======================")
    print("{} --> {}.{} * 2^{}".format(num1, ''.join(fnum1.intPart), ''.join(fnum1.fracPart), fnum1.bias-DEFAULT_BIAS))
    print("sign : {}, exponent : {}, mantissa : {}".format(fnum1.sign, ''.join(fnum1.exp), ''.join(fnum1.man)))
    print("\n=======================Num2=======================")
    print("{} --> {}.{} * 2^{}".format(num2, ''.join(fnum2.intPart), ''.join(fnum2.fracPart), fnum2.bias-DEFAULT_BIAS))
    print("sign : {}, exponent : {}, mantissa : {}".format(fnum2.sign, ''.join(fnum2.exp), ''.join(fnum2.man)))
    print("\n======================RESULT======================")
    result = FADD(fnum1, fnum2)
    print("<Num1 + Num2> = {}".format(num1 + num2))
    print("sign : {}, exponent : {}, mantissa : {}".format(result.sign, ''.join(result.exp), ''.join(result.man)))
