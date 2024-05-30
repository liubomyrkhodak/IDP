sub ShowWelcomeScreen()
    m.WelcomeScreen = CreateObject("roSGNode", "WelcomeScreen")
    m.WelcomeScreen.ObserveField("buttonSelected","OnButtonSelected")
    m.top.ComponentController.CallFunc("show", {
        view: m.WelcomeScreen
    })
end sub

sub OnButtonSelected()
    ShowStoreScreen()
end sub