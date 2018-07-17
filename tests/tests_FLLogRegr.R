
# Load the package --------------------------------------------------------

devtools::load_all(".")


# Create the object -------------------------------------------------------

deeptableMDS <- FLTableMDS(getTestTableName("tblLogRegrMulti"),
                           group_id_colname = "DATASETID",
                           obs_id_colname = "OBSID",
                           var_id_colnames = "VARID",
                           cell_val_colname = "NUM_VAL")

glmfitMDS <- glm(NULL, data = deeptableMDS)

# MDS coefficients
glmfitMDS$coefficients
