## JK dashboard Prototype 

library(shinydashboard)
library(shiny)

# Application code 
ui <- dashboardPage(skin="blue",
                    dashboardHeader(title = "JK QI Standards"),
                    dashboardSidebar( sidebarMenu(
                      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
                    )),
                    dashboardBody( 
                      fluidRow(
                        box(title = "This is a prototype QI dashboard for Damien", 
                            "It will use ANZNN spreadsheet"),
                        
                        
                      ),
                      
                      fluidRow(
                        
            #Panel 1 ------------------------------------------------------------
            
                        box(
                          title = "Antenatal Steroids", height = 300, width = 4, 
                          solidHeader = TRUE, status = "success",
                          tags$img(src='field1.png', height=230, 
                          style="display: block; margin-left: 
                          auto; margin-right: auto;")
                        ),
            
            #Panel 2 ------------------------------------------------------------
            
                        box(
                          title = "Birthweight vs Gestation", height = 300, width = 4, 
                          solidHeader = TRUE, status="success", 
                          tags$img(src='field2.png', height=230, 
                                   style="display: block; margin-left: 
                          auto; margin-right: auto;")
    
                        ),
                        
            #Panel 3 ------------------------------------------------------------
            
              
                        box(
                          title = "Birthweight vs Gestation", height = 300, width = 4, 
                          solidHeader = TRUE, status="danger", 
                          tags$img(src='field3.png', height=230, 
                                   style="display: block; margin-left: 
                          auto; margin-right: auto;")
                        )
                      ),
            
            #Panel 4 ------------------------------------------------------------
            
                      
                      fluidRow(
                        box(
                          title = "Title 4", height = 300, width = 4, 
                          solidHeader = TRUE, status="warning", 
                          tags$img(src='field4.png', height=230, 
                                   style="display: block; margin-left: 
                          auto; margin-right: auto;")
                        ),
                        
             #Panel 5 ------------------------------------------------------------
                        
                        
                        box(
                          title = "Title 5", height = 300, width = 4, 
                          solidHeader = TRUE, status="warning", 
                          "Box content"
                        ),
             
             #Panel 6 ------------------------------------------------------------
             
             
                        box(
                          title = "Title 6", height = 300, width = 4, 
                          solidHeader = TRUE, status="danger", 
                          "Box content"
                        )
                      ))
)

# Set UI and use server function to view app 
server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)


