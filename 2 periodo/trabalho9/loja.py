class Loja:
	def __init__(self, attrs={}):
		for attr in Loja.attributos().keys():
			if attr not in attrs:
				attrs[attr] = Loja.attributos()[attr][:][1]
		self.properties = attrs

	@classmethod
	def attributos(self):
		import datetime
		return {"nome": ["str", str('')], "especializacao": ["str", str('')], "localizacao": ["str", str('')], "horario_de_inicio_de_expediente": ["datetime", datetime.time( 10,30,0 )], "horario_de_final_de_expediente": ["datetime", datetime.time( 19,30,0 )], "possue_estoque": ["int", int(100)], "limite_do_estoque": ["int", int(100)], "saldo": ["float", 100]}

	def __getattr__(self, name):
		if "properties" in self.__dict__ and name in self.properties:
			return self.properties[name]
		elif(name in Loja.attributos().keys()):
			return self.__dict__[name]
		else:
			return self.__dict__ 

	def __setattr__(self, name, value):
		if "properties" in self.__dict__ and name in self.properties:
			if (name in ["limite_do_estoque", "saldo"]) and float(value) == 0.0:
				print name
				value = 100
			self.properties[name] = value
		else:
			self.__dict__[name] = value

	def estocar(self, valor=0.0, quantidade=0):
		import datetime
		hora_corrente = datetime.datetime.now().time()
		if self.horario_de_inicio_de_expediente > hora_corrente or self.horario_de_final_de_expediente < hora_corrente:
			raise Exception('Loja fechada. Horario de funcionamento de {} as {}'.format(self.horario_de_inicio_de_expediente.strftime("%H:%m"), self.horario_de_final_de_expediente.strftime("%H:%m")))
		if(isinstance(valor, numbers.Real) and isinstance(quantidade, numbers.Real)):
			self.properties["limite_do_estoque"] += quantidade
			self.properties["saldo"] += valor


	def vender_produto(self, valor=0.0, quantidade=0):
		import datetime
		hora_corrente = datetime.datetime.now().time()
		if self.horario_de_inicio_de_expediente > hora_corrente or self.horario_de_final_de_expediente < hora_corrente:
			raise Exception('Loja fechada. Horario de funcionamento de {} as {}'.format(self.horario_de_inicio_de_expediente.strftime("%H:%m"), self.horario_de_final_de_expediente.strftime("%H:%m")))
		if(isinstance(valor, numbers.Real) and isinstance(quantidade, numbers.Real) and not(self.properties["limite_do_estoque"] < quantidade or self.properties["saldo"] < valor)):
			self.properties["limite_do_estoque"] -= quantidade
			self.properties["saldo"] -= valor
		elif (self.properties["limite_do_estoque"] < quantidade or self.properties["saldo"] < valor):
			raise Exception("Limite de estoque ou saldo excedidos!\n" + "Limite do estoque: " + str(self.properties["limite_do_estoque"]) + "\nSaldo: " + str(self.properties["saldo"]))