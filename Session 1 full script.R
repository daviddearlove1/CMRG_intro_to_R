####Session 1####
#Note: you can navigate between topics using the drop-down menu at the bottom of the screen 

####The R environment####

####Setting your working directory####
#From RStudio, use the menu to change your working directory (where you saved your files)
#Session > Set Working Directory > Choose Directory

####Types of data in R####
#string (or character) data comprises of characters (e.g., CMRG) contained within quotation marks
string <- "CMRG"
#To assign "CMRG" to the object string, we use an arrow (<-)
#To run a line of of code, move the the cursor to the line you wish to run and press cmd + enter (Mac) or Ctrl + enter (Windows)
#To print something (e.g., to show what it contains or perform a function) you can either...
print(string)
#or simply...
string
#We can determine the class of data contained within the object string using the following command...
class(string)

#Whole numbers or decimals are stored in R as numeric data
#If we want to store data as an integer, you must add the letter L after (e.g. 2L)
x <- 1
is.integer(x)
x <- 1L
is.integer(x)
#The difference between numeric and integer data relates to how they are stored 
#The difference is not relevant at this point; we will be storing whole numbers and decimals numeric data, not integers 
#The combine function allows you to group data into a vector (a sequence of related items)
#We'll use the combine function to group the values 1 to 5 into the factor x
#A factor is an object created using a vector
x <- c(1,2,3,4,5)
#Alternatively...
x <- c(1:5)
#We'll use the factor x to demonstrate what logical data is (i.e., whether something is true or false)
#Are the variables in the factor x equal to 4?
x == 4
#Are the variables in the factor x less than 6?
x < 6
#Are the variables in the factor x greater than 3?
x > 3
#The different names (object, vector, factor etc.) are, for now, largely irrelevant
#Also, R automatically assigns data types (more on this later)

####TASK 1.1####
#Create a vector containing the the following: "Damian", "Vicky", James", "Cat", Jack", "Tony", "Kerstin", "Steph"  and assign it to a factor called Tyler group
#Print Tyler group to the console
#Check the class of the data contained within Tyler group

Tyler_group <- c("Damian","Vicky","James","Cat","Jack","Tony","Kerstin","Steph")
Tyler_group
class(Tyler_group)

####Data frames####
#This is a very important data type for our purposes
#Simply, this a table
#Data stored in a data frame (table) can be numeric, factor or character type 
#Let's create another vector called Gender

#####TASK 1.2####
#Create another factor called Gender, including the correct gender for each of the members of the Tyler group
#Print this to the console
#Check the class of data within Gender

Gender <- c("Male","Female","Male","Female","Male","Male","Female","Female")
Gender
class(Gender)

#Now we can join the Tyler_group and Gender factors together to create a data frame...
Tyler_gender <- data.frame(Tyler_group, Gender)
Tyler_gender
#Note: try and keep a consistent naming format when creating factors, data frames etc
#Note: be particularly careful with capitalization - R is case sensitive!
#Note: spaces are not permitted
#The good news is that we do not need to create data frames from scratch
#Rather, we will be importing data from Excel...

####Importing and checking the data####
#DD note: switch to PowerPoint
#We can access the data from our (already set - see above) working directory using the read.csv function...
ketone <- read.csv("Example_data_set.csv")
#Note: this has been assigned to a data frame called ketone 
#Let's start by inspecting this data frame using the structure function
str(ketone) 
#Note that it has 80 observations across 8 variables 
#Note that R predicts what the data in each variable are 
#It has determined that ID is an integer  
#This is not accurate as this is nominal data 
#In reality, we are not going to be analyzing the participant ID, but let's change it anyway
#We can analyse or modify specific variables in a data frame (in this case, ID) using the format DF_name$variable_name
ketone$ID <- as.factor(as.integer(ketone$ID))
str(ketone)
#We can get a little more detail about the data frame by using the head command

####TASK 1.3####
#Use the head command to investigate the data

head(ketone)
#This shows the first 6 entries in the data frame called ketone  
#The head command is useful if you want to get a limited view of very large data sets 
#However, this one is relatively small, so we could just explore the whole object...

ketone
#You could also look at the data frame by selecting it from the environment screen ("Stuff 1" section)

####Installing and accessing packages####
#Installing a package is incredibly simple...
install.packages("ggplot2")
#This installs the package named ggplot2 
#Now we need to access this package from our library...
library("ggplot2")
#You only need to install the package once, but you'll need to load the package from your library every time you start a new session 
install.packages("ggthemes")
library("ggthemes")
install.packages("ggpubr")
library("ggpubr")
install.packages("dplyr")
library("dplyr")
install.packages("magrittr")
library(magrittr)
install.packages("rstatix")
library("rstatix")

####TASK 1.4####
#Install and load the "emmeans" package, which we will use later

install.packages("emmeans")
library("emmeans")

####TASK 1.5####
#There are thousands of packages available  
#The full list can be found here - https://cran.r-project.org/web/packages/available_packages_by_name.html
#A key 'selling point' for R vs. other GUI based programs is the flexibility these packages provide
#Try typing "blood glucose r package" into a search engine of choice  
#The first response should be cgmanalysis - a package specifically designed for analysing data attained from a continuous glucose monitor 

####Explanation of the example data set####
#A (fictional) experiment was run to determine whether consuming a ketone containing drink lowers blood glucose and non esterified fatty acids (NEFA)
#Ten participants were recruited to a matched-group-design, random-order-controlled study 
#A baseline blood sample was taken (time = 0 min) and participants then consumed a ketone-containing drink 
#Further blood measurements were taken at 30, 60 and 90 min while they rested 
ketone
#2 x DVs, 2 x IVs

####Initial data exploration####
#Let's start by determining the mean and SD for [BHB], [glucose] and [NEFA] 
#We'll summarise this in a table  
#To do this we'll need to use the dplyr package, which is the 'go-to' package for exploring data
#We can learn more about each package by using the help function
?dplyr
ketone %>%
  summarise(BHB_mean = mean(BHB), BHB_SD = sd(BHB), glucose_mean = mean(Glucose), glucose_SD = sd(Glucose), NEFA_mean = mean(NEFA), NEFA_SD = sd(NEFA))
#Let's break this code down...
#We select the "ketone" data frame  
#The %>% symbol (called a pipe) says that everything that follows applies to this data set 
#Summarise does as it say: creates a summary table for the columns defined 
#In this case, the columns are ""Mass_mean", "Mass_SD","BHB_mean", "BHB_SD", "Glucose_mean", "Glucose_SD", "NEFA_mean" and "NEFA_SD" 

####TASK 1.6####
#Create a summary table from the ketone data set for Body_mass showing mean (BM_mean) and SD (BM_SD)

#If your code was this, you'll get an answer of NA...
ketone %>%
  summarise(BM_mean = mean(Body_mass), BM_SD = sd(Body_mass))
#Why is this?

#This is because body mass includes missing data (it was only measured at time 0)
#If we use the command na.rm = TRUE (NA removed = TRUE), we can exclude these...
ketone %>%
  summarise(BM_mean = mean(Body_mass, na.rm = TRUE), BM_SD = sd(Body_mass, na.rm = TRUE))

####Filtering####
#We looked at the mean and SD for the entire data set above 
#It might be useful to look at these separately for the control and ketone groups 
#To do this, we need to filter the data 
#Let's remind ourselves of what the data frame contains...   
head(ketone)

####TASK 1.7####
#How do we filter data using the dplyr package?
#Type "filtering data dplyr" into Google (other search engines are available) 
#Select the top hit and scroll down to Examples (Star Wars - filtering by one criterion)

#With this knowledge, let's repeat the code above, but include a filter to show only the ketone data
ketone %>%
  filter(Condition == "Ketone") %>%
  summarise(BHB_mean = mean(BHB), BHB_SD = sd(BHB), glucose_mean = mean(Glucose), glucose_SD = sd(Glucose), NEFA_mean = mean(NEFA), NEFA_SD = sd(NEFA))
#Notice that we use the pipe %>% twice

####TASK 1.8####
#Now repeat this for the control group

ketone %>%
  filter(Condition == "Control") %>%
  summarise(BHB_mean = mean(BHB), BHB_SD = sd(BHB), glucose_mean = mean(Glucose), glucose_SD = sd(Glucose), NEFA_mean = mean(NEFA), NEFA_SD = sd(NEFA))

#Doing this separately is a little tedious and it makes it difficult to compare conditions
#Let's create a single line of code where we group by the study condition 
#Also, we'll create an additional column called N, which tells us how many entries there are for each variable 
#https://dplyr.tidyverse.org/reference/group_by.html
ketone %>%
  group_by(Condition) %>% #so instead of filtering, we are grouping (i.e., presenting the data for each condition separately)
  summarise(BHB_mean = mean(BHB), BHB_SD = sd(BHB), glucose_mean = mean(Glucose), glucose_SD = sd(Glucose), NEFA_mean = mean(NEFA), NEFA_SD = sd(NEFA),
  N = n()          
  )

####TASK 1.9####
#Now let's try filtering out the baseline (0) values and repeating the grouped summary
#What is wrong with the following line of code? (clue: there are 2 mistakes)
ketone %>%
  group_by(Condition) %>%
  filter(Time !=0) %>%
  summarise(BHB_mean = mean(BHB), BHB_SD = sd(BHB), glucose_mean = mean(Glucose), glucose_SD = sd(Glucose), NEFA_mean = mean(NEFA), NEFA_SD = sd(NEFA),
            N = n()          
  )

#Save your progress!!!!
?ggplot2
#And then clean R studio...
rm(list=ls())
  
####Homework####
#Create a .csv file of your own data and practice the steps above 
