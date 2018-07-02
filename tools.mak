# Prerequisite: set $(TOOL_PATH) and $(INCLUDE_PATH)

BIM2HRB  = $(TOOL_PATH)/bim2hrb
BIN2OBJ  = $(TOOL_PATH)/bin2obj
CC2GAS   = $(TOOL_PATH)/gocc1
DEL      = rm -f
EDIMG    = $(TOOL_PATH)/edimg
GAS2NASK = $(TOOL_PATH)/gas2nask -a
MAKEFONT = $(TOOL_PATH)/makefont
NASK     = $(TOOL_PATH)/nask
OBJ2BIM  = $(TOOL_PATH)/obj2bim

CFLAGS = -I$(INCLUDE_PATH) -Os -Wall
