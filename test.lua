FreeAllFlowboxes()
FreeAllRegions()

dac= FBDac
sinosc = FlowBox(FBSinOsc)
freqPush = FlowBox(FBPush)
ampPush = FlowBox(FBPush)

freqPush.Out:SetPush(sinosc.Freq)
ampPush.Out:SetPush(sinosc.Amp)

freqPush:Push(.3)
ampPush:Push(.5)


dac.In:SetPull(sinosc.Out)