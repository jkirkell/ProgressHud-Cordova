//
//  ProgressHud.js
//
// Created by Olivier Louvignes on 04/25/2012.
//
// Copyright 2011 Olivier Louvignes. All rights reserved.
// MIT Licensed

var exec = function (methodName, options, success, error) {
    cordova.exec(success, error, "ProgressHud", methodName, options);
};

var log = function (msg) {
    console.log("ProgressHud[js]: " + msg);
};

var ProgressHud = function () {
    this.options = {};
};

ProgressHud.prototype.show = function (options, callback) {
	if(!options) options = {};
	var scope = options.scope || null;
	delete options.scope;

	var service = 'ProgressHud',
		action = 'show',
		callbackId = service + (cordova.callbackId + 1);

	var config = {
		mode: options.mode || 'indeterminate',
		labelText: options.labelText || 'Loading...',
		detailsLabelText: options.detailsLabelText || '',
		progress: options.progress || 0
	};

	var _callback = function(result) {
		if(typeof callback == 'function') callback.apply(scope, arguments);
	};
	
	return exec('show', options, callback, callback);
};

ProgressHud.prototype.set = function (options, callback) {
	if(!options) options = {};
	var scope = options.scope || null;
	delete options.scope;

	var service = 'ProgressHud',
		action = 'set',
		callbackId = service + (cordova.callbackId + 1);

	var _callback = function(result) {
		if(typeof callback == 'function') callback.apply(scope, arguments);
	};
	
	return exec('set', options, callback, callback);
};

ProgressHud.prototype.hide = function (options, callback) {
	if(!options) options = {};
	var scope = options.scope || null;
	delete options.scope;

	var service = 'ProgressHud',
		action = 'hide',
		callbackId = service + (cordova.callbackId + 1);

	var config = {};

	var _callback = function(result) {
		if(typeof callback == 'function') callback.apply(scope, arguments);
	};
	
	return exec('hide', options, callback, callback);
};

module.exports = new ProgressHud();