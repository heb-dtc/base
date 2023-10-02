CURRENT_DIR = $(shell pwd)

DUNST_CONFIG = $(HOME)/.config/dunst

all: dunst_rc

dunst_rc: dunstrc
	mkdir $(DUNST_CONFIG)
	ln -snf $(CURRENT_DIR)/dunstrc $(DUNST_CONFIG)/dunstrc

.PHONY: all
