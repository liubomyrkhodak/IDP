sub Init()
    m.landingButtonGroup = m.top.findNode("landingButtonGroup")

    Buttons = ["Continue to Products"]
    m.landingButtonGroup.buttons = Buttons
    m.landingButtonGroup.observeField("buttonSelected","onLandingButtonSelected")
    m.top.ObserveField("focusedChild", "OnFocusChange")
end sub

sub OnFocusChange()
    if m.top.HasFocus() then m.landingButtonGroup.SetFocus(true)
end sub

sub onLandingButtonSelected()   
    m.top.buttonSelected = true
end sub
