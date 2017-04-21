
library(shiny)

mydat <- read.csv("kc_house_data.csv", header=T)
mydata <- mydat[, c(2,3, 4,5, 6,7,15, 17)]
mydata$SoldDate <- substr(mydata$date, 1, 8)
mydata$SoldDate <- as.Date(mydata$SoldDate,
                           format = "%Y%m%d")
mydata <- mydata[, -1]

mydata <- mydata[order(mydata$zipcode, mydata$bedrooms, mydata$yr_built), ]

shinyUI(fluidPage(
        titlePanel("Basic DataTable of House Sales in King County, USA"),
        
        # Create a new Row in the UI for selectInputs
        sidebarLayout(sidebarPanel(
              "User Documentation: Use this App to help you get a price hint of your new home in the Great Seattle Area. Nallow down your choices based on the house price indicators.", 
                selectInput("zip", "Zipcode:", 
                            c("All", unique(as.character(mydata$zipcode)))), 
                
                selectInput("bedrooms", "Number of Bedrooms:",
                            c("All", unique(as.character(mydata$bedrooms)))), 
                
                selectInput("yearbt", "Year built:",
                            c("All", unique(as.character(mydata$yr_built)))),
                
                
              sliderInput("price", label = h3("Price Range:"), min(mydata$price), 
                           max(mydata$price), value = c(300000, 500000)),
               
               actionButton("goButton", "Go!"),
               p("Click the button to update the datatable")
        ),
        # Create a new row for the table.
        mainPanel(
                tabsetPanel(type="tabs",
                            tabPanel("Data", br(), 
                DT::dataTableOutput("table")  ),
                tabPanel("Summary", br(), textOutput("out2"))
                )
        )
)
))
