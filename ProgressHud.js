cordova.define("com.phonegap.plugins.progresshud.ProgressHud", function(require, exports, module) {//
//  ProgressHud.js
//
// Originally created by Olivier Louvignes on 04/25/2012.
// Updated by Jeff Kirkell on 09/16/2013
//
// Copyright 2013 Jeff Kirkell. All rights reserved.
// MIT Licensed

var exec = function (methodName, serviceName, options, success, error) {
    cordova.exec(success, error, serviceName, methodName, options);
};

var log = function (msg) {
    console.log("ProgressHud[js]: " + msg);
};

var ProgressHud = function () {
    this.serviceName = "ProgressHud"
};

ProgressHud.prototype.show = function (options, callback) {
    var methodName = 'show';

    if(!options) options = {};
	var scope = options.scope || null;
	delete options.scope;

	var config = {
		mode: options.mode || 'intermediate',
		labelText: options.labelText || 'Loading...',
		detailsLabelText: options.detailsLabelText || '',
		progress: options.progress || 0
	};

    var callbackId = this.serviceName + (cordova.callbackId + 1);

	var _callback = function(result) {
		if(typeof callback == 'function') callback.apply(scope, arguments);
	};
	
	return exec(methodName, this.serviceName, [config], callback, callback);
};

ProgressHud.prototype.set = function (options, callback) {
	var methodName = 'set';
	
	if(!options) options = [];
	var scope = options.scope || null;
	delete options.scope;

	var callbackId = this.service + (cordova.callbackId + 1);
               
	var _callback = function(result) {
		if(typeof callback == 'function') callback.apply(scope, arguments);
	};
	
	return exec(methodName, this.serviceName, [options], callback, callback);
};

ProgressHud.prototype.hide = function (options, callback) {
	var methodName = 'hide';

	if(!options) options = {};
	var scope = options.scope || null;
	delete options.scope;

	var callbackId = this.serviceName + (cordova.callbackId + 1);

	var _callback = function(result) {
		if(typeof callback == 'function') callback.apply(scope, arguments);
	};
	
	return exec(methodName, this.serviceName, options, callback, callback);
};

module.exports = new ProgressHud();
});
