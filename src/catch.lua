local commandHandler = require("command")
local scoreHandler = require("score")
local generationHandler = require("gen")

local function computeAndPrintResult(currentScore, name, isShiny)
	local newScore = 0
	local trueName, isReallyShiny = generationHandler.getLastPokemon()
	if trueName == nil or isReallyShiny == nil then
		return
	end

	if DEBUG then
		print("Actual data :")
		print(trueName)
		print(isReallyShiny)

		print("\nGuess :")
		print(name)
		print(isShiny)
	end

	if trueName == nil or isReallyShiny == nil then
		print("...There is no pokemon to catch")
		return
	end

	if name == trueName then
		print("You got the right name! (+2)")
		newScore = newScore + 2
	else
		print(string.format("False! The name of the pokemon is %s", trueName))
	end

	if isShiny == isReallyShiny then
		if isReallyShiny then
			print("It is indeed a shiny! (+1)")
		else
			print("It is indeed not a shiny! (+1)")
		end

		newScore = newScore + 1
	else
		if isReallyShiny then
			print("It was in fact a shiny")
		else
			print("It was sadly not a shiny")
		end
	end

	if name ~= trueName and isShiny ~= isReallyShiny then
		print("\nBetter luck next time!")
	elseif name == trueName and isShiny == isReallyShiny then
		print("\nLet's see it again!")
		local command = commandHandler.command({
			settings = {
				name = trueName,
				isRandom = false,
				isShiny = isReallyShiny,
				isBig = true,
				generation = false,
				toStore = false,
			},
		})

		command:build()
		command:execute()
	end

	return newScore + currentScore
end

local function catch(name, isShiny)
	print("catching...\n")

	local newScore = computeAndPrintResult(scoreHandler.getScore(), name, isShiny)
	if newScore == nil then
		return
	end
	scoreHandler.updateScore(newScore)
end

return { catch = catch }
