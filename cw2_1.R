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

# -------- creating data ----------------
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

# -------- Question 2.i - ROC curve of KNN and LDA --------

library(pROC) 

# ROC curve for KNN
knn.pred <- predict(knnFit,test.feature)
knn.probs <- predict(knnFit,test.feature,type="prob")
# create ROC curve point vector with probabilities
knn.ROC <- roc(predictor=knn.probs$Bad, response=test.label,
               levels=rev(levels(test.label)))

# ROC curve for lda
lda.pred <- predict(ldaFit,test.feature) confusionMatrix(lda.pred,test.label)
lda.probs <- predict(ldaFit,test.feature,type="prob")
# create ROC curve point vector
lda.ROC <- roc(predictor=lda.probs$Bad, response=test.label, 
               levels=rev(levels(test.label)))

# Plot for the KNN ROC and the LDA ROC
# Grouping both plot elements for clarity
plot(knn.ROC,main="ROC curve", col="black")
lines(lda.ROC,col="blue") ## add a line to previous plot 
# plot legend
legend("bottomright",legend=c("kNN","LDA"),
       col=c("black","blue"),
       lty=c(1,1),cex=1,text.font=2)


# -------- Question 2.ii - Boxplots --------

pred=predict(knnFit,test.feature) 
acc[ii]=mean(pred==test.label) #accuracy vectors
ti1 = c("KNN", "LDA") # resp names for accuracy vectors

acc <- c(KNNacc,LDAacc) # accuracy matrix for boxplot
# Boxplot for both vectors
featurePlot(x = acc,# maybe add if error [,]
            y = ti1, # idem
            plot = "box",
            ## Pass in options to bwplot() 
            scales = list(y = list(relation="free"),
                          x = list(rot = 90)),  # ?? vertical boxplot ?
            layout = c(2,1 ), 
            auto.key = list(columns = 2))

# end


