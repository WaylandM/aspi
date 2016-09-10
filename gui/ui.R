##################################################################################
#                                                                                #
#  Analysis of Symmetry of Parasitic Infections (ASPI)                           #
#                                                                                #
#  Version 0.1                                                                   #
#                                                                                #
#  Copyright (C) 2016 Matthew Thomas Wayland                                     #
#                                                                                #
#  This file is part of Analysis of Symmetry of Parasitic Infections.            #
#                                                                                #
#  Analysis of Symmetry of Parasitic Infections is free software: you can        #
#  redistribute it and/or modify it under the terms of the GNU General Public    #
#  License as published by the Free Software Foundation, either version 3 of     #
#  the License, or (at your option) any later version.                           #
#                                                                                #
#  Analysis of Symmetry of Parasitic Infections is distributed in the hope that  #
#  it will be useful, but WITHOUT ANY WARRANTY; without even the implied         #
#  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the     #
#  GNU General Public License for more details.                                  #
#                                                                                #
#  You should have received a copy of the GNU General Public License along       #
#  with Analysis of Symmetry of Parasitic Infections.                            #
#  If not, see <http://www.gnu.org/licenses/>.                                   #
#                                                                                #
#                                                                                #
##################################################################################

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("ASPI"),
  h4("Analysis of Symmetry of Parasitic Infections (version 0.1)"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File', 
                accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
      radioButtons("method", "Method",
                   c("G-test" = "gtest", "Exact Binomial Test" = "binom")),
      radioButtons("multTest", "Multiple Test Correction",
                   c("Benjamini & Hochberg (False Discovery Rate)" = "bh", "Holm (Familywise Error Rate)" = "holm")),
      selectInput(inputId = "sigThresh",
                  label = "Significance level",
                  choices = c(0.001, 0.01, 0.05, 0.1),
                  selected = 0.05),
      br(),
      
      helpText( a("Help", href="https://github.com/WaylandM/aspi/blob/master/doc/gui.md", target="_blank")), width=4),

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
