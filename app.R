library("plumber")

rpoc <- plumb("plumber.R")  # Where 'plumber.R' is the location of the file shown above
rpoc$registerHook("exit", function(){
  print("Server is closed !!")
})
rpoc$run(port=8000)

