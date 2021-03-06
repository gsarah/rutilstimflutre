% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quantgen.R
\name{drawLocCrossovers}
\alias{drawLocCrossovers}
\title{Crossing-overs}
\usage{
drawLocCrossovers(crosses, nb.snps, lambda = 2)
}
\arguments{
\item{crosses}{data.frame with three columns, parent1, parent2, child; if parent 1 and 2 are the same, it will be an autofecondation; if parent2 is NA, it will be a haplodiploidization}

\item{nb.snps}{vector with the nb of SNPs per chromosome, which names are chromosome names}

\item{lambda}{mean number of crossing-overs (parameter of a Poisson)}
}
\value{
list of lists (one per cross, then one per parent, then one per chromosome) whose names are crosses$child, in the same order
}
\description{
Draw the number and location of crossing-overs per gamete.
}
\author{
Timothee Flutre
}

