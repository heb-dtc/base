CURRENT_DIR = $(shell pwd)

I3_STATUS = $(HOME)/.i3/i3status.conf
I3_CONFIG = $(HOME)/.i3/config
I3_TRAY = $(HOME)/.i3/tray.sh

I3_BLOCKS_DIR = $(HOME)/.i3/blocks
I3_BLOCKS = $(I3_BLOCKS_DIR)/i3blocks.conf

I3_STATUS_RS_DIR = $(HOME)/.i3/status_rs
I3_STATUS_RS = $(I3_STATUS_RS_DIR)/i3_status_rust.toml

X_INIT_RC = $(HOME)/.xinitrc
X_RESOURCES = $(HOME)/.Xresources
X_DEFAULTS = $(HOME)/.Xdefaults

COLOURS_DIR = $(HOME)/.colours
OXIDE_COLOURS = $(COLOURS_DIR)/oxide.colours

all: $(X_INIT_RC) $(X_RESSOURCES) $(X_DEFAULTS) $(I3_CONFIG) $(I3_STATUS) $(I3_TRAY) $(I3_BLOCKS) $(I3_STATUS_RS) $(OXIDE_COLOURS)

$(I3_STATUS): i3status.conf
	ln -sf $(CURRENT_DIR)/i3status.conf $(I3_STATUS)

$(I3_CONFIG): config
	ln -sf $(CURRENT_DIR)/config $(I3_CONFIG)

$(I3_TRAY): tray.sh
	ln -sf $(CURRENT_DIR)/tray.sh $(I3_TRAY)

$(I3_BLOCKS): i3blocks.conf
	mkdir -p $(I3_BLOCKS_DIR)
	ln -sf $(CURRENT_DIR)/i3blocks.conf $(I3_BLOCKS)	

$(I3_STATUS_RS): i3_status_rust.toml
	mkdir -p $(I3_STATUS_RS_DIR)
	ln -sf $(CURRENT_DIR)/i3_status_rust.toml $(I3_STATUS_RS)

$(X_INIT_RC): xinitrc
	ln -sf $(CURRENT_DIR)/xinitrc $(X_INIT_RC)

$(X_RESOURCES): Xresources
	ln -sf $(CURRENT_DIR)/Xresources $(X_RESOURCES)

$(X_DEFAULTS): Xdefaults
	ln -sf $(CURRENT_DIR)/Xdefaults $(X_DEFAULTS)

$(OXIDE_COLOURS): oxide.colours
	mkdir -p $(COLOURS_DIR)
	ln -sf $(CURRENT_DIR)/oxide.colours $(OXIDE_COLOURS)

.PHONY: all
