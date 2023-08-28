#Task 01

#Packages and Libraries
#A collection of crucial R programmes for data research is called tidyverse. 
#We can conduct operations on and interact with the data thanks to the packages included in the tidyverse ecosystem
#Our data can be used for a plethora of purposes, including subsetting, transformation, visualisation, etc

install.packages("tidyverse") 
library(tidyverse) 

#Q1:

#To gather all the mentioned columns together
#Lengthens datasets by lowering the number of columns and raising the number of rows 
#The names_to gives the name of the variable that will be created from the data stored in the column names
#The values_to gives the name of the variable that will be created from the data stored in the cell value

who1 <- who %>% pivot_longer(names_to = "key", values_to = "cases", new_sp_m014:newrel_f65) 

#values_drop_na to drop rows that correspond to missing values
who1 <- who1 %>% drop_na(cases)

#Q2:

#In R programming, we can add additional variables to the supplied data frame by using the mutate() method. 
#By carrying out the actions on the current variables, these new variables are added.
who2 <- who1 %>% mutate(across('key', str_replace, 'newrel', 'new_rel'))

Q3:
#A single data frame or table column can be divided into numerous columns using the separate() method from the tidyr package.
who3 <- who2 %>% separate(key, c("new","type","sexage"),sep="_")

#Q4:
#A single data frame or table column can be divided into numerous columns using the separate() method from the tidyr package.
who4 <- who3 %>% separate(sexage, c("sex","age"), sep = "(?<=[A-Za-z])(?=[0-9])")

#Q5:
#A single data frame or table column can be divided into numerous columns using the separate() method from the tidyr package.
head(who4, 5)
tail(who4, 5)

#Q6:
#With fields separated by commas, headers (column names), rows indexes, and values enclosed in double-quotes, you can export a R DataFrame to a CSV file using the write.csv() function.
write_csv(who4, "C:/Users/Ruvini Suranika/Desktop/Greenwich/Term 01/R/Coursework/who4.csv")

#Task 02

#Q1:

DataFrame <- Nile

#Divide the total number of values in the data collection by the sum of all the values
mean(DataFrame)

#The data set's median value
median(DataFrame)

# Create the function
getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}

#The most occurring number in the data set
getmode(DataFrame)

#The degree to which a set of data values deviates from the mean
var(DataFrame)

#A metric used to express how much a group of data values vary or are dispersed
sd(DataFrame)


#Q2:

#Minimum Value
min(DataFrame)

#Maximum Value
max(DataFrame)

#Difference between the minimum value in the vector and the maximum value in the given vector
spread <- max(DataFrame)- min(DataFrame)
spread

#Minimum and Maximum values
range(DataFrame)

Q3:
#IQR() function is used to compute the interquartile range of a given object of numerical values
IQR(DataFrame)

#A quantile is nothing but a sample that is divided into equal groups or sizesIn the quantiles
#The 25th percentile is called as lower quartile, 50th percentile is called as Median and the 75th Percentile is called as the upper quartile.
quantile(DataFrame)

Q4:
#The values of a variable's frequencies are shown in a histogram as bucketed ranges. Bar chat and a histogram are comparable.
#but a histogram arranges the values into continuous ranges. 
#The height of each bar in a histogram corresponds to the number of values that fall inside that range

hist(DataFrame, main = "Histogram - Flow of the River Nile", xlab = "Nile", ylab = "Frequency",border="black", col="Red")
 
#Q5:
 
#qqnorm is a general function whose default technique yields a normal QQ plot of the values in y.
qqnorm(DataFrame)

#qqline adds a line to a "theoretical," by default normal, quantile-quantile plot that passes through the probs quantiles, by default the first and third quartiles.
qqline(DataFrame, col="red", lwd=2)

#Q6
#The plot() function is used to draw points (markers) in a diagram
plot(DataFrame, type = "h", col = "red", xlab = "Year",ylab="Frequency",lwd =3 , main = "Frequancy of the River Nile from 1871 to 1970")

#Task 03

#A plotting software called ggplot2 offers helpful functions for generating intricate graphs from data in a data frame. 
#It offers a more programmatic interface for choosing which variables to plot, how to present them, and other visual characteristics

ggplot2::ggplot()
ggplot2::mpg
library(ggplot2)

#Q1:
#The scatterplot is produced by the function geom point(), which adds a layer of points to your plot
#Aesthetic mappings are set with the aes() function
qplot(cty, data = mpg, geom = "histogram", bins = 20)
qplot(hwy, data = mpg, geom = "histogram", bins = 20)
ggplot(data=mpg) + geom_point(mapping = aes(x =hwy, y = cty, color = manufacturer))

#Q2:
#To facet your plot by a single variable, use facet_wrap(~variable).
ggplot(data = df) + geom_point(mapping = aes(x = displ, y = cty, color=class)) + facet_wrap(~ class, nrow = 2)

#Q3:
#To facet your plot by the combination of two variables, use facet_grid(variable1~variable2)
plot1<- ggplot(mpg) + geom_point(mapping = aes(x=displ, y=hwy, color=class)) + geom_point(mapping = aes(x=displ, y=cty, color=class))+ facet_grid(drv ~ cyl, labeller = label_both)
plot1