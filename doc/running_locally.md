#Running ASPI on your local computer
##Required software
To run the ASPI web application on your local computer you will need to install [R](http://www.r-project.org/) and the [Shiny](http://shiny.rstudio.com/) web application framework. 

[R](http://www.r-project.org/) can be downloaded from http://www.r-project.org/. Once you have installed R, you can install Shiny by executing the following instruction on the R command line:
```r
install.packages("shiny", dependencies=TRUE)
```

##Launching the web application
Run the following command in R to launch the application:
```r
shiny::runGitHub(repo="aspi", username="waylandm", subdir="gui")
```

The following page will open in your web browser:



<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/aspi_start.png" width="450" alt="Meristogram GUI before data loaded">

A guide to using the web application can be found [here](https://github.com/WaylandM/aspi/blob/master/doc/gui.md)
