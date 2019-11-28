# VIPNp: Prediction of VIPN in pediatric leukemic cancer patients

The purpose of this app is to predict probability that acute lymphoblastic leukemia (ALL) patients are susceptible to vincristine-induced peripheral neuropathy (VIPN), using their metabolite profiles. It is based on our trained SVM models --- see [the paper](https://www.medrxiv.org/content/10.1101/19013078v1) for details. 

The app can be run online [at this link](https://parulv1.shinyapps.io/vipnp_shiny/) or [locally, using R](#running-locally).

## Table of Contents

- [Purpose](#purpose)
- [Input Format](#input-format)
- [Model Comparison](#model-comparison)
- [Running Locally](#running-locally)
- [Handling Missing Data](#handling-missing-data)
- [Contact](#contact)
- [Cite](#cite)

## Purpose

VIPN is a numbing and painful sensation felt in the hands and feet, as a result of treatment with vincristine, a common chemotherapy drug. Currently, there are no established ways of predicting VIPN in patients, leading to suboptimal treatment for them. We use a metabolomics-based approach to predict VIPN in pediatric patients undergoing treatment with vincristine for ALL, at early stages of the treatment. We hope that this work can help physicians in making vincristine dosage decision for more effective treatment of ALL.


## Input Format
Predictions are made using metabolite profiles obtained from patient blood samples collected on either day 8 or 6 months of the chemotherapy treatment. 
The app expects inputs in csv format --- see templates for [day 8](https://github.com/parulv1/VIPNp/blob/master/Day8Template.csv) and [6 months](https://github.com/parulv1/VIPNp/blob/master/Mo6Template.csv).

Molecular mass and retention times of those metabolites are specified in this format: `<molecular mass (in Da)>@<retention time (in mins)>`. Please add the expression of each of these metabolites (as obtained from mass spectrometry and normalized by sample volume) of new patients to the right of each of these metabolites. See example below. Thus, every column will correspond to one patient, and every row will correspond to one metabolite. Note that only two metabolites are needed for a day 8 prediction, while 21 metabolites are needed for 6 month prediction --- see the template files for the exact names.

Example input file for `m` patients with `n` metabolites:
```
<mass of metabolite M_1 (in Da)>@<retention time of metabolite M_1>, <observation of M_1 for patient 1>, <observation of M_1 for patient 2>, ..., <observation of M_1 for patient m>
...
<mass of metabolite M_n (in Da)>@<retention time of metabolite M_n>, <observation of M_n for patient 1>, <observation of M_n for patient 2>, ..., <observation of M_n for patient m>
```

For details on mass spectrometry, see Methods section (page 13) of [the paper](https://www.medrxiv.org/content/10.1101/19013078v1).


## Model Comparison
If you have the actual data of VIPN susceptibility of each of these patients, you can also upload that. Simply upload a csv file with a single column, where row entry will either be "High" or "Low". Upon uploading that, you can see the confusion matrix and other accuracy parameters to test our model accuracy. See page 3 of [the paper](https://www.medrxiv.org/content/10.1101/19013078v1) for details on how to phenotype the patients.

Example predictions file:
```
High
Low
...
High
```
Note that the predictions file must have `m` lines, with one line for each of the patients specified in the metabolite input profile above in the same order.



## Running Locally
After installing the R packages `shiny`, `caret`, and `e1071`,
this app can be run locally using R as follows:
```
> library(shiny)    
> runGitHub("VIPNp", "parulv1")
```

## Handling Missing Data
Note: Our model cannot handle missing data. Please estimate it before uploading the metabolite profile. We recommend to estimate missing data by manually inspecting each chromatogram peak obtained from mass spectrometry and reintegrating the peaks if required.

## Contact
If you have questions regarding the usage of this app, please contact [Parul Verma](https://parulv1.github.io/).

## Cite
If you found this package useful, please cite the following work.

```
@article{Verma2019VIPNp,
title = {A {M}etabolomics {A}pproach for {E}arly {P}rediction of {V}incristine-{I}nduced {P}eripheral {N}europathy},
author = {Verma, Parul and Deveraj, Jayachandran and Skiles, Jodi L. and Sajdyk, Tammy and Smith, Ellen M.L. and
          Ho, Richard H. and Hutchinson, Raymond and Wells, Elizabeth and   Li, Lang and  
          Renbarger, Jamie and Cooper, Bruce and Ramkrishna, Doraiswami},
journal = {Preprint},
year = {2019},
url = {https://www.medrxiv.org/content/10.1101/19013078v1}
}
```
