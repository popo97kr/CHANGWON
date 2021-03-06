library(readxl)
pop=read_excel("C:/Users/user/Desktop/changwon/data/combined.xlsx")
library(caret)
library(dplyr)
set.seed(1715)
pop
pop$pop<-as.numeric(pop$pop)
pop$workpop<-as.numeric(pop$workpop)
a <- scale(pop[,2:4])  
a
summary(a)
pop.kmeans <- kmeans(a, centers = 3, iter.max = 1000)
pop.kmeans$centers
pop$cluster <- as.factor(pop.kmeans$cluster)

b<-pop$cluster
b<-as.array(pop$cluster)
b
qplot(pop,workpop, colour = cluster, data = pop,xlab="인구",ylab="직장")
qplot(pop,facscore, colour = cluster, data = pop,xlab="인구",ylab="시설물")
qplot(workpop,facscore, colour = cluster, data = pop,xlab="직장근처",ylab="시설물")
table(pop$dong,pop$cluster)
library(NbClust)
nc<- NbClust(a, min.nc = 2, max.nc = 15, method = "kmeans")
par(mfrow=c(1,1))
barplot(table(nc$Best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen")


wssplot <- function(data, nc = 15, seed = 1247) {
  wss <- (nrow(data) - 1) * sum(apply(data, 2, var))
  for (i in 2:nc) {
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab = "Number of Clusters",
       ylab = "Within groups sum of squares")}

wssplot(a)

dat=read_excel("C:/Users/user/Desktop/changwon/data/combined.xlsx")
dat<-cbind(dat,b)
write.csv(dat,"C:/Users/user/Desktop/changwon/data/cluster.csv")
dat$pop<-as.numeric(dat$pop)
dat$workpop<-as.numeric(dat$workpop)
dat$facscore<-as.numeric(dat$facscore)

dat

install.packages(c("rgl","car"))
require(car)
dat<-cbind(as.data.frame(scale(dat[2:4])),dat$b)
dat
pop<-dat$pop
work<-dat$workpop
fac<-dat$facscore

dat$'dat$b'
scatter3d(x=pop,y=work,z=fac, 
          groups=dat$'dat$b', grid=FALSE, 
          surface=FALSE, ellipsoid=TRUE, 
          axis.col=c('black','black','black'),
          surface.col = c("#df8c80", "#a1afd3", "#8f9f7d"))
