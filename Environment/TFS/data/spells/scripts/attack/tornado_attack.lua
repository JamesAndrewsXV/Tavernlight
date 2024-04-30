local SMALL_EFFECT_DELAY = 600
local LARGE_EFFECT_DELAY = 700

-- First Effect Setup
local smallTornado = Combat()
smallTornado:setParameter(COMBAT_PARAM_TYPE, COMBAT_UNDEFINEDDAMAGE)
smallTornado:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
smallTornado:setArea(createCombatArea(AREA_DIAMOND_SMALL))

-- Second Effect Setup
local largeTornado = Combat()
largeTornado:setParameter(COMBAT_PARAM_TYPE, COMBAT_UNDEFINEDDAMAGE)
largeTornado:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
largeTornado:setArea(createCombatArea(AREA_DIAMOND_LARGE))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + magicLevel + 6
	local max = (level / 5) + (magicLevel * 2.6) + 16
	return -min, -max
end

smallTornado:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Helper function to play effects via timer
function playEffect(creature, variant, combat)
	combat:execute(creature, variant)
end

function onCastSpell(creature, variant)
    for i = 1, 5, 1 do
        addEvent(playEffect, i*SMALL_EFFECT_DELAY, creature:getId(), variant, smallTornado)
		addEvent(playEffect, i*LARGE_EFFECT_DELAY, creature:getId(), variant, largeTornado)
    end
    return true
end
