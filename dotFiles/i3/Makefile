CURRENT_DIR = $(shell pwd)

I3_STATUS = $(HOME)/.i3/i3status.conf
I3_CONFIG = $(HOME)/.i3/config
I3_BLOCKS = $(HOME)/.i3blocks.conf
X_INIT_RC = $(HOME)/.xinitrc
X_RESOURCES = $(HOME)/.Xresources
X_DEFAULTS = $(HOME)/.Xdefaults
OXIDE_COLOURS = $(HOME)/.colours/oxide.colours

all: $(I3_STATUS) $(I3_CONFIG) $(I3_BLOCKS) $(X_INIT_RC) $(X_RESSOURCES) $(X_DEFAULTS) $(OXIDE_COLOURS)

$(I3_STATUS): i3status.conf
	ln -sf $(CURRENT_DIR)/i3status.conf $(I3_STATUS)

$(I3_CONFIG): config
	ln -sf $(CURRENT_DIR)/config $(I3_CONFIG)

$(I3_BLOCKS): i3blocks.conf
	ln -sf $(CURRENT_DIR)/i3blocks.conf $(I3_BLOCKS)	

$(X_INIT_RC): xinitrc
	ln -sf $(CURRENT_DIR)/xinitrc $(X_INIT_RC)

$(X_RESOURCES): Xresources
	ln -sf $(CURRENT_DIR)/Xresources $(X_RESOURCES)

$(X_DEFAULTS): Xdefaults
	ln -sf $(CURRENT_DIR)/Xdefaults $(X_DEFAULTS)

$(OXIDE_COLOURS): oxide.colours
	ln -sf $(CURRENT_DIR)/oxide.colours $(OXIDE_COLOURS)

.PHONY: all
