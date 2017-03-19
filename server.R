library(shiny)
library(shinyjs)

share <- list(
  title = "Prediction of disease using the abnormal exhale breath",
  url = "http://bas.com/shiny/Disease Prediction Analysis/",
  description = "Explore trends in disease predicted using abnormal exhale breath",
  twitter_user = "bas"
)

fluidPage(
  useShinyjs(),
  title = "Prediction of disease using the Abnormal Exhale Breath   ",
  
  
  # enclose the header in its own section to style it nicer
  div(id = "headerSection",
      h1("Prediction of disease using the Abnormal Exhale Breath"),
      
      
      
      # show a loading message initially
      div(
        id = "loadingContent",
        h2("Loading...")
      ),	
      
      # all content goes here, and is hidden initially until the page fully loads
      hidden(div(id = "allContent",
                 
                 # sidebar - filters for the data
                 sidebarLayout(
                   sidebarPanel(
                     h3("Filter data", style = "margin-top: 0;"),
                     
                     # show all the cancers or just specific types?
                     selectInput(
                       "subsetType", "",
                       c("Show all Gas types" = "all",
                         "Select specific types" = "specific"),
                       selected = "all"),
                     
                     # which cancer types to show
                     conditionalPanel(
                       "input.subsetType == 'specific'",
                       uiOutput("GasTypeUi")
                     ), br(),
                     
                     # whether to combine all data in a given year or not
                     checkboxInput("showGrouped",
                                   strong("Group all Gas Level"),
                                    FALSE), br(),
                     
                     # what years to show
                     # Note: yearText should use "inline = TRUE" in newer shiny versions,
                     # but since the stats server has an old version I'm doing this in css
                     strong(span("GasLevel")),
                     textOutput("GasLevelText",inline = TRUE), br(),  
                     uiOutput("GasLevelUi"), br(),
                     
                     
                     # what variables to show
                     uiOutput("variablesUi"),
                     
                     # button to update the data
                     shiny::hr(),
                     actionButton("updateBtn", "Update Data")
                   ),
                     
                     
                     # main panel has two tabs - one to show the data, one to plot it
                     mainPanel(
                       wellPanel(
                       tabsetPanel(
                         id = "resultsTab", type = "tabs",
                         
                         # tab showing the data in table format
                         tabPanel(
                           title = "Show data", id = "tableTab",
                           
                           br(),
                           downloadButton("downloadData", "Download table"),
                           br(), br(),
                           
                           span("Table format:"),
                           radioButtons(inputId = "tableViewForm",
                                        label = "",
                                        choices = c("Wide" = "wide", "Long" = "long"),
                                        inline = TRUE),
                           br(),
                           
                           tableOutput("dataTable")
                         ),
                         
                         # tab showing the data as plots
                         tabPanel(
                           title = "Plot data", id = "plotTab",
                           br(),
                           downloadButton("downloadPlot", "Save figure"),
                           br(), br(),
                           plotOutput("dataPlot")
                         ),
                         
                         # tab showing the data as plots for regression analysis
                         tabPanel(
                           title = "Plot data",id = "plotTab",
                           br(),
                           downloadButton("downloadPlot","Save figure"),
                           br(), br(),
                           plotOutput("dataPlot")
                         )
                       )
                     )
                     ))
                 )
      ))
  )
  
  shiny::hr()
  actionButton("updateBtn", "Update Data")
)
  
  
  # main panel has two tabs - one to show the data, one to plot it
  mainPanel(
     wellPanel(
    tabsetPanel(
      id = "resultsTab", type = "tabs",
      
      # tab showing the data in table format
      tabPanel(
        title = "Show data", id = "tableTab",
        
        br(),
        downloadButton("downloadData", "Download table"),
        br(), br(),
        
        span("Table format:"),
        radioButtons(inputId = "tableViewForm",
                     label = "",
                     choices = c("Wide" = "wide", "Long" = "long"),
                     inline = TRUE),
        br(),
        
        tableOutput("dataTable")
      ),
      
      # tab showing the data as plots
      tabPanel(
        title = "Plot data", id = "plotTab",
        br(),
        downloadButton("downloadPlot", "Save figure"),
        br(), br(),
        plotOutput("dataPlot"),
        # tab showing the data as plots
        tabPanel(
          title = "Plot data", id = "plotTab",
          br(),
          downloadButton("downloadPlot", "Save figure"),
          br(), br(),
          plotOutput("dataPlot")
          
        )
      )
    ))
  )
)

