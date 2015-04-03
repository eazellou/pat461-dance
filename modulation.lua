FreeAllFlowboxes()
FreeAllRegions()
dac= FBDac

asymp = FlowBox(FBAsymp)
sinosc = FlowBox(FBSinOsc)
energyPush = FlowBox(FBPush)
energyPush.Out:SetPush(asymp.In)
asymp.In:SetPull(energyPush.Out) --switch with this
freqPush = FlowBox(FBPush)
freqPush.Out:SetPush(sinosc.Freq)
--energyPush.Out:SetPush(sinosc.Amp)
--asymp.Out:SetPush(sinosc.Amp) --switch with this
sinosc.Amp:SetPull(asymp.Out)

dac.In:SetPull(sinosc.Out)

freqPush:Push(.3)
energyPush:Push(.5)

rotX = 0
rotY = 0
rotZ = 0
accX = 0
accY = 0
accZ = 0

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

function rotate(self, x, y, z)
	rotX = round(100*x, 0)
	rotY = round(100*y, 0)
	rotZ = round(100*z, 0)
	printData()
end

function accel(self, x, y, z)
	accX = round(x, 2)
	accY = round(y, 2)
	accZ = round(z, 2)
	magnitude = math.sqrt(accX^2 + accY^2 + accZ^2)
	--magnitude ranges about .98 - 3.5
	energy = 1-magnitude
	--energy ranges about .28 - 1
	DPrint(energy)
	addEnergy(energy)
	printData()
end


r = Region()
r:SetWidth(ScreenWidth())
r:SetHeight(ScreenHeight())
r:EnableInput(true)
r:Handle("OnRotation", rotate)
r:Handle("OnAccelerate", accel)