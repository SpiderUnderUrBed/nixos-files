-- WirePlumber script to set Logitech C270 as the primary webcam

source_om = ObjectManager({
  Interest({
    type = "node",
    Constraint({ "node.name", "matches", "v4l2_input.*" }),  -- Match any V4L2 input device
  }),
})

sink_om = ObjectManager({
  Interest({
    type = "node",
    Constraint({ "media.class", "matches", "Video/Source" }),  -- Match any video source application
  }),
})

source_om:activate()
sink_om:activate()

MyLink = nil
local function create_link()
  if MyLink == nil then
    for source in source_om:iterate() do
      if source.properties["node.description"]:find("C270") then  -- Ensure it's the Logitech C270
        for sink in sink_om:iterate() do
          MyLink = Link("link-factory", {
            ["link.output.node"] = source.properties["node.id"],
            ["link.input.node"] = sink.properties["node.id"],
          })
          MyLink:activate(1)
          print("✅ Webcam linked: " .. source.properties["node.name"] .. " -> " .. sink.properties["node.name"])
        end
      end
    end
  end
end

source_om:connect("installed", function() create_link() end)
sink_om:connect("installed", function() create_link() end)
source_om:connect("object-added", function() create_link() end)
sink_om:connect("object-added", function() create_link() end)
