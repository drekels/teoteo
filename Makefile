DISTRIBUTION_NAME := teoteo
IGNORE_DIRECTORY := ignore

PYTHON_FILES = $(shell find . -name \*.py -not -path "./ignore/*" -not -path "./test/*" -not -name setup.py)

SAMPLE_ENV := $(IGNORE_DIRECTORY)/$(DISTRIBUTION_NAME)SampleEnv
SAMPLE_ENV_PIP := $(SAMPLE_ENV)/bin/pip
SAMPLE_ENV_PYTHON := $(SAMPLE_ENV)/bin/python

TEST_ENV := $(IGNORE_DIRECTORY)/$(DISTRIBUTION_NAME)TestEnv
TEST_ENV_PIP := $(TEST_ENV)/bin/pip
TEST_ENV_NOSE := $(TEST_ENV)/bin/nosetests

DIST_DIR := dist/

dist: setup.py $(PYTHON_FILES) requirements.txt README MANIFEST.in MAKEFILE
	rm -f -r dist
	/usr/bin/env python setup.py sdist 

.PHONY: sampleEnv
sampleEnv: $(SAMPLE_ENV)
$(SAMPLE_ENV): dist $(IGNORE_DIRECTORY)
	rm -f -r $(SAMPLE_ENV)
	virtualenv $(SAMPLE_ENV) --no-site-packages
	$(SAMPLE_ENV_PIP) install $(DIST_DIR)/$(DISTRIBUTION_NAME)*

.PHONY: testEnv
testEnv: $(TEST_ENV) 
UNDEFINED VALUE: requirements.txt MAKEFILE $(IGNORE_DIRECTORY)
	rm -f -r $(TEST_ENV)
	virtualenv $(TEST_ENV) --no-site-packages
	$(TEST_ENV_PIP) install -r requirements.txt
	$(TEST_ENV_PIP) install mock
	$(TEST_ENV_PIP) install unittest2
	$(TEST_ENV_PIP) install nose

.PHONY: clean
clean:
	rm -f -r $(DISTRIBUTION_NAME).egg-info build dist MANIFEST $(SAMPLE_ENV) $(TEST_ENV)

.PHONY: pyshell
pyshell: $(SAMPLE_ENV)
	$(SAMPLE_ENV_PYTHON)

.PHONY: test
test: $(TEST_ENV)
	$(TEST_ENV_NOSE)

.PHONY: debug
debug: $(TEST_ENV)
	$(TEST_ENV_NOSE) -s

$(IGNORE_DIRECTORY):
	mkdir $(IGNORE_DIRECTORY)
