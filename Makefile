Z_TOOLS = ./z_tools
QEMU_PATH = "$(Z_TOOLS)/qemu"

.PHONY: run
run:
	cp ./helloos.img "$(QEMU_PATH)/fdimage0.bin"
	cd "$(QEMU_PATH)" && ./run.sh
