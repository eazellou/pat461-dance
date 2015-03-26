DPrint("")
FreeAllRegions()

FreeAllRegions()

host = "35.2.73.0"
port = 8080

bg = Region()
bg:Show()
bg:SetWidth(ScreenWidth())
bg:SetHeight(ScreenHeight())
bg.t = bg:Texture(100, 100, 255, 255)
bg:SetLayer("BACKGROUND")

-- Two Tracks and piano container

upperTrack = Region()
upperTrack:Show()
upperTrack:SetAnchor("CENTER", 0.7*ScreenWidth(), 0.5*ScreenHeight())
upperTrack:SetHeight(ScreenHeight()*0.75)
upperTrack:SetWidth(ScreenWidth()*0.03)
upperTrack.t = upperTrack:Texture(0, 0, 255, 255)
upperTrack:SetLayer("MEDIUM")
upperTrack:EnableInput(true)

lowerTrack = Region()
lowerTrack:Show()
lowerTrack:SetAnchor("CENTER", 0.85*ScreenWidth(), 0.5*ScreenHeight())
lowerTrack:SetHeight(ScreenHeight()*0.75)
lowerTrack:SetWidth(ScreenWidth()*0.03)
lowerTrack.t = lowerTrack:Texture(0, 0, 255, 255)
lowerTrack:SetLayer("MEDIUM")
lowerTrack:EnableInput(true)

pianoContainer = Region()
pianoContainer:Show()
pianoContainer:SetAnchor("CENTER", 0.3*ScreenWidth(), 0.5*ScreenHeight())
pianoContainer:SetHeight(ScreenHeight()*0.75)
pianoContainer:SetWidth(ScreenWidth()*0.45)
pianoContainer.t = pianoContainer:Texture(125, 125, 125, 255)
pianoContainer:SetLayer("MEDIUM")

-- block on lower track
lowerBlock = Region()
lowerBlock:Show()
lowerBlock:SetAnchor("CENTER", lowerTrack,"CENTER", 0, 0)
lowerBlock:SetHeight(ScreenHeight()*0.03)
lowerBlock:SetWidth(ScreenWidth()*0.08)
lowerBlock.t = lowerBlock:Texture(100, 0, 255, 255)
lowerBlock:SetLayer("LOW")
lowerBlock:EnableInput(true)
-- lowerBlock:EnableMoving(true)

-- blocks on upper track
upperLeftBlock = Region()
upperLeftBlock:Show()
upperLeftBlock:SetAnchor("CENTER", upperTrack,"CENTER", 0, -ScreenHeight()*0.75/2)
upperLeftBlock:SetHeight(ScreenHeight()*0.03)
upperLeftBlock:SetWidth(ScreenWidth()*0.08)
upperLeftBlock.t = upperLeftBlock:Texture(100, 0, 255, 255)
upperLeftBlock:SetLayer("LOW")
-- upperLeftBlock:EnableInput(true)
-- upperLeftBlock:EnableMoving(true)

upperRightBlock = Region()
upperRightBlock:Show()
upperRightBlock:SetAnchor("CENTER", upperTrack,"CENTER", 0, -20)
upperRightBlock:SetHeight(ScreenHeight()*0.03)
upperRightBlock:SetWidth(ScreenWidth()*0.08)
upperRightBlock.t = upperRightBlock:Texture(100, 0, 255, 255)
upperRightBlock:SetLayer("LOW")
upperRightBlock:EnableInput(true)
-- upperRightBlock:EnableMoving(true)

-- Piano Keys (White)

doKey = Region()
doKey:Show()
doKey:SetAnchor("CENTER", 0.3*ScreenWidth(), (0.5 - 0.3171)*ScreenHeight())
doKey:SetHeight(ScreenHeight()*0.0957)
doKey:SetWidth(ScreenWidth()*0.43)
doKey.t = doKey:Texture(255, 255, 255, 255)
doKey:SetLayer("MEDIUM")
doKey:EnableInput(true)
doKey.osc = "do"

reKey = Region()
reKey:Show()
reKey:SetAnchor("CENTER", 0.3*ScreenWidth(), (0.5 - 0.2114)*ScreenHeight())
reKey:SetHeight(ScreenHeight()*0.0957)
reKey:SetWidth(ScreenWidth()*0.43)
reKey.t = reKey:Texture(255, 255, 255, 255)
reKey:SetLayer("MEDIUM")
reKey:EnableInput(true)
reKey.osc = "re"

miKey = Region()
miKey:Show()
miKey:SetAnchor("CENTER", 0.3*ScreenWidth(), (0.5 - 0.1057)*ScreenHeight())
miKey:SetHeight(ScreenHeight()*0.0957)
miKey:SetWidth(ScreenWidth()*0.43)
miKey.t = miKey:Texture(255, 255, 255, 255)
miKey:SetLayer("MEDIUM")
miKey:EnableInput(true)
miKey.osc = "mi"

faKey = Region()
faKey:Show()
faKey:SetAnchor("CENTER", 0.3*ScreenWidth(), 0.5*ScreenHeight())
faKey:SetHeight(ScreenHeight()*0.0957)
faKey:SetWidth(ScreenWidth()*0.43)
faKey.t = faKey:Texture(255, 255, 255, 255)
faKey:SetLayer("MEDIUM")
faKey:EnableInput(true)
faKey.osc = "fa"

soKey = Region()
soKey:Show()
soKey:SetAnchor("CENTER", 0.3*ScreenWidth(), (0.5 + 0.1057)*ScreenHeight())
soKey:SetHeight(ScreenHeight()*0.0957)
soKey:SetWidth(ScreenWidth()*0.43)
soKey.t = soKey:Texture(255, 255, 255, 255)
soKey:SetLayer("MEDIUM")
soKey:EnableInput(true)
soKey.osc = "so"

laKey = Region()
laKey:Show()
laKey:SetAnchor("CENTER", 0.3*ScreenWidth(), (0.5 + 0.2114)*ScreenHeight())
laKey:SetHeight(ScreenHeight()*0.0957)
laKey:SetWidth(ScreenWidth()*0.43)
laKey.t = laKey:Texture(255, 255, 255, 255)
laKey:SetLayer("MEDIUM")
laKey:EnableInput(true)
laKey.osc = "la"

xiKey = Region()
xiKey:Show()
xiKey:SetAnchor("CENTER", 0.3*ScreenWidth(), (0.5 + 0.3171)*ScreenHeight())
xiKey:SetHeight(ScreenHeight()*0.0957)
xiKey:SetWidth(ScreenWidth()*0.43)
xiKey.t = xiKey:Texture(255, 255, 255, 255)
xiKey:SetLayer("MEDIUM")
xiKey:EnableInput(true)
xiKey.osc = "xi"

-- Piano Keys (Black)
doreKey = Region()
doreKey:Show()
doreKey:SetAnchor("BOTTOMLEFT", reKey,"BOTTOMLEFT", 0, -0.035* ScreenHeight())
doreKey:SetHeight(ScreenHeight()*0.06)
doreKey:SetWidth(ScreenWidth()*0.33)
doreKey.t = doreKey:Texture(0, 0, 0, 255)
doreKey:SetLayer("HIGH")
doreKey:EnableInput(true)
doreKey.osc = "dore"

remiKey = Region()
remiKey:Show()
remiKey:SetAnchor("BOTTOMLEFT", miKey,"BOTTOMLEFT", 0, -0.035* ScreenHeight())
remiKey:SetHeight(ScreenHeight()*0.06)
remiKey:SetWidth(ScreenWidth()*0.33)
remiKey.t = remiKey:Texture(0, 0, 0, 255)
remiKey:SetLayer("HIGH")
remiKey:EnableInput(true)
remiKey.osc = "remi"

fasoKey = Region()
fasoKey:Show()
fasoKey:SetAnchor("BOTTOMLEFT", soKey,"BOTTOMLEFT", 0, -0.035* ScreenHeight())
fasoKey:SetHeight(ScreenHeight()*0.06)
fasoKey:SetWidth(ScreenWidth()*0.33)
fasoKey.t = fasoKey:Texture(0, 0, 0, 255)
fasoKey:SetLayer("HIGH")
fasoKey:EnableInput(true)
fasoKey.osc = "faso"

solaKey = Region()
solaKey:Show()
solaKey:SetAnchor("BOTTOMLEFT", laKey,"BOTTOMLEFT", 0, -0.035* ScreenHeight())
solaKey:SetHeight(ScreenHeight()*0.06)
solaKey:SetWidth(ScreenWidth()*0.33)
solaKey.t = solaKey:Texture(0, 0, 0, 255)
solaKey:SetLayer("HIGH")
solaKey:EnableInput(true)
solaKey.osc = "sola"

laxiKey = Region()
laxiKey:Show()
laxiKey:SetAnchor("BOTTOMLEFT", xiKey,"BOTTOMLEFT", 0, -0.035* ScreenHeight())
laxiKey:SetHeight(ScreenHeight()*0.06)
laxiKey:SetWidth(ScreenWidth()*0.33)
laxiKey.t = laxiKey:Texture(0, 0, 0, 255)
laxiKey:SetLayer("HIGH")
laxiKey:EnableInput(true)
laxiKey.osc = "laxi"

------------------------------------------------------------ Event Handler -------------------------------------------------------

-- key touch event
function blackKeyTouchDown( self )
	self:SetHeight(ScreenHeight()*0.05)
	self:SetWidth(ScreenWidth()*0.3)
	SendOSCMessage(host,port,"/urMus/text", self.osc)
	DPrint("Sending: "..self.osc)
end

function blackKeyTouchUp( self )
	self:SetHeight(ScreenHeight()*0.06)
	self:SetWidth(ScreenWidth()*0.33)
end

doreKey:Handle("OnTouchDown", blackKeyTouchDown)
remiKey:Handle("OnTouchDown", blackKeyTouchDown)
fasoKey:Handle("OnTouchDown", blackKeyTouchDown)
solaKey:Handle("OnTouchDown", blackKeyTouchDown)
laxiKey:Handle("OnTouchDown", blackKeyTouchDown)

doreKey:Handle("OnEnter", blackKeyTouchDown)
remiKey:Handle("OnEnter", blackKeyTouchDown)
fasoKey:Handle("OnEnter", blackKeyTouchDown)
solaKey:Handle("OnEnter", blackKeyTouchDown)
laxiKey:Handle("OnEnter", blackKeyTouchDown)

doreKey:Handle("OnTouchUp", blackKeyTouchUp)
remiKey:Handle("OnTouchUp", blackKeyTouchUp)
fasoKey:Handle("OnTouchUp", blackKeyTouchUp)
solaKey:Handle("OnTouchUp", blackKeyTouchUp)
laxiKey:Handle("OnTouchUp", blackKeyTouchUp)

doreKey:Handle("OnLeave", blackKeyTouchUp)
remiKey:Handle("OnLeave", blackKeyTouchUp)
fasoKey:Handle("OnLeave", blackKeyTouchUp)
solaKey:Handle("OnLeave", blackKeyTouchUp)
laxiKey:Handle("OnLeave", blackKeyTouchUp)

function whiteKeyTouchDown( self )
	self.t:SetTexture(100, 100, 100, 255)
	SendOSCMessage(host,port,"/urMus/text", self.osc)
	DPrint("Sending: "..self.osc)
end

function whiteKeyTouchUp( self )
	self.t:SetTexture(255, 255, 255, 255)
end

doKey:Handle("OnTouchDown", whiteKeyTouchDown)
reKey:Handle("OnTouchDown", whiteKeyTouchDown)
miKey:Handle("OnTouchDown", whiteKeyTouchDown)
faKey:Handle("OnTouchDown", whiteKeyTouchDown)
soKey:Handle("OnTouchDown", whiteKeyTouchDown)
laKey:Handle("OnTouchDown", whiteKeyTouchDown)
xiKey:Handle("OnTouchDown", whiteKeyTouchDown)

doKey:Handle("OnEnter", whiteKeyTouchDown)
reKey:Handle("OnEnter", whiteKeyTouchDown)
miKey:Handle("OnEnter", whiteKeyTouchDown)
faKey:Handle("OnEnter", whiteKeyTouchDown)
soKey:Handle("OnEnter", whiteKeyTouchDown)
laKey:Handle("OnEnter", whiteKeyTouchDown)
xiKey:Handle("OnEnter", whiteKeyTouchDown)

doKey:Handle("OnTouchUp", whiteKeyTouchUp)
reKey:Handle("OnTouchUp", whiteKeyTouchUp)
miKey:Handle("OnTouchUp", whiteKeyTouchUp)
faKey:Handle("OnTouchUp", whiteKeyTouchUp)
soKey:Handle("OnTouchUp", whiteKeyTouchUp)
laKey:Handle("OnTouchUp", whiteKeyTouchUp)
xiKey:Handle("OnTouchUp", whiteKeyTouchUp)

doKey:Handle("OnLeave", whiteKeyTouchUp)
reKey:Handle("OnLeave", whiteKeyTouchUp)
miKey:Handle("OnLeave", whiteKeyTouchUp)
faKey:Handle("OnLeave", whiteKeyTouchUp)
soKey:Handle("OnLeave", whiteKeyTouchUp)
laKey:Handle("OnLeave", whiteKeyTouchUp)
xiKey:Handle("OnLeave", whiteKeyTouchUp)

-- Block on track event

function updateLowerBlock( self, x, y, dx, dy )
	--DPrint("x: "..(x + dx)..", y: "..(y+dy))
	lowerBlock:SetAnchor("BOTTOM", lowerTrack,"CENTER", 0, y+dy-ScreenHeight()*0.75/2)
	scaledLower = (y+dy)/(ScreenHeight()*0.75)*2 - 1
	DPrint("Lower Scale: "..scaledLower)
end

lowerTrack:Handle("OnMove", updateLowerBlock)

function updateupperRightBlock( self, x, y, dx, dy )
	--DPrint("x: "..(x + dx)..", y: "..(y+dy))
	upperRightBlock:SetAnchor("BOTTOM", upperTrack,"CENTER", 0, y+dy-ScreenHeight()*0.75/2)
	scaledHigher = (y+dy)/(ScreenHeight()*0.75)*2 - 1
	DPrint("Higher Scale: "..scaledHigher)
end

upperTrack:Handle("OnMove", updateupperRightBlock)
