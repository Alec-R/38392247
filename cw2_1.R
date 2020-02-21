rm(list = ls())
#install.packages("mlbench")
library(mlbench)
library(caret)

data("PimaIndiansDiabetes")
#factorize the last column
PimaIndiansDiabetes$diabetes = factor(PimaIndiansDiabetes$diabetes)
#Scale data
diabetes_scale = scale(PimaIndiansDiabetes[-9])
sd1 = 5  #for creating data
kk = c(3, 5, 7, 9, 11, 13, 15, 17, 19, 21)

#--------creating data----------------
set.seed(sd1)
#Training Index
i_train = createDataPartition(PimaIndiansDiabetes$diabetes, p = 0.7, times = 20)
#Features of Training set
for (i in 1:length(i_train)){
  X_train[i,] = diabetes_scale[i_train[i]]
  
}

X_train = diabetes_scale[i_train$Resample1,]
#Training labels
labels_train = PimaIndiansDiabetes$diabetes[i_train$Resample1]
#Features of Test set
X_test = diabetes_scale[-i_train$Resample1,]
#True labels for test
true_labels = PimaIndiansDiabetes[-i_train$Resample1]

#----------------knn-------------------------------------



