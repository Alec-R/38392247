rm(list = ls())
#install.packages("mlbench")
library(mlbench)
library(caret)

data("PimaIndiansDiabetes")
#factorize the last column
PimaIndiansDiabetes$diabetes = factor(PimaIndiansDiabetes$diabetes)
#Scale data ------not used anymore
#diabetes_scale = scale(PimaIndiansDiabetes[-9])
sd = 10  #for creating data
kk = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21)

#--------creating data----------------
set.seed(sd)
#Training Index
i_train = createDataPartition(PimaIndiansDiabetes$diabetes, p = 0.7, times = 20, list = F)

acc = vector("numeric", 10)
knnGrid = expand.grid(k = kk)
for (i in 1:dim(i_train)[2]){
  X_train = PimaIndiansDiabetes[i_train[, i], -9]
  label_train = PimaIndiansDiabetes[i_train[, i], 9]
  y_test = PimaIndiansDiabetes[-i_train[, i], -9]
  label_test = PimaIndiansDiabetes[-i_train, 9]
  #knn classifier
  set.seed(sd)
  fitControl = trainControl(method = "repeatedcv", 
                            number = 5, 
                            repeats = 5,
                            summaryFunction = twoClassSummary, 
                            classProbs = TRUE)
  set.seed(sd)
  knnFit = train(X_train, label_train, method = "knn", 
                 trControl = fitControl, 
                 metric = "ROC",
                 preProcess = c("center","scale"), 
                 tuneGrid = knnGrid)
}
knnFit

#----------




