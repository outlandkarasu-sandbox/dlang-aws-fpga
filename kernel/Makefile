# Makefile for kernel awsxclbin file.

TARGET=sw_emu
PLATFORM=$(AWS_PLATFORM)
KERNEL_NAME=product
KERNEL_COUNT=1

OUT_DIR=.
OBJS=$(OUT_DIR)/product.xo
OUT=$(OUT_DIR)/product.xclbin
LOG_DIR=./log
REPORT_DIR=./report
TEMP_DIR=./temp

XOCC_FLAGS=--target $(TARGET) --platform $(PLATFORM) --save-temps --log_dir $(LOG_DIR) --temp_dir $(TEMP_DIR)
XOCC_COMPILE_FLAGS=-k $(KERNEL_NAME)
XOCC_LINK_FLAGS=--nk $(KERNEL_NAME):$(KERNEL_COUNT) --report_level estimate --report_dir $(REPORT_DIR)

.PHONY: all
all: $(OUT) emconfig.json

%.xo : %.cl
	xocc -c $(XOCC_FLAGS) $(XOCC_COMPILE_FLAGS) -o $@ $^

emconfig.json:
	emconfigutil --platform $(PLATFORM) --nd 1 --od $(OUT_DIR)/

$(OUT): $(OBJS)
	xocc -l $(XOCC_FLAGS) $(XOCC_LINK_FLAGS) -o $@ $^

.PHONY: clean
clean:
	- rm -rf $(OUT) $(OBJS) emconfig.json
	- rm -rf $(LOG_DIR)/* $(REPORT_DIR)/* $(TEMP_DIR)/*

