# Machine learning coursewrk 2
## Question 1
### Explain the difference between ‘25-fold cross-validation’ and ‘repeating 5-fold cross-validation 5 times’
Cross validation essentially allows us to compare the efficiency of machine learning models. 

The k-fold Cross Validation approach randomly divides the data into k folds of roughly equal size, in this case 25 folds. Each of the folds is left out in turn and the remaining k-1 folds are used to train the model. The fold that we hold out is our validation set and is predicted. Furthermore, these predictions are summarized into a particular performance measure such as Mean Square Error. We would then repeat this procedure 25 times where each time a different fold is treated as a validation set. Therefore, we would have k (25) estimates of the MSE. Ultimately our ¬k-fold Cross Validation estimate would be the average of these 25 estimates.

Repeated k-fold cross validation will repeat the random sampling in the first step multiple times and then perform k-fold cross validation in each of those instances. for instance, repeating a 5-fold cross-validation five times would involve 5 random 5 fold splits of the traning set into training and validation sets. this is diffferent from performing 25 fold-cross validation which would only involve 1 random split into 25 sections of training and validation sets. 

**References**

Introduction to Statistical Learning (Can professionalize these later)

Applied Predictive Modelling

## Question 2 iv: conclusions
