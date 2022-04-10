

local bridge = Blueprint(
    Vector(0, 0, 0),
    Rotator(0, 0, 0),
    "bp-events-assets::BP_Events_Bridge"
)

local function split_str(str, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    str:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

Client.Subscribe("Tick", function(ds)
    local tags = bridge:GetActorTags()
    for i, v in ipairs(tags) do
        local split = split_str(v, ",")
        Events.Call(split[1], split[2])
    end
    bridge:CallBlueprintEvent("ClearTags")
end)