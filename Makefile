ZMK_DIR  ?= $(shell pwd)/zmk
APP_DIR  ?= $(ZMK_DIR)/app
CONFIG   ?= $(shell pwd)/config
OUT_DIR  ?= $(shell pwd)/build

BOARD    ?= seeeduino_xiao_ble
EXTRA    ?= $(shell pwd)

.PHONY: setup left right reset clean

setup:
	@test -d $(ZMK_DIR) || { \
		echo "Cloning ZMK into $(ZMK_DIR)..."; \
		git clone https://github.com/zmkfirmware/zmk.git $(ZMK_DIR) --depth 1; \
	}
	cd $(ZMK_DIR) && west init -l app/ && \
	west config update.clone-depth 1 && \
	west update

left:
	cd $(ZMK_DIR) && west build -s app -d $(OUT_DIR)/left -b $(BOARD) -- \
		-DSHIELD=totem_left \
		-DZMK_CONFIG="$(CONFIG)" \
		-DZMK_EXTRA_MODULES="$(EXTRA)"

right:
	cd $(ZMK_DIR) && west build -s app -d $(OUT_DIR)/right -b $(BOARD) -- \
		-DSHIELD=totem_right \
		-DZMK_CONFIG="$(CONFIG)" \
		-DZMK_EXTRA_MODULES="$(EXTRA)"

reset:
	cd $(ZMK_DIR) && west build -s app -d $(OUT_DIR)/reset -b $(BOARD) -- \
		-DSHIELD=settings_reset \
		-DZMK_CONFIG="$(CONFIG)" \
		-DZMK_EXTRA_MODULES="$(EXTRA)"

clean:
	rm -rf $(OUT_DIR)
