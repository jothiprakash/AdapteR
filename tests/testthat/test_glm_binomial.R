Renv = new.env(parent = globalenv())
FLenv <- as.FL(Renv)
Renv$dataf<- data.frame(var1 = rnorm(200),
                        var2 = rnorm(200), 
                        var3 = sample( c(0, 1), 200, replace = TRUE))
ldose <- rep(0:5, 2)
Renv$data2 <- data.frame(var1 = rep(0:5, 2),
                         var2 = (c(1, 4, 9, 13, 18, 20, 0, 2, 6, 10, 12, 16))/20,
                         var3 = factor(rep(c("M", "F"), c(6, 6))))

FLenv$dataf <- as.FLTable(Renv$dataf,tableName = getOption("TestTempTableName"),temporary=F, drop = TRUE)

test_that("glm: execution for binomial ",{
  result = eval_expect_equal({
    glmobj <- glm(var3 ~ var1 + var2, data=dataf, family = "binomial")
    coeffs <- coef(glmobj)
    predict_glmobj <- predict(glmobj, type = "response")
  },Renv,FLenv,
  expectation = c("coeffs", "predict_glmobj"),
  noexpectation = "glmobj",
  check.attributes=F,
  tolerance = .000001
  )
}) 

## Not a good data-- fails on Aster and hadoop
FLenv$data2 <- as.FLTable(Renv$data2,tableName = getOption("TestTempTableName"),temporary=F, drop = TRUE)

test_that("glm: execution for categorical variables",{
  result = eval_expect_equal({
    glmobj_data2 <- glm(var2 ~ var1 + var3, data = data2, family = binomial)
    predict_glmobj2 <- predict(glmobj_data2, type = "response")
  },Renv,FLenv,
  expectation = "predict_glmobj2",
  noexpectation = "glmobj_data2",
  check.attributes=F,
  tolerance = .000001
  )
}) 

test_that("glm: Successful execution of FLLogRegrWt",{
  glmfit <- glm(var2 ~ var1 + var3,data = FLenv$data2,family="logisticwt",eventweight=0.8,noneventweight=1)
  coeff <- coef(glmfit)
  pred <- predict(glmfit, type = "response")
}) 

test_that("glm: equality of coefficients, residuals, fitted.values, df.residual for binomial",{
    result = eval_expect_equal({
        coeffs2 <- glmobj$coefficients
        res <- as.vector(glmobj$residuals)
        fitted <- as.vector(glmobj$fitted.values)
        names(res) <- names(fitted) <- NULL ## todo: support names in AdapteR
        dfres <- glmobj$df.residual
    },Renv,FLenv,
    expectation=c("coeffs2","res",
                "fitted","dfres"),
    noexpectation = "glmobj",
    tolerance = .000001,
    check.attributes = F
  )
})

## MD Testing
test_that("glm: multi dataset",{
    flMDObjectDeep <- FLTableMD(table=getTestTableName("tblLogRegrMulti"),
                            group_id_colname="DATASETID",
                            obs_id_colname="OBSID",
                            var_id_colname="VARID",
                            cell_val_colname="NUM_VAL")

    fit <- glm(NULL,
                data = flMDObjectDeep)
    coeffList <- coef(fit)
    summaryList <- summary(fit)
    test_that("Check for dimensions of coefficients and summary for DeepTable ",{
        expect_equal(names(coeffList),
                     paste0("Model",unlist(flMDObjectDeep@Dimnames[[1]])))
        expect_equal(names(coeffList),
                     names(summaryList))
        expect_equal(sapply(coeffList,length),
                    sapply(colnames(flMDObjectDeep),length)-1,
                    check.names=FALSE)  ## remove -1
    })
})



