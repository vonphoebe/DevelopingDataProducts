
library(shiny)
mydata <- read.csv("~/NYSBRFSS2015c.csv", header=T)
mytable <- table(mydata$GENHLTH1, mydata$BPHIGH4)
#loghlth <- glm(GENHLTH1 ~ BPHIGH4,family=binomial,data=mydata)

shinyServer(
        function(input, output) {
                
                output$out1 <- renderText(input$box1) 
                output$out2 <- renderText(input$box2)
                
                
                output$outplot1 <- renderPlot({
                        plot(mydata$GENHLTH1)})
                output$outplot2 <- renderPlot({
                        plot(mydata$BPHIGH4)})
                output$value <- renderTable({
                        mytable 
                     }) 
                #output$value2 <- renderText({summary(loghlth)})
                })


 


                
