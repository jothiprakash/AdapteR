CALL FLRegrDataPrep(
'%tableName',
'%primaryKey',
NULL,
'%deepTableName',
'%obsID',
'%varID',
'%value',
%catToDummy,
%performNorm,
%performVarReduc,
%makeDataSparse,
%minStdDev,
%maxCorrel
1,
'%excludeString',
'%classSpecString',
'%whereClause',
'%inAnalysisID',
AnalysisID);