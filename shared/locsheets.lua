local loc = {}

loc.SHEET_KEY = "1t-2XMabwtjwObXM70OmpXTrevM3IKQYmzCw-bt01udI"
loc.SHEET_INDEX = 1
loc.content = {}

local LOADED = false
local CALLBACKS = {}

loc.PARSE_FUNC = function(response, content)
  local reserved_keys = { id = "reserved", category = "reserved", updated = "reserved", link = "reserved", content = "reserved", title = "reserved" }
  local json_string = response.response:gsub("gsx", ""):gsub("%$", "")
	local data = json.decode(json_string)
	for k, v in pairs(data.feed.entry) do
		for kk, vv in pairs(v) do
			if reserved_keys[kk] == nil and kk ~= "key" then
				if content[v.key.t] == nil then
					content[v.key.t] = {}
				end
				content[v.key.t][kk] = vv.t
			end
		end
	end
end

local function http_result(self, _, response)
  loc.PARSE_FUNC(response, loc.content)
  LOADED = true
  for i = 1, #CALLBACKS do
    CALLBACKS[i](loc.content)
  end
  CALLBACKS = {}
end

function loc.on_load(callback)
  if LOADED then
    callback(loc.content)
  else
    table.insert(CALLBACKS, callback)
    local url = "https://spreadsheets.google.com/feeds/list/"..loc.SHEET_KEY.."/"..loc.SHEET_INDEX.."/public/values?alt=json"
    print(url)
  	http.request(url, "GET", http_result)
  end
end

function loc.get(key)
  local lang = string.sub(sys.get_sys_info().device_language, 1, 2)
  return loc.content[key][lang]
end

return loc
