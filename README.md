# MusicOset Acoustic Features Analysis

This repository contains R code used to explore, visualize, and model the MusicOset acoustic features dataset. The analysis includes data preprocessing, exploratory data analysis (EDA), regression modelling, and classification tasks.

# Project Overview

The goal of this project is to investigate relationships between musical features such as energy, loudness, danceability, tempo and others using statistical and machine learning techniques.

The analysis includes:

Data import & cleaning,
Summary statistics & structure checks,
Exploratory visualizations,
Correlation analysis,
Simple & multiple linear regression,
Logistic regression classification,
Model evaluation (accuracy, precision, recall, F1-score)

# Libraries Used

The analysis uses the following R packages:

library(tidyverse)

# Data Description

The dataset ('musicoset_songfeatures_acoustic_features.csv') contains Spotify-like musical features such as:

tempo,
energy,
loudness,
danceability,
acousticness,
valence,
key(categorical),
mode(categorical),
time_signature(categorical)

The script converts relevant columns into factors to support modelling.

# Key Steps in the Analysis

1. Data Import

The dataset is loaded using 'read_delim()' with tab-separated formatting.

2. Missing Data Check

A summary table is created to identify missing values across all variables.

3. Exploratory Data Analysis

The script includes:

Histogram of tempo,
Histogram of energy,
Boxplot of loudness,
Scatterplot: energy vs loudness

4. Correlation Analysis

Correlation tests evaluate relationships between:

Energy ↔ Loudness
Danceability ↔ Tempo

5. Regression Models

Simple Linear Regression: loudness ~ energy
Multiple Linear Regression: loudness ~ energy + danceability + acousticness + valence
Includes regression visualizations and prediction diagnostics.

6. Classification Model

A binary variable high_energy is created based on median energy.
A logistic regression model is trained using:

loudness
danceability
tempo

# Visualizations

The script generates several plots using 'ggplot2', enabling intuitive understanding of distributions and relationships.

# Results Summary 

Strong correlation observed between energy and loudness,
Regression models show energy as a significant predictor,

Logistic classification yields reasonable performance with calculated accuracy, precision, recall, and F1

# How to Run the Code

1. Clone this repository:
2. Open R or RStudio
3. Install required libraries:
   install.packages("tidyverse")
4. Run the script in R or RStudio
5. Ensure the dataset path is correctly set to your local directory



