/**
 * Created by user on 5/16/2019.
 */
({
    doLoadData: function(component, event, helper){
        var callback = event.getParam('arguments').callback;
        $LH.executeAction(component, 'getOpportunity', {
            opportId: component.get('v.recordId')
        }, function(opportunity){
            callback(opportunity);
        });
    }
})