# Analysis of Symmetry of Parasitic Infections (ASPI)

# remove uninfected hosts
removeUninfected <- function(x){
  
  if(length(x[1,])!=2)
    stop("x must contain exactly 2 columns")
  
  if(length(x[,1])<1)
    stop("x must contain data for at least one host")
  
  if(!is.numeric(x[,1]) | !is.numeric(x[,2]))
    stop("Both columns of x must be numeric")
  
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
  
  if(length(x[1,])!=2)
    stop("x must contain exactly 2 columns")
  
  if(length(x[,1])<1)
    stop("x must contain data for at least one host")
  
  if(!is.numeric(x[,1]) | !is.numeric(x[,2]))
    stop("Both columns of x must be numeric")
  
  if(sum(x==0)!=0)
    stop("Data contains zero counts!")
  
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
  
  if(length(x[1,])!=2)
    stop("x must contain exactly 2 columns")
  
  if(length(x[,1])<1)
    stop("x must contain data for at least one host")
  
  if(!is.numeric(x[,1]) | !is.numeric(x[,2]))
    stop("Both columns of x must be numeric")
  
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

plotHistogram <- function(x, nBreaks=10, ...){
  if(length(x[1,])!=2)
    stop("x must contain exactly 2 columns")
  
  if(length(x[,1])<1)
    stop("x must contain data for at least one host")
  
  if(!is.numeric(x[,1]) | !is.numeric(x[,2]))
    stop("Both columns of x must be numeric")
  
  if(sum(x==0)!=0)
    stop("Data contains zero counts!")
  
  logRatios <- log2(x[,2]/x[,1])
  bins <- pretty(c(min(logRatios), max(logRatios)), n=as.numeric(nBreaks)+1)
  #bins <- pretty(c(min(logRatios()), max(logRatios())), n=as.numeric(input$nBreaks)+1)
  histColours <- c(rep("#4DAF4A", sum(bins<0)), rep("#984EA3", sum(bins>0)))
  hist(logRatios, col=histColours, breaks=bins, xlab=expression(paste("log"[2],"(right/left)")), ...)
}

plotVolcano <- function(x, test="G", pAdj="BH", sigThresh=0.05, ...){
  if(length(x[1,])!=2)
    stop("x must contain exactly 2 columns")
  
  if(length(x[,1])<1)
    stop("x must contain data for at least one host")
  
  if(!is.numeric(x[,1]) | !is.numeric(x[,2]))
    stop("Both columns of x must be numeric")
  
  if(sum(x==0)!=0)
    stop("Data contains zero counts!")
  
  if(test=="G"){
    testResults <- g.test(x)
  }else{
    testResults <- eb.test(x)
  }
  
  if(pAdj=="BH"){
    log10p <- log10(testResults$hosts$BH)
  }else{
    log10p <- log10(testResults$hosts$Bonferroni)
  }
  
  logRatios <- log2(x[,2]/x[,1])
  plotColours <- ifelse(log10p < log10(as.numeric(sigThresh)), "#E41A1C", "#377EB8")
  plotSymbols <- ifelse(log10p < log10(as.numeric(sigThresh)), 15, 16)
  plot(logRatios, -log10p,  col=plotColours, pch = plotSymbols, xlab=expression(paste("log"[2],"(right/left)")), ylab=expression(paste("-log"[10],"(p-value)")), ...)
  abline(h=-log10(as.numeric(sigThresh)), col="gray10", lty=2)
}


