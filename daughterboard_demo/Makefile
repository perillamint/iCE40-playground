PROJ := daughterboard
PIN_DEF := hx8kboard.pcf
DEVICE := hx8k

SIMCOMPILER := iverilog
SIMULATOR := vvp
VIEWER := gtkwave

TOPMODULE := top

SYNTHFLAGS := -p synth_ice40 -top $(TOPMODULE)
PNRFLAGS := -d $(subst hx,,$(subst lp,,$(DEVICE)))
SIMCOMPFLAGS :=
SIMFLAGS := -v

SRCS = $(wildcard *.v)
TBSRCS = $(filter %_tb.v, $(SRCS))
MODSRCS = $(filter-out %_tb.v %_incl.v, $(SRCS))
VVPS = $(patsubst %.v,%.vvp,$(TBSRCS))
VCDS = $(patsubst %_tb.v,%_wave.vcd,$(TBSRCS))

BINS := $(PROJ).bin
RPTS := $(patsubst %.bin,%.rpt,$(BINS))
BLIFS := $(patsubst %.bin,%.blif,$(BINS))
ASCS := $(patsubst %.bin,%.asc,$(BINS))

all: timing bitstream

timing: $(RPTS)

bitstream: $(BINS)

simulate: $(VCDS)

flash: $(PROJ).bin
	iceprog $<

load: $(PROJ).bin
	iceprog -S $<

$(BLIFS): %.blif: %.v $(MODSRCS)
	yosys '$(SYNTHFLAGS) -blif $@' $^

$(ASCS): %.asc: $(PIN_DEF) %.blif
	arachne-pnr $(PNRFLAGS) -o $@ -p $^

$(BINS): %.bin: %.asc
	icepack $< $@

$(RPTS): %.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

$(VVPS): %.vvp: %.v $(MODSRCS)
	$(SIMCOMPILER) $(SIMCOMPFLAGS) $^ -o $@

$(VCDS): %_wave.vcd: %_tb.vvp
	$(SIMULATOR) $(SIMFLAGS) $<

clean:
	rm $(wildcard *.vvp) $(wildcard *.vcd) $(BLIFS) $(BINS) $(RPTS) $(ASCS)
