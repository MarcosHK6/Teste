class Triangulo:
    def __init__(self, a, b, c):
        self.a = a
        self.b = b
        self.c = c
    
    def valido(self):
        return (self.a + self.b > self.c and self.b + self.c > self.a and self.a + self.c > self.b)
        
    def classificacao(self):
        if self.a == self.b and self.b == self.c:
            return "Triângulo equilátero"
        elif self.a == self.b or self.b == self.c or self.a == self.c:
            return "Triângulo isósceles"
        else:
            return "Triângulo escaleno"

a, b, c = input("Insira os lados do triângulo, na forma A B C: ").split()
a,b,c = int(a),int(b),int(c)
t = Triangulo(a,b,c)
if not t.valido():
    print("Triângulo inválido")
else:
    print(t.classificacao())