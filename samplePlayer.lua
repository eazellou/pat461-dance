FreeAllRegions()
FreeAllFlowboxes()
DPrint("start")

pushStarts = {}
samplers = {}
pushLoop = {}
pushAmp = {}
pushSample = {}
dac = FBDac

for j = 1,3 do
    samplers[j] = FlowBox(FBSample)
end

for k = 1,3 do
	--22 notes
	samplers[k]:AddFile(DocumentPath("C2Medium.wav"))
	samplers[k]:AddFile(DocumentPath("D2Medium.wav"))
	samplers[k]:AddFile(DocumentPath("E2Medium.wav"))
	samplers[k]:AddFile(DocumentPath("F2Medium.wav"))
	samplers[k]:AddFile(DocumentPath("G2Medium.wav"))
	samplers[k]:AddFile(DocumentPath("A2Medium.wav"))
	samplers[k]:AddFile(DocumentPath("B2Medium.wav"))
	samplers[k]:AddFile(DocumentPath("C3Medium.wav"))
	samplers[k]:AddFile(DocumentPath("D3Medium.wav"))
	samplers[k]:AddFile(DocumentPath("E3Medium.wav"))
	samplers[k]:AddFile(DocumentPath("F3Medium.wav"))
	samplers[k]:AddFile(DocumentPath("G3Medium.wav"))
	samplers[k]:AddFile(DocumentPath("A3Medium.wav"))
	samplers[k]:AddFile(DocumentPath("B3Medium.wav"))
	samplers[k]:AddFile(DocumentPath("C4Medium.wav"))
	samplers[k]:AddFile(DocumentPath("D4Medium.wav"))
	samplers[k]:AddFile(DocumentPath("E4Medium.wav"))
	samplers[k]:AddFile(DocumentPath("F4Medium.wav"))
	samplers[k]:AddFile(DocumentPath("G4Medium.wav"))
	samplers[k]:AddFile(DocumentPath("A4Medium.wav"))
	samplers[k]:AddFile(DocumentPath("B4Medium.wav"))
	samplers[k]:AddFile(DocumentPath("C5Medium.wav"))
end

for i = 1,3 do
    pushStarts[i] = FlowBox(FBPush)
    pushLoop[i] = FlowBox(FBPush)
    pushSample[i] = FlowBox(FBPush)
    pushAmp[i] = FlowBox(FBPush)

    pushStarts[i].Out:SetPush(samplers[i].Pos)
    pushLoop[i].Out:SetPush(samplers[i].Loop)
    pushSample[i].Out:SetPush(samplers[i].Sample)
    pushAmp[i].Out:SetPush(samplers[i].Amp)

    pushLoop[i]:Push(0) --don't loop
    pushStarts[i]:Push(1) --don't start playing until triggered later
    pushAmp[i]:Push(.7) --less likely to clip if layering sounds

    dac.In:SetPull(samplers[i].Out) --connect samplers to speaker
end


piano = {}
for p = 1,22 do
	piano[p] = 0 --initially no notes are active
end

function activatePitch(pitch, on)
	root = 0
	if pitch == "C" then
		root = 0
		if on then
			piano[22] = 1
		else
			piano[22] = 0
		end
	elseif pitch == "D" then
		root = 1
	elseif pitch == "E" then
		root = 2
	elseif pitch == "F" then
		root = 3
	elseif pitch == "G" then
		root = 4
	elseif pitch == "A" then
		root = 5
	elseif pitch == "B" then
		root = 6
	end
	if on then
		piano[root+1] = 1
		piano[root+8] = 1
		piano[root+15] = 1
	else
		piano[root+1] = 0
		piano[root+8] = 0
		piano[root+15] = 0
	end
end

function validPitch(pitch, dist, up)
	if (piano[pitch] == 0) then
		return false
	elseif (up == 1 and pitch < prevPitch) then
		if pitch < 22 then
			return false
		else
			return true
		end
	elseif ((up == 0) and pitch > prevPitch) then
		if pitch > 1 then
			return false
		else
			return true
		end
	elseif math.abs(pitch - prevPitch) < dist then
		return false
	else
		return true
	end
end

numPlayer = 1
prevPitch = 0

function playMedNote(dist, up)
	--numPlayer is the index for whatever player is next in the circle
	--dist ranges from 0-5
	--if up, will move note up, otherwise will move note down
	if(up == 1)then
		random = math.ceil(math.random()*6)
	elseif(up==0)then
		random = math.ceil(math.random()*6)+16
	else
		random = math.ceil(math.random()*22) --random number 1-22
	end
	
	if (prevPitch==0) then
		prevPitch = random
	end
	
	done = 0
	final = 0
	while (done == 0) do
		random = math.ceil(math.random()*22) --only choose a number activated by keyboard
		done = validPitch(random, dist, up)
		if done then
			final = random
		end
	end
	prevPitch = random
	
		pushSample[numPlayer]:Push(final/22 + 1/44) --go to randomly chosen note
		pushStarts[numPlayer]:Push(-1) --play note
		DPrint(final)
		numPlayer = numPlayer + 1 --increment to next player
		if numPlayer > 3 then
			numPlayer = 1
		end
	
end

--pentatonic
	activatePitch("C",1)
	activatePitch("E",1)
	activatePitch("G",1)
	activatePitch("A",1)


delX = 0
delY = 0
delZ = 0
accX = 0
accY = 0
accZ = 0
accXold = 0
accYold = 0
accZold = 0

up = false

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function accel(self, x, y, z)
	accXold = accX
	accYold = accY
	accZold = accZ
	accX = round(x, 2)
	accY = round(y, 2)
	accZ = round(z, 2)
	delX = accX - accXold
	delY = accY - accYold
	delZ = accZ - accZold
end

function detect(self)
	if (math.abs(delY) > .3 and accY < 0) then
		--quickly moving up
		DPrint("moving UP quickly")
		playMedNote(0,1)
	elseif (math.abs(delY) > .3 and accY > 0) then
		--quickly moving down
		DPrint("moving DOWN quickly")
		playMedNote(0,0)
	elseif (math.abs(delY) < .3) then
		--not moving up or down quickly
	end
	if(accY < 0) then
		up = true
	else
		up = false
	end
	
	
end


i = 1
r = Region()
r:SetWidth(ScreenWidth())
r:SetHeight(ScreenHeight())
r:EnableInput(true)
r:Handle("OnAccelerate", accel)
r:Handle("OnUpdate", detect)





















