CURRENT_DIR = $(shell pwd)

ZSH_RC = $(HOME)/.zshrc
ALIASES = $(HOME)/.aliases
EXPORTS = $(HOME)/.exports
FUNCTIONS = $(HOME)/.functions
DIRCOLORS = $(HOME)/.dircolors

all: zsh_rc themes

zsh_rc: zshrc
	ln -snf $(CURRENT_DIR)/exports $(EXPORTS)
	ln -snf $(CURRENT_DIR)/aliases $(ALIASES)
	ln -snf $(CURRENT_DIR)/functions $(FUNCTIONS)
	ln -snf $(CURRENT_DIR)/dircolors $(DIRCOLORS)
	ln -snf $(CURRENT_DIR)/zshrc $(ZSH_RC)

themes: heb.zsh-theme old_heb.zsh-theme
	sudo ln -snf $(CURRENT_DIR)/old_heb.zsh-theme /usr/share/oh-my-zsh/custom/themes/old_heb.zsh-theme
	sudo ln -snf $(CURRENT_DIR)/heb.zsh-theme /usr/share/oh-my-zsh/custom/themes/heb.zsh-theme

.PHONY: all
