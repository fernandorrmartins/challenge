-- I don't know how to replicate the copies behind the character. I imagine it is necessary to use C++ on the client or server to have this effect.
-- Despite this, I analyzed the video, and from what i saw, the dash goes through 7 steps.
-- I tried to replicate time to move every step.
local steps = 7

local function teleportEvent(cid, pos)
	local player = Player(cid)
    if not player then
        return
    end
	player:getPosition():sendMagicEffect(2)
	player:teleportTo(pos)
end

function onCastSpell(creature, variant)
	local player = Player(creature)
    if not player then
        return
    end

    local pos = player:getPosition()
	local direction = player:getDirection()

    for x = 1, steps do
		pos:getNextPosition(direction, 1)
        local tile = Tile(pos)

        for i = tile:getThingCount() - 1, 0, -1 do
            if thing then
				if
					thing:hasProperty(CONST_PROP_BLOCKSOLID) or
					thing:hasProperty(CONST_PROP_BLOCKPROJECTILE) or
					thing:hasProperty(CONST_PROP_BLOCKPATH) or
					thing:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) or
					thing:hasProperty(CONST_PROP_IMMOVABLEBLOCKPATH)
				then
					goto leave
				end
            end
        end
        if not tile:isWalkable(tile) then
            goto leave
        end

        addEvent(teleportEvent, 5, player:getId(), pos)
    end

    ::leave::
    return
end