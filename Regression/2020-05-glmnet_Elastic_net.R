library(ggplot2)
library(installr)
library(glmnet)

# lambda is regularization factor
# look at it with CV
set.seed(123)
# read in data
Y_mat <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/Y_Ketamine_MRS.npy")
X_mat <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/X_3_k.npy")

# test and train split from python 
X_train <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/X_train.npy")
X_test <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/X_test.npy")
y_train <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/Y_train.npy")
y_test <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/Y_test.npy")

# standardized in python
X_train_st <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/X_train_st.npy")
X_test_st <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/X_test_st.npy")
y_train_st <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/Y_train_st.npy")
y_test_st <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/Y_test_st.npy")

enet <- glmnet(as.matrix(X_train), y_train)
enet.co <- coef(enet)

# plot x_axis: L1 Norm
plot(enet)
# plot x_axis=lambda
plot(enet, xvar = "lambda", label = TRUE)

plot(enet, xvar = "dev", label = TRUE)

# Cross validation

cvfit = cv.glmnet(as.matrix(X_train), y_train, type.measure = "mse", nfolds = 5, alpha=.5, standardize= TRUE)
# cv lambda with minimal mse:  0.06173035
cvfit$lambda.min
# most regularized model such that error is within one standard error of the minimum: 0.1639612
cvfit$lambda.1se

coef_m=coef(cvfit, s = "lambda.min")

# plot x_axis: L1 Norm
plot(cvfit)
# plot x_axis=lambda
plot(cvfit, xvar = "lambda", label = TRUE)

plot(cvfit, xvar = "dev", label = TRUE)
# predicting beta
coef(cvfit, s = "lambda.min")

print(enet)

rsq = 1 - cvfit$cvm/var(y)

#dev.ratio The fraction of (null) deviance explained (for "elnet", this is the R-square).
#The deviance calculations incorporate weights if present in the model. The deviance is defined to be 2*(loglike_sat - loglike), where loglike_sat is the loglikelihood for the saturated model (a model with a free parameter per observation). Hence dev.ratio=1-dev/nulldev.

cvfit$dev.ratio
##########################################
# glmnet with Standardized data

cvfit = cv.glmnet(as.matrix(X_train_st), y_train_st, type.measure = "mse", nfolds = 5, alpha=.5, standardize= FALSE)
# cv lambda with minimal mse:  0.06173035
cvfit$lambda.min
# most regularized model such that error is within one standard error of the minimum: 0.1639612
cvfit$lambda.1se
plot(cvfit)

y_train_st_r <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/Y_train_st_reshaped.npy")

cvfit_r = cv.glmnet(as.matrix(X_train_st), y_train_st_r, type.measure = "mse", nfolds = 5, alpha=.5, standardize= FALSE)
# cv lambda with minimal mse:  0.06173035
cvfit_r$lambda.min
# most regularized model such that error is within one standard error of the minimum: 0.1639612
cvfit$lambda.1se

plot(cvfit_r)
### 
# cv best lambda so different??
# y input vector? what shape?

lambdas_to_try <- 10^seq(-3, 5, length.out = 100)
cvfitl = cv.glmnet(as.matrix(X_train_st), y_train_st, type.measure = "mse", nfolds = 5, lambda=lambdas_to_try, alpha=.5, standardize= FALSE)
cvfitl$lambda.min
plot(cvfitl)
cvfitlr = cv.glmnet(as.matrix(X_train_st), y_train_st_r, type.measure = "mse", nfolds = 5, lambda=lambdas_to_try, alpha=.5, standardize= FALSE)
cvfitlr$lambda.min

# Use only X as standardized:
cv_fit_X_st=cv.glmnet(as.matrix(X_train_st), y_train, type.measure = "mse", nfolds = 5, lambda=lambdas_to_try, alpha=.5, standardize= FALSE)
coef(cv_fit_X_st, s = "lambda.min")

# 28/05/20: corrected data
y_k <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/Y_Ketamine.npy")
x1_k <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/X_1_Ketamine.npy")
x2_k <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/X_2_Ketamine.npy")

cv_fit=cv.glmnet(as.matrix(x1_k), y_k, type.measure = "mse", nfolds = 5, lambda=lambdas_to_try, alpha=.5, standardize= FALSE)
coef(cv_fit, s = "lambda.min")

cv_fit2=cv.glmnet(as.matrix(x2_k), y_k, type.measure = "mse", nfolds = 5, lambda=lambdas_to_try, alpha=.5, standardize= FALSE)
coef(cv_fit2, s = "lambda.min")

cad <- npyLoad("C:/Users/canlab/Desktop/Masterthesis_python/ReDoneAnalysis20200420/Elastic_net/CADSS_ket.npy")

cv_fit_c=cv.glmnet(as.matrix(x1_k), cad, type.measure = "mse", nfolds = 5, lambda=lambdas_to_try, alpha=.5, standardize= FALSE)
coef(cv_fit_c, s = "lambda.min")