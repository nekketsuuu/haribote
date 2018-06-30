# Prerequisite: set $(TOOL_PATH) and $(INC_PATH)

BIM2HRB  = $(TOOL_PATH)/bim2hrb
CC2GAS   = $(TOOL_PATH)/gocc1
DEL      = rm -f
EDIMG    = $(TOOL_PATH)/edimg
GAS2NASK = $(TOOL_PATH)/gas2nask -a
NASK     = $(TOOL_PATH)/nask
OBJ2BIM  = $(TOOL_PATH)/obj2bim

CFLAGS = -I$(TOOL_PATH) -Os -Wall
