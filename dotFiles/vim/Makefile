CURRENT_DIR = $(shell pwd)

VIM_RC = $(HOME)/.vimrc
VIM_DIR = $(HOME)/.vim
PATHOGEN = $(VIM_DIR)/autoload/pathogen.vim
PLUGINS_DIR = $(VIM_DIR)/bundle

all: $(VIM_RC) $(VIM_DIR) $(PATHOGEN) $(PLUGINS_DIR) plugins

$(VIM_RC): vimrc
	ln -snf $(CURRENT_DIR)/vimrc $(VIM_RC)

$(VIM_DIR):
	mkdir -p $(VIM_DIR)

$(PLUGINS_DIR):
	mkdir -p $(PLUGINS_DIR)

$(PATHOGEN):
	curl -LSso $(PATHOGEN) --create-dirs https://tpo.pe/pathogen.vim

plugins:
	git clone https://github.com/scrooloose/nerdtree $(PLUGINS_DIR)/nerdtree
	git clone https://github.com/tpope/vim-fugitive $(PLUGINS_DIR)/vim-fugitive
	git clone https://github.com/bling/vim-airline $(PLUGINS_DIR)/vim-airline	
	git clone https://github.com/altercation/vim-colors-solarized $(PLUGINS_DIR)/vim-colors-solarized
	git clone https://github.com/airblade/vim-gitgutter $(PLUGINS_DIR)/vim-gitgutter
	git clone https://github.com/jistr/vim-nerdtree-tabs $(PLUGINS_DIR)/vim-nerdtree-tabs
	git clone https://github.com/ctrlpvim/ctrlp.vim $(PLUGINS_DIR)/ctrlp
	git clone https://github.com/derekwyatt/vim-fswitch $(PLUGINS_DIR)/fswitch
	git clone https://github.com/dikiaap/minimalist $(PLUGINS_DIR)/minimalist
	git clone https://github.com/leafgarland/typescript-vim.git $(PLUGINS_DIR)/typescript-vim
	git clone https://github.com/prettier/vim-prettier $(PLUGINS_DIR)/vim-prettier
	git clone https://github.com/pangloss/vim-javascript.git $(PLUGINS_DIR)/vim-javascript
	git clone https://github.com/plasticboy/vim-markdown.git $(PLUGINS_DIR)/vim-markdown
	git clone https://github.com/ycm-core/YouCompleteMe.git $(PLUGINS_DIR)/YouCompleteMe

.PHONY: all
