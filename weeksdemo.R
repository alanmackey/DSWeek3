# Enter data into vectors before constructing
# Dataframe
date_col <- c('2018-15-10', '2018-01-11', '2018-10-21', '2018-10-21', '2018-05-01')
ctry_col <- c('US','US','IRL','IRL','IRL')
gender_col <- c('M','F','F','M','F')
# 99 is invalid value in age attribute which will require recoding
age_col <- c(32,45,25,39,99)
q1_col <- c( 5, 3, 3, 3, 2)
q2_col <- c( 4, 5, 5, 3, 2)
q3_col <- c( 5, 2, 5, 4, 1)
# NA is inserted in place of missing data for attribute
q4_col <- c( 5, 5, 5, NA, 2)
q5_col <- c( 5, 5, 2, NA, 1)

column_names <- c('Date', 'Country', 'Gender', 'Age', 'q1', 'q2', 'q3', 'q4', 'q5')

#Construct dataframe from above vectors

managers <- data.frame(date_col, ctry_col, gender_col, age_col, q1_col, q2_col, q3_col, q4_col, q5_col)

managers

#Add column names to data frame using col_names vector

colnames(managers) <- column_names
str(managers)
head(managers, 4)

#Recode incorrect age data from 99 to NA

managers$Age[managers$Age == 99] <- NA

#Create a new attribute called age_cat and set values to
# in age_cat to the following if true 
# <=25 = Young
# >=26 & <=44 = Middle Aged
# >=45 = Elderly
#We will also recode NA to Elderly

managers$age_cat[managers$Age >= 45] <- 'Elderly'
managers$age_cat[managers$Age >= 26 & managers$Age <= 44 ] <- 'Middle Aged'
managers$age_cat[managers$Age <= 25] <- 'Young'

#Recode NA in age field to 'Elderly'
managers$age_cat[is.na(managers$Age)] <-'Elderly'

# Add summary column to data frame
summary_col <- managers$q1+managers$q2+managers$q3+ 
  managers$q4+managers$q5
managers <- data.frame(managers, summary_col)

# Add mean column to data frame
mean_value <- rowMeans(managers[5:9])
managers <- data.frame(managers, mean_value)

#Rename the new columns 
names(managers)[12] <- "Mean Value"
names(managers)[11] <- "Answer Total"
names(managers)[10] <- "Age Category"

str(managers)

#-----------------------------------------------------
#Dealing with missing data
#-----------------------------------------------------

# removes any rows that contain NA - listwise deletion
new_managers <- na.omit(managers)
new_managers

# Use Complete cases to show rows where data is available
complete_data = complete.cases(managers)
complete_data
sum(complete_data)

# List the rows that dont have missing values
# note that the comma ','and no number in the square bracket means 'all columns' 

complete_data <- managers[!complete.cases(managers),]
complete_data

# find the sum of all missing values in the age column
sum(is.na(managers$Age))
