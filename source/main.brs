'********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub Main(args as Dynamic)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()
    m.global = screen.getGlobalNode()

    'sendEventToGoogleAnalytics("key", "event")
    m.global.AddField("GoogleAnalytics", "string", false)
    m.global.observeField("GoogleAnalytics",m.port)
    while(true)
        msg = wait(0, m.port)
	       msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roSGNodeEvent" then
            eventCategory = msg.GetData()
            sendEventToGoogleAnalytics(eventCategory)
        end if
    end while
end sub

sub GoogleAnalyticsTrigger(event)
    eventCategory = event.GetData()
    stop
    sendEventToGoogleAnalytics(eventCategory)
end sub

function sendEventToGoogleAnalytics(eventCategory as String, eventAction = "action" as String, eventLabel = "" as String , eventValue = "" as String)
    ' Initialize the Roku Analytics Component Library (RACL)
    m.global.addField("RSG_analytics", "node", false)
    m.global.RSG_analytics = CreateObject("roSGNode", "Roku_Analytics:AnalyticsNode")
    
    ' Initialize Google Analytics parameters
    m.global.RSG_analytics.init = {
        ga4: {
            api_secret: "kxydEJo-Qtesdg7cILggAQ",
            measurement_id: "G-0N84FWSYBT"
        }
    }
    
    ' Construct the event parameters
    eventParams = {
        GA4: {
            events: [
                {
                    name: eventCategory,
                    params: {
                        action: eventAction
                    }
                }
            ]
        }
    }
    
    ' Add optional event label if provided
    if eventLabel <> invalid then
        eventParams.GA4.events[0].params.label = eventLabel
    end if
    
    ' Add optional event value if provided
    if eventValue <> invalid then
        eventParams.GA4.events[0].params.value = eventValue
    end if
    
    ' Send the event to Google Analytics
    m.global.RSG_analytics.trackEvent = eventParams
end function