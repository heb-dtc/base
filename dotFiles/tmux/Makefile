CURRENT_DIR = $(shell pwd)

TMUX_CONFIG = $(HOME)

all: conf

conf: tmux.conf
	ln -snf $(CURRENT_DIR)/tmux.conf $(TMUX_CONFIG)/.tmux.conf
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

.PHONY: all
