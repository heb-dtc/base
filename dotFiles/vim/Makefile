CURRENT_DIR = $(shell pwd)

VIM_RC = $(HOME)/.vimrc

all: vim_rc

vim_rc: vimrc
	ln -snf $(CURRENT_DIR)/vimrc $(VIM_RC)

.PHONY: all
