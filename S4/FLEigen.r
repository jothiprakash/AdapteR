FLEigen <- function(FLMatrix)  {

		Matrix_ID   <- FLMatrix@MatrixID;
		Row_ID      <- FLMatrix@RowIDColName;
		Col_ID      <- FLMatrix@ColIDColName;
		Cell_Val    <- FLMatrix@CellValColName;
		MatrixTable <- FLMatrix@MatrixTableName;

		OutTable 	<- GenOutMatrixTable("FLEigenVectors",MatrixTable, Matrix_ID)		
		path        <- "SQL//FLEigenVectorUdt.sql";
		stopifnot(file.exists(path));
		sql 		<- readChar(path, nchar = file.info(path)$size);
		sql 		<- sprintf(	sql, 
								OutTable,
								Row_ID,   
								Col_ID,   
								Cell_Val,   
								MatrixTable,
								toString(Matrix_ID));
		sql <- gsub("[\r\n\t]", " ", sql);
		print(sql)
		Connection  <- FLMatrix@ODBCConnection
		sqlQuery(Connection, sql, stringsAsFactors = FALSE);
		RetData$vectors = new(	"FLMatrix", 
								ODBCConnection  = Connection,
								DBName          = FLMatrix@DBName, 
								MatrixTableName = OutTable, 
								MatrixID        = Matrix_ID, 
								MatrixIDColName = "OutputMatrixID", 
								RowIDColName    = "OutputRowNum", 
								ColIDColName    = "OutputColNum", 
								CellValColName  = "OutputVal")

		OutTable 	<- GenOutMatrixTable("FLEigenValues",MatrixTable, Matrix_ID)		
		path        <- "SQL//FLEigenValueUdt.sql";
		stopifnot(file.exists(path));
		sql 		<- readChar(path, nchar = file.info(path)$size);
		sql 		<- sprintf(	sql, 
								OutTable,
								Row_ID,   
								Col_ID,   
								Cell_Val,   
								MatrixTable,
								toString(Matrix_ID));
		sql <- gsub("[\r\n\t]", " ", sql);
		print(sql)
		Connection  <- FLMatrix@ODBCConnection
		sqlQuery(Connection, sql, stringsAsFactors = FALSE);
		RetData$values = new(	"FLMatrix", 
								ODBCConnection  = Connection,
								DBName          = FLMatrix@DBName, 
								MatrixTableName = OutTable, 
								MatrixID        = Matrix_ID, 
								MatrixIDColName = "OutputMatrixID", 
								RowIDColName    = "OutputRowNum", 
								ColIDColName    = "OutputColNum", 
								CellValColName  = "OutputVal")
		
		return(RetData);
}	