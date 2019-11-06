# VIPNp
This app can be used to predict probability that ALL patients are susceptible to vincristine-induced peripheral neuropathy (VIPN), using their metabolite profiles, based on our trained SVM models.

Prediction can be done using blood samples collected on day 8 and 6 months of the treatment. Only selected metabolites are needed. Please see the template csv files for the metabolites that are required. Molecular mass and retention times of those metabolites are specified. Please add the metabolite profile of new patients to the right of each of these metabolites. Thus, every column will correspond to one patient, and every row will correspond to one metabolite. As mentioned in the templates, only two metabolites are needed for day 8 prediction, and 21 for 6 months prediction. 

If you have the actual data of VIPN susceptibility of each of these patients, you can also upload that. Simply upload a csv file with a single column, where row entry will either be "High" or "Low". Upon uploading that, you can see the confusion matrix and other accuracy parameters to test our model accuracy. Check out this [link](https://parulv1.shinyapps.io/vipnp_shiny/) for VIPNp on the shinyapps server. 

Note: Our model cannot handle missing data. Please estimate it before uploading the metabolite profile. We recommend to estimate missing data by manually inspecting each chromatogram peak and reintegrating the peaks if required. Caret and e1071 packages are needed to run this app. Please install them before using VIPNp.
