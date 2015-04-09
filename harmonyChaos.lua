--basic structure declares two pages with different color backgrounds.

FreeAllRegions()
FreeAllFlowboxes()
DPrint("")

r = nil
local currentpage = 0
lastTime = Time()
--page 1 is harmony, page 2 is chaos
function SwitchPage(self,xSpeed)
    if Time() > (lastTime + 1) then
        --DPrint(xSpeed)
        if math.abs(xSpeed) > 6 then
            if currentpage == 2 then
                if xSpeed > 0 then
                    currentpage = 1
                    SetPage(currentpage)
                end
            else
                if xSpeed < 0 then
                    currentpage = 2
                    SetPage(currentpage)
                end
            end
            lastTime = Time()
        end
    end
end

SetPage(1)
currentpage = 1

--harmony
r1 = Region()
r1.t = r1:Texture(32,32,32,255)
r1:EnableHorizontalScroll(true)
r1:Handle("OnHorizontalScroll", SwitchPage)
r1:Show()
r1:EnableInput(true)
r1:SetWidth(ScreenWidth())
r1:SetHeight(ScreenHeight())
r1:SetAnchor("BOTTOMLEFT",0,0)
r1:SetLayer("BACKGROUND")

halfWidth = ScreenWidth() / 2
halfHeight = ScreenHeight() / 2

smallHeight = ScreenHeight()/3 - 8
if smallHeight > ScreenWidth()/2 then
    smallHeight = ScreenWidth()/2
end

bigHeight = ScreenHeight()/2 - 6
if bigHeight > ScreenWidth()/2 then
    bigHeight = ScreenWidth()/2
end
bigRadius = bigHeight/2
smRad = smallHeight/2

dot1 = Region()
dot1.t = dot1:Texture(DocumentPath("Dot.png"))
dot1:Show() 
dot1.id = 1
dot1.t:SetBlendMode("ALPHAKEY")
dot1:SetHeight(smallHeight)
dot1:SetWidth(dot1:Height())
dot1:SetAnchor("CENTER", smRad, halfHeight - smallHeight - 12)

time1 = Region()
time1.t = time1:Texture(DocumentPath("darkdot.png"))
time1:Show()
time1.t:SetBlendMode("ALPHAKEY")
time1:SetHeight(0)
time1:SetWidth(0)
time1:SetAnchor("CENTER",dot1,"CENTER")
time1:SetParent(dot1)

dot2 = Region()
dot2.t = dot2:Texture(DocumentPath("Dot.png"))
dot2:Show() 
dot2.id = 2
dot2.t:SetBlendMode("ALPHAKEY")
dot2:SetHeight(smallHeight)
dot2:SetWidth(dot2:Height())
dot2:SetAnchor("CENTER", smRad, halfHeight)

time2 = Region()
time2.t = time2:Texture(DocumentPath("darkdot.png"))
time2:Show()
time2.t:SetBlendMode("ALPHAKEY")
time2:SetHeight(0)
time2:SetWidth(0)
time2:SetAnchor("CENTER",dot2,"CENTER")
time2:SetParent(dot2)

dot3 = Region()
dot3.t = dot3:Texture(DocumentPath("Dot.png"))
dot3:Show() 
dot3.id = 3
dot3.t:SetBlendMode("ALPHAKEY")
dot3:SetHeight(smallHeight)
dot3:SetWidth(dot3:Height())
dot3:SetAnchor("CENTER", smRad, halfHeight + smallHeight + 12)

time3 = Region()
time3.t = time3:Texture(DocumentPath("darkdot.png"))
time3:Show()
time3.t:SetBlendMode("ALPHAKEY")
time3:SetHeight(0)
time3:SetWidth(0)
time3:SetAnchor("CENTER",dot3,"CENTER")
time3:SetParent(dot3)

dot5 = Region()
dot5.t = dot5:Texture(DocumentPath("Dot.png"))
dot5:Show() 
dot5.id = 4
dot5.t:SetBlendMode("ALPHAKEY")
dot5:SetHeight(bigHeight)
dot5:SetWidth(dot5:Height())
dot5:SetAnchor("CENTER", ScreenWidth() - bigRadius, ScreenHeight()/2 - bigRadius - 6)

time5 = Region()
time5.t = time5:Texture(DocumentPath("darkdot.png"))
time5:Show()
time5.t:SetBlendMode("ALPHAKEY")
time5:SetHeight(0)
time5:SetWidth(0)
time5:SetAnchor("CENTER",dot5,"CENTER")
time5:SetParent(dot5)

dot6 = Region()
dot6.t = dot6:Texture(DocumentPath("Dot.png"))
dot6:Show() 
dot6.id = 5
dot6.t:SetBlendMode("ALPHAKEY")
dot6:SetHeight(bigHeight)
dot6:SetWidth(dot6:Height())
dot6:SetAnchor("CENTER", ScreenWidth() - bigRadius, ScreenHeight()/2 + bigRadius + 6)

time6 = Region()
time6.t = time6:Texture(DocumentPath("darkdot.png"))
time6:Show()
time6.t:SetBlendMode("ALPHAKEY")
time6:SetHeight(0)
time6:SetWidth(0)
time6:SetAnchor("CENTER",dot6,"CENTER")
time6:SetParent(dot6)

function shrinkme(self, elapsed)
    local width = self:Width()
    local height = self:Height()
    width = width - elapsed * self.shrinkspeed
    height = height - elapsed *self.shrinkspeed
    if width <= 0 or height <= 0 then
        self:SetWidth(0)
        self:SetHeight(0)
        self:Handle("OnUpdate", nil)
        dad = self:Parent()
        dad:EnableInput(true)
        dad:Handle("OnTouchDown",timerShrink)
    else
        self:SetWidth(width)
        self:SetHeight(height)
    end
end

function timerShrink(this)
    
    pushStarts[this.id]:Push(-1)
    kid = this:Children()
    kid:SetHeight(this:Height())
    kid:SetWidth(this:Width())
    kid.shrinkspeed = 17
    this:EnableInput(false)
    kid:Handle("OnUpdate",shrinkme)
end


    pushStarts = {}
    samplers = {}
    pushLoop = {}
    pushAmp = {}
    pushSample = {}
    dac = FBDac

    for j = 1,5 do
        samplers[j] = FlowBox(FBSample)
    end

    samplers[1]:AddFile(DocumentPath("AbMono.wav")) 
    samplers[2]:AddFile(DocumentPath("BbMono.wav")) 
    samplers[3]:AddFile(DocumentPath("CMono.wav")) 
    samplers[4]:AddFile(DocumentPath("Ab10Mono.wav")) 
    samplers[5]:AddFile(DocumentPath("G10Mono.wav")) 

    for i = 1,5 do
        pushStarts[i] = FlowBox(FBPush)
        pushLoop[i] = FlowBox(FBPush)
        pushSample[i] = FlowBox(FBPush)
        pushAmp[i] = FlowBox(FBPush)

        pushStarts[i].Out:SetPush(samplers[i].Pos)
        pushLoop[i].Out:SetPush(samplers[i].Loop)
        pushSample[i].Out:SetPush(samplers[i].Sample)
        pushAmp[i].Out:SetPush(samplers[i].Amp)

        pushLoop[i]:Push(0)
        pushStarts[i]:Push(1)
        pushAmp[i]:Push(.5)

        dac.In:SetPull(samplers[i].Out)
    end

    

   



dot1:EnableInput(true)
dot2:EnableInput(true)
dot3:EnableInput(true)
dot5:EnableInput(true)
dot6:EnableInput(true)

dot1:Handle("OnTouchDown", timerShrink)
dot2:Handle("OnTouchDown", timerShrink)
dot3:Handle("OnTouchDown", timerShrink)
dot5:Handle("OnTouchDown", timerShrink)
dot6:Handle("OnTouchDown", timerShrink)



--**modification starts here
barwidth = 300
currwidth = 0
globalChangeVar = 0

function increaseBar(region, x, y, z)
    if globalChangeVar <= 0.0009 and currwidth > 0 then
        currwidth = currwidth - 10
    end
    if currwidth < 300 then
        currwidth = currwidth + globalChangeVar
    end
    region:SetWidth(currwidth)
end
--ends here
function accelStrength( x,y,z )
    return (math.abs(x) + math.abs(y) + math.abs(z)) / 3
end

function randomWithStrength(widthOrHeight, strength)
    return widthOrHeight + math.random(-widthOrHeight, widthOrHeight) * (strength / MAXSTRENGTHPOSSIBLE)
end

debouncer = 0
initialStrength = 0
maxStrength = 0
MAXSTRENGTHPOSSIBLE = 0.75
function chaosMovement(region, x, y, z)
    if debouncer == 0 then
        initialStrength = accelStrength(x,y,z)
    end
    debouncer = debouncer + 1
    if debouncer ~= 2 then
        return
    end
    debouncer = 0

    local changeInStrength = math.abs(accelStrength(x,y,z) - initialStrength)

    if changeInStrength > maxStrength then
        maxStrength = changeInStrength
        --DPrint("Max strength: " .. tostring(maxStrength))
    end

    if changeInStrength > MAXSTRENGTHPOSSIBLE then
        changeInStrength = MAXSTRENGTHPOSSIBLE
    end
    --**needed a global strength variable
    globalChangeVar = changeInStrength*10

    middleCircle:SetAnchor("TOP", randomWithStrength(halfWidth, changeInStrength), randomWithStrength(halfHeight, changeInStrength) + 50)
end

SetPage(2)
currentpage = 2
--chaos
r2 = Region()
r2.t = r2:Texture(0,0,0,255) --dark gray **(changed to black because the png file looks weird if it isn't)
r2:EnableHorizontalScroll(true)
r2:Handle("OnHorizontalScroll", SwitchPage)
r2:Show()
r2:EnableInput(true)
r2:SetWidth(ScreenWidth())
r2:SetHeight(ScreenHeight())
r2:SetAnchor("BOTTOMLEFT",0,0)
r2:SetLayer("BACKGROUND")
r2:Handle("OnAccelerate", chaosMovement)

--**My modification starts here
bar = Region()
bar.t = bar:Texture(60,45,70,255)
bar:SetAnchor("TOPLEFT", 10, 40)
bar:SetHeight(20)
bar:SetWidth(barwidth)
--bar:SetLayer("BACKGROUND")
bar:Show()

progress = Region()
progress.t = progress:Texture(150,0,150,255)
progress:SetAnchor("TOPLEFT", 10, 40)
progress:SetHeight(20)
progress:SetWidth(currwidth)
progress:Handle("OnAccelerate", increaseBar)
progress:Show()

--ends here

middleCircle = Region()
middleCircle.t = middleCircle:Texture("2000px-Disc_Plain_red.svg.png") --**changed to a png file
--middleCircle.t = middleCircle:Texture(32,32,32,255)
middleCircle:Show()
middleCircle:EnableInput(true)
middleCircle:SetWidth(50)
middleCircle:SetHeight(50)
middleCircle:SetAnchor("TOP", halfWidth, halfHeight)

SetPage(1)
