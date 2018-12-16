#!/bin/sh

cd `dirname $0`

XCL_EMULATION_MODE=${1:-sw_emu} dub run

