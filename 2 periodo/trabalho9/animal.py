#!/usr/bin/python
# -*- coding: utf-8 -*-
class Animal:
	def __init__(self):
		self._numero_de_patas = 4
		self._rabo = "sim"
		self._pele = "pêlos"
		self._classificacao = "vertebrado"
		self._tipo_de_fecundacao = "Vivíparos"

	def descricao(self):
		variaveis = self.dicionario_de_atributos()
		descricao_ = ""
		for x in variaveis:
			descricao_ += x + ": "+ (str(variaveis[x]) + "\n")
		return descricao_

	def dicionario_de_atributos(self):
		return {"animal": self.__class__.__name__, "Numero de patas": self._numero_de_patas, "Possui Rabo?": self._rabo, "Tipo de pele": self._pele, "Classificação": self._classificacao, "Tipo de fecundacao": self._tipo_de_fecundacao}

class Mamifero(Animal):
	def __init__(self):
		Animal.__init__(self)
		self._numero_de_patas = 2
		self._rabo = "não"
		self._temperatura_corporal_media = "36 graus"

	
	def dicionario_de_atributos(self):
		return {"animal": self.__class__.__name__, "Temperatura médica corporal": self._temperatura_corporal_media, "Numero de patas": self._numero_de_patas, "Possui Rabo?": self._rabo, "Tipo de pele": self._pele, "Classificação": self._classificacao, "Tipo de fecundacao": self._tipo_de_fecundacao}