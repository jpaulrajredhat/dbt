# Use an official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install DBT
RUN pip install -U pip

# RUN pip install --no-cache-dir dbt-core==1.5 dbt-trino pandas
RUN pip install --no-cache-dir pipenv dbt-core==1.5 dbt-trino==1.5.1 dbt-fal==1.5.9 pycountry country_converter
RUN pip install numpy==1.26.4

# RUN pip install fal
# Set working directory
WORKDIR /dbt

COPY ./pcaf/ .

# Install dependencies
RUN dbt deps

# Step 5: Set environment variables (if needed for dbt profiles)
# Replace with appropriate values or secrets management
ENV DBT_PROFILES_DIR=/dbt

CMD ["dbt","run"]