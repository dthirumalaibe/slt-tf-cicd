#!/bin/bash
###############################################################################
# Name: setup.sh
# Purpose: To automate the setup of AWS CLI within Travis CI.
# Users can run this script manually after defining the
# variables described therein. These are environment variables
# which *must* be predefined in Travis before attempting CI/CD.
###############################################################################
aws configure set aws_access_key_id $AWS_ACCESS_KEY
aws configure set aws_secret_access_key $AWS_SECRET_KEY
aws configure set default.region $AWS_DEFAULT_REGION
aws configure set default.output $AWS_DEFAULT_OUTPUT
