function StoreManager() as Object
    ?"StoreManager"
    if m.__StoreManager = Invalid
        m.__StoreManager = {
            GetCatalog  : Billing_GetCatalog
            GetPurchases: Billing_GetPurchases
        }
        m.__StoreManager.store = Store_GetChannelStoreInstance()
    end if
    return m.__StoreManager
end function

function Store_GetChannelStoreInstance() as Object
    ?"Store_GetChannelStoreInstance"
    scene = GetGlobalAA().global.GetScene()
    channelStore = scene.FindNode("store")
    if channelStore = Invalid
        channelStore = scene.CreateChild("ChannelStore")
        channelStore.fakeServer = true
        channelStore.id = "store"
    end if
    return channelStore
end function

sub Billing_GetCatalog()
    m.store.ObserveField("catalog", "onGetCatalog")
    m.store.command = "getCatalog"
end sub

sub Billing_GetPurchases()
    m.store.ObserveField("purchases", "onGetPurchases")
    m.store.command = "GetPurchases"
end sub

sub onGetCatalog()
    m.__storemanager.store.unobserveField("catalog")
    data = CreateObject("roSGNode", "ContentNode")
    if (m.__storemanager.store.catalog <> invalid)
        count = m.__storemanager.store.catalog.GetChildCount()
        CheckProductData(count)
        for i = 0 to count - 1
            productData = data.CreateChild("StoreProductData")
            item = m.__storemanager.store.catalog.getChild(i)
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

sub onGetPurchases()
    m.__storemanager.store.unobserveField("purchases")
end sub

sub CheckProductData(count)
    if count = invalid or count = 0 then HandleError()
end sub