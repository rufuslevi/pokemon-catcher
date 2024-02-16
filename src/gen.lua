local function generateRandomPokemonData(generation)
	local commandHandler = require("command")

	local isShiny
	if math.random(0, 1) == 1 then
		isShiny = true
	else
		isShiny = false
	end

	local command = commandHandler.command:new("", true, isShiny, false, generation, true)
	command:build()
	command:execute()
end

local function processTempPokemonData()
	local name
	local shiny = false
	local art = {}

	local foo = io.open("/tmp/foo", "r")
	if not foo then
		return name, shiny, art
	end

	local lineNumber = 1
	for line in foo:lines() do
		if lineNumber == 1 then
			local part = 1
			for str in string.gmatch(line, "[^%s]+") do
				if part == 1 then
					name = str
				elseif part == 2 then
					shiny = true
				end
				part = part + 1
			end
		else
			table.insert(art, line)
		end

		lineNumber = lineNumber + 1
	end

	return name, shiny, art
end

local function printArt(art)
	for _, line in pairs(art) do
		print(line)
	end
end

local function storeGeneratedPokemon(name, shiny)
	local foo = io.open(BIN_PATH .. "last_pokemon", "w")
	if not foo then
		return
	end

	foo:write(name .. "\n")
	foo:write(tostring(shiny) .. "\n")
	foo:close()
end

local function getLastPokemon()
	local lastPokemonFile = io.open(BIN_PATH .. "last_pokemon", "r")
	if not lastPokemonFile then
		return
	end

	local name
	local isShiny

	local lineNumber = 1
	for line in lastPokemonFile:lines() do
		if lineNumber == 1 then
			name = line
		elseif lineNumber == 2 then
			if line == "true" then
				isShiny = true
			elseif line == "false" then
				isShiny = false
			end
		end
		lineNumber = lineNumber + 1
	end
	lastPokemonFile:close()

	return name, isShiny
end

local function initNewPokemon(generation)
	generateRandomPokemonData(generation)
	local name, shiny, art = processTempPokemonData()
	if name == "" then
		print("Error! Pokemon data processing failed")
		return
	end
	storeGeneratedPokemon(name, shiny)
	printArt(art)
	print("\nTo catch a pokemon enter 'pokemon catch [name] [is shiny? (true|false)]'")

	if DEBUG then
		print(name)
		print(shiny)
	end
end

return { initNewPokemon = initNewPokemon, getLastPokemon = getLastPokemon }
