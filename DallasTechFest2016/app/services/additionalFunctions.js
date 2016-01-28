'use strict';

app.factory('additionalFunctions', [function () {
    var generateGUID = function () {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    };

    var addAlert = function (message, messageType) {
        var id = generateGUID();
        var JQueryId = "#" + id;
        var alertType = '';
        
        switch (messageType) {
            case 'error':
                alertType = 'alert-danger';
                break;
            case 'warning':
                alertType = 'alert-warning';
                break;
            case 'info':
                alertType = 'alert-info';
                break;
            case 'success':
                alertType = 'alert-success';
                break;
            default:
                alertType = 'alert-primary';
        };

        $('#alerts').append('<div style="display:none;" class="alert ' + alertType + '" id="' + id + '">' +
            '<button type="button" class="close" data-dismiss="alert">' +
            'x</button>' + message + '</div>');

        $(JQueryId).fadeIn(3000);
        window.setTimeout(function () {
            // closing the popup
            $(JQueryId).fadeTo(300, 0.5).slideUp(2000, function() {
                $(JQueryId).alert('close');
            });
        }, 5000);
    };

    return {
        addAlert: addAlert
    };
}])