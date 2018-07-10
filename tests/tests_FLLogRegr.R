
# Load the package --------------------------------------------------------

devtools::load_all(".")


# Create the object -------------------------------------------------------

deeptableMD <- FLTableMDS(getTestTableName("tblLogRegrMulti"),
                          group_id_colname = "DATASETID",
                          obs_id_colname = "OBSID",
                          var_id_colnames = "VARID",
                          cell_val_colname = "NUM_VAL")

glmfitMD <- glm(NULL, data = deeptableMD)
