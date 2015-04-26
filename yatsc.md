YATSC : Yet Another Titanic Survival Calculator
========================================================
author: Pierre Lecointre
date: 20150426
transition: rotate

<small>
Shiny application and RStudio Presenter developped as an assignment for the
"Developping Data products" course taught on Coursera by John Hopkins University.
</small>

Titanic passenger survival prediction
========================================================

**Titanic** was a British passenger liner that sank in Northen Atlantic in 1912, after a collision with an iceberg, occuring more than 1,500 fatalities.

It is said that "Women and children first" was not the only determinant of passenger survivability. In particular, class seems an important determinant.

In order to set up a Titanic survival calculator, I will use the dataset `titanic3`, an updated and improved `titanic` (thanks to Thomas Cason) dataset, available on the website of the department of biostatistics of Vanderbilt University :  
http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3.csv

Summary of dataset
========================================================


<small>
The dataset `titanic3` contains 1309 records of 14 variables :

```
 [1] "pclass"    "survived"  "name"      "sex"       "age"      
 [6] "sibsp"     "parch"     "ticket"    "fare"      "cabin"    
[11] "embarked"  "boat"      "body"      "home.dest"
```

Some variables contains a high number of missing values (263 for the variable `age`).

So, the prediction will only be based on `pclass`, `sex`, `fare`, `embarked` and a new variable `rel`, number of relatives aboard, sum of `sibsp` and `parch`.

***


```
  pclass survived                           name    sex   age sibsp parch
1      1        1  Allen, Miss. Elisabeth Walton female 29.00     0     0
2      1        1 Allison, Master. Hudson Trevor   male  0.92     1     2
3      1        0   Allison, Miss. Helen Loraine female  2.00     1     2
  ticket     fare   cabin embarked boat body
1  24160 211.3375      B5        S    2   NA
2 113781 151.5500 C22 C26        S   11   NA
3 113781 151.5500 C22 C26        S        NA
                        home.dest
1                    St Louis, MO
2 Montreal, PQ / Chesterville, ON
3 Montreal, PQ / Chesterville, ON
```
</small>
Prediction calculation
========================================================

Using library `randomForest`, I have fitted a random forest model on the revised `titanic3` dataset named `train`: 

```r
fit <- randomForest(as.factor(survived) ~ ., data = train, importance =TRUE, ntree=2000)
```

A `predict` function accepts the user input as new data, and returns the prediction as a binomial factor (will survive / will not survive), sent to the UI by the `server` object.

Prediction Results
===
The interactive shiny application can be accessed at this link :   
https://pfml.shinyapps.io/yatsc/

Details of the code are available at this GitHub repo :   
https://github.com/pfml/yatsc/tree/master
