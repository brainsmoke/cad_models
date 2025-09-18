
COMMON=
SCAD_DEFINES=

TARGETS=clamp.stl vesascope.stl vesascope_antislip.stl

all: $(TARGETS)

%.stl: %.scad $(COMMON)
	openscad -o $@ $(SCAD_DEFINES) $<
