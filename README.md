## Installation
You can use this module in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

	https://github.com/squatchus/defold-locsheets/archive/master.zip

## Usage
1) Create new document in Google Spreadsheets
2) Make sure you have structure [like the one in example](https://docs.google.com/spreadsheets/d/1t-2XMabwtjwObXM70OmpXTrevM3IKQYmzCw-bt01udI/edit?usp=sharing). Column with localization keys must be titled as 'key'. Columns with localizations for specific languages must be titled with 2-letters language code
3) Get shareable link to the document
4) Copy spreadsheet key (part between 'https://docs.google.com/spreadsheets/d/' and '/edit?usp=sharing')
5) Update your labels inside collection or gui script using the following callback:

```lua
local loc = require("shared.locsheets")

function init(self)
  loc.SHEET_KEY = "1t-2XMabwtjwObXM70OmpXTrevM3IKQYmzCw-bt01udI"
  loc.SHEET_INDEX = 1 -- optionally you can specify different sheets
  loc.on_load(function(content)
    pprint(content)
    label.set_text("/hello#label", loc.get("title"))
  end)
end
```
