var screenshot = {
    enable: function (successCallback, errorCallback) {
      cordova.exec(successCallback, errorCallback, 'secureScreen', 'enable', []);
    },
    disable: function (successCallback, errorCallback) {
      cordova.exec(successCallback, errorCallback, 'secureScreen', 'disable', []);
    },
    registerListener : function(callback) {
      cordova.exec(callback, callback, 'secureScreen', 'listen', []);
  
    }
  }
  cordova.addConstructor(function () {
    if (!window.plugins) {window.plugins = {};}
  
    window.plugins.securescreen = screenshot;
 
    return window.plugins.securescreen;
  });