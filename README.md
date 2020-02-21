# Machine learning coursewrk 2
## Question 1
### Explain the difference between ‘25-fold cross-validation’ and ‘repeating 5-fold cross-validation 5 times’
Cross validation essentially allows us to compare the efficiency of machine learning models. 

The n-fold Cross Validation approach randomly divides the data into n folds of roughly equal size, in this case 25 folds. Each of the folds is left out in turn and the remaining n-1 folds are used to train the model. The fold that we hold out is our validation set and is predicted by our knn predictor. We would then repeat this procedure 25 times where each time a different fold is treated as a validation set, and the remaining ones as the training sets. Finally, for each different k value, these predictions are summarized into a particular performance measure such as Mean Square Error, which would be the average of the squared errors associated to that k, and on the basis of this measure an optimal k is selected. 

Repeated k-fold cross validation will repeat the random sampling in the first step multiple times and then perform k-fold cross validation in each of those instances. For instance, repeating a 5-fold cross-validation five times would involve 5 random 5 fold splits of the traning set into training and validation sets from which we could obtain 5 different accuracy measures. this is diffferent from performing 25 fold-cross validation which would only involve 1 random split into 25 sections of training and validation sets. 

**References**

Introduction to Statistical Learning (Can professionalize these later)

Applied Predictive Modelling

## Question 2 iv: conclusions
