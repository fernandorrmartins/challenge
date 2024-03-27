-- First skill in challenge.
-- The version on my server didn't have the same effects as the video, and I didn't have time to edit and add to .spr, .dat, .otbm
-- Initially I tried to do something dynamic, but some methods like "createCombatArea" cannot be called within other methods.
-- I studied the video and checked as closely as possible the execution time and order of execution of the magic effects.
SPELL_EFFECT = {
	STORM = 44,
	WHIRLWIND = 12
}
AREA = {
	STORM = {
		{
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 1, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{1, 0, 0, 2, 0, 0, 1},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
		},
		{
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 2, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 1, 0, 1, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
		},
		{
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 1, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 1, 2, 1, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
		}
	},
	WHIRLWIND = {
		{
			{0, 0, 0, 1, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 1, 0, 0, 0, 0, 0},
			{0, 0, 0, 2, 0, 0, 0},
			{0, 1, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
		},
		{
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 1, 0, 1, 0},
			{0, 0, 0, 2, 0, 0, 0},
			{0, 0, 0, 0, 0, 1, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
		},
		{
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 2, 0, 0, 0},
			{0, 0, 0, 1, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 1, 0, 0, 0}
		}
	}
}

function executeCombat(cid, varId, combat)
	local player = Player(cid)
    if not player then
        return
    end
    local variant = Variant(varId)
    if variant then
        combat:execute(player, variant)
    end
end

local combat_storm1 = Combat()
combat_storm1:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat_storm1:setParameter(COMBAT_PARAM_EFFECT, SPELL_EFFECT.STORM)
combat_storm1:setArea(createCombatArea(AREA.STORM[1]))
local combat_storm2 = Combat()
combat_storm2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat_storm2:setParameter(COMBAT_PARAM_EFFECT, SPELL_EFFECT.STORM)
combat_storm2:setArea(createCombatArea(AREA.STORM[2]))
local combat_storm3 = Combat()
combat_storm3:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat_storm3:setParameter(COMBAT_PARAM_EFFECT, SPELL_EFFECT.STORM)
combat_storm3:setArea(createCombatArea(AREA.STORM[3]))

local combat_whirlwind1 = Combat()
combat_whirlwind1:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat_whirlwind1:setParameter(COMBAT_PARAM_EFFECT, SPELL_EFFECT.WHIRLWIND)
combat_whirlwind1:setArea(createCombatArea(AREA.WHIRLWIND[1]))
local combat_whirlwind2 = Combat()
combat_whirlwind2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat_whirlwind2:setParameter(COMBAT_PARAM_EFFECT, SPELL_EFFECT.WHIRLWIND)
combat_whirlwind2:setArea(createCombatArea(AREA.WHIRLWIND[2]))
local combat_whirlwind3 = Combat()
combat_whirlwind3:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat_whirlwind3:setParameter(COMBAT_PARAM_EFFECT, SPELL_EFFECT.WHIRLWIND)
combat_whirlwind3:setArea(createCombatArea(AREA.WHIRLWIND[3]))

function onCastSpell(creature, variant)
    local player = Player(creature)
    if not player then
        return false
    end
	local cid = player:getId()
	local varId = variant:getNumber()
	executeCombat(cid, varId, combat_storm1)
	executeCombat(cid, varId, combat_whirlwind1)
	addEvent(executeCombat, 280, cid, varId, combat_storm2)
	addEvent(executeCombat, 280, cid, varId, combat_whirlwind2)
	addEvent(executeCombat, 480, cid, varId, combat_storm3)
	addEvent(executeCombat, 770, cid, varId, combat_whirlwind3)
	addEvent(executeCombat, 1020, cid, varId, combat_whirlwind1)
	addEvent(executeCombat, 1260, cid, varId, combat_whirlwind2)
	addEvent(executeCombat, 1750, cid, varId, combat_whirlwind3)
	addEvent(executeCombat, 1980, cid, varId, combat_whirlwind1)
	addEvent(executeCombat, 2270, cid, varId, combat_whirlwind2)
	addEvent(executeCombat, 2760, cid, varId, combat_whirlwind3)
	return
end

