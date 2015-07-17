## ---- eval=FALSE, echo=TRUE----------------------------------------------
#  # options(Elsevier_API = "F1QH-Q64B-BSBI-JASJ", Elsevier_TM_API = "1QH-Q64B-BSBI-JAS")
#  

## ---- echo=F, eval=TRUE--------------------------------------------------
library(ElsevierR)

options(Elsevier_API = "5b4c22442fdb5685587b566c7de8a567", Elsevier_TM_API = "c2494d00460743fb8a299ca3de737083")

# auth_key(NULL)
# auth_tm_key(NULL)

## ------------------------------------------------------------------------
citation_count_scopus(value ="DOI(10.1016/S0014-5793(01)03313-0)")

