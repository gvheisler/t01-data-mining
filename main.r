
df <- rbind(read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_01.csv")), 
            read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_02.csv")))

library('arules')

####
#exclusao da coluna de numero da partida
####
df <- df[,-1]

####
#criacao da coluna de vitoria/derrota
####
res <- vector("numeric")
for (i in 1:nrow(df)) {
  if(df[i,]$Oponentes>df[i,]$Amigos){
    res <- c(res, 0)
  }else{
    res <- c(res, 1)
  }
}

####
#adicionando coluna de resultados no df e retirando as coulas de pontos
####
df <- cbind(df, res)
df <- df[,-c(2,3)]



####
#tratamento da coluna de nomes, separando em um novo df
####
nomes <- df[,1]
dfNomes <- data.frame()
for (i in 1:length(nomes)) {
  nm <- unlist(strsplit(nomes[i], ','))
  nm <- tolower(nm)
  nm <- gsub(" ", '', nm)
  nm <- gsub("ç", 'c', nm)
  nm <- gsub("<e7>", 'c', nm)
  if(length(nm)==3){
    dfNomes <- rbind(dfNomes, nm)
  }else if(length(nm)==2){
    nm[[3]]=NA
    dfNomes <- rbind(dfNomes, nm)
  }
}


####
#Criação one-hot-encoding
####

unicos <- sort(unique(unlist(dfNomes)))
ndf <- data.frame(matrix(ncol = length(unicos),
                         nrow = nrow(dfNomes)))
colnames(ndf) <- unicos

for (i in 1:nrow(ndf)){
  for(j in 1:ncol(ndf)){
    ndf[i, j] <- 0
  }
}

for (indice in unicos) {
  for (i in 1:nrow(dfNomes)){
    for(j in 1:ncol(dfNomes)){
      if(!is.na(dfNomes[i,j])){
        if(dfNomes[i,j]==indice){
          ndf[i, indice] <- 1
        }
      }
    }
  }
}

ndf <- cbind(ndf, res)

for (j in 1:ncol(ndf)) {
  ndf[,j] <- as.factor(ndf[,j])
}

####
#criacao de regras e subset
####
regras <- apriori(ndf, parameter = list(conf = 0.5, supp = 0.1, 
                     target = 'rules', minlen = 2, maxlen = 2))
regras <- sort(regras, by = 'confidence')
inspect(regras, ruleSep = '->', itemSep = '&')

subc <- subset(regras, (rhs %in% 'res=1'))
subc <- sort(subc, by = 'confidence')
inspect(subc)

