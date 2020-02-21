rm(list = ls())
#install.packages("mlbench")
library(mlbench)
library(caret)
library(MASS)    # if use lda()
#install.packages("pROC")
library(pROC)    #if use .auc

data("PimaIndiansDiabetes")
#factorize the last column
PimaIndiansDiabetes$diabetes = factor(PimaIndiansDiabetes$diabetes)
#Scale data ------not used anymore------P4 knnvslda
#diabetes_scale = scale(PimaIndiansDiabetes[-9])
sd1 = 100  #for creating data
sd2 = 75
sd3 = 0.674558976321

#to see if the auc increases as kk increases
kk = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 47, 49)
#ROC was used to select the optimal model using the largest value.
#The final value used for the model was k= 43. Good!!!
#kk = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21)
#------------creating data----------------

set.seed(sd1)
#Training Index
i_train = createDataPartition(PimaIndiansDiabetes$diabetes, p = 0.7, times = 20, list = F)

#-------------Tune k----------------------------
knnGrid = expand.grid(k = kk)
for (i in 1:dim(i_train)[2]){
  X_train = PimaIndiansDiabetes[i_train[, i], -9]
  label_train = PimaIndiansDiabetes[i_train[, i], 9]
  #knn classifier
  set.seed(sd2)
  fitControl = trainControl(method = "repeatedcv", 
                            number = 5, 
                            repeats = 5,
                            summaryFunction = twoClassSummary, 
                            classProbs = T)
  set.seed(sd3)
  knnFit = train(X_train, label_train, method = "knn", 
                 trControl = fitControl, 
                 metric = "ROC",
                 preProcess = c("center","scale"), 
                 tuneGrid = knnGrid)
 #auc??
 #roc_knn = knnFit$results[, 2]
}
knnFit

#------------knn prediction--------------
#roc_knn = vector("numeric", 20)
#auc_knn = vector("numeric", 20)
for(i in 1:dim(i_train)[2]){
  #Test Featurs and Test labels
  y_test = PimaIndiansDiabetes[-i_train[, i], -9]
  label_test = PimaIndiansDiabetes[-i_train[, i], 9]
  #knn prediction
  knn_pred = predict(knnFit, y_test)
  #confusion matrix ---> name it?
  confusionMatrix(knn_pred, label_test) 
  #prob for classify
  knn_probs = predict(knnFit, y_test, type="prob") 
  head(knn_probs)
  #ROC
  # 'Positive' Class : neg
  #response and levels ; controls and classes
  roc_knn = roc(predictor = knn_probs$neg, response = label_test, 
                levels = rev(levels(label_test))) 
  ## ERROR!!! Setting direction: controls ? cases
  roc_knn
  auc_knn = roc_knn$auc
  auc_knn
}
#ERROR!!!Setting direction: controls > cases

#------------------LDA Prediction--------------------
for(i in 1:dim(i_train)[2]){
  X_train = PimaIndiansDiabetes[i_train[, i], -9]
  label_train = PimaIndiansDiabetes[i_train[, i], 9]
  #Test Featurs and Test labels
  y_test = PimaIndiansDiabetes[-i_train[, i], -9]
  label_test = PimaIndiansDiabetes[-i_train[, i], 9]
  #lda classifier
  ldaFit = train(X_train, label_train, method = "lda",
               trControl = trainControl(summaryFunction = twoClassSummary, 
                                        classProbs = T),
               #preProcess = c("center","scale")
               )
  ldaFit
  #LDA prediction
  lda_pred = predict(ldaFit, y_test)
  confusionMatrix(lda_pred, label_test)
  #probabilities
  lda_probs = predict(ldaFit, y_test, type = "prob")
  head(lda_probs)
  lda_roc = roc(predictor = lda_probs$neg, 
                response = label_test,
                levels = rev(levels(label_test)))
  lda_auc = lda_roc$auc
}
#----------




