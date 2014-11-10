ROLLNAME = gnucompiler
VERSION :=$(shell bash version.sh -v)
RELEASE :=$(shell bash version.sh -h)
COLOR    = orange
RPM.EXTRAS         = AutoReq:No

REDHAT.ROOT = $(PWD)
