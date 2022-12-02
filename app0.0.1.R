
# origional
# https://shiny.rstudio.com/gallery/shiny-theme-selector.html

#programming, 
# https://shiny.rstudio.com/articles/reactivity-overview.html


library(shiny)
library(shinythemes)
library(googlesheets4)


   # Define UI
   # all of this part will be the buttons but no logic
ui <- fluidPage(theme = shinytheme("superhero"),#for light ui use theme "journal"
                navbarPage(
                
                  " using google shets no terminal ",
                  tabPanel("Navbar 1",
                           sidebarPanel(
                             actionButton("start", "load auth"),
                             actionButton("get_tables", "get the tables data"),
                             actionButton("show_graph", "show chart"),
                             
                             fluidRow(column(4,dataTableOutput('dto'))#,
                                      #column(4,tableOutput('to')))
                             )
                             
                           ), # sidebarPanel
                           mainPanel(
                             h1("zachs discount web services"),
                             
                             h4("weeeeeeee"),
                             verbatimTextOutput("txtout"),
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Navbar 2",
                           sidebarPanel( textInput("caption", "Caption", "enter 0 to select google id "),
                                         verbatimTextOutput("value")
                                         )

                            
                           ), # sidebarPanel
                           mainPanel(
                             h1("hey"),
                             
                             h4("no thx"),
                             verbatimTextOutput("txtout"),
                             
                           ) # mainPanel
                           
                  ),
                  tabPanel("Navbar 3", "This panel is intentionally left blank")
                  
                 # navbarPage
) # fluidPage


# Define server function  
# logic section the ui is under the previous. 
server <- function(input, output) {
  
  output$value <- renderText({ input$caption })
  

  observeEvent(input$start, {
      gs4_auth(
        email = gargle::gargle_oauth_email(),# more used when using token
        path = NULL,
        scopes = "https://www.googleapis.com/auth/spreadsheets",
        cache = gargle::gargle_oauth_cache(),
        use_oob = gargle::gargle_oob_default(),
        token = NULL
      )
  })

  
  observeEvent(input$get_tables, {
    x <- gs4_find()
  })
  
  
  observeEvent(input$show_graph, {
    output$dto <- renderDataTable({x})
    y <- c(1,2,2,3)
  })
  

} # server


# Create Shiny object
shinyApp(ui = ui, server = server)
