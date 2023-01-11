![covid-housing](https://github.com/Jrheldmann/Starfall/blob/main/Square_role/readMeResources/covid-housing.png)
# Covid-19 Impact on Housing Prices in the US
## Group Members
 Members     | Role     |    Responsibilities  |
| ------------- | ------------- | -------- |
| Juhi          | Database  Lead       | Create databases |
| Will| Technology Lead         | 	Machine learning model|
| Tim |Dashboard Lead | Create a dashboard to present the data|
| Joe| Github Lead | Responsible for updating the repository and ReadMe|

## Overview 

### Selected Topic

Team Starfall has chosen to develop a machine learning model to predict the change in housing prices in a given U.S. county based on the number of local COVID cases. Demographic data for each county will also be taken into consideration. In the U.S., there is a wide variety of socioeconomic statuses and pre-existing housing market conditions in a given county. Because buying or selling a home is such a major life event and financial strain, these demographic data must be included because we expect that the predictive power of any model will likely vary from county to county based on some of these factors.

### Selection Rationale

The team initially sought to use COVID datasets to predict spikes in COVID cases in a given U.S. county based on trends in historic weekly COVID data from that county. This seemed like a good topic for its inherent current cultural relevance, as well as the volume of COVID case data publicly available from the Centers for Disease Control (CDC). As per recommendations from the instructor and teaching assistant regarding the scope of that investigation being too large and not having a clearly defined business-use case, we decided to pivot to a modified topic.

After analysis the  county-based COVID case dataset were retained, but shifted the target prediction to home sales. This was a good compromise to retain our initial interest in a current and impactful topic. While it might seem counter-intuitive, adding the home sales data as a predictive target did actually narrow the scope of the machine learning model. Rather than trying to train a model to use one set of historic COVID data to predict that same type of data might change in the future, we can now use the historic COVID data and the temporally and geographically matched housing data to train a model to only predict the housing data's changes. This is much more likely to lead to a successful machine learning model, and also draws a much clearer picture of how that model can be used for a business use.

### Data sources

As previously stated, COVID case data by county was sourced from the CDC. Demographic data by county was sourced from the U.S. Census Bureau, Rural-Urban Continuum Codes were sourced from the U.S. Department of Agriculture, and home sales data by county was sourced from Zillow.
Dependent Variable- Zillow Housing data: https://www.zillow.com/research/data/

* This data is the typical value of a home in a specific county at a specific time.

Rural vs Urban counties- Rural-Urban Continuum Codes:https://www.ers.usda.gov/data-products/rural-urban-continuum-codes.aspx

* This is data that the Department of Agriculture uses to determine what counties are Urban vs Rural.

Income per capita- ACS: https://data.census.gov/table?q=B19301:+PER+CAPITA+INCOME+IN+THE+PAST+12+MONTHS+(IN+2021+INFLATION-ADJUSTED+DOLLARS)&g=0100000US,$0500000&tid=ACSDT1Y2021.B19301

* This is ACS data from 2019-2021 for per capita income by county.

Population/Age/Sex 2017-2019- CC-EST2020-AGESEX-ALL.csv:https://www2.census.gov/programs-surveys/popest/datasets/2010-2020/counties/asrh/ Race/Ethnicity 2017-2019-CC-EST2020-AL6LDATA.csv:https://www2.census.gov/programs-surveys/popest/datasets/2010-2020/counties/asrh/

Population/Age/Sex 2020-2021 cc-est2021-agesex-all.csv:https://www2.census.gov/programs-surveys/popest/datasets/2020-2021/counties/asrh/

* These sets of data are age and sex data for 2019-2021 from the US cenusus. 

Race/Ethnicity 2020-2021 cc-est2021-all.csv:https://www2.census.gov/programs-surveys/popest/datasets/2020-2021/counties/asrh/

* These sets of data are race and ethnicity data for 2019-2021 from the US cenusus. 

COVID-19 data: https://data.cdc.gov/Public-Health-Surveillance/United-States-COVID-19-Community-Levels-by-County/3nnm-4jni (Split into years for CSV size)

* This COVID-10 data is from the CDC. 

FIPS: https://github.com/kjhealy/us-county/blob/master/data/census/fips-by-state.csv

* This reflects fips data. FIPS is the code that the US uses to catagorize each county in the US.

### Questions to be answered

Did COVID-19 cases correlate with changes in home prices?

Using x factors can one predict future housing trends?

X:

- Population number

- Rural Urban Continuum provided by the Department of Agriculture

- Median age

- Race/Ethnicity

- Gender ratio

- Per Capita income 

Are home prices in rural, suburban, and urban areas being impacted the same way by COVID cases, or is the rate of home price change different based on these location classifications?

## Presentation & Dashboard & Database

Google Slideshow: https://docs.google.com/presentation/d/1kjO0vaHzWOCidoWfdnLT9qGtgoUTodmvxP2sFZ1uGJk/edit#slide=id.p

Tableau Public Workbook: https://public.tableau.com/app/profile/tim5029/viz/Starfall_Dashboard/StarfallDashboard?publish=yes


## Data Base

Data was cleaned (removing counties not in the US such as Washington DC or US territories, years not inbetween 2019 and 2021, and missing data).

Data that had multiple csv's were contacantated into one database, at this point we had 6 databases: income, race/ethnicity, population, Rural/urban, Zillow housing, COVID cases, and Fips. 
A challange at this point was making the time series Zillow file into multiple rows. This was done using the pd.stack() method. 

All databases were made sure to have either a FIPs, countyname,Statename, or countyname,StateAbrivation so that FIPS database can be used to join all databases. After this we have not yet removed the unneeded columns. 

ERD:

![ERD](https://user-images.githubusercontent.com/109693301/207495541-33df45d6-d182-4eb1-b512-86207fc6ce04.png)


All tables are connected by fips, fips by year, and fips by year and month. This ERD only contains columns we are going to keep.

Data was merged into two dataframes in pandas housing/covid data and demographic (population, race/eth, income, and Rural/urban areas). This was was uploaded to MongoAtlas. Within SQL we were able to merge both sets of data into merged_data and uploaded into MongoAtlas. All uploads used PyMongo.

After looking at tablaeu it was realized that the New York City did not have any COVID data so that was removed beinging the final number of rows to 95131.

Final database both in MongoDB but also in Circle folder under merged_data

Iterations in detail: (Insert link currently in Circle folder, Circle_roleReadMe.txt)

Using PyMongo the data was connected to the machine learning.

## Machine Learning

Description of data preprocessing

- Using the final data set, preprocessing began with removing any rows or columns that contained null values. Using the years 2019, 2020, and 2021 will allow the machine learning models to make conclusions from data pre-covid, covid's peak, and the subsiding of covid. The columns “_id” will be removed due to it being a string. 

Description of feature engineering and the feature selection, including the decision-making process

- Due to there being 24 columns in the final data set, not all features will be used. In order to determine which features are good predictors of the target, each feature will be compared with the target and the correlation will be calculated. Any feature that has a correlation coefficient less than 0.20 will be removed before entering the data into the deep learning model.
- Features with large correlations will be used in the linear regression model, with the house cost as the target.

Description of how data was split into training and testing sets

- When using the deep learning model, the train_test_split method from the sklearn library will be used. By default, the train size will be we to 0.25.

Explanation of model choice, including limitations and benefits

- Using a linear regression model be will beneficial because it will show the correlation with the specific feature and the target, house cost. After the correlation between each feature was calculated, select features will be used in the regression model. Below are the three regression models that were most prominant.


![linear_regression_cases_cost](https://user-images.githubusercontent.com/109091887/211933815-943ff311-e58f-4cd7-963a-21ec0495b705.png) ![linear_regression_pcincome_cost](https://user-images.githubusercontent.com/109091887/211933842-2f63304f-d1e7-4b91-9d69-825deaa17ced.png) ![linear_regression_medage_cost](https://user-images.githubusercontent.com/109091887/211933852-1484d8a9-578b-42dc-bc6f-f18ee932bc36.png)

A limitation of the linear regression model is the removal of many features. These other features may potentially play a big role in making predictions of the target. Also multiple features being used at the same time could improve a more sophisticated machine learning model.

Explanation of changes in model choice (if changes occurred between the Segment 2 and Segment 3 deliverables)

- After using the final data in the linear regression model, certain features do show a moderate linear pattern with house cost. Although this machine learning model does give us some insight, additional machine learning models will be considered. In order to include multiple features at once, a deep learning neural network was implemented next. Features that showed a correlation of less than 0.2 when compared with house cost were removed before training the model. 

Description of how the model was trained (or retrained, if the team is using an existing model)

- The deep learning model was designed using 18 features (input dimenstions), two hidden layers of 8 and 4 neurons (using the relu activation function), and one output layer (using the sigmoid activation function). At first, the model was not successful in training and predicted house cost based on all features. Several adjustments were made in attempt to improve the current accuracy score of 0. The scaler function was changed from StandardScaler to MinMaxScaler so values are scaled from 0 to 1 instead of -1 to 1. The first layer's activation function was changed from sigmoid to relu but the output layer is kept as sigmoid. This resulted in an improved accuracy score.

![Deep_Learning_Epochs_Accuracy](https://user-images.githubusercontent.com/109091887/211936382-47601fa6-13fe-4c42-a0b4-c09c41fd6aee.PNG)

Description and explanation of model's confusion matrix, including final accuracy score

- An unsupervised learning model was not used therefore there is no confusion matrix.  
- Accuracy score improved from 0 to 2.7979e-05.

## Conclusion
Ultimately, the results demonstrate that 'Per Capita Income' was the largest factor in regards to Typical Housing Value and that there isn't a strong correlation between the Covid Cases Total and Typical Housing Value despite an obvious skew in value across metro, metro-adjacent, and rural designated counties. 
Sadly, Deep Learning didn't prove compatible with the available data due to high loss values.

## Future Work

* Add in 2022 data when it becomes available
* Conduct a literature review of past economic research into housing market fluctuations
* Consider alternative analogous measures (e.g. population density of a county rather than RUCC, GDP of a county rather than income per capita)
* Account for changes in relative numbers of renters vs. owners, changes in rent prices
* Comparative analysis of vaccine hesitancy and vaccine uptake by county
* Explore alternative methods for addressing outliers and missing data
* Address discrepancies between county population & case numbers (e.g. Los Angeles County)

## What would we change?

* Look at demographics as percentages instead of raw numbers
* Find COVID case data for New York City


## Technology Used
#### Data Exploration: 
Python, SQL, MongoAtlas, MongoDB

#### Data Analysis: 
Python, Jupyter Notebook, Pandas, Google Collab, Java, Html

#### Dashboard: 
Tableau

#### Communitication: 
GitHub, Slack

#### Algorithms: 
Linear regression

### Library

#### Database:
Pandas, Numpy, Json, PyMongo

#### Data Analysis
Numpy, Pandas, Collections (Counter), matplotlib (plt), skleran.linear_model (LinearRegression), sklearn.preprocessing (StandardScaler), PyMongo, Json
