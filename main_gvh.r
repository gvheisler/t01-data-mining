
df <- rbind(read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_01.csv")), 
            read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_02.csv")))

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

for (i in 1:length(nomes)) {
  nm <- unlist(strsplit(nomes[i], ','))
  nm <- tolower(nm)
  nm <- gsub(" ", '', nm)
  dfNomes <- rbind(dfNomes, nm)
  if(length(nm)==2){
    dfNomes[i,3]=NA
  }
}



unicos <- sort(unique(unlist(dfNomes)))

print(unicos)

ndf <- data.frame(matrix(ncol = length(unicos), nrow = nrow(dfNomes)))

colnames(ndf) <- unicos

print(ndf)

for (i in 1:nrow(ndf)){
  for(j in 1:ncol(ndf)){
    ndf[i, j] <- 0
  }
}

for (indice in unicos) {
  for (i in 1:nrow(dfNomes)){
    for(j in 1:ncol(dfNomes)){
      if(dfNomes[i,j]==indice){
        ndf[i, indice] <- 1
      }
    }
  }
}
