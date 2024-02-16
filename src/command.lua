local command = {
	settings = {
		name = "",
		isRandom = false,
		isShiny = false,
		isBig = false,
		generation = 1,
		toStore = false,
	},
	command = "",
}

function command.new(self, name, isRandom, isShiny, isBig, generation, toStore)
	self.settings.name = name
	self.settings.isRandom = isRandom
	self.settings.isShiny = isShiny
	self.settings.isBig = isBig
	self.settings.generation = generation
	self.settings.toStore = toStore

	return self
end

function command.build(self)
	local tempCommand = "pokemon-colorscripts"

	if self.settings.isRandom then
		tempCommand = tempCommand .. " -r"
		if self.generation then
			tempCommand = string.format(" %s %d", tempCommand, self.generation)
		end
	end

	if self.settings.isShiny then
		tempCommand = tempCommand .. " -s"
	end

	if self.settings.isBig then
		tempCommand = tempCommand .. " -b"
	end

	if self.settings.name ~= "" then
		tempCommand = string.format(" %s -n %s", tempCommand, self.settings.name)
	end

	if self.settings.toStore then
		tempCommand = tempCommand .. " > /tmp/foo"
	else
		tempCommand = tempCommand .. " --no-title"
	end

	self.command = tempCommand
end

function command.execute(self)
	os.execute(self.command)
end

return { command = command }
