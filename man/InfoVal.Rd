% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FLWOE.R
\name{InfoVal}
\alias{InfoVal}
\title{\code{InfoVal} Performs  on FLTable objects.It is an aggregate function which
which measures the information value of a data set. Information value is a
concept used for variable selection during model building. This analysis can be used
assess the overall predictive power of the variables being considered.}
\usage{
InfoVal(events, nonevents, n = 2, data = list(), ...)
}
\arguments{
\item{events}{Events or element of good distribution.}

\item{nonevents}{Non-Events or element of bad distribution.}

\item{n}{number of ID's for which information is to be calculated.
fltbl <- FLTable(table = getTestTableName("tblinfoval"), obs_id_colname="BinID")
flmod <- InfoVal(event = "Events", nonevents = "NonEvents", data = fltbl,n = 4)}

\item{data}{An object of class FLTable.}
}
\description{
\code{InfoVal} Performs  on FLTable objects.It is an aggregate function which
which measures the information value of a data set. Information value is a
concept used for variable selection during model building. This analysis can be used
assess the overall predictive power of the variables being considered.
}
