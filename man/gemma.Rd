% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quantgen.R
\name{gemma}
\alias{gemma}
\title{Launch GEMMA}
\usage{
gemma(model = "ulmm", y, X, snp.coords, alleles, maf = 0.01, K.c = NULL,
  W, out.dir = getwd(), task.id = "gemma", verbose = 1, clean = "none",
  seed = 1859, burnin = 1000, nb.iters = 7000, thin = 10)
}
\arguments{
\item{model}{name of the model to fit (ulmm/bslmm)}

\item{y}{N-vector of phenotypes}

\item{X}{NxP matrix of SNP genotypes encoded in number of copies of the 2nd allele, i.e. as allele doses in {0,1,2}, with individuals in rows and SNPs in columns}

\item{snp.coords}{data.frame with 3 columns (snp, coord, chr)}

\item{alleles}{data.frame with SNPs in rows (names as row names) and alleles in columns (first is "minor", second is "major")}

\item{maf}{SNPs with minor allele frequency strictly below this threshold will be discarded}

\item{K.c}{NxN kinship matrix; if NULL, will be estimated using X via \code{\link{estimGenRel}} with relationships="additive" and method="zhou"}

\item{W}{NxQ matrix of covariates with individuals in rows (names as row names), a first column of 1 and a second column of covariates values}

\item{out.dir}{directory in which the output files will be saved}

\item{task.id}{identifier of the task (used in temporary and output file names)}

\item{verbose}{verbosity level (0/1)}

\item{clean}{remove files: none, some (temporary only), all (temporary and results)}

\item{seed}{seed for the generator of pseudo-random numbers}

\item{burnin}{number of iterations to discard as burn-in (if model="bslmm")}

\item{nb.iters}{number of iterations (if model="bslmm")}

\item{thin}{thining (if model="bslmm")}
}
\value{
invisible list
}
\description{
See Zhou & Stephens (Nature Genetics, 2012) and Zhou et al (PLoS Genetics, 2013).
}
\examples{
\dontrun{## simulate genotypes
set.seed(1859)
I <- 200
P <- 2000
X <- simulGenosDose(nb.genos=I, nb.snps=P)

## simulate phenotypes
model <- simulBvsr(Q=1, X=X, pi=0.01, pve.A=0.7, sigma.a2=1)

## test SNPs one by one with the univariate LMM
snp.coords <- data.frame(snp=colnames(X), coord=1:ncol(X),
                         chr="chr1", stringsAsFactors=FALSE)
alleles <- data.frame(minor=rep("a", ncol(X)),
                      major="A", stringsAsFactors=FALSE)
rownames(alleles) <- colnames(X)
fit.u <- gemma(model="ulmm", model$Y[,1], X, snp.coords, alleles,
               W=model$W, out.dir=tempdir(), clean="all")
cor(model$a[model$gamma == 1], fit.u$tests$beta[model$gamma == 1])
cols <- rep("black",ncol(X)); cols[model$gamma==1] <- "red"
qqplotPval(fit.u$tests$p_wald, col=cols)

## fit all SNPs jointly with the BSLMM
burnin <- 10^3
nb.iters <- 10^4
thin <- 10^2
fit.bs <- gemma(model="bslmm", model$Y[,1], X, snp.coords, alleles,
                W=model$W, out.dir=tempdir(), clean="all",
                burnin=burnin, nb.iters=nb.iters, thin=thin)
posterior.samples <- coda::mcmc(data=fit.bs$hyperparams, start=burnin + 1,
                                end=burnin + nb.iters, thin=thin)
summary(posterior.samples)
}
}
\author{
Timothee Flutre [aut,cre], Dalel Ahmed [ctb]
}

