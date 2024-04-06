local catchHandler = require("catch")
local genHandler = require("gen")
local scoreHandler = require("score")

DEBUG = false
PWD = arg[0]:sub(1, -13)
BIN_PATH = PWD .. "bin/"
package.path = PWD .. "src/?.lua;" .. package.path

local function processShinyInput(guess)
	local shinyGuess = nil
	if guess == "true" or guess == "t" then
		shinyGuess = true
	elseif guess == "false" or guess == "f" then
		shinyGuess = false
	end

	return shinyGuess
end

if DEBUG then
	for _, args in pairs(arg) do
		print(args)
	end
	print("\n")
end

if arg[1] == "score" then
	scoreHandler.printScore()
elseif arg[1] == "catch" then
	local shinyGuess = processShinyInput(arg[3])
	catchHandler.catch(arg[2], shinyGuess)
else
	genHandler.initNewPokemon(arg[1])
end
