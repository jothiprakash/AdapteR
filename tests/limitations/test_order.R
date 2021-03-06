Renv <- new.env(parent = globalenv())

Renv$x <- c(1,1,3:1,1:4,3);
Renv$y <- c(9,9:1);
Renv$z <- c(2,1:9)
Renv$cy <- as.character(Renv$y)
Renv$x1 <- c(5:1, 6:8, 12:9)
#Renv$y1 <- (Renv$x1 - 5)^2
Renv$a <- c(4, 3, 2, NA, 1)
Renv$b <- c(4, NA, 2, 7, 1)
#Renv$z1 <- cbind(Renv$a, Renv$b)
Renv$dd <- data.frame(Renv$x, Renv$y, Renv$z)
Renv$d4 <- data.frame(x = round(rnorm(100)), y = round(10*runif(100)),
                      z = round( 8*rnorm(100)), u = round(50*runif(100)))

FLenv <- as.FL(Renv)

as.FL(Renv$dd)

test_that("order: Sorting data frames with specified columns",{
    eval_expect_equal({
        # Either as above {for factor 'z' : using internal coding}:
        test4 <- dd[order(x, -y, z), ] 
    },Renv,FLenv)
})       

test_that("order: Sorting data frames, along 1st column, ties along 2nd, ... *arbitrary* no.{columns}",{
    eval_expect_equal({
        test5 <- dd[ do.call(order, dd), ]
        d4s <- d4[ do.call(order, d4), ]    #do.call not in FL
    },Renv,FLenv)
})       



#set.seed(1)  # reproducible example:    #Cannot set seed
#i <- which(diff(d4s[, 3]) == 0)    #diff not in FL
#   in 2 places, needed 3 cols to break ties:
#gh <- d4s[ rbind(i, i+1), ]

## test2 <- rbind(x, y, z)[, order(x, -xtfrm(cy), z)]     xtfrm and rbind(all in comments) not for FL

test_that("order: NA values supported",{eval_expect_equal({

  #test5 <- rbind(x1[o], y1[o])   #rbind 
  o1 <- order(a, b)
  #(o2 <- order(a, b, na.last = FALSE));
  #(o3 <- order(a, b, na.last = NA)); 
  },Renv,FLenv)
})

