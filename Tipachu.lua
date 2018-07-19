--[[
	Tipachu
		Adds item icons to tooltips
--]]

local DEFAULT_ICON_SIZE = 24
local GetItemIconByID = C_Item.GetItemIconByID
local GetSpellInfo = GetSpellInfo

--add icon to the tooltip
local function setTooltipIcon(self, icon)
	local title = icon and _G[self:GetName() .. 'TextLeft1']
	if title then
		title:SetFormattedText('|T%s:%d|t %s', icon, _G['TipachuSize'] or DEFAULT_ICON_SIZE, title:GetText())
	end
end

--tooltip hooking generator
local function newTooltipHooker(method, func)
	return function(tooltip)
		local modified = false

		tooltip:HookScript('OnTooltipCleared', function(self, ...)
			modified = false
		end)

		tooltip:HookScript(method, function(self, ...)
			if not modified  then
				modified = true
				func(self, ...)
			end
		end)
	end
end

local hookItem = newTooltipHooker('OnTooltipSetItem', function(self, ...)
	local _, link = self:GetItem()
	if link then
		setTooltipIcon(self, GetItemIconByID(link))
	end
end)

local hookSpell = newTooltipHooker('OnTooltipSetSpell', function(self, ...)
	local _, id = self:GetSpell()
	if id then
		setTooltipIcon(self, select(3, GetSpellInfo(id)))
	end
end)

--hook tooltips
for _, tooltip in pairs{GameTooltip, ItemRefTooltip} do
	hookItem(tooltip)
	hookSpell(tooltip)
end