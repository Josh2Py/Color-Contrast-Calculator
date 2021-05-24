#Noenv

;Window Controls
Gui, ColorContrast:New
Gui, Add, Text, ,Foreground RGB Colors Values
Gui, Add, Text, ,Red
Gui, Add, Slider, x+m vFredSlider Range0-255 gSliderRel AltSubmit, 0
Gui, Add, Edit, x+m w50 vFredText gEdit
Gui, Add, UpDown, x+m w50 Range0-255 gEdit, 
Gui, Add, Text, x5,Green
Gui, Add, Slider, x+m vFgreenSlider Range0-255 gSliderRel AltSubmit,0
Gui, Add, Edit, x+m w50 vFgreenText gEdit, 0 
Gui, Add, UpDown, x+m w50 Range0-255 gEdit, 
Gui, Add, Text, x10 ,Blue
Gui, Add, Slider, x+m vFblueSlider Range0-255 gSliderRel AltSubmit, 0
Gui, Add, Edit, x+m w50 vFblueText gEdit, 0
Gui, Add, UpDown, x+m w50 Range0-255 gEdit, 


Gui, Add, Text, ym, Background RGB Colors Values
Gui, Add, Text, ,Red
Gui, Add, Slider, x+m vBredSlider Range0-255 gSliderRel AltSubmit, 0
Gui, Add, Edit, x+m w50 vBredText gEdit, 0
Gui, Add, UpDown, x+m w50 Range0-255 gEdit, 255
Gui, Add, Text, xp-165 yp+40,Green
Gui, Add, Slider, x+m vBgreenSlider Range0-255 gSliderRel AltSubmit, 0
Gui, Add, Edit, x+m w40 vBgreenText gEdit, 0
Gui, Add, UpDown, x+m w50 Range0-255 gEdit, 255
Gui, Add, Text, xp-165 yp+40,Blue
Gui, Add, Slider, x+m vBblueSlider Range0-255 gSliderRel AltSubmit, 0
Gui, Add, Edit, x+m w50 vBblueText gEdit, 0
Gui, Add, UpDown, x+m w50 Range0-255 gEdit, 255
Gui, Add, Text, ,Select the Color Contrast Ratio
Gui, Add, DropDownList, vCCRatio, 4.6 | 3.2
Gui, Add, Button, gsubmit, Submit
Gui, show, 
return 

;Update Slider on Text Edit
SliderRel: 
Gui, Submit, NoHide 
GuiControl,, BredText, %BredSlider% 
GuiControl,, BgreenText, %BgreenSlider% 
GuiControl,, BblueText, %BblueSlider% 
GuiControl,, FredText, %FredSlider% 
GuiControl,, FgreenText, %FgreenSlider% 
GuiControl,, FblueText, %FblueSlider% 
return 

;Update Text Box with Values
Edit: 
Gui, Submit, Nohide 
GuiControl,, BredSlider, %BredText%
GuiControl,, BgreenSlider, %BgreenText%
GuiControl,, BblueSlider, %BblueText%
GuiControl,, FredSlider, %FredText%
GuiControl,, FgreenSlider, %FgreenText%
GuiControl,, FblueSlider, %FblueText%
return

submit:
gui,submit
;Calculate  Srgb
RGBOCT = 255

BRsrgb = % BredText/RGBOCT 
BGsrgb = % BgreenText/RGBOCT
BBsrgb = % BblueText/RGBOCT

BRSRGB = %BRsrgb%
BGSRGB = %BGsrgb%
BBSRGB = %BBsrgb%

BR += ((BRSRGB + 0.055)/1.055)**2.4
BG += ((BGSRGB + 0.055)/1.055)**2.4
BB += ((BBSRGB + 0.055)/1.055)**2.4

L1 += (BR*0.2126) + (0.7152*BG) + (0.0722*BB)

FRsrgb = % FredText/RGBOCT 
FGsrgb = % FgreenText/RGBOCT
FBsrgb = % FblueText/RGBOCT

FRSRGB = %FRsrgb%
FGSRGB = %FGsrgb%
FBSRGB = %FBsrgb%

FR += ((FRSRGB + 0.055)/1.055)**2.4
FG += ((FGSRGB + 0.055)/1.055)**2.4
FB += ((FBSRGB + 0.055)/1.055)**2.4

L2 += (FR*0.2126) + (0.7152*FG) + (0.0722*FB)

CCL1 += L1 + 0.05
CCL2 += L2 + 0.05

L2T += (( CCL1 / CCRatio ) - 0.05)
GainL2 = % global L2
Gain += (L2T/GainL2)

FRT += Gain*FR
FGT += Gain*FG
FBT += Gain*FB      

FRsT += Abs(Round(((FRT**(1/2.4))*1.055-0.055)*255))
FGsT += Abs(Round(((FGT**(1/2.4))*1.055-0.055)*255))
FBsT += Abs(Round(((FBT**(1/2.4))*1.055-0.055)*255))

pFRsT += (FRsT/255)*100
pFGsT += (FGsT/255)*100
pFBsT += (FBsT/255)*100

percFRsT = % Round(pFRsT, 2)
percFGsT = % Round(pFGsT, 2)
percFBsT = % Round(pFBsT, 2)

MsgBox, R = %FRsT% or %percFRsT%`%`nG = %FGsT% or %percFGsT%`%`nB = %FBsT% or %percFBsT%`%
    
    
    



ExitApp
return






