
df <- rbind(read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_01.csv")), 
            read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_02.csv")))

library('arules')

df <- df[,-1]

res <- vector("numeric")
for (i in 1:nrow(df)) {
  if(df[i,]$Oponentes>df[i,]$Amigos){
    res <- c(res, 0)
  }else{
    res <- c(res, 1)
  }
}

df <- cbind(df, res)

df <- df[,-c(2,3)]

nomes <- df[,1]

dfNomes <- data.frame()

i = 28

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

unicos <- sort(unique(unlist(dfNomes)))

ndf <- data.frame(matrix(ncol = length(unicos), nrow = nrow(dfNomes)))

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

for (i in 1:ncol(ndf)) {
  ndf[,i] <- as.factor(ndf[,i])
}


regras <- apriori(ndf, parameter = list(conf = 0.2, supp = 0.1, target = 'rules', minlen = 3))

inspect(regras, ruleSep = '->', itemSep = '&')

subc <- subset(regras, rhs %in% 'res=0')

inspect(subc, ruleSep = '->', itemSep = '&')
