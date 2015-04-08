FreeAllFlowboxes()
FreeAllRegions()
DPrint("")

dac= FBDac
sinosc = FlowBox(FBCMap)

-- energy1 -> Asymp -> CMap.Amp
asymp = FlowBox(FBAsymp)
energyPush = FlowBox(FBPush)
energyPush.Out:SetPush(asymp.In)
asymp.In:SetPull(energyPush.Out)
sinosc.Amp:SetPull(asymp.Out)

-- frequency -> Asymp -> CMap.Freq
freqPush = FlowBox(FBPush)
freqSymp = FlowBox(FBAsymp)
freqPush.Out:SetPush(freqSymp.In)
sinosc.Freq:SetPull(freqSymp.Out)

-- nonLin1 -> Asymp -> CMap.NonL
linPush = FlowBox(FBPush)
linSymp = FlowBox(FBAsymp)
linSymp.In:SetPull(linPush.Out)
sinosc.NonL:SetPull(linSymp.Out)

-- energy2 -> Asymp -> CMap.Amp
sinosc2 = FlowBox(FBCMap)
asymp2 = FlowBox(FBAsymp)
energyPush2 = FlowBox(FBPush)
energyPush2.Out:SetPush(asymp2.In)
sinosc2.Amp:SetPull(asymp2.Out)

-- frequency -> Asymp -> CMap.Freq
freqPush2 = FlowBox(FBPush)
freqSymp2 = FlowBox(FBAsymp)
freqPush2.Out:SetPush(freqSymp2.In)
sinosc2.Freq:SetPull(freqSymp2.Out)

-- nonLin1 -> Asymp -> CMap.NonL
linPush2 = FlowBox(FBPush)
linSymp2 = FlowBox(FBAsymp)
linSymp2.In:SetPull(linPush2.Out)
sinosc2.NonL:SetPull(linSymp2.Out)

sinosc3 = FlowBox(FBCMap)
asymp3 = FlowBox(FBAsymp)
energyPush3 = FlowBox(FBPush)
energyPush3.Out:SetPush(asymp3.In)
sinosc3.Amp:SetPull(asymp3.Out)

freqPush3 = FlowBox(FBPush)
freqSymp3 = FlowBox(FBAsymp)
freqPush3.Out:SetPush(freqSymp3.In)
sinosc3.Freq:SetPull(freqSymp3.Out)

linPush3 = FlowBox(FBPush)
linSymp3 = FlowBox(FBAsymp)
linSymp3.In:SetPull(linPush3.Out)
sinosc3.NonL:SetPull(linSymp3.Out)

sinosc4 = FlowBox(FBCMap)
asymp4 = FlowBox(FBAsymp)
energyPush4 = FlowBox(FBPush)
energyPush4.Out:SetPush(asymp4.In)
sinosc4.Amp:SetPull(asymp4.Out)

freqPush4 = FlowBox(FBPush)
freqSymp4 = FlowBox(FBAsymp)
freqPush4.Out:SetPush(freqSymp4.In)
sinosc4.Freq:SetPull(freqSymp4.Out)

linPush4 = FlowBox(FBPush)
linSymp4 = FlowBox(FBAsymp)
linSymp4.In:SetPull(linPush4.Out)
sinosc4.NonL:SetPull(linSymp4.Out)

-- CMap -> Dac
dac.In:SetPull(sinosc.Out)
dac.In:SetPull(sinosc2.Out)
dac.In:SetPull(sinosc3.Out)
dac.In:SetPull(sinosc4.Out)

freqPush:Push(.5)
energyPush:Push(.5)
linPush:Push(0)
linPush2:Push(0)
linPush3:Push(0)
linPush4:Push(0)


function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function printData()
	--ranges from 1-100
	--DPrint("gyro: " .. rotX .. "  " .. rotY .. " " .. rotZ .. "   accel: " .. accX .. " " .. accY .. " " .. accZ)
end

function addEnergy(energy)
	DPrint(energy)
	nonLin1 = energy
	nonLin2 = 3*energy/4
	nonLin3 = energy/2
	nonLin4 = energy/4
	linPush:Push(nonLin1)
	linPush2:Push(nonLin2)
	linPush3:Push(nonLin3)
	linPush4:Push(nonLin4)
	energy1 = energy
	energy2 = energy/2
	energy3 = energy/4
	energy4 = energy/64
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
	magnitude = magnitude*.5 --so that it doesn't go quite as high or low
	changeFreq(magnitude)
	--DPrint(rotX .. " " .. rotY .. " " .. rotZ)
	printData()
end

function accel(self, x, y, z)
	magnitude = math.sqrt(x^2 + y^2 + z^2)
	--DPrint(magnitude)
	--magnitude ranges about .98 - 3.5
	energy = (magnitude - 1)*.7
	if energy > .8 then
		energy = .8
	end
	if energy < .05 then
		energy = .05
	end
	--energy ranges about .28 - 1
	--DPrint(accX)
	addEnergy(energy)
	printData()
end

r = Region()

-- We register this function to be called when a network traffic is incoming
function gotOSC(self, xr, yr, zr, xa, ya, za)
    DPrint("Receiving\nRotation: "..xr.." "..yr.." "..zr.." ".."\nAccel: "..xa.." "..ya.." "..za)
    rotate(self, xr, yr, zr)
    accel(self, xa, ya, za)
end

r:Handle("OnOSCMessage", gotOSC)

SetOSCPort(8888)
host,port = StartOSCListener()