Real-Time Road Accident Data Analysis
This project focuses on analyzing real-time road accident data in New York City using APIs, Python, SQL, and MySQL. It covers the complete data pipeline from collection to analysis and prediction. The goal is to uncover insights from accident trends and support traffic safety improvements.

Problem Statement
Accidents in metro cities like NYC lead to loss of life and property. This project aims to identify accident patterns and high-risk areas using real-time data to assist in better decision-making for traffic planning and public safety.

Objectives
Collect real-time accident data from NYC Open Data API
Clean, transform, and store the data in MySQL
Perform Exploratory Data Analysis (EDA) using SQL
Visualize accident trends and patterns using Python
Build a model to predict accident boroughs
Forecast accident trends using time series analysis

Tools and Technologies

Python
MySQL
SQLAlchemy
Pandas
Matplotlib, Seaborn, Plotly
Git & GitHub

Project Breakdown
ETL Pipeline
Data fetched from NYC’s Open Data API
Transformed by handling nulls, converting data types, and feature engineering
Loaded into MySQL database using the append method

EDA using SQL
Created summary tables and views like:
daily_accident_summary
top_dangerous_streets
hourly_accident_distribution
borough_street_hotspots

Visualizations
Daily trends (line plot)
Dangerous streets (bar chart)
Hourly accident patterns (bar chart)
Borough hotspots (bar chart)

Predictive Modeling
Random Forest classifier to predict borough of accident
Feature importance and accuracy evaluation
Time Series Forecasting
Used ARIMA model to forecast daily accident counts
Applied seasonal decomposition and stationarity tests

Key Insights
Accidents spike during specific hours and days
Certain boroughs and streets are consistently high-risk
Predictive models and trends can assist in proactive safety measures
