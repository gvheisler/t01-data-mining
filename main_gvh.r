
df <- rbind(read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_01.csv")), 
            read.csv(url("http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_02.csv")))

df <- df[,-1]

for (i in 1:nrow(df)) {
  if(df[i,]$Oponentes==df[i,]$Amigos){
    print(i)
  }
}
