# YATSC : Yet Another Titanic Survival Calculator
# v0.3 - 20150426 - Pierre Lecointre
library(shiny)

shinyUI(
    fluidPage(
        # Title
        titlePanel("YATSC"),
        helpText("Yet Another Titanic SurvivalCalculator"),
        helpText("This application use a random forest prediction tool to predict the survival of a Titanic passenger, based on some passenger attributes."),
        helpText("Dataset used was obtained from the Department of Biostatistics of Vanderbilt University."),
        # Page
        sidebarLayout(
            # Input zone
            sidebarPanel(
                helpText("Select passenger's attribute, then press Submit"),
                selectInput('tClass', 'Passenger class :', list("1st class passenger" = 1, "2nd class passenger" = 2, "3rd class passenger"= 3)),
                radioButtons('tSex', 'Passenger gender :', c('Male' = 'male', 'Female' = 'female')) ,
                numericInput('tRel', 'Number of relatives Aboard :', 1, min = 0, max = 10, step = 1),
                sliderInput('tFare', 'Fare, in 1912 British Pounds ( 1 pounds approx. actual 125 USD ) :', 15.0, min = 7.0, max = 512.0, step = 5.0),
                radioButtons('tFrom', 'Boarding port :', c('Cherbourg (C)' = 'C', 'Queenstown (Q)' = 'Q', 'Southampton (S)' = 'S')),
                submitButton('Submit')
            ),
            # Results zone
            mainPanel(
                h3('Survival Calculator'),
                h4('Running prediction on a passenger with the following attributes :'),
                textOutput("inputtClass"),
                textOutput("inputtSex"),
                textOutput("inputtRel"),
                textOutput("inputtFare"),
                textOutput("inputtFrom"),
                h4('leads to the following prediction :'),
                verbatimTextOutput("prediction")
            )
        )
    ))