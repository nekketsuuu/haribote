# Tools

TOOL_PATH = ../z_tools
INCLUDE_PATH = ../z_tools/haribote
include ../tools.mak

# Sources

RULE_FILE = $(INCLUDE_PATH)/haribote.rul
TEK = ../z_tools/fdimg0at.tek
IMG = haribote.img

TRASH = bootpack.gas bootpack.nas bootpack.map \
  bootpack.obj bootpack.bim bootpack.hrb \
  asmhead.bin asmhead.lst \
  ipl10.bin ipl10.lst \
  haribote.sys $(IMG)

# Build rules

all: $(IMG)

%.bin: %.nas
	$(NASK) $< $@ $(@:%.bin=%.lst)

bootpack.gas: bootpack.c
	$(CC2GAS) -o $@ $<

bootpack.nas: bootpack.gas
	$(GAS2NASK) $< $@

bootpack.obj: bootpack.nas
	$(NASK) $< $@ $(<:%.obj=%.lst)

# 3136KB = 3MB + 64KB
bootpack.bim: bootpack.obj
	$(OBJ2BIM) @$(RULE_FILE) \
		out:$@ stack:3136k \
		map:bootpack.map $<

bootpack.hrb: bootpack.bim
	$(BIM2HRB) $< $@ 0

haribote.sys: asmhead.bin bootpack.hrb
	cat $^ > $@

$(IMG): ipl10.bin haribote.sys
	$(EDIMG) imgin:$(TEK) \
		wbinimg src:ipl10.bin len:512 from:0 to:0 \
		copy from:haribote.sys to:@: \
		imgout:$@

# Utilities

.PHONY: clean
clean:
	$(DEL) $(TRASH)
