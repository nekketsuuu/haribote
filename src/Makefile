# Tools

TOOL_PATH = ../z_tools
INCLUDE_PATH = ../z_tools/haribote
include ../tools.mak

# Sources

RULE_FILE = $(INCLUDE_PATH)/haribote.rul
TEK = ../z_tools/fdimg0at.tek
IMG = haribote.img
C_OBJFILES = graphic.obj dsctbl.obj int.obj fifo.obj \
  keyboard.obj mouse.obj memory.obj
OBJFILES = bootpack.obj naskfunc.obj hankaku.obj $(C_OBJFILES)
NASFILES = asmhead.nas ipl10.nas

TRASH = $(IMG) \
  $(OBJFILES) $(OBJFILES:%.obj=%.bim) $(OBJFILES:%.obj=%.gas) \
  $(OBJFILES:%.obj=%.hrb) $(C_OBJFILES:%.obj=%.nas) \
  $(NASFILES:%.nas=%.bin) $(NASFILES:%.nas=%.lst) \
  bootpack.map bootpack.nas \
  haribote.sys

.PRECIOUS: %.bim %.bin %.c %.gas %.hrb %.lst %.map %.nas %.obj %.sys

# Build rules

.PHONY: all
all: $(IMG)

%.bin: %.nas
	$(NASK) $< $@ $(@:%.bin=%.lst)

%.gas: %.c bootpack.h
	$(CC2GAS) $(CFLAGS) -o $@ $<

%.nas: %.gas
	$(GAS2NASK) $< $@

%.obj %.lst: %.nas
	$(NASK) $< $@ $(@:%.bin=%.lst)

hankaku.bin: hankaku.txt
	$(MAKEFONT) $< $@

hankaku.obj: hankaku.bin
	$(BIN2OBJ) $< $@ _$(basename $<)

# 3136KB = 3MB + 64KB
bootpack.bim bootpack.map: $(OBJFILES)
	$(OBJ2BIM) @$(RULE_FILE) \
		out:$@ stack:3136k \
		map:bootpack.map $^

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
