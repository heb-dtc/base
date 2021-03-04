CURRENT_DIR = $(shell pwd)

ROFI_CONF_DIR = $(HOME)/.config/rofi
ROFI_CONF = $(ROFI_CONF_DIR)/config.rasi
DUNST_CONF_DIR = $(HOME)/.config/dunst
DUNST_CONF = $(DUNST_CONF_DIR)/dunstrc

all: zsh git i3 rofi dunst

zsh:
	make -C zsh

git:
	make -C git

i3:
	make -C i3

rofi: 
	mkdir -p $(ROFI_CONF_DIR)
	ln -sf $(CURRENT_DIR)/rofi/config.rasi $(ROFI_CONF)

dunst:
	mkdir -p $(DUNST_CONF_DIR)
	ln -sf $(CURRENT_DIR)/dunst/dunstrc $(DUNST_CONF)

.PHONY: all zsh git i3 rofi dunst
