s1 = input("Insira a palavra ou frase a ser invertida: ")
s2 = ""
for i in range(len(s1)-1, -1, -1):
    s2 += s1[i]
print(f"Palavra invertida: {s2}")