CREATE TABLE covidhousing (
	 cost_house int,
     fip_year_month VARCHAR(40),
     fip_year VARCHAR(40),
	 cases int,
     PRIMARY KEY (fip_year_month)
);

CREATE TABLE demographics (
	 PCIncome int,
	 fip_year VARCHAR(40),
     fips VARCHAR(40),
	 POPESTIMATE int,
	 MFratio FLOAT,
	 POPEST_MALE int,
	 POPEST_FEM int,
	 MEDIAN_AGE_TOT FLOAT,
	 UNDER5_TOT int,
	 AGE513_TOT int,
	 AGE1544_TOT int,
	 AGE4564_TOT int,
	 AGE65PLUS_TOT int,
	 RUCC_2013 int,
	 WA int,
	 BA int,
	 IA int,
	 AA	int,
	 NA	int,
	 TOM int,
	 NH int,
	 H int,
     PRIMARY KEY (fip_year)
);

CREATE TABLE Merged AS(
SELECT covidhousing.cost_house, covidhousing.cases,covidhousing.fip_year_month,demographics.fips,
demographics.PCIncome,demographics.POPESTIMATE,demographics.mfratio,demographics.popest_male,demographics.popest_fem,
demographics.median_age_tot, demographics.under5_tot, demographics.age513_tot, demographics.age1544_tot, 
demographics.age4564_tot, demographics.age65plus_tot, demographics.rucc_2013, demographics.WA, demographics.BA, 
demographics.IA, demographics.AA, demographics.NA, demographics.TOM, demographics.NH, demographics.H
FROM covidhousing
JOIN demographics
ON covidhousing.fip_year = demographics.fip_year)