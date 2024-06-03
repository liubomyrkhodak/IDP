sub Init()
    m.store = m.top.findNode("store")
    m.store.ObserveField("catalog", "onGetCatalog")
    m.productGrid = m.top.findNode("productGrid")
    m.store.command = "GetCatalog"
    m.top.ObserveField("focusedChild", "OnFocusChange")
end sub

sub OnFocusChange()
    if m.top.HasFocus() then m.productGrid.SetFocus(true)
end sub

sub onGetCatalog()
    data = CreateObject("roSGNode", "ContentNode")
    if (m.store.catalog <> invalid)
        count = m.store.catalog.GetChildCount()
        CheckProductData(count)
        for i = 0 to count - 1
            productData = data.CreateChild("StoreProductData")
            item = m.store.catalog.getChild(i)
            productData.productName = item.name
            productData.productPrice = item.cost
            productData.freeTrialType = item.freeTrialType
            productData.productType = item.productType
        end for
        m.productGrid.content = data
    else 
        HandleError()
    end if
end sub

sub CheckProductData(count)
    if count = invalid or count = 0 then HandleError()
end sub

sub HandleError()
    m.top.Getscene().callFunc("HandleError")
end sub