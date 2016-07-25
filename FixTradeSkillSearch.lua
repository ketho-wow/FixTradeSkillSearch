-- Author: Ketho (EU-Boulderfist)
-- License: Public Domain

hooksecurefunc("ChatEdit_InsertLink", function(text) -- shift-clicked
	-- change from SearchBox:HasFocus to :IsShown again
	if text and TradeSkillFrame and TradeSkillFrame:IsShown() then
		local spellId = strmatch(text, "enchant:(%d+)")
		local spell = GetSpellInfo(spellId)
		local item = GetItemInfo(strmatch(text, "item:(%d+)") or 0)
		local search = spell or item
		if not search then return end
		
		-- search needs to be lowercase for .SetRecipeItemNameFilter
		TradeSkillFrame.SearchBox:SetText(search:lower())
		
		-- jump to the the recipe
		if spell then -- can only select recipes on the learned tab
			if PanelTemplates_GetSelectedTab(TradeSkillFrame.RecipeList) == 1 then
				TradeSkillFrame:SelectRecipe(tonumber(spellId))
			end
		elseif item then
			C_Timer.After(.1, function() -- wait a bit or we cant select the recipe yet
				for _, v in pairs(TradeSkillFrame.RecipeList.dataList) do
					if v.name == item then
						--TradeSkillFrame.RecipeList:RefreshDisplay() -- didnt seem to help
						TradeSkillFrame:SelectRecipe(v.recipeID)
						return
					end
				end
			end)
		end
	end
end)

-- increase search box width -- up from 112
TradeSkillFrame.SearchBox:SetWidth(200)
