# IMDb-Analysis

## Used Technologies

Tools used for this project:

Docker - for using images;
Mage AI - for downloading and uploading raw data to BigQuery and orchestration;
Terraform - as Infrastructure-as-Code (IaC) tool;
Google Compute Engine - as a virtual machine;
Google Cloud Storage - for storage terraform files;
Google BigQuery - for the project Data Warehouse;
dbt - for the transformation of raw data;
Google Looker studio - for visualizations.

The project pulls data from IMDb Developer daily, upload it to BigQuery by using Mage AI, uses dbt to transform raw data from BigQuery and upload it back daily, Terraform used to upload configuration to Google Cloud Storage. Looker studio was used for visualizations

## Problem description

In nowadays there is a lot of movies, tv programms, shows e.t.c. is creating every year. And i got a question: What is the most popular genre of this shows and how people rating them? To build this project i'm using a publicly available dataset provided by [IMDb Developer](https://datasets.imdbws.com/).
Tasks for project:
Upload data from source to BigQuery on schedule
Transform data in dbt to create a table with common dataset, create table for reporting, upload it to BigQuery
Use Looker Studio for visualisation


## Cloud

Project created with Google Cloud Virtual Machine, uses Terraform

## Data ingestion and Workflow orchestration

The project pulls data from IMDb Developer daily, upload it to BigQuery by using Mage AI python scripts.

mage ai dag

## Data warehouse and Transformations (dbt)

dbt was used to transform raw data from BigQuery and upload it back daily,

dbt dag

dbt structure

## Dashboard

Looker studio was used for visualizations with (2 tiles)[source]

# How to reproduce

Next steps will help to reproduce the project

## Setting up a virtual machine

The best practice to setup a virtual machine is to follow a fully completed guide from [DeZoomcamp](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=15). 
This video includes:
Generating SSH keys
Creating a virtual machine on GCP
Connecting to the VM with SSH
Installing Anaconda (not necessary)
Installing Docker
Creating SSH config file
Accessing the remote machine with VS Code and SSH remote
Installing docker-compose
Installing pgcli (not necessary)
Port-forwarding with VS code: connecting to pgAdmin and Jupyter from the local computer (not necessary, but port forwarding part is useful)
Installing Terraform (as example)
Using sftp for putting the credentials to the remote machine
Shutting down and removing the instance

Also we need a fully setupped BigQuery on Google cloud with proper permissions.

## Uploading raw data to BigQuery

I'm using VS Code to connect to my virtual machine.
Mage AI used as orchestator tool that uploads the dataset to BigQuery everyday. 
If you want to reproduce my project, then clone my repo to your machine.


1. Navigate to mage-data and start command 
```
docker-compose build
docker-compose up
```
2. To config Mage AI add your .json API key from Google Cloud to mage-data/ folder
2. After that Mage AI is up and can be connected on localhost:6789.
3. In pipelines blocks for loading and uploading data was created

image about pipelines

4. Run pipelines manually or create triggers to run on schedule

image triggers

5. Open BigQuery on Google cloud and look at uploaded data

BigQuery image imdb data

## Transforming using dbt

1. Create dbt account, setup the project. Follow the (instructions)[https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/dbt_cloud_setup.md] to setup it properly
2. Connect your account to github in profile settings
3. Run dbt build
4. The new dataset created in BigQuery with several view and materialized table. Common data is partitioned and clustered.

imdb dbt image

## Dashboard

1. Create a new report in Looker Studio
2. Add BigQuery table (filmes_by_genre table in my project) as data source
3. Create a tile and configure as you like

Looker studio data source image



