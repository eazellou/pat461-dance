FreeAllFlowboxes()
FreeAllRegions()
dac= FBDac

sinosc = FlowBox(FBSinOsc)

asymp = FlowBox(FBAsymp)
energyPush = FlowBox(FBPush)
energyPush.Out:SetPush(asymp.In)
asymp.In:SetPull(energyPush.Out)
sinosc.Amp:SetPull(asymp.Out)

freqPush = FlowBox(FBPush)
freqSymp = FlowBox(FBAsymp)
freqPush.Out:SetPush(freqSymp.In)
freqSymp.In:SetPull(freqPush.Out)
sinosc.Freq:SetPull(freqSymp.Out)


dac.In:SetPull(sinosc.Out)

freqPush:Push(.5)
energyPush:Push(.5)


function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function printData()
	--ranges from 1-100
	--DPrint("gyro: " .. rotX .. "  " .. rotY .. " " .. rotZ .. "   accel: " .. accX .. " " .. accY .. " " .. accZ)
end

function addEnergy(energy)
	--DPrint(energy)
	energyPush:Push(energy)
end

function changeFreq(freq)
	freqPush:Push(freq)
end

function rotate(self, x, y, z)
	rotX = round(x,2)
	rotY = round(y,2)
	rotZ = round(z,2)
	magnitude = math.sqrt(x^2 + y^2 + z^2)
	magnitude = magnitude*.5 + .25 --so that it doesn't go quite as high or low
	changeFreq(magnitude)
	DPrint(rotX .. " " .. rotY .. " " .. rotZ)
	printData()
end

function accel(self, x, y, z)
	magnitude = math.sqrt(x^2 + y^2 + z^2)
	--magnitude ranges about .98 - 3.5
	energy = 1-magnitude
	--energy ranges about .28 - 1
	--DPrint(accX)
	addEnergy(energy)
	printData()
end


r = Region()
r:SetWidth(ScreenWidth())
r:SetHeight(ScreenHeight())
r:EnableInput(true)
r:Handle("OnRotation", rotate)
r:Handle("OnAccelerate", accel)