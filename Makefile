#!/bin/bash

# ===========================================================
# Author:   Marcos Lin, Hooman Korasani
# Created:	03 May 2013
# Updated:	11 Dec 2013    
#
# Makefile used to setup django-appengine-template application
#
# ===========================================================

SRC           = src
PTENV         = prt-env
PIP           = $(PTENV)/bin/pip
PYLIB_REQ     = tools/pylib_req.txt
PYLIB_REQ_PRE = tools/pylib_req_pre.txt
PYLIB_SRC     = $(SRC)/lib
PKG_DEF       = django isodate dateutil pytz rauth passlib PIL unittest2 nose
PKG_DEF_PY    = facebook.py

# ------------------
# USAGE: First target called if no target specified
man :
	@cat readme.make
	@cat pylib_req.txt

# ------------------
# Define file needed
$(PIP) :
ifeq ($(shell which virtualenv),)
	$(error virtualenv command needed to be installed.)
endif
	@mkdir -p $(PYLIB_SRC)	
	@virtualenv --no-site-packages $(PTENV)


$(PTENV)/pylib_req.txt : $(PYLIB_REQ)
	@$(PIP) install -r $(PYLIB_REQ)
	@$(PIP) install --pre -r $(PYLIB_REQ_PRE)
	@cp -a $(PYLIB_REQ) $@


# ------------------
# MAIN TARGETS
virtualenv : $(PIP) $(PTENV)/pylib_req.txt $(PYLIB_SRC)

setup_lib : $(PTENV)/lib/python2.7/site-packages
	@for dir in $(PKG_DEF); do \
		mkdir -p $(PYLIB_SRC)/$$dir; \
		rsync -av $^/$$dir/ $(PYLIB_SRC)/$$dir/; \
	done
	@for file in $(PKG_DEF_PY); do \
		rsync -av $^/$$file $(PYLIB_SRC)/; \
	done
	# touch $(PYLIB_SRC)/flaskext/__init__.py
	cp $(PTENV)/lib/python2.7/site-packages/closure/closure.jar tools/
	cp $(PTENV)/lib/python2.7/site-packages/cssmin.py tools/

setup : virtualenv setup_lib




# ------------------
# DEFINE PHONY TARGET: Basically all targets
.PHONY : \
	man virtualenv setup setup_lib
