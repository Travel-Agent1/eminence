
-- The Arachnid Quarter
-- The Construct Quarter
-- The Military Quarter
-- The Plague Quarter


-- Decimate every 105 seconds, Frenzy (wipe) after 480 seconds (420 in 25-man)
local gluth = Eminence:new(15932)
gluth.mobguid = 15932


local wipetime
function gluth:Engage()
	wipetime = GetTime() + (GetCurrentDungeonDifficulty() == 1 and 480 or 420)
	self:CLEU_SPELL_DAMAGE()
	self:RegisterCombatLogEvent("SPELL_DAMAGE", 28375, 54426)
	self:RegisterCombatLogEvent("SPELL_MISSED", 28375, 54426)
end


local last = 0
function gluth:CLEU_SPELL_DAMAGE() -- Decimate
	local time = GetTime()
	if (time - last) > 5 then
		last = time
		if (GetTime() + 105) < wipetime then
			self:RunStopwatch(0, 105, "Decimate:")
		else
			self:RunStopwatch(0, wipetime - GetTime(), "Wipe:")
		end
	end
end

gluth.CLEU_SPELL_MISSED = gluth.CLEU_SPELL_DAMAGE


--
-- local test = Eminence:new(26272)
-- test.mobguid = 26272
--
--
-- function test:UNIT_AURA(event, unit)
-- 	if unit ~= "player" then return end
-- 	self:RunStopwatch(0, 10, "Test:")
-- end
--
-- test:RegisterEvent("UNIT_AURA")
