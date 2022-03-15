n = int(input("Insira o índice de parada da sequência de Fibonacci: "))
x1 = 1
x2 = 1
prox = 0
if n == 1:
    print("1")
elif n == 2:
    print("1,1")
else:
    s = "1,1"
    for _ in range(n-2):
        prox = x1 + x2
        x1 = x2
        x2 = prox
        s = s + ',' + str(prox)
    print(s)