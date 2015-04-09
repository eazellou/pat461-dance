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

host = "35.2.144.72"
port = 8888

function sendAccel(self, xa, ya, za)
	DPrint("Sending\nRotation: "..xr.." "..yr.." "..zr.." ".."\nAccel: "..xa.." "..ya.." "..za)
	-- SendOSCMessage(host, portR, "/urMus/numbers", xr, yr, zr)
	-- SendOSCMessage(host, portA, "/urMus/numbers", xa, ya, za)
	SendOSCMessage(host, port, "/urMus/numbers", 1, xr)
	SendOSCMessage(host, port, "/urMus/numbers", 2, yr)
	SendOSCMessage(host, port, "/urMus/numbers", 3, zr)
	SendOSCMessage(host, port, "/urMus/numbers", 4, xa)
	SendOSCMessage(host, port, "/urMus/numbers", 5, ya)
	SendOSCMessage(host, port, "/urMus/numbers", 6, za)
end

r = Region()
r:SetWidth(ScreenWidth())
r:SetHeight(ScreenHeight())
r:EnableInput(true)
r:Handle("OnRotation", setRotate)
r:Handle("OnAccelerate", sendAccel)