#!/usr/bin/python
# -*- coding: utf-8 -*-
import re

def nomes_e_idades():
	quit = ""
	dicionario = {}
	while(quit.upper() != "QUIT"):
		quit = raw_input("Digite: 'QUIT' caso deseje sair do programa")
		print(quit.upper())
		if quit.upper() == "QUIT":
			break
		nome = raw_input("\nEntre com seu nome: ")
		idade = raw_input("\nQual sua idade?")
		dicionario[nome] = idade

	print(dicionario)


def e_palindromo(item):
	string_ = str(item)
	string_ = re.sub("[.|,|:]", '', string_)
	string_ = list(''.join(string_.split()))

	array_alterada_reverse = list(reversed(string_))
	if(''.join(string_) == ''.join(array_alterada_reverse)):
		return "palindromo"
	else:
		return "Não é palindromo"

def retornar_sequencia_fibonnacci(numero):
	fibonnaci = []
	for n in range(numero):
		if(len(fibonnaci) in [0]):
			fibonnaci.append(0)
		elif len(fibonnaci) in [1,2]:
			fibonnaci.append(1)
		elif n > 1:
			proximo_n = fibonnaci[-1] + fibonnaci[-2]
			fibonnaci.append(proximo_n)
	print 'Fibonnacci do numero {} é: {}'.format(numero, fibonnaci)

def retorna_numeros_primos(numero):
	numeros_primos = []
	numero_ = numero+1
	for n in range(1, numero_):
		if(numero_e_primo(n) == True):
			numeros_primos.append(n)
	return numeros_primos

def numero_e_primo(numero):
	e_primo = True
	for i in range(2,(numero)):
		if(numero%i) == 0:
			e_primo = False
			return False
		else:
			e_primo = True
	return e_primo



class Calculadora:
	def __init__(self):
		pass

	def somar(self, lista):
		soma = 0
		for x in lista:
			soma+= x
		return soma

	def subtrair(self, lista):
		lista.sort()
		subtrair = lista.pop()
		for x in lista:
			subtrair-= x
		return subtrair

	def multiplicar(self, lista):
		multiplicando = lista[0]
		del(lista[0])
		for multiplicador in lista:
			multiplicando*= multiplicador
		return multiplicando

	def dividir(self, lista):
		dividendo = lista[0]
		del(lista[0])
		for divisor in lista:
			dividendo/= divisor
		return dividendo