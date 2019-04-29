# This will not work
#install.packages('EBImage')

# This will work
#source("http://bioconductor.org/biocLite.R")
#biocLite()
#biocLite("EBImage")

library(EBImage)

# https://cran.r-project.org/web/packages/keras/vignettes/getting_started.html
# Keras is a high-level neural networks API developed with a focus on enabling 
# fast experimentation. Being able to go from idea to result with the least possible 
# delay is key to doing good research.

#install.packages('keras')
library(keras)
pics <- c('p1.jpg', 'p2.jpg', 'p3.jpg', 'p4.jpg', 'p5.jpg', 'p6.jpg',
          'c1.jpg', 'c2.jpg', 'c3.jpg', 'c4.jpg', 'c5.jpg', 'c6.jpg')

mypic <- list()
for (i in 1:12) {mypic[[i]] <- readImage(pics[i])}

# Explore
print(mypic[[1]])
display(mypic[[1]])
display(mypic[[7]])
summary(mypic[[1]])
hist(mypic[[12]])
hist(mypic[[2]])
str(mypic)

# Resize
for (i in 1:12) {mypic[[i]] <- resize(mypic[[i]], 28, 28)}
str(mypic)

# Reshapte
# https://www.rdocumentation.org/packages/reticulate/versions/1.12/topics/array_reshape
for (i in 1:12) {mypic[[i]] <- array_reshape(mypic[[i]], c(28, 28, 3))}
str(mypic)

# Row Bind
trainx <- NULL
for (i in 1:5) {trainx <- rbind(trainx, mypic[[i]])}
str(trainx)

for (i in 7:11) {trainx <- rbind(trainx, mypic[[i]])}
str(trainx)
testx <- rbind(mypic[[6]], mypic[[12]])
trainy <- c(0,0,0,0,0,1,1,1,1,1)
testy <- c(0, 1)


# One Hot Encoding
# One-hot-encoding converts an unordered categorical vector (i.e. a factor) to multiple binarized 
# vectors where each binary vector of 1s and 0s indicates the presence of a class (i.e. level) 
# of the of the original vector.
#
trainLabels <- to_categorical((trainy))
testLabels <- to_categorical(testy)

trainLabels
testLabels

# Model
# The sequential model is a linear stack of layers.
# You create a sequential model by calling the keras_model_sequential() function then a series 
# of layer functions:
  
model <- keras_model_sequential()
model %>%
         layer_dense(units = 256, activation = 'relu', input_shape = c(2352)) %>%
         layer_dense(units = 128, activation = 'relu') %>%
         layer_dense(units = 2, activation = 'softmax')

summary(model)
# 2352 * 256 + 256
# 128 * 256 + 128

# Compile 
model %>%
        compile(loss = 'binary_crossentropy',
                optimizer = optimizer_rmsprop(),
                metrics = c('accuracy'))

# Fit Model
# Trains the model for a given number of epochs (iterations on a dataset).
history <- model %>%
           fit(trainx,
               trainLabels,
               epochs = 30,
               batch_size = 32,
               validation_split = 0.2)


plot(history)

# Evaluation & Prediction - train data
model %>% evaluate(trainx, trainLabels)
pred <- model %>% predict_classes(trainx)
pred

table(Predicted = pred, Actual = trainy)

prob <- model %>% predict_proba(trainx)
prob

cbind(prob, Predected = pred, Actual = trainy)


# Evaluation & Prediction - test data
model %>% evaluate(testx, testLabels)
pred <- model %>% predict_classes((testx))
table(Predicted = pred, Actual = testy)

# Ref: Bharatendra Rai

