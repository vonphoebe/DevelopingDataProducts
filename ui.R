library(shiny)

shinyUI(fluidPage(
        titlePanel("General Health and High Blood Pressure in NYS 2015 BRFSS"), 
        
        sidebarLayout(
        sidebarPanel(
                selectInput("mydata", label=h4("Tab2: Would you say that in general your health is:"), 
                            choices = levels(mydata$GENHLTH1 )), 
                
                selectInput("mydata", label=h4("Tab1: Ever told blood pressure high:"),
                            choices =levels(mydata$BPHIGH4 )),
                
                h5("Tab3: Contigency table of 'General health' and 'Blood pressure'")),
                
                mainPanel(tabsetPanel(type="tabs",
                                      tabPanel("Tab1", br(), plotOutput('outplot1')),
                                      tabPanel("Tab2", br(), plotOutput("outplot2")),
                                      tabPanel("Tab3", br(), tableOutput("value"))
                                      #tabPanel("Tab4", br(), textOutput("value2"))
                                      
                )
                )
        )

))
