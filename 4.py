def fatorial(x: int):
    if x == 1 or x == 0:
        return 1
    else:
        return x * fatorial(x-1)

n = int(input("Insira o número cujo fatorial deseja-se ser calculado: "))
print(f"O fatorial de {n} é {fatorial(n)}")