# James Andrews Tavernlight Games Test

## Question 1
[Question 1 Answer](Question1.lua)

### Problem
- There seems to be an arbitrary value of 1000, which seems to indicate a key in the player object that has a specific function. This is not clear. I have assumed that the key 1000 holds the value that pertains to the player's login state.
- The `onLogout` function unconditionally returns true. The caller will not be able to interpret if the logout of a player was successful or not based off of its return value.
- The storage value within the conditional being looked up is equal to 1. I assume that "1" represents a "logged in" state and "-1" represents a "logged out" state, so I have left this part of the implementation as-is. However, in the case that this key represents an "ID" of players logged in, with -1 being the logged out state, another implementation would need to be made depending on the range of keys.

### Solution
- Added a local variable [`login_key`](Question1.lua?plain=1#L4), which specifies that the key being manipulated for the `onLogout` function is manipulating the login state of a player.
- Changed arguments for [`releaseStorage`](Question1.lua?plain=1#L7) to change a player's value at the given key to -1, which makes it polymorphic for other functions on a player that may require release.
- Changed `onLogout` to return [true when it has successfully found a player who is logged in and executes `releaseStorage`](Question1.lua?plain=1#L14), and returns [false when the condition has not been met](Question1.lua?plain=1#L16).

## Question 2
[Question 2 Answer](Question2.lua)

### Problem
- This function will only print one guild name despite asking for a list.
- `result` is an undefined variable.
- `db` may assumedly be a globally accessible variable, but it is not explicitly outlined.

### Solution
- Added `db` as an argument to the [function signature](Question2.lua?plain=1#L3) to ensure compatibility. This step is not necessary if `db` is a global variable.
- Added a [table](Question2.lua?plain=1#L7) to represent the list of found guild names
- [`while` loop](Question2.lua?plain=1#L9) inserts new names into the `guildNames` table as long as a result is found in the database `db`.
- If we have [found guilds that meet our member criteria](Question2.lua?plain=1#L16), we will print them line by line, otherwise  we will [print a message that states none have been found](Question2.lua?plain=1#L20).

## Question 3
[Question 3 Answer](Question3.lua)

### Problem
- This function is inadequately named. Its function is to kick members from the player's party.
- There are no failsafes to handle players who do not exist or players who are not in a party.
- Players are being removed by name. Assuming names are unique identifiers, we should be comparing the party member's name to the names found in matching players.
- There is a mismatch on the construction of a player character. The beginning of a function utilizes `playerId` to retrieve a player character, while the for loop utilizes `membername` to retrieve a player. I will assume that players cannot be properly retrieved by their name.

### Solution

- Changed the function name to [`kickPartyMember`](Question3.lua?plain=1#L3)
- Added error messages to the retrieval of a [Player](Question3.lua?plain=1#L4) and a [Party](Question3.lua?plain=1#L11)
- Renamed the variables in the [for loop](Question3.lua?plain=1#L18)
- Changed comparison of the [if statement](Question3.lua?plain=1#L19) from player objects to strings
- Added [error](Question3.lua?plain=1#L24) for when a party member could not be found in the player's party.

## Question 4
[Question 4 Answer](Question4.cpp)

### Problem
- The core feature causing the issue is that we may obtain a player by two different methods
    - The first method is through the active game. These players seem to be logged in.
    - The second method is through `IOLoginData::loadPlayerByName`. These players are offline.
- While online, all the `player` pointer needs to do is point to a currently active player in the `g_game`. This _should NOT be deleted, as it will erase the player from the game_. Instead, we should let this pointer go out of scope.
- While offline, the `player` needs to create a new player object, and load its data through `IOLoginData::loadPlayerByName`. Before the function is finished, it needs to _delete the player object_ to prevent the memory leak.
- It is ambiguous whether the `item` object must be deleted after an item is successfully created and used, due to the call of `internalAddItem`. My implementation _assumes that either `internalAddItem` assumes the responsibility of the `item`'s lifetime, or that the `player` or `g_game` now owns the `item`, and it is unsafe to delete in this function_.

### Solution

- If `player` failed to be instantiated by `IOLoginData::loadPlayerByName`, it will now be [deleted](Question4.cpp?plain=1#L10).
- If an `item` could not be created and a `player` is offline, the player will be [deleted](Question4.cpp?plain=1#L18).
    - Because no changes have been made to the player, it will not be saved
- When the `item` has been successfully added to the `player` and the `player` is offline, it will be [deleted](Question4.cpp?plain=1#L28).
- The `item`'s lifetime is not handled in this function. If the `item` has to be freed, however, a [delete call belongs after the function call to `internalAddItem`](Question4.cpp?plain=1#L26).


## Question 5

[Question 5 Video](Q5/Question5.mp4)




