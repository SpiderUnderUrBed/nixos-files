stream = {
  rules = {
    {
      matches = {
        { ["media.class"] = "Stream/Input/Video" }
      },
      actions = {
        update_props = {
          ["target.object"] = "v4l2_input.pci-0000_00_14.0-usb-0_4_1.0"
        }
      }
    }
  }
}

apply_stream_rules(stream.rules)
