% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quantgen.R
\name{imputeGenosWithMeanPerPop}
\alias{imputeGenosWithMeanPerPop}
\title{Genotype imputation}
\usage{
imputeGenosWithMeanPerPop(X, pops, min.maf.pop = 0.1, max.miss.pop = 0.3,
  rm.still.miss = TRUE, verbose = 1)
}
\arguments{
\item{X}{NxP matrix of marker genotypes numerically encoded (if SNPs, in number of copies of the 2nd allele, i.e. as allele doses in {0,1,2}), with individuals in rows and markers in columns; NA if missing}

\item{pops}{data.frame with 2 columns, "ind" and "pop"}

\item{min.maf.pop}{minimum minor allele frequency per population (before imputation) below which SNPs are discarded}

\item{max.miss.pop}{maximum amount of missing genotypes per population (before imputation) above which SNPs are discarded}

\item{rm.still.miss}{if TRUE, remove marker(s) still with missing genotype(s) in at least one population (depending on \code{min.maf.pop} and \code{max.miss.pop})}

\item{verbose}{verbosity level (0/1)}
}
\value{
NxP matrix with imputed genotypes
}
\description{
Impute missing marker genotypes with the mean of the non-missing, population by population.
}
\author{
Timothee Flutre
}
\seealso{
\code{\link{imputeGenosWithMean}}
}

