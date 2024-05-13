'********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub Main(args as Dynamic)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()
    m.global = screen.getGlobalNode()
    scene.signalBeacon("AppLaunchComplete")
    while(true)
        msg = wait(0, m.port)
	       msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roSGNodeEvent" then
            eventCategory = msg.GetData()
        else if msgType = "roInputEvent" 'RBMN-15294: inner deeplinking (in the app);
            deeplinkParams = msg.getInfo()
            parseDeeplinkingParams(deeplinkParams)
        end if
    end while
end sub
sub parseDeeplinkingParams(args as Object)
end sub
