CURRENT_DIR = $(shell pwd)

ROFI_CONFIG = $(HOME)/.config/rofi

all: rofi

rofi: config.rasi
	mkdir $(ROFI_CONFIG)
	ln -snf $(CURRENT_DIR)/config.rasi $(ROFI_CONFIG)/config.rasi

.PHONY: all
