local function printScore()
	local scoreFile = io.open(BIN_PATH .. "score", "r")
	if not scoreFile then
		return
	end

	local score
	for line in scoreFile:lines() do
		score = tonumber(line)
		break
	end
	if not score then
		score = 0
	end

	print(string.format("Your score is : %d", score))
end

local function updateScore(newScore)
	local scoreFile = io.open(BIN_PATH .. "score", "w")
	if not scoreFile then
		return
	end

	scoreFile:write(tostring(newScore))
	scoreFile:close()
end

local function getScore()
	local scoreFile = io.open(BIN_PATH .. "score", "r")
	if not scoreFile then
		updateScore(0)
		return 0
	end

	local score
	for line in scoreFile:lines() do
		score = tonumber(line)
		break
	end
	if not score then
		score = 0
	end

	return score
end

return { printScore = printScore, getScore = getScore, updateScore = updateScore }
