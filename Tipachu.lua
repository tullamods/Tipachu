--[[
	Tipachu
		Adds item icons to tooltips
--]]

local DEFAULT_ICON_SIZE = 24

local function AddIcon(self, icon)
	if icon then
		local title = _G[self:GetName() .. 'TextLeft1']
		if title and not title:GetText():find('|T' .. icon) then --make sure the icon does not display twice on recipies, which fire OnTooltipSetItem twice
			title:SetFormattedText('|T%s:%d|t %s', icon, _G['TipachuSize'] or DEFAULT_ICON_SIZE, title:GetText())
		end
	end
end

--[[
	Item Hooking
--]]

local function hookItem(tip)
	tip:HookScript('OnTooltipSetItem', function(self, ...)
		local name, link = self:GetItem()
		local icon = link and GetItemIcon(link)
		AddIcon(self, icon)
	end)
end
hookItem(_G['GameTooltip'])
hookItem(_G['ItemRefTooltip'])


--[[
	Spell Hooking
--]]

local function hookSpell(tip)
	tip:HookScript('OnTooltipSetSpell', function(self, ...)
		local name, rank, icon = GetSpellInfo(self:GetSpell())
		AddIcon(self, icon)
	end)
end
hookSpell(_G['GameTooltip'])
hookSpell(_G['ItemRefTooltip'])