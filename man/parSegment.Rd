\name{parSegment}
\alias{parSegment}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Parallel implementation of \code{segment} function of \code{DNAcopy}
}
\description{
There are three key differences between this function and the original
\code{segment} function of package \code{DNAcopy}. First, the execution can be
parallelized, either by using multiple cores of the present host or by 
invoking a grid engine to run on multiple hosts. Secondly, random number 
generator may be re-initialized, with the same seed, for each sample. Finally,
there is a "skinny" option for the value, i.e., a \code{DNAcopy} object with no
\code{data} item.
}
\usage{
parSegment(CNAobj, ranseed = NULL, distrib = c("vanilla", "Rparallel"), 
njobs = 1, out = c("full", "skinny"), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{CNAobj}{
An object of class \code{CNA}, usually a value produced by the \code{CNA} 
function of \code{DNAcopy}
}
  \item{ranseed}{
A single integer to seed the random number generator.
}
  \item{distrib}{
One of "vanilla" (default) and "Rparallel" to choose a parallelization
option: no parallelization ("vanilla"), parallelization on multiple cores
of the local host ("Rparallel").
}
  \item{njobs}{
An integer specifying the desired number of parallel jobs.
}
  \item{out}{
One of "full" (default) or "skinny" to specify the form of the value, an object
of class \code{DNAcopy}, with the \code{data} item present ("full") or not
("skinny").
}
  \item{\dots}{
Arguments other than \code{x} to be passed on to the \code{segment} function of
\code{DNAcopy}.
}
}
\value{
An object of class \code{DNAcopy}. If \code{out == "skinny"} the \code{data}
item of the value will not be returned in order to reduce the memory use.
}
\author{
Alex Krasnitz
}
\seealso{
Package \code{DNAcopy}.
}
\examples{
data(coriell)
#prepare data for segmentation
CNA.object <- CNA(genomdat=coriell[,c(4,5)],coriell$Chromosome,coriell$Position,
	data.type="logratio",sampleid=dimnames(coriell)[[2]][4:5])
#equivalent to "segment" of DNAcopy
parseg<-parSegment(CNA.object,undo.splits="sdundo")
#Random number generator to be re-seeded for each sample
parsegrep<-parSegment(CNA.object,ranseed=123,undo.splits="sdundo")
#multi-core execution but the result should not change
parsegrep1<-parSegment(CNA.object,ranseed=123,distrib="Rparallel",njobs=2,
undo.splits="sdundo")
}
