# Tools

AS    = ./z_tools/nask
DEL   = rm -f
EDIMG = ./z_tools/edimg

Z_TOOLS   = ./z_tools
QEMU_PATH = ./z_tools/qemu

TOOLS = bim2bin bim2hrb bin2obj edimg gas2nask \
  gocc1 gocc1plus gocpp0 golib00 haritol makefont \
  multicmd nask naskcnv0 obj2bim sjisconv t5lzma \
  makeiso

# Sources

TARGET = ./src/haribote.img
SYS    = ./src/haribote.sys
IPLBIN = ./src/ipl.bin
TEK    = ./z_tools/fdimg0at.tek

TRASH = $(TARGET) $(SYS) $(SYS:%.sys=%.lst) \
  $(IPLBIN) $(IPLBIN:%.bin=%.lst) \
  $(QEMU_PATH)/fdimage0.bin

# Build rules

all: tools $(TARGET)

.PHONY: tools
tools:
	cd ./tolsrc && make all
	cd ./tolsrc && make install
	cp -r ./tolsrc/ok/* $(Z_TOOLS)/

$(TARGET): $(IPLBIN) $(SYS)
	$(EDIMG) imgin:$(TEK) \
		wbinimg src:$< len:512 from:0 to:0 \
		copy from:$(SYS) to:@: \
		imgout:$@

$(SYS): $(SYS:%.sys=%.nas)
	$(AS) $< $@ $(<:%.nas=%.lst)

%.bin: %.nas
	$(AS) $< $@  $(<:%.nas=%.lst)

# Utilities

.PHONY: run clean clean-all

run: $(TARGET)
	cp $(TARGET) $(QEMU_PATH)/fdimage0.bin
	cd $(QEMU_PATH) && ./run.sh

clean:
	$(DEL) $(TRASH)
clean-all: clean
	$(DEL) -r $(TOOLS)
	cd ./tolsrc && make clean
