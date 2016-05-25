# Analysis of Symmetry of Parasite Infections (ASPI)

library(shiny)

# FUNCTIONS TO TEST FOR BILATERAL ASYMMETRY

# remove uninfected hosts
removeUninfected <- function(x){
  return(x[apply(x,1,sum)>0,])
}

# G-test
# This function implements Sokal & Rohlf's (1995) G-test for the specific case of an expected 1:1 ratio
# Reference R.R. Sokal & F.J. Rohlf (1995) Biometry. 3rd Edition. New York: W.H. Freeman and Company. 887 pp.
# The function takes as its argument a matrix or data frame with two numeric columns; first column is for 
# left-side and 2nd column for right-side. Identifiers for hosts can be provided as row names.
g.test <- function(x){
  # convert to data.frame if matrix - omit from web app, because will be checked before this function called
  x <- as.data.frame(x)
  
  calcG <- function(fL, fR, df=1){
    fSum <- fL+fR
    G <- 2*(fL*log(fL/(fSum*0.5)) + fR*log(fR/(fSum*0.5)))
    pval <- pchisq(G, df, lower.tail=F)
    return(c(G, pval))
  }
  
  # G for each individual host GI
  individualG <- apply(x, 1, function(r){
    return(calcG(r[1],r[2]))
  })
  
  Bonferroni <- p.adjust(individualG[2,], 'bonferroni')
  BH <- p.adjust(individualG[2,], 'BH')
  
  individualG <- as.data.frame(cbind(row.names(x), x, t(individualG), BH, Bonferroni))
  names(individualG) <- c("Host", "Left", "Right", "G", "p", "BH", "Bonferroni")
  
  # Total G (GT)
  GT <- sum(individualG$G)
  dfGT <- length(individualG$G)
  pGT <- pchisq(GT, dfGT, lower.tail=F)
  
  # Pooled G (GP)
  pooledResult <- calcG(sum(x[,1]), sum(x[,2]))
  GP <- pooledResult[1]
  pGP <- pooledResult[2]
  
  # Heterogeneity G (GH)
  GH <- GT - GP
  dfGH <- dfGT-1
  pGH <- pchisq(GH, dfGH, lower.tail=F)
  
  # prepare output
  testSummary <- as.data.frame(cbind(c("Pooled", "Heterogeneity", "Total"), c(1, dfGH, dfGT), c(GP, GH, GT), c(pGP, pGH, pGT)))
  names(testSummary) <- c("Test", "df", "G", "p")
  
  output <- list(testSummary, individualG)
  names(output) <- c("summary", "hosts")
  return(output)
  
}

# Exact Binomial Test
eb.test <- function(x){
  
  binomTestP <- function(fL, fR){
    return(binom.test(fL, fL+fR, p=0.5, alternative='two.sided')$p.value)
  }
  
  # Binomial tests for individual hosts
  individualP <- apply(x, 1, function(r){
    return(binomTestP(r[1],r[2]))
  })
  
  Bonferroni <- p.adjust(individualP, 'bonferroni')
  BH <- p.adjust(individualP, 'BH')
  
  individualP <- as.data.frame(cbind(row.names(x), x, individualP, BH, Bonferroni))
  names(individualP) <- c("Host", "Left", "Right", "p", "BH", "Bonferroni")
  
  # Binomial tests for pooled hosts
  fLSum <- sum(x[,1])
  fRSum <- sum(x[,2])
  
  pooledP <- binomTestP(fLSum, fRSum)
  
  output <- list(pooledP, individualP)
  names(output) <- c("pooled", "hosts")
  return(output)
  
}

shinyServer(function(input, output, session) {
  
  plotHistogram <- function(){
    bins <- pretty(c(min(logRatios()), max(logRatios())), n=as.numeric(input$nBreaks)+1)
    histColours <- c(rep("#4DAF4A", sum(bins<0)), rep("#984EA3", sum(bins>0)))
    hist(logRatios(), col=histColours, breaks=bins, xlab=expression(paste("log"[2],"(right/left)")), main=expression(bold(paste("Histogram of log"[2], " ratios"))))
  }
  
  plotVolcano <- function(){
    plotColours <- ifelse(log10p() < log10(as.numeric(input$sigThresh)), "#E41A1C", "#377EB8")
    plotSymbols <- ifelse(log10p() < log10(as.numeric(input$sigThresh)), 15, 16)
    plot(logRatios(), -log10p(),  col=plotColours, pch = plotSymbols, xlab=expression(paste("log"[2],"(right/left)")), ylab=expression(paste("-log"[10],"(p-value)")), main=expression(bold(paste("Statistical significance ", bolditalic(vs), " ratio (right/left)"))))
    abline(h=-log10(as.numeric(input$sigThresh)), col="gray10", lty=2)
  }
  
  inputData <- reactive({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    updateTabsetPanel(session, "resTabset", "Summary")
    inputDF <- as.data.frame(read.csv(inFile$datapath, header=T))
    validate(
      need(length(inputDF[,1])==length(unique(inputDF[,1])), "Each host must have a unique ID"),
      need(length(inputDF[1,])==3, "Input file must be comma-separated with three columns: Host.ID, left, right"),
      need(length(inputDF[,1])>0, "Input file must contain data for at least one host")
    )
    row.names(inputDF) <- inputDF[,1]
    inputDF[,1] <- NULL
    return(inputDF)
  })
  
  parasiteCounts <- reactive({
    if (is.null(inputData()))
      return(NULL)
    removeUninfected(inputData())
  })
  
  numberInfectedHosts <- reactive({
    if (is.null(parasiteCounts()))
      return(NULL)
    else
      return(length(parasiteCounts()[,1]))
  })
  
  testResults <- reactive({
    if (is.null(parasiteCounts()))
      return(NULL)
    if (input$method=="gtest")
      return(g.test(parasiteCounts()))
    else
      return(eb.test(parasiteCounts()))
  })
  
  logRatios <- reactive({
    if (is.null(parasiteCounts()))
      return(NULL)
    log2(parasiteCounts()[,2]/parasiteCounts()[,1])
  })
  
  corrP <- reactive({
    if(is.null(testResults()))
      return(NULL)
    if(input$multTest=="bh")
      return(testResults()$hosts$BH)
    else
      return(testResults()$hosts$Bonferroni)
  })
  
  log10p <- reactive({
    if(is.null(corrP()))
      return(NULL)
    else
      return(log10(corrP()))
  })
  

  numberAsymmetricInfections <- reactive({
    if(is.null(corrP()))
      return(NULL)
    if(is.null(logRatios()))
      return(NULL)
    total <- sum(corrP() < as.numeric(input$sigThresh))
    leftBias <- sum(corrP() < as.numeric(input$sigThresh) & logRatios()<0)
    rightBias <- sum(corrP() < as.numeric(input$sigThresh) & logRatios()>0)
    result <- c(total, leftBias, rightBias)
    names(result) <- c("total", "leftBias", "rightBias")
    return(as.list(result))
  })
  
  hostSummaryTable <- reactive({
    if(is.null(corrP()))
      return(NULL)
    validate(
      need(sum(parasiteCounts()==0)==0 | input$method=="binom", "Parasite count data contains one or more zeroes, therefore a G-test is not applicable. Please select the Exact Binomial Test instead.")
    )
    asymInfections <- sum(corrP() < as.numeric(input$sigThresh))
    leftBias <- sum(corrP() < as.numeric(input$sigThresh) & parasiteCounts()[,1]>parasiteCounts()[,2])
    rightBias <- sum(corrP() < as.numeric(input$sigThresh) & parasiteCounts()[,1]<parasiteCounts()[,2])
    data.frame(Hosts=c("Total", "Infected", "Asymmetric Infections", "Left Bias", "Right Bias"),
    Count=c(length(inputData()[,1]), numberInfectedHosts(), asymInfections, leftBias, rightBias))
  })
  
  output$hostSummary <- renderTable(
    hostSummaryTable(), include.rownames=F, include.colnames=T
  )
  
  parasiteSummaryTable <- reactive({
    if(is.null(parasiteCounts()))
      return(NULL)
    if(sum(parasiteCounts()==0)!=0 & input$method=="gtest")
      return(NULL)
    left <- sum(parasiteCounts()[,1])
    right <- sum(parasiteCounts()[,2])
    total <- left + right
    data.frame(Parasites=c("Total", "Left Side", "Right Side"),
               Count=c(total, left, right))
  })
  
  output$parasiteSummary <- renderTable(
    parasiteSummaryTable(), include.rownames=F, include.colnames=T
  )
  
  statSummaryTable <- reactive({
    if(is.null(testResults()))
      return(NULL)
    if(sum(parasiteCounts()==0)!=0 & input$method=="gtest")
      return(NULL)
    if(input$method=="gtest")
      return(testResults()$summary)
    else
      return(data.frame(Test=c("Pooled Binomial Exact"), p=c(testResults()$pooled)))
  })
  
  output$statSummary <- renderTable(
      statSummaryTable(), include.rownames=F, include.colnames=T
  )
  
  testFunction <- reactive({
    if(sum(parasiteCounts()==0)==0 & !(is.null(parasiteCounts())))
      return(".")
    else
      return("")
  })
  
  output$hiddenText <- reactive({
     testFunction()
  })
  
  output$individualHosts <- DT::renderDataTable({
    if(input$method=="gtest" & sum(parasiteCounts()==0)!=0)
      return(NULL)
    DT::datatable(testResults()$hosts, options = list(searching = F), rownames=F)
  })
  
  output$histogram <- renderPlot({
    if(is.null(parasiteCounts()))
      return(NULL)
    validate(
      need(sum(parasiteCounts()==0)==0, "Parasite count data contains one or more zeroes, therefore a histogram of log ratios cannot be displayed.")
    )
    plotHistogram()
  })
  
  output$volcanoPlot <- renderPlot({
    if(is.null(testResults()))
      return(NULL)
    validate(
      need(sum(parasiteCounts()==0)==0, "Parasite count data contains one or more zeroes, therefore log ratios cannot be calculated and a volcano plot cannot be displayed.")
    )
    plotVolcano()
  })
  
  output$downloadResultsTable <- downloadHandler(
    filename = "ASPI_results_table.csv",
    content = function(file) {
      write.csv(testResults()$hosts, file, row.names=F, quote=F)
    }
  )
  
  output$histogramPDF <- downloadHandler(
    filename = "ASPI_histogram.pdf",
    content = function(file) {
      pdf(file, width=7, height=4)
      par(mar=c(4,4,1,1) + 0.1)
      plotHistogram()
      dev.off()
    }
  )
  
  output$histogramPNG <- downloadHandler(
    filename = "ASPI_histogram.png",
    content = function(file) {
      png(file, res=1000, units="mm", width=180, height=120)
      par(mar=c(4,4,1,1)+0.1)
      plotHistogram()
      dev.off()
    }
  )
  
  output$volcanoPDF <- downloadHandler(
    filename = "ASPI_volcano_plot.pdf",
    content = function(file) {
      pdf(file, width=7, height=4)
      par(mar=c(4,4,1,1)+0.1)
      plotVolcano()
      dev.off()
    }
  )
  
  output$volcanoPNG <- downloadHandler(
    filename = "ASPI_volcano_plot.png",
    content = function(file) {
      png(file, res=1000, units="mm", width=180, height=120)
      par(mar=c(4,4,1,1)+0.1)
      plotVolcano()
      dev.off()
    }
  )

})
