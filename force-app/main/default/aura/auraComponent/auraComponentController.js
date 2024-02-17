({
    myAction : function(component, event, helper) {
    //component.find('childLWC').callMe();
    },
    handleAccountSelect: function(component,event,helper) {
        console.log('####Id in Aura:'+event.getParam('accountId'));
        console.log('####Name in Aura:'+event.getParam('accountName'));
    }
})
