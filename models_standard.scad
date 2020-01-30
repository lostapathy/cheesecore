include <config.scad>

// ORIGINAL RAILCORE II 300ZL
module rc300zl(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zl;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc300zl;
  $halo_size          = halo_rc300zl;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elecbox_original_rc300zl;
  $branding_name      = "Original 300ZL";

  $rail_specs         = rails__original_rc300zl;
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth       = 50 ;
  children();
}

// ORIGINAL RAILCORE II ZLT
module rc300zlt(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zlt;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc300zlt;
  $halo_size          = halo_rc300zlt;
  $front_window_size  = front_window_original_300zlt;
  $elecbox            = elecbox_original_rc300zlt;
  $branding_name      = "Original 300ZLT";

  $rail_specs         = rails__original_rc300zlt;
  $leadscrew_specs    = leadscrew_original_rc300zlt;
  $bed                = bed_standard_rc300;
  $feet_depth       = 50 ;
  children();
}

// ORIGINAL RAILCORE II 250ZL
module rc250zl(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc250zl;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc250zl;
  $halo_size          = halo_rc250zl;
  $front_window_size  = front_window_original_250zl;
  $elecbox            = elecbox_original_rc250zl;
  $branding_name      = "Original 250ZL";

  $rail_specs         = rails__original_rc250zl;
  $leadscrew_specs    = leadscrew_original_rc250zl;
  $bed                = bed_standard_rc250;
  $feet_depth         = 50 ;
  children();
}

// rc150mini - based on a bit of info about the bed from steve :)
module rc150mini(position = [80, 80, 20]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc150mini;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc150mini;
  $halo_size          = halo_rc150mini;
  $front_window_size  = front_window_original_150mini;
  $elecbox            = elec_miniplaceh; //placeholder
  $branding_name      = "150mini";

  $rail_specs         = rails__original_rc150mini;
  $leadscrew_specs    = leadscrew_original_rc150mini;
  $bed                = bed_standard_rc150mini;
  $feet_depth         = 100 ;
  // 100mm "legs" that the panels extend down to cover

  children();
}
