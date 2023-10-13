CURRENT_DIR = $(shell pwd)

DESKTOP_APP_DIR = $(HOME)/.local/share/applications

all: desktop_entry

desktop_entry: firefox-profile-chooser.desktop
	mkdir $(DESKTOP_APP_DIR)
	ln -snf $(CURRENT_DIR)/firefox-profile-chooser.desktop $(DESKTOP_APP_DIR)/firefox-profile-chooser.desktop

.PHONY: all
