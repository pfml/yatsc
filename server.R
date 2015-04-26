# YATSC : Yet Another Titanic Survival Calculator
# v0.3 - 20150426 - Pierre Lecointre

library(shiny)
library(randomForest)

titanic <- read.csv("./titanic3.csv")
titanic$rel <- titanic$sibsp + titanic$parch
train <- titanic[,-c(3, 5, 6, 7, 8, 10, 12, 13, 14)]
#train$pclass <- as.factor(train$pclass)
#train$survived <- as.factor(train$survived)
compcases <- complete.cases(train)
train <- train[compcases,]

# Prediction model

fit <- randomForest(as.factor(survived) ~ ., data = train, importance =TRUE, ntree=2000)

# Survival Calculator Function

survPred <- function(pClass, pSex, pFare, pFrom, pRel) {

    test <- train[1, -c(2)]
    test <- rbind(test, data.frame(
        pclass=as.integer(pClass),
        sex=pSex,
        fare=as.numeric(pFare),
        embarked=pFrom,
        rel=as.integer(pRel)))
    test <- test[-1,]
    pred <- predict(fit, test)
    if (pred == 0) {
        response <- "Passenger will most probably not survive"
    }
    else if (pred == 1) {
        response <- "Passenger will most probably survive"
    }
    else {
        response <- "Opps! Let's try again"
    }
    return(response)
}
shinyServer(
    function(input, output) {
        output$inputtClass <- renderText({paste("Passenger class : ", input$tClass)})
        output$inputtSex <- renderText({paste("Passenger gender : ", input$tSex)})
        output$inputtRel <- renderText({paste("Number of relatives aboard : ", input$tRel)})
        output$inputtFare <- renderText({paste("Passenger fare : ", as.numeric(input$tFare))})
        output$inputtFrom <- renderText({paste("Boarding port : ", input$tFrom)})
        output$prediction <- renderText({survPred(input$tClass,input$tSex,input$tFare,input$tFrom,input$tRel)})
    }
)