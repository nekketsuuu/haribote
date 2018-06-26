AS = ./z_tools/nask
DEL = rm -f

Z_TOOLS   = ./z_tools
QEMU_PATH = ./z_tools/qemu

TOOLS = bim2bin bim2hrb bin2obj edimg gas2nask \
  gocc1 gocc1plus gocpp0 golib00 haritol makefont \
  multicmd nask naskcnv0 obj2bim sjisconv t5lzma \
  makeiso

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

.PHONY: clean
clean:
	$(DEL) "$(TARGET)"
	$(DEL) "$(QEMU_PATH)/fdimage0.bin"
clean-all: clean
	$(DEL) -r $(TOOLS)
