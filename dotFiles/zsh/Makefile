CURRENT_DIR = $(shell pwd)

ZSH_RC = $(HOME)/.zshrc
ANDROID_TOOLS = $(HOME)/.oh-my-zsh/custom/androiddevtoolez.zsh
GIF_TOOLS = $(HOME)/.oh-my-zsh/custom/gifitup.zsh

all: zsh_rc android_tools gif_tools

zsh_rc: zshrc
	ln -sf $(CURRENT_DIR)/zshrc $(ZSH_RC)

android_tools: androiddevtoolez.zsh
	ln -sf $(CURRENT_DIR)/androiddevtoolez.shz $(ANDROID_TOOLS)

gif_tools: gifitup.zsh
	ln -sf $(CURRENT_DIR)/gifitup.shz $(GIF_TOOLS)

.PHONY: all
