# coursework 2
# =========== Question 2.i - ROC curve of KNN and LDA ========

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


# =========== Question 2.ii - Boxplots  ========

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