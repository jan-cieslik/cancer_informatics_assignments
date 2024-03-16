# Task 1: Load necessary libraries: readr for reading data, caret for preprocessing and modeling and randomForest for building random forest model

# Task 2: Load the dataset

# Task 3: Split the dataset into training and testing sets. Set seed to 4 for reproducibility. Use 80% of data for the trainingset and the other 20% for the testset. Name it data_train and data_test.

# Task 4: Define predictors and outcome variable. Predictors are all colnames of the dataset minus Status. Status will be the desired outcome variable.

# Task 5: Preprocess the predictors by centering and scaling them using the preProcess function. This standardization ensures that all variables have a mean of 0 and a standard deviation of 1, which can improve the performance of some machine learning algorithms. Call the data preProcValues. Predict also the dataset for training and testing and call it train_transformed and test_transformed. 

# Task 6: Build a random forest model. Ensure that the outcome variable Status is treated as a factor in your dataset. You can do this using the factor() function. Specify the predictors (x), the outcome variable (y), and the number of trees in the forest (ntree = 500). Name it rf_vulvarcancer.
# OOB Estimate of Error Rate: This stands for "Out-of-Bag estimate of error rate" and it's commonly used in ensemble learning methods like Random Forests. It estimates the error rate of the model using data that was not used in training
# Confusion Matrix: A confusion matrix is a table that is often used to describe the performance of a classification model on a set of test data for which the true values are known. Rows represent the actual classes. Columns represent the predicted classes.

# Task 7: Predict on the test set using the predict() function and name it prediction_vulvarcancer. Compute a confusion matrix to evaluate the performance of the model on the test set. The confusion matrix provides information about the model's predictions compared to the actual outcomes. Name it confusion_vulvarcancer.
# The predict function is used to apply a trained model to new, unseen data in order to obtain predictions or classifications. It takes the input data and produces the corresponding output labels or values based on the learned patterns from the training data.
# The confusion matrix is a valuable tool in evaluating the performance of a classification model by summarizing its predictions against the actual labels. 
# Accuracy: The overall accuracy of the model

# Task 8: Plot variable importance using the varImpPlot function and name it plot_vulvarcancer.
# Mean Decrease Gini: This metric represents the average decrease in Gini impurity across all nodes in the decision trees where a particular feature is used for splitting. Higher values indicate greater importance.

