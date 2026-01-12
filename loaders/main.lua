local placeID = game.PlaceId
local gameID = game.GameId

if placeID == 893973440 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nextydev/Snw-Hub/refs/heads/main/ftf0.0.1.lua"))()
elseif gameID == 6931042565 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nextydev/Snw-Hub/refs/heads/main/vbl0.0.1.lua"))()
else
    print("[SnwHub] Game not supported!")
    print("[SnwHub] Join Discord for see the games supported!")
    setclipboard("discord.gg/J7X36yv9hx")
end
