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

## Presentation & Dashboard

Google Slideshow: https://docs.google.com/presentation/d/1kjO0vaHzWOCidoWfdnLT9qGtgoUTodmvxP2sFZ1uGJk/edit#slide=id.p

Dashboard (published via Tableau Public): https://public.tableau.com/app/profile/tim5029/viz/Starfall_Dashboard/StarfallDashboard?publish=yes


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

Iterations in detail: [Databasedocumentation.docx](https://github.com/Jrheldmann/Starfall/files/10396325/Databasedocumentation.1.docx)

Using PyMongo the data was connected to the machine learning.

## Machine Learning

### Linear Regression
Using the sample_data.csv focused was placed on the "cases" and "Cost" columns, with the cases as the feature (independent variable) and the Cost as the target (dependent variable). 

 The data was scaled for cases and Cost and created a new linear regression model. The y-intercept changed due to the scaling and the slope changed from 0.06 to 0.08. There is a positive association between cases and Cost. It would be worth looking into the correlation coefficient also to see how strongly correlated the two variables are. 

### Logistical Regression
The next step was to look at logistical regression to attempt to predict Cost based on all the other 24 features in the dataset. The data was not scaled. Since Y was binary this model was rejected.

### Neural Network
Next I decided to include all of the columns besides the C_S column, which represented the county and state. A different column labeled "FIPS" is the US postal code for each row so that represents the location of the successfully with a numerical value. Since all other columns were numerical with a wide range of numbers, I decided to scale each column. Then I began creating a basic neural network. As a preliminary value, I would hope that the basic neural network yields an accuracy score of 50% or above. Based on how successful the model it, I will consider using a deep learning model by creating additional layers and neurons. 

After completing the basic neural network, using all 24 features, and 100 epochs, the accuracy is 0.0. Not the results I was looking for but I think I can improve the accuracy by removing some features. Since the basic neural network wasn't very successful, my next model will be a deep learning model since deep learning models are better at making predictions with many features. At this point, I'm hoping for the deep learning model will result in an accuracy higher than 0.0.

### Second Segment

Description of preliminary data preprocessing
- Using sample_data.csv, there are 26 columns. As a precautionary measure, all rows and columns that contain all null values will be removed. The data in this dataframe is from year 2017 to 2021. In order to not have Pre-Covid-19 data skew our results, all data prior to the year 2019 will be removed. We belive this will allow us to set a baseline of how housing costs have changed prior to the pandemic. 

Description of preliminary feature engineering and preliminary feature selection, including the decision-making process
- For the linear regression model, we will use Covid Cases as the feature, and House Cost as the target. In other models, we will removing other columns, such as county/state and per capita income, that we don't feel will be important features in predicting our target. Right now the target of House Cost is a quantitative variable, which may present a problem with neural networks. If the neural network produces results with low accuracy, we may have to create a a new column that represents whether there is a Cost Increase or Cost Decrease from the previous month. This column would be binary and might allow the neural network to have improved accuracy. 

![linear_regression](https://user-images.githubusercontent.com/109091887/209036936-a2f53f8c-03d2-4940-ba62-9372d25c919c.png)

Description of how data was split into training and testing sets
- When using the basic neural network, the train_test_split method from the sklearn library will be used. By default, the train size will be we to 0.25. 

Explanation of model choice, including limitations and benefits
- Using a linear regression model be will beneficial to use if the data continues to stay linear. This will be determined when the entire dataset is imported into the model. If the Covid Cases and House Cost do not have a linear relationship then another model will be considered. Another limitation of this model if the removal of many possible features. These other potential feature may play a big role in making predictions of the target. Other models that are being considered are logisitical regression, PCA, neural networks, and deep learning models. 

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
