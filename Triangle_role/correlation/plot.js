// 12.2.2

// var sortedCities = cityGrowths.sort((a,b) => a.Increase_from_2016 - b.Increase_from_2016).reverse(); 

// var topFiveCities = sortedCities.slice(0,5);

// var topFiveCityNames = topFiveCities.map(city => city.City);
// var topFiveCityGrowths = topFiveCities.map(city => parseInt(city.Increase_from_2016));

// var trace = {
//     x: topFiveCityNames,
//     y: topFiveCityGrowths,
//     type: "bar"
//   };
//   var data = [trace];
//   var layout = {
//     title: "Most Rapidly Growing Cities",
//     xaxis: {title: "City" },
//     yaxis: {title: "Population Growth, 2016-2017"}
//   };
//   Plotly.newPlot("bar-plot", data, layout);

// 12.2.2 SKILL DRILL
// Use the same dataset to create a bar chart of the seven largest cities by population.

var sortedCorr = featureCorrelations.sort((a,b) => a.Correlation - b.Correlation).reverse(); 

var FeatureNames = sortedCorr.map(feature => feature.Feature);
var FeatureCorr = sortedCorr.map(feature => feature.Correlation);

var trace = {
    x: FeatureNames,
    y: FeatureCorr,
    type: "bar"
  };
  var data = [trace];
  var layout = {
    title: "Correlation with House Cost",
    xaxis: {title: "Feature" },
    yaxis: {title: "Correlation"}
  };
  Plotly.newPlot("bar-plot", data, layout);