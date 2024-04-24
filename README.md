# James Andrews Tavernlight Games Test

## Question 1
[Question 1 Answer](Question1.lua)
### Problem
- There seems to be an arbitrary value of 1000, which seems to indicate a key in the player object that has a specific function. This is not clear.
- The onLogout function unconditionally returns true. The caller will not be able to interpret if the logout of a player was successful or not based off of its return value.
- The storage value within the conditional being looked up is equal to 1. I assume that "1" represents a "logged in" state and "-1" represents a "logged out" state, so I have left this part of the implementation as-is. However, in the case that this key represents an "ID" of players logged in, with -1 being the logged out state, it would be best to change this conditional to `if player:getStorageValue(login_key) >= 1`.

### Solution
- Added a local variable [login_key](Question1.lua?plain=1#L4), which specifies that the key being manipulated for the `onLogout` function is manipulating the login state of a player.
- Changed arguments for [`releaseStorage`](Question1.lua?plain=1#L7) to change a player's value at the given key to -1, which makes it polymorphic for other functions on a player that may require release
- Changed `onLogout` to return [true when it has successfully found a player who is logged in and executes `releaseStorage`](Question1.lua?plain=1#L14), and returns [false when the condition has not been met](Question1.lua?plain=1#L16).