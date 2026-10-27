
COMMON=
SCAD_DEFINES=

DEPSDIR=deps

TARGETS=clamp.stl vesascope.stl vesascope_antislip.stl wrench.stl wrench_8_10.stl hole_test.stl binpedal.stl bitholder.stl brompton_rack_stay.stl doorhandlebushing.stl garagedoorknobcover.stl usb_microscope_holder_replacement.stl

all: $(TARGETS)

%.stl: %.scad $(COMMON)
	mkdir -p "$(DEPSDIR)"
	openscad -d "$(DEPSDIR)/$@.d" -o $@ $(SCAD_DEFINES) $<

include $(wildcard $(DEPSDIR)/*.stl.d)
