Q?=@
OPENSCAD=openscad --backend Manifold

.PHONY: clean

DEFAULT_TARGETS = front_cover_vent_switch.stl \
	front_cover_vent_noswitch.stl \
	front_cover_novent_noswitch.stl \
	front_cover_novent_switch.stl \
	back_cover.stl \
	track.stl track_insert.stl

all: $(DEFAULT_TARGETS)

front_cover_vent_switch.stl: front_cover.scad
	$(Q) echo "SCAD $@"
	$(Q)$(OPENSCAD) -D esc_switch_cutouts=true -D ventilation=true -o $@ $<

front_cover_novent_switch.stl: front_cover.scad
	$(Q) echo "SCAD $@"
	$(Q)$(OPENSCAD) -D esc_switch_cutouts=true -D ventilation=false -o $@ $<

front_cover_vent_noswitch.stl: front_cover.scad
	$(Q) echo "SCAD $@"
	$(Q)$(OPENSCAD) -D esc_switch_cutouts=false -D ventilation=true -o $@ $<

front_cover_novent_noswitch.stl: front_cover.scad
	$(Q) echo "SCAD $@"
	$(Q)$(OPENSCAD) -D esc_switch_cutouts=false -D ventilation=false -o $@ $<

%.stl: %.scad
	$(Q) echo "SCAD $@"
	$(Q)$(OPENSCAD) -o $@ $<

clean:
	@rm -f $(DEFAULT_TARGETS)
