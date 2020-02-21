library(caret)
data(GermanCredit)
#data(germancredit)
GermanCredit[,c("Purpose.Vacation","Personal.Female.Single")] <-list(NULL)
set.seed(12)
trainIndex = createDataPartition(GermanCredit$Class, p=0.7, list=FALSE, times=10 )
acc = vector("numeric",10)
for(ii in 1:10){
train.feature= GermanCredit[trainIndex[,ii], -10]
train.label = GermanCredit$Class[trainIndex[,ii]]
test.feature= GermanCredit[-trainIndex[,ii], -10]
test.label= GermanCredit$Class[-trainIndex[,ii]]
fitControl = trainControl(method="repeatedcv", number=5, repeats=2)
set.seed(5)
knnFit = train(train.feature,train.label,method = "knn",trControl=fitControl, preProcess=c("center","scale"), tuneLength=10)
pred= predict(knnFit,test.feature)
acc[ii]=mean(pred==test.label)
}
acc
boxplot(acc)
