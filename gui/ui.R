# Analysis of Symmetry of Parasite Infections (ASPI)

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("ASPI"),
  h4("Analysis of Symmetry of Parasitic Infections"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File', 
                accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
      radioButtons("method", "Method",
                   c("G-test" = "gtest", "Exact Binomial Test" = "binom")),
      radioButtons("multTest", "Multiple Test Correction",
                   c("Benjamini & Hochberg (False Discovery Rate)" = "bh", "Bonferroni (Familywise Error Rate)" = "bonf")),
      selectInput(inputId = "sigThresh",
                  label = "Significance level",
                  choices = c(0.001, 0.01, 0.05, 0.1),
                  selected = 0.05),
      br(),
      
      helpText( a("Help", href="https://github.com/WaylandM/baa/blob/master/doc/gui.md", target="_blank")), width=4),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(id="resTabset",
        type = "tabs", 
        tabPanel("Summary", 
          tags$br(),
          fluidRow(
          column(6, tableOutput("hostSummary")),
          column(6, tableOutput("parasiteSummary"))),
          tags$br(),
          tableOutput("statSummary"),
          textOutput('hiddenText'),
          tags$head(tags$style("#hiddenText{color: white;}"))
          ),
                          
        tabPanel("Individual Hosts", DT::dataTableOutput('individualHosts'),
                           tags$hr(),
                           conditionalPanel(
                             condition="output.statSummary!=''",
                             wellPanel(
                               downloadButton('downloadResultsTable', 'Download Table of Results')
                             )
                           )),
        tabPanel("Histogram", 
                 plotOutput("histogram"),
                 conditionalPanel(condition="output.hiddenText=='.'", 
                                  wellPanel(selectInput(inputId = "nBreaks",
                                                        label = "Number of bins in histogram (approximate):",
                                                        choices = c(5, 10, 20, 50),
                                                        selected = 20),
                                            tags$hr(),
                                            downloadButton('histogramPDF', 'PDF Histogram'), 
                                            downloadButton('histogramPNG', 'PNG Histogram')
                                            )
                                  )
                 ),
        tabPanel("Volcano Plot",
                 plotOutput("volcanoPlot"),
                 conditionalPanel(condition="output.hiddenText=='.'", 
                                  wellPanel(fluidRow(
                                    downloadButton('volcanoPDF', 'PDF Volcano Plot'), 
                                    downloadButton('volcanoPNG', 'PNG Volcano Plot')
                                    )
                                    )
                                  )
                 )
        )
      )
    )
  )
  )
