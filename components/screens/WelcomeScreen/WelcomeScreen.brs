sub Init()
    m.landingButtonGroup = m.top.findNode("landingButtonGroup")
    m.landingButtonGroup.SetFocus(true)

    Buttons = ["Continue to Products"]
    m.landingButtonGroup.buttons = Buttons
    m.landingButtonGroup.observeField("buttonSelected","onLandingButtonSelected")
end sub

sub onLandingButtonSelected()   
    m.top.buttonSelected = true
end sub
