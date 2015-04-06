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

sinosc2 = FlowBox(FBSinOsc)
asymp2 = FlowBox(FBAsymp)
energyPush2 = FlowBox(FBPush)
energyPush2.Out:SetPush(asymp2.In)
asymp2.In:SetPull(energyPush2.Out)
sinosc2.Amp:SetPull(asymp2.Out)

freqPush2 = FlowBox(FBPush)
freqSymp2 = FlowBox(FBAsymp)
freqPush2.Out:SetPush(freqSymp2.In)
freqSymp2.In:SetPull(freqPush2.Out)
sinosc2.Freq:SetPull(freqSymp2.Out)

sinosc3 = FlowBox(FBSinOsc)
asymp3 = FlowBox(FBAsymp)
energyPush3 = FlowBox(FBPush)
energyPush3.Out:SetPush(asymp3.In)
asymp3.In:SetPull(energyPush3.Out)
sinosc3.Amp:SetPull(asymp3.Out)

freqPush3 = FlowBox(FBPush)
freqSymp3 = FlowBox(FBAsymp)
freqPush3.Out:SetPush(freqSymp3.In)
freqSymp3.In:SetPull(freqPush3.Out)
sinosc3.Freq:SetPull(freqSymp3.Out)

sinosc4 = FlowBox(FBSinOsc)
asymp4 = FlowBox(FBAsymp)
energyPush4 = FlowBox(FBPush)
energyPush4.Out:SetPush(asymp4.In)
asymp4.In:SetPull(energyPush4.Out)
sinosc4.Amp:SetPull(asymp4.Out)

freqPush4 = FlowBox(FBPush)
freqSymp4 = FlowBox(FBAsymp)
freqPush4.Out:SetPush(freqSymp4.In)
freqSymp4.In:SetPull(freqPush4.Out)
sinosc4.Freq:SetPull(freqSymp4.Out)


dac.In:SetPull(sinosc.Out)
dac.In:SetPull(sinosc2.Out)
dac.In:SetPull(sinosc3.Out)
dac.In:SetPull(sinosc4.Out)

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
	energy1 = energy
	energy2 = energy/2
	energy3 = energy/4
	energy4 = energy/8
	energyPush:Push(energy1)
	energyPush2:Push(energy2)
	energyPush3:Push(energy3)
	energyPush4:Push(energy4)
end

function changeFreq(freq)
	freq1 = freq/4 + 3/16
	freq2 = freq/3 + 1/6
	freq3 = freq/2 + 1/8
	freq4 = freq
	freqPush:Push(freq1)
	freqPush2:Push(freq2)
	freqPush3:Push(freq3)
	freqPush4:Push(freq4)
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