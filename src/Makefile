# Tools

TOOL_PATH = ../z_tools
INCLUDE_PATH = ../z_tools/haribote
include ../tools.mak

# Sources

RULE_FILE = $(INCLUDE_PATH)/haribote.rul
TEK = ../z_tools/fdimg0at.tek
IMG = haribote.img
CFILES = bootpack.c graphic.c dsctbl.c int.c fifo.c keyboard.c mouse.c
NASFILES = asmhead.nas ipl10.nas

TRASH = $(IMG) \
  $(CFILES:%.c=%.bim) $(CFILES:%.c=%.gas) $(CFILES:%.c=%.hrb) \
  $(CFILES:%.c=%.nas) $(CFILES:%.c=%.obj) \
  $(NASFILES:%.nas=%.bin) $(NASFILES:%.nas=%.lst) \
  bootpack.map \
  hankaku.bin hankaku.obj \
  haribote.sys \
  naskfunc.obj

# Build rules

.PHONY: all
all: $(IMG)

%.bin: %.nas
	$(NASK) $< $@ $(@:%.bin=%.lst)

%.gas: %.c bootpack.h
	$(CC2GAS) $(CFLAGS) -o $@ $<

%.nas: %.gas
	$(GAS2NASK) $< $@

%.obj: %.nas
	$(NASK) $< $@ $(@:%.bin=%.lst)

hankaku.bin: hankaku.txt
	$(MAKEFONT) $< $@

hankaku.obj: hankaku.bin
	$(BIN2OBJ) $< $@ _$(basename $<)

# 3136KB = 3MB + 64KB
bootpack.bim: bootpack.obj naskfunc.obj hankaku.obj $(CFILES:%.c=%.obj)
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
