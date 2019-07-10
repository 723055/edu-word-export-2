/**
 * Created by Leonid Bartenev
 */
({
    doInit: function (component, event, helper) {
       component.getConcreteComponent().loadData(function (data) {
           $LH.logError(function () {
               var templatePath = component.get('v.templatePath');
               var fileName = component.get('v.fileName') + '.docx';
               DocxExport.export(data, templatePath, fileName);
           });
           $A.get("e.force:closeQuickAction").fire();
       })
    }

})