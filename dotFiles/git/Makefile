CURRENT_DIR = $(shell pwd)

GIT_CONFIG = $(HOME)/.gitconfig
CURIOUS_CONFIG = $(HOME)/.gitconfig_curious

all: gitconf curiousconf

gitconf: gitconfig
	ln -sf $(CURRENT_DIR)/gitconfig $(GIT_CONFIG)

curiousconf: gitconfig_curious
	ln -sf $(CURRENT_DIR)/gitconfig_curious $(CURIOUS_CONFIG)

.PHONY: all
