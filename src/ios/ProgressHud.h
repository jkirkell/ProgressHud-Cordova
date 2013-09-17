//
//  ProgressHud.h
//
// Created by Jeff Kirkell on 09/17/2013.
// 
//
// Copyright 2013 Jeff Kirkell. All rights reserved.
// MIT Licensed

#import <Cordova/CDVPlugin.h>
#import "MBProgressHUD.h"

@interface ProgressHud : CDVPlugin {

	NSString* callbackID;
	MBProgressHUD* progressHUD;

}

@property (nonatomic, copy) NSString* callbackID;
@property (nonatomic, assign) MBProgressHUD* progressHUD;

//Instance Method
- (void) show:(CDVInvokedUrlCommand*)command;
- (void) set:(CDVInvokedUrlCommand*)command;
- (void) hide:(CDVInvokedUrlCommand*)command;

@end