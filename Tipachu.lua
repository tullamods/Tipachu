--[[
	Tipachu
		Adds item icons to tooltips
--]]

local DEFAULT_ICON_SIZE = 24

local function addIcon(self, icon)
	local title = icon and _G[self:GetName() .. 'TextLeft1']
	if title then
		title:SetFormattedText('|T%s:%d|t %s', icon, _G['TipachuSize'] or DEFAULT_ICON_SIZE, title:GetText())
	end
end

--[[ tooltip hooking ]]--

local function hookItem(tip)
	local tooltipModified = false

	tip:HookScript('OnTooltipCleared', function(self, ...)
		tooltipModified = false
	end)

	tip:HookScript('OnTooltipSetItem', function(self, ...)
		if not tooltipModified  then
			tooltipModified  = true

			local name, link = self:GetItem()
			local icon = link and GetItemIcon(link)
			addIcon(self, icon)
		end
	end)
end

local function hookSpell(tip)
	local tooltipModified = false

	tip:HookScript('OnTooltipCleared', function(self, ...)
		tooltipModified = false
	end)

	tip:HookScript('OnTooltipSetSpell', function(self, ...)
		if not tooltipModified  then
			tooltipModified  = true

			local spellName, spellRank, spellID = GameTooltip:GetSpell()
			if spellId then
				local icon = select(3, GetSpellInfo(spellID))
				addIcon(self, icon)
			end
		end
	end)
end

for _, tooltip in pairs{GameTooltip, ItemRefTooltip} do
	hookItem(tooltip)
	hookSpell(tooltip)
end