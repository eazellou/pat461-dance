FreeAllFlowboxes()
FreeAllRegions()
dac= FBDac

asymp1 = FlowBox(FBAsymp)
sinosc1 = FlowBox(FBSinOsc)
push1 = FlowBox(FBPush)
push1.Out:SetPush(asymp1.In)
sinosc1.Amp:SetPull(asymp1.Out)

dac.In:SetPull(sinosc1.Out)

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
	DPrint("gyro: " .. rotX .. "  " .. rotY .. " " .. rotZ .. "   accel: " .. accX .. " " .. accY .. " " .. accZ)
end

function rotate(self, x, y, z)
	rotX = round(100*x, 0)
	rotY = round(100*y, 0)
	rotZ = round(100*z, 0)
	printData()
end

function accel(self, x, y, z)
	accX = round(100*x, 0)
	accY = round(100*y, 0)
	accZ = round(100*z, 0)
	printData()
end


r = Region()
r:SetWidth(ScreenWidth())
r:SetHeight(ScreenHeight())
r:EnableInput(true)
r:Handle("OnRotation", rotate)
r:Handle("OnAccelerate", accel)
