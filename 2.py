a, b, c = input("Insira os lados do triângulo, na forma A B C: ").split()
a,b,c = int(a),int(b),int(c)
if a + b <= c or b + c <= a or a + c <= b:
    print("Triângulo inválido")
elif a == b and b == c:
    print("Triângulo equilátero")
elif a == b or b == c or a == c:
    print("Triângulo isósceles")
else:
    print("Triângulo escaleno")