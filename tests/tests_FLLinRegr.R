# Test script for Linear regression function. Includes
# FLLinRegr, FLLinRegrMD and FLLinRegrMDS functions.

devtools::load_all(".")

# Connection object
connection <- flConnect(odbcSource = "TD JP 15.10",
                        database = "fuzzylogix",
                        platform = "TD",
                        debug = TRUE, drop = TRUE, temporary = TRUE,
                        user = "dbc", TestDatabase = "fuzzylogix")

# For FLLinRegr Object
widetable  <- FLTable(getTestTableName("tblAbaloneWide"), "ObsID")
lmfit <- lm(Rings~Height+Diameter,widetable)

# For FLLinRegrMD object
flMDObject <- FLTableMD(table = getTestTableName("tblAbaloneWideMDS"),
                        group_id_colname = "GroupID",
                        obs_id_colname = "ObsID",group_id = c(1, 2))
vformula <- Rings~.
lmfitMD <- lm(vformula,
              data=flMDObject)

# For FLLinRegrMDS object
flMDSObject <- FLTableMDS(table = getTestTableName("tblAbaloneWideMDS"),
                          group_id_colname = "GroupID",
                          obs_id_colname = "ObsID",group_id = c(1, 2))
vformula <- Rings~.
lmfitMDS <- lm(vformula,
               data=flMDSObject)


# FLLinRegrMD test cases --------------------------------------------------

# Overall print or summary
lmfitMD

# MD coefficients
lmfitMD$coefficients

# MD residuals
lmfitMD$residuals

# MD fitted.values
lmfitMD$fitted.values

# MD FLCoeffStdErr
lmfitMD$FLCoeffStdErr

# MD FLCoeffTStat
lmfitMD$FLCoeffTStat

# MD FLCoeffPValue
lmfitMD$FLCoeffPValue

# MD FLCoeffNonZeroDensity
lmfitMD$FLCoeffNonZeroDensity

# MD FLCoeffCorrelWithRes
lmfitMD$FLCoeffCorrelWithRes

# MD call
lmfitMD$call

# MD df.residual
lmfitMD$df.residual

# MD x
lmfitMD$x

# MD y
lmfitMD$y

# MD qr
lmfitMD$qr

# MD terms
lmfitMD$terms

# MD formula
lmfitMD$formula

# MD regrstats
lmfitMD$regrstats


# FLLinRegrMDS test cases -------------------------------------------------

# Overall print or summary
lmfitMDS

# MDS coefficients
lmfitMDS$coefficients

# MDS residuals
lmfitMDS$residuals

# MDS fitted.values
lmfitMDS$fitted.values

# MDS FLCoeffStdErr
lmfitMDS$FLCoeffStdErr

# MDS FLCoeffTStat
lmfitMDS$FLCoeffTStat

# MDS FLCoeffPValue
lmfitMDS$FLCoeffPValue

# MDS FLCoeffNonZeroDensity
lmfitMDS$FLCoeffNonZeroDensity

# MDS FLCoeffCorrelWithRes
lmfitMDS$FLCoeffCorrelWithRes

# MDS s
lmfitMDS$s

# MDS call
lmfitMDS$call

# MDS df.residual
lmfitMDS$df.residual

# MDS model
lmfitMDS$model

# MDS x
lmfitMDS$x # needs working

# MDS y
lmfitMDS$y

# MDS qr and rank
lmfitMDS$qr
lmfitMDS$rank

# MDS terms
lmfitMDS$terms

# MDS xlevels
lmfitMDS$xlevels

# MDS assign
lmfitMDS$assign

# MDS formula
lmfitMDS$formula

# MDS regrstats
lmfitMDS$regrstats
