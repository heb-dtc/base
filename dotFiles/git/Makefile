CURRENT_DIR = $(shell pwd)

GITCONFIG = $(HOME)/.gitconfig

all: gitconf

gitconf: gitconfig
	ln -sf $(CURRENT_DIR)/gitconfig $(GITCONFIG)

.PHONY: all
