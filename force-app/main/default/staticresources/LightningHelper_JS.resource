// Lightning Helper $LH - helper module -----------------------------------------------------------------------------
(function (w){
    var debugMode = false;

    var service = {

        executeAction: function(component, actionName, params, successCallback, errorCallback, finalCallback){
            service.logError(function () {
                var action = component.get('c.' + actionName);
                if(params) action.setParams(params);
                action.setCallback(service, function (response) {
                    try{
                        if (response.getState() === "SUCCESS") {
                            successCallback(response.getReturnValue());
                        } else {
                            if(errorCallback) errorCallback(response);
                            var errMessage = service.getErrorMessage(response);
                            if(debugMode) errMessage = 'Action: ' + actionName + ', Error: ' + errMessage;
                            throw new Error(errMessage);
                        }
                    }catch (e) {
                        console.error(e);
                        var message = e.message;
                        if(!debugMode) message = e.message.split('\n')[0];
                        service.showErrorToast('ERROR', message);
                        //throw e;
                    }finally {
                        if(finalCallback) finalCallback();
                    }
                });
                $A.enqueueAction(action);
            })
        },

        logError: function(loggedLogic){
            try{
                loggedLogic();
            }catch (e) {
                console.error(e);
                service.showErrorToast('Error', e.message);
            }
        },

        getFullPageName: function () {
            if(document.location.href.slice(-1) === '/') return '';
            var urlParts = document.location.href.split('/');
            if(urlParts.length > 0) return urlParts[urlParts.length - 1];
        },

        getUrlParameter: function (sParam) {
            var sPageURL = document.location.search.substring(1),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        },

        getPageName: function() {
            var fullPageName = service.getFullPageName();
            var nameParts = fullPageName.split('?');
            return nameParts[0];
        },

        navigateToPage: function(pageName){
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                url: '/' + pageName
            });
            console.log('Navigate to page: ' + pageName);
            urlEvent.fire();
        },

        navigateToHome: function(){
            service.navigateToPage('');
        },

        createRetString: function () {
            return encodeURIComponent(service.getFullPageName());
        },

        getRetPage: function (retString) {
            return decodeURIComponent(retString);
        },

        getErrorMessage: function(response) {
            var errorMsg = 'Unknown error';
            var errors = response.getError();
            if (errors && errors[0] && errors[0].message) errorMsg = errors[0].message;
            return errorMsg;
        },

        showToast: function (title, type, message, duration) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title: title,
                message: message,
                type: type,
                duration: duration ? duration : undefined,
                mode: duration ? 'dismissible' : 'sticky'
            });
            toastEvent.fire();
        },

        showErrorToast: function (title, errorMessage, duration) {
            service.showToast(title, "error", errorMessage, duration);
        },

        showSuccessToast: function(title, message, duration){
            service.showToast(title, 'success', message, duration);
        },

        showWarningToast: function(title, message, duration){
            service.showToast(title, 'warning', message, duration);
        },

        showInfoToast: function(title, message, duration){
            service.showToast(title, 'info', message, duration);
        },

        showErrorToastFromResponse: function (response) {
            service.showErrorToast('Error', service.getErrorMessage(response));
        }


    };
    w.$LH = service;

}(window));