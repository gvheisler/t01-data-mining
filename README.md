# Trabalho 01 de data mining

## Assunto: Associação

### [Documento no overleaf](https://www.overleaf.com/5131289339zkcqdtmyxnqw)

### O que fazer:
Transformar CSVs em one hot encoding
Aplicar o apriori e gerar as regras
Ordenar as regras e analisar elas


### O que foi feito:
* Junção das tabelas
* Transformação dos dados
* Criação de dataframe no formato one-hot-encoding
* Criação de regras de associação (porém com problemas)


~~~R
  ndf     # dataframe one hot encoding
  dfNomes # dataframe com todos nomes (partidas apenas com dois amigos a terceira coluna é NA)
  regras  # regras de associação
~~~

### Etapas feitas
* Adicionada coluna para vitoria ou derrota [1,0]
* As pontuações foram retiradas

##### Criado dfNomes, que contém todos os nomes (cada partida uma linha)
* Separação de todas strings de nomes
* Nomes -> tudo em minusculo
* ç transformado em c
* <e7> transformado em c (letra bugada mas era um ç no csv)
Se tem 3 nomes, dfNomes fica com a linha cheia
Se tem 2 nomes, dfNomes fica com NA na terceira coluna

##### Criação do One-hot-encoding

### Anotações:
Empate na linha 17 (atualmente tratado como vitoria)