Q1-Q4 - Fix or improve the implementation of the below methods.

Q1 - Fix or improve the implementation of the below methods

[Solution]
local function releaseStorage(player, storage)
    player:setStorageValue(storage, -1)
end

function onLogout(player)
	local storageValue = 1000
	player:setStorageValue(storageValue, 1)
    if player:getStorageValue(storageValue) == 1 then
        releaseStorage(player, storageValue)
    end
    return true
end


Q2 - Fix or improve the implementation of the below method

[Solution]
function printSmallGuildNames(memberCount)
	local selectGuildQuery = "SELECT `name` FROM `guilds` WHERE `max_members` > %d;"
    local resultId = db.storeQuery(selectGuildQuery:format(memberCount))
	
	if resultId then
		repeat
			local guildName = result.getDataString(resultId, "name")
			print(guildName)
		until not result.next(resultId)
	end

	if resultId ~= false then
		result.free(resultId)
	end
end



Q3 - Fix or improve the name and the implementation of the below method

[Solution]
function removePlayerFromParty(playerId, memberName)
	local player = Player(playerId)
	local party = player:getParty()

	for _, member in pairs(party:getMembers()) do
		local playerToRemove = Player(memberName)
		if member == playerToRemove then
			party:removeMember(playerToRemove)
		end
	end
end



Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	Player* player = g_game.getPlayerByName(recipient);
	if (!player) {
		player = new Player(nullptr);
		if (!IOLoginData::loadPlayerByName(player, recipient)) {
			delete(player);
			return;
		}
	}

	Item* item = Item::CreateItem(itemId);
	if (!item) {
		delete(item);
		return;
	}

	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

	if (player->isOffline()) {
		IOLoginData::savePlayer(player);
		delete(player);
	}
}


The last 3 tests require setting up & utilizing Open Source TFS & OTC, this is part of the trial itself to confirm your ability to setup a local environment and basic navigation of Github.

Here you can find the base for TFS & OTC 
https://github.com/otland/forgottenserver
https://github.com/edubart/otclient