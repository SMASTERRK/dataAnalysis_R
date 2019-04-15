setwd("C://RAM//Projects//supply chain POC")
print(getwd())


data <- read.csv("input.csv")
data1 <- read.csv("input1.csv")
data <- rbind(data,data1)
data2 <- read.csv("input2.csv")
data <- rbind(data,data2)
data <- data[!duplicated(data[,c('name')]),]
data$start_date <- as.Date(data$start_date)
print(data)

#* referring the data Manipulation Process
source("dataManipulation.R")

#* linear regression based manipulation
plot(data$start_date,data$salary)
abline(lm(data$salary~data$start_date))

initialValue<- aggregate(salary ~ dept, data, sum)
deptValue <- subset(initialValue, dept == 'IT')
print(deptValue)
finaldata <- transform(deptValue, percentage = 100 * (salary/nrow(subset(data,dept == 'IT')))/salary )
print(finaldata$percentage)

value <- subset(data, dept == 'IT' & start_date >= '2008-01-02')
print (value)



#* Log some information about the incoming request
#* @filter logger
function(req){
  cat(as.character(Sys.time()), "-", 
      req$REQUEST_METHOD, req$PATH_INFO, "-", 
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  plumber::forward()
}

#' Return entire data
#' @get /data
function(){
  list(data)
}


#* Return the value matches
#* @param a get the values
#* @post /display
function(department){
  value <- subset(data, dept == department)
  print(value)
}

#* Plot a histogram
#* @png (width = 400, height = 500)
#* @param department get the values
#* @get /plot
function(department){
  value <- subset(data, dept == department)
  rand <- c(value[, 3])
  hist(rand)
}



#* @png (width = 400, height = 500)
#* @param a get the dept values
#* @param b get the based values
#* @get /retrive
function(a,b){

  value <- subset(data, dept == a & start_date >= b)
  print(b)
  print(value)
  print('==============================================')
  initialValue<- aggregate(salary ~ dept, value, sum)
  deptValue <- subset(initialValue, dept == a)
  finaldata <- transform(deptValue, percentage = 100 * (salary/nrow(subset(value,dept == a)))/salary )
  x <- c(finaldata$percentage, 100 - finaldata$percentage)
  labels <- c(a, 'Others')
  pie(x,labels)

}
