Z_TOOLS   = ./z_tools
QEMU_PATH = ./z_tools/qemu

all: tools

.PHONY: tools
tools:
	cd tolsrc && make all
	cd tolsrc && make OKDIR="../$(Z_TOOLS)" install

.PHONY: run
run:
	cp ./helloos.img "$(QEMU_PATH)/fdimage0.bin"
	cd "$(QEMU_PATH)" && ./run.sh
