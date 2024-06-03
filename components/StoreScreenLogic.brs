sub ShowStoreScreen()
    m.StoreScreen = CreateObject("roSGNode", "StoreScreen")
    m.top.ComponentController.CallFunc("show", {
        view: m.StoreScreen
    })
end sub

sub HandleError()
    dialog = CreateObject("roSGNode", "Dialog")
    dialog.title = "Error"
    dialog.message = "No Products"
    m.top.dialog = dialog
end sub