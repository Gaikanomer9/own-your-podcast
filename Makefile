.DEFAULT_GOAL = help

PROJECT_ID      ?= project_id
GCS_BUCKET      ?= example.com
LOCATION        ?= EUROPE-WEST2
STORAGE_CLASS   ?= STANDARD

help:
	@echo "First create a GCP environment by running \"make prepare_gcp_env\""
	@echo "Then run \"make dry-update\" to check the generated XML feed."
	@echo "Finally push changes to GCP via \"make update\" command."
.PHONY: help

prepare_gcp_env:
	@echo "Preparing GCP environment"
	gcloud auth login
	gcloud config set project $(PROJECT_ID)
	gsutil mb -p $(PROJECT_ID) -c $(STORAGE_CLASS) -l $(LOCATION) gs://$(GCS_BUCKET)
	gsutil iam ch allUsers:objectViewer gs://$(GCS_BUCKET)
.PHONY: prepare_gcp_env