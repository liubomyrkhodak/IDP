sub Init()
    m.top.ObserveField("focusedChild", "OnFocusChange")
    m.productGrid = m.top.findNode("productGrid")
    StoreManager().GetCatalog()
    StoreManager().GetPurchases()
end sub

sub OnFocusChange()
    if m.top.HasFocus() then m.productGrid.SetFocus(true)
end sub

sub HandleError()
    m.top.Getscene().callFunc("HandleError")
end sub