CURRENT_DIR = $(shell pwd)

ZSH_RC = $(HOME)/.zshrc
ALIASES = $(HOME)/.aliases
EXPORTS = $(HOME)/.exports
FUNCTIONS = $(HOME)/.functions
DIRCOLORS = $(HOME)/.dircolors
ANDROID_TOOLS = $(HOME)/.oh-my-zsh/custom/androiddevtoolez.zsh
GIF_TOOLS = $(HOME)/.oh-my-zsh/custom/gifitup.zsh

all: zsh_rc android_tools gif_tools

zsh_rc: zshrc
	ln -snf $(CURRENT_DIR)/exports $(EXPORTS)
	ln -snf $(CURRENT_DIR)/aliases $(ALIASES)
	ln -snf $(CURRENT_DIR)/functions $(FUNCTIONS)
	ln -snf $(CURRENT_DIR)/dircolors $(DIRCOLORS)
	ln -snf $(CURRENT_DIR)/zshrc $(ZSH_RC)

android_tools: androiddevtoolez.zsh
	ln -sfn $(CURRENT_DIR)/androiddevtoolez.zsh $(ANDROID_TOOLS)

gif_tools: gifitup.zsh
	ln -sfn $(CURRENT_DIR)/gifitup.zsh $(GIF_TOOLS)

.PHONY: all
