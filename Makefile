# Tools

TOOL_PATH    = ./z_tools
INCLUDE_PATH = ./z_tools/haribote
QEMU_PATH    = ./z_tools/qemu
include ./tools.mak

TOOLS = bim2bin bim2hrb bin2obj edimg gas2nask \
  gocc1 gocc1plus gocpp0 golib00 haritol makefont \
  multicmd nask naskcnv0 obj2bim sjisconv t5lzma \
  makeiso

# Sources

IMG = ./src/haribote.img
TRASH = $(QEMU_PATH)/fdimage0.bin

# Build rules

.PHONY: all tools $(IMG)

all: tools $(IMG)

tools:
	$(MAKE) -C ./tolsrc
	$(MAKE) -C ./tolsrc install
	cp -r ./tolsrc/ok/* $(TOOL_PATH)/

$(IMG):
	$(MAKE) -C ./src IMG=$(notdir $(IMG))

# Utilities

.PHONY: run clean clean-all

run: $(IMG)
	cp $(IMG) $(QEMU_PATH)/fdimage0.bin
	cd $(QEMU_PATH) && ./run.sh

clean:
	$(DEL) $(TRASH)
	$(MAKE) -C ./src IMG=$(notdir $(IMG)) clean
clean-all: clean
	$(DEL) -r $(TOOLS)
	$(MAKE) -C ./tolsrc clean
