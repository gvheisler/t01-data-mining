# Trabalho 01 de data mining

## Assunto: Associação


### O que fazer:
Transformar CSVs em one hot encoding

Aplicar o apriori e gerar as regras

Ordenar as regras e analisar elas


### O que foi feito:
* Junção das tabelas
* Transformação dos dados
* Criação de dataframe no formato one-hot-encoding
* Criação de regras de associação


~~~R
  ndf     # dataframe one hot encoding
  dfNomes # dataframe com todos nomes (em partidas apenas com dois amigos a terceira coluna é NA)
  regras  # regras de associação
~~~

### Etapas feitas
* Adicionada coluna para vitoria ou derrota [1 ou 0]
* As pontuações foram retiradas

##### Criação do dfNomes, que contém todos os nomes (cada partida uma linha)
* Separação de todas strings de nomes
* Nomes -> tudo em minusculo
* ç transformado em c
* < e7 > transformado em c (letra bugada mas era um ç no csv)

Se tem 3 nomes, dfNomes fica com a linha cheia

Se tem 2 nomes, dfNomes fica com NA na terceira coluna

##### Criação do One-hot-encoding

### Anotações:
Empate na linha 17 (descartado)


### Conclusões:

##### Melhor jogador individual: yuriko

##### Melhor dupla: jimmy e yuriko

##### Pior dupla: barbara e francois



| lhs                     | -> | rhs      | support   | confidence | coverage  | lift      |
|-------------------------|----|----------|-----------|------------|-----------|-----------|
| {yuriko=1}              | -> | {res=1}  | 0.2500000 | 0.5937500  | 0.4183007 | 1.297768  |
| {jimmy=1, yuriko=1}     | -> | {res=1}  | 0.1250000 | 0.7037037  | 0.1764706 | 1.538095  |
| {barbara=1, francois=1} | -> | {res=0}  | 0.1710526 | 0.7878788  | 0.2156863 | 1.4523549 |
