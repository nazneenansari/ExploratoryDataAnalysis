# Lending Club Case Study
  This case study aims to give us an idea of applying EDA in a real business scenario. In this case study, we develop a basic understanding of risk analytics in banking and financial services and understand how data is used to minimise the risk of losing money while lending to customers.


## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Conclusions](#conclusions)
* [Acknowledgements](#acknowledgements)

<!-- You can include any other section that is pertinent to your problem -->

## General Information
  #### Problem Statement
The lending company facilitates personal loans, business loans, and financing of medical procedures. Borrowers can easily access lower interest rate loans through a fast online interface. However, lending loans to ‘risky’ applicants is the largest source of financial loss (called credit loss). The credit loss is the amount of money lost by the lender when the borrower refuses to pay or runs away with the money owed.
Thus, the company wants to understand the driving factors (or driver variables) behind loan default, i.e. the variables which are strong indicators of default.  The company can utilise this knowledge for its portfolio and risk assessment before approving any loan application.
 #### Dataset
Dataset contains the complete loan data for all loans issued through the time period 2007 to 2011. The given dataset contains the information about past loan applicants and whether they ‘defaulted’ or not.It contains all the approved loan data with customer information and customer behaviorial data. There is no transactional history of those applicants whose loan is rejected by the company and so this data is not available with the company (and thus in this dataset).


<!-- You don't have to answer all the questions - just the ones relevant to your project. -->

## Conclusions
- Loans with funded amount between 0-5k & loans with borrowers annual income between 30k-45k needs to be verified.
- Borrowers with high open to total account ratio and interest rate (~12.5%) for the loan term of 36 months, tend to default, hence need to be monitored.
- Borrowers with 10+ years and less than 1 year of work experience with annual income in the range of 45k-60k and 15k-45k respectively, and funded amount 5k-10k and 0-5k respectively, tend to default, hence to be asked to submit some security against the loan.
- Citizens from California who borrowed loan for debt consolidation need to be watched.
- The borrowers with grade B and sub-grade B5 are tend to be Charged Off more.
- People having rented home tend to charged off, followed by ones having home ownership as Mortgage.
- Account holders with high open to total account ratio with funded loan amount of 0-5k and an annual income of 0-15k are more prone to miss their repayment on time.
- The maximum number of Charged Off loans are in the DTI (debt-toincome) range of 12-18. Loans which are Not Verified in the DTI range of 12-18 tend to Charged Off.

<!-- You don't have to answer all the questions - just the ones relevant to your project. -->


## Technologies Used
- Numpy - version 1.20.3
- Pandas - version 1.3.4
- Seaborn - version 0.11.2
- Matplotlib - version 3.4.3
- Pandas Profiling - version 3.1.1

<!-- As the libraries versions keep on changing, it is recommended to mention the version of library used in this project -->

## Acknowledgements
- References
  1. https://www.lendingclub.com/foliofn/rateDetail.action
  2. https://pandas.pydata.org/docs/
  3. https://numpy.org/doc/stable/
  4. https://seaborn.pydata.org/
  5. https://matplotlib.org/
  6. https://github.com/pandas-profiling/pandas-profiling

## Contact
Created by 
- Chetan Desai [@MrChetanDesai]
- Nazneen Ansari [@nazneenansari]



<!-- Optional -->
<!-- ## License -->
<!-- This project is open source and available under the [... License](). -->

<!-- You don't have to include all sections - just the one's relevant to your project -->
