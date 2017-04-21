
library(DT)

mydat <- read.csv("kc_house_data.csv", header=T)
mydata <- mydat[, c(2,3, 4,5, 6,7,15, 17)]
mydata$SoldDate <- substr(mydata$date, 1, 8)
mydata$SoldDate <- as.Date(mydata$SoldDate,
                           format = "%Y%m%d")
mydata <- mydata[, -1]
mydata <- mydata[order(mydata$zipcode, mydata$bedrooms, mydata$yr_built), ]

shinyServer(
function(input, output) {
        data <- mydata
        
        #observeEvent(input$goButton, NULL)
        
        df <- eventReactive(input$goButton, 
                {(if (input$price != "All") {
                        data <- data[mydata$price %in%
                                            input$price[1]:input$price[2], ]
                })        
                 (if (input$zip != "All") {
                        data <- data[data$zipcode == input$zip,]
                        })
                
                ( if (input$yearbt !="All") {
                        data <- data[data$yr_built == input$yearbt,]
                }) 
                
                (if (input$bedrooms != "All") {
                                data <- data[data$bedrooms == input$bedrooms,]
                                })                
                
                        }
                )
        
        output$table <- DT::renderDataTable(
                DT::datatable(df(),
 # sorted columns are colored now because CSS are attached to them
                        options =list(orderClasses = TRUE, autoWidth = TRUE), 
                        filter = 'top')  
                        )
        
        meanKC <- round(mean(mydata$price), digits=0)
        medianKC <- round(median(mydata$price), digits=0 )
        lowKC <- min(mydata$price)
        highKC <- max(mydata$price)
        
        output$out2 <- renderText(paste0('The mean price of sold houses in King County from May 2014 to May 2015 was ', meanKC,
                                         ' dollars, and the median price was ', medianKC, ' dollars, the price range was ', 
                                         lowKC, ' dollars to ', highKC, ' dollars.')
        )
}
)





                
