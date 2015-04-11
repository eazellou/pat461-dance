FreeAllFlowboxes()
FreeAllRegions()
DPrint("")

dac= FBDac
sinosc = FlowBox(FBCMap)

-- energy1 -> Asymp -> CMap.Amp
asymp = FlowBox(FBAsymp)
energyPush = FlowBox(FBPush)
ampAttack = FlowBox(FBPush)
ampAttack.Out:SetPush(asymp.Tau)
energyPush.Out:SetPush(asymp.In)
asymp.In:SetPull(energyPush.Out)
sinosc.Amp:SetPull(asymp.Out)

-- frequency -> Asymp -> CMap.Freq
freqPush = FlowBox(FBPush)
freqSymp = FlowBox(FBAsymp)
fAttackPush = FlowBox(FBPush)
fAttackPush.Out:SetPush(freqSymp.Tau)
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
ampAttack2 = FlowBox(FBPush)
ampAttack2.Out:SetPush(asymp2.Tau)
energyPush2 = FlowBox(FBPush)
energyPush2.Out:SetPush(asymp2.In)
sinosc2.Amp:SetPull(asymp2.Out)

-- frequency -> Asymp -> CMap.Freq
freqPush2 = FlowBox(FBPush)
freqSymp2 = FlowBox(FBAsymp)
fAttackPush2 = FlowBox(FBPush)
fAttackPush2.Out:SetPush(freqSymp2.Tau)
freqPush2.Out:SetPush(freqSymp2.In)
sinosc2.Freq:SetPull(freqSymp2.Out)

-- nonLin1 -> Asymp -> CMap.NonL
linPush2 = FlowBox(FBPush)
linSymp2 = FlowBox(FBAsymp)
linSymp2.In:SetPull(linPush2.Out)
sinosc2.NonL:SetPull(linSymp2.Out)

sinosc3 = FlowBox(FBCMap)
asymp3 = FlowBox(FBAsymp)
ampAttack3 = FlowBox(FBPush)
ampAttack3.Out:SetPush(asymp3.Tau)
energyPush3 = FlowBox(FBPush)
energyPush3.Out:SetPush(asymp3.In)
sinosc3.Amp:SetPull(asymp3.Out)

freqPush3 = FlowBox(FBPush)
freqSymp3 = FlowBox(FBAsymp)
fAttackPush3 = FlowBox(FBPush)
fAttackPush3.Out:SetPush(freqSymp3.Tau)
freqPush3.Out:SetPush(freqSymp3.In)
sinosc3.Freq:SetPull(freqSymp3.Out)

linPush3 = FlowBox(FBPush)
linSymp3 = FlowBox(FBAsymp)
linSymp3.In:SetPull(linPush3.Out)
sinosc3.NonL:SetPull(linSymp3.Out)

sinosc4 = FlowBox(FBCMap)
asymp4 = FlowBox(FBAsymp)
ampAttack4 = FlowBox(FBPush)
ampAttack4.Out:SetPush(asymp4.Tau)
energyPush4 = FlowBox(FBPush)
energyPush4.Out:SetPush(asymp4.In)
sinosc4.Amp:SetPull(asymp4.Out)

freqPush4 = FlowBox(FBPush)
freqSymp4 = FlowBox(FBAsymp)
fAttackPush4 = FlowBox(FBPush)
fAttackPush4.Out:SetPush(freqSymp4.Tau)
freqPush4.Out:SetPush(freqSymp4.In)
sinosc4.Freq:SetPull(freqSymp4.Out)

linPush4 = FlowBox(FBPush)
linSymp4 = FlowBox(FBAsymp)
linSymp4.In:SetPull(linPush4.Out)
sinosc4.NonL:SetPull(linSymp4.Out)

-- CMap -> Rev
rev = FlowBox(FBJCRev)
rev2 = FlowBox(FBJCRev)
rev3 = FlowBox(FBJCRev)
rev4 = FlowBox(FBJCRev)
rev.In:SetPull(sinosc.Out)
rev2.In:SetPull(sinosc2.Out)
rev3.In:SetPull(sinosc3.Out)
rev4.In:SetPull(sinosc4.Out)

revPush = FlowBox(FBPush)
revPush:SetPush(rev.T60)
revPush1 = FlowBox(FBPush)
revPush1:SetPush(rev.T60)
revPush2 = FlowBox(FBPush)
revPush2:SetPush(rev.T60)
revPush3 = FlowBox(FBPush)
revPush3:SetPush(rev.T60)
revPush4 = FlowBox(FBPush)
revPush4:SetPush(rev.T60)

revPush:Push(.6)
revPush2:Push(.6)
revPush3:Push(.6)
revPush4:Push(.6)

-- Rev -> Dac
dac.In:SetPull(rev.Out)
dac.In:SetPull(rev2.Out)
dac.In:SetPull(rev3.Out)
dac.In:SetPull(rev4.Out)

freqPush:Push(.5)
energyPush:Push(.5)
linPush:Push(0)
linPush2:Push(0)
linPush3:Push(0)
linPush4:Push(0)
fAttackPush:Push(-.5) --start out with a quick attack
fAttackPush2:Push(-.5)
fAttackPush3:Push(-.5)
fAttackPush4:Push(-.5)
ampAttack:Push(-.5)
ampAttack2:Push(-.5)
ampAttack3:Push(-.5)
ampAttack4:Push(-.5)

prevEnergy = 0
prevFreq = 0

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function printData()
	--ranges from 1-100
	--DPrint("gyro: " .. rotX .. "  " .. rotY .. " " .. rotZ .. "   accel: " .. accX .. " " .. accY .. " " .. accZ)
end

tau1 = -.9
tau2 = .5

function addEnergy(energy)
	if energy > prevEnergy then
		--increasing energy, want a quick attack
		ampAttack:Push(tau1)
		ampAttack2:Push(tau1)
		ampAttack3:Push(tau1)
		ampAttack4:Push(tau1)
	else
		--decreasing energy, want a long release
		ampAttack:Push(tau2)
		ampAttack2:Push(tau2)
		ampAttack3:Push(tau2)
		ampAttack4:Push(tau2)
	end
	prevEnergy = energy --update

	--non-linear timbre
	nonLin1 = energy
	nonLin2 = 3*energy/4
	nonLin3 = energy/2
	nonLin4 = energy/4
	linPush:Push(nonLin1)
	linPush2:Push(nonLin2)
	linPush3:Push(nonLin3)
	linPush4:Push(nonLin4)

	--amplitude
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
	if freq > prevFreq then
		--increasing frequency so we want a quick attack
		fAttackPush:Push(tau1)
		fAttackPush2:Push(tau1)
		fAttackPush3:Push(tau1)
		fAttackPush4:Push(tau1)
	else
		--decreasing frequency so we want a slow release
		fAttackPush:Push(tau2)
		fAttackPush2:Push(tau2)
		fAttackPush3:Push(tau2)
		fAttackPush4:Push(tau2)
	end
	prevFreq = freq --update
	
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

xr = 0
yr = 0
zr = 0
xa = 0
ya = 0
za = 0

-- We register this function to be called when a network traffic is incoming
function gotOSC(self, num, data)
	if num == 1 then
		xr = data
	elseif num == 2 then
		yr = data
	elseif num == 3 then
		zr = data
	elseif num == 4 then
		xa = data
	elseif num == 5 then
		ya = data
	elseif num == 6 then
		za = data
	else
		DPrint("Error")
	end
	
	DPrint("Receiving\nRotation: "..(xr or "nil").." "..(yr or "nil").." "..(zr or "nil").." ".."\nAccel: "..(xa or "nil").." "..(ya or "nil").." "..(za or "nil"))
    rotate(self, xr, yr, zr)
    accel(self, xa, ya, za)
end

r:Handle("OnOSCMessage", gotOSC)
r:SetWidth(ScreenWidth())
r:SetHeight(ScreenHeight())
r.t = r:Texture(255, 100, 100, 255)
r:Show()
SetOSCPort(8888)
host,port = StartOSCListener()

--------------------------------------------- UI ----------------------------------------------

wave = Region()

wave:SetHeight(10)
wave:SetWidth(10)
wave.t = wave:Texture(255, 255, 255, 255)
wave:SetAnchor("CENTER", 0.5*ScreenWidth(), 0.5*ScreenHeight())
wave:EnableInput(true)
wave:Show()
wave.shrinkspeed = 100

wave.isActive = false

function expand(self, elapsed)
	if (self.isActive) then
		DPrint("Scale: "..self:Width())
		self:SetWidth(self:Width() + elapsed * self.shrinkspeed)
		self:SetHeight(self:Height() + elapsed * self.shrinkspeed)
		if (self:Height() >= ScreenHeight()) then
			wave:SetHeight(10)
			wave:SetWidth(10)
			wave.isActive = true
		end
	end
end

function activate(self)
	DPrint("Activated")
	self.isActive = true
	self:SetWidth(self.width)
end

wave:Handle("OnTouchDown", activate)
wave:Handle("OnUpdate", expand)
