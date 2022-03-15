n = int(input("Insira o número cujo fatorial deseja-se ser calculado: "))
x = 1
for i in range(1,n+1):
    x = x * i
print(f"O fatorial de {n} é {x}")