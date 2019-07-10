/**
 * Created by Leonid Bartenev
 */
({
    doLoadData: function (component, event, helper) {
        var callback = event.getParam('arguments').callback;
        $LH.executeAction(component, 'getAccount', {
            accountId: component.get('v.recordId')
        }, function (account) {
            callback(account);
        },function () {
            $A.get("e.force:closeQuickAction").fire();
        });
    }

})