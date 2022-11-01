
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
