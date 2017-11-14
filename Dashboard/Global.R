rm(list = ls())

library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(scales)
library(data.table)
library(rjson)

theme_set(theme_bw(12))

lArchitectureParms = list()

# Should point to where you've downloaded the repository
# This is the path used to read other assets like the file needed for dtAllowedOperations
lArchitectureParms$cRootDirectory = Sys.getenv('AtherGitRepo')
lArchitectureParms$cRootDirectory = ifelse(
   lArchitectureParms$cRootDirectory == '',
   '/mnt/disks/vi-data/AtherGit',
   lArchitectureParms$cRootDirectory
)

# should point to some location where you want to save the scenarios
lArchitectureParms$cAtherDataLocation = Sys.getenv('AtherDataLocation')
lArchitectureParms$cAtherDataLocation = ifelse(
   lArchitectureParms$cAtherDataLocation == '',
   '/mnt/disks/vi-data/Data',
   lArchitectureParms$cAtherDataLocation
)

# The number of variables that a user is allowed to add
iRandomlyLargeNumberForVariables = 99

# The number of empirical distributions that a user is allowed to add
iRandomlyLargeNumberForEmpirical = 99

# The operations that a user is allowed
dtAllowedOperations = fread(
   paste0(
      lArchitectureParms$cRootDirectory,
      '/MonteCarloTool/Metadata/Operations.csv'
   ),
   sep = ';'
)
# sorting it in order of longer operators to shorter operators to
# avoid mix ups with the string parsing
dtAllowedOperations = dtAllowedOperations[rev(order(nchar(Operator)))]

# adding radians to the trigo functions to prevent any misunderstanding
sinradian = sin
asinradian = asin
cosradian = cos
acosradian = acos
tanradian = tan
atanradian = atan