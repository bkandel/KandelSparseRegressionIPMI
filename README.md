This repository holds the data and scripts used in Kandel et al., "Predicting Cognitive Data from Medical Images Using
Sparse Linear Regression", IPMI 2013.  

To reproduce the results, you must have R and ANTsR installed.  Instructions for installing R can be found at
http://cran.us.r-project.org/.  To install ANTsR, open up a terminal and type: 
  git clone https://github.com/stnava/ANTsR.git
  sudo R CMD INSTALL ANTsR
You may have to install some dependencies for ANTsR (if you don't have the dependencies, an error message will appear
during the install step).  To compile the document 'master.Rnw', you will also have to install the 'knitr' package.  Once R and ANTsR are installed, open up an R session in the directory this message lives in and type: 
  require(knitr)
  knit('master.Rnw')
This will generate a PDF with results computed on the fly from the input data supplied.  It may take a while (a couple of
hours from beginning to end), depending on how fast your computer is.  If you are familiar with R, feel free to explore the source code chunks in master.Rnw.

