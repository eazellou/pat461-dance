FreeAllFlowboxes()
FreeAllRegions()
DPrint("")

xr=0
yr=0
zr=0

function setRotate(self, x, y, z)
	xr = x
	yr = y
	zr = z
end

host = "35.2.179.193"
port = 8888

function sendAccel(self, x, y, z)
	DPrint("Sending\nRotation: "..xr.." "..yr.." "..zr.." ".."\nAccel: "..x.." "..y.." "..z)
	SendOSCMessage(host, port, "/urMus/numbers", xr, yr, zr, xa, ya, za)
end

r = Region()
r:SetWidth(ScreenWidth())
r:SetHeight(ScreenHeight())
r:EnableInput(true)
r:Handle("OnRotation", setRotate)
r:Handle("OnAccelerate", sendAccel)