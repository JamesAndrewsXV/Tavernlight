//Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient); //Players of an active game
    if (!player) {
        //attempting to load inactive players
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        delete item;
        if(player->isOffline()) {
            delete player;
        }
        return;
    }

    // Refer to the README for notes
    // This implementation assumes `internalAddItem` handles the item's lifetime
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
        delete player;
    }
}
