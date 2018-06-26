AS = ./z_tools/nask

Z_TOOLS   = ./z_tools
QEMU_PATH = ./z_tools/qemu

TARGET = ./src/helloos.img

all: tools $(TARGET)

.PHONY: tools
tools:
	cd ./tolsrc && make all
	cd ./tolsrc && make install
	cp -r ./tolsrc/ok/* "$(Z_TOOLS)/"

%.img: %.nas tools
	$(AS) "$<" "$@"

run: $(TARGET)
	cp "$(TARGET)" "$(QEMU_PATH)/fdimage0.bin"
	cd "$(QEMU_PATH)" && ./run.sh
