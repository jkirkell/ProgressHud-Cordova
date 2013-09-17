//
//  ProgressHud.m
//
// Created by Jeff Kirkell on 09/17/2013.
// 
//
// Copyright 2013 Jeff Kirkell. All rights reserved.
// MIT Licensed

#import "ProgressHud.h"


@implementation ProgressHud

@synthesize progressHUD, callbackID;

-(void) show:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
	self.progressHUD = nil;
	self.progressHUD = [MBProgressHUD showHUDAddedTo:self.webView.superview animated:YES];
	self.progressHUD.mode = MBProgressHUDModeIndeterminate;

    [self.progressHUD show:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) set:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
	//NSLog(@"set:%@\n withDict:%@", arguments, options);

	// The first argument in the arguments parameter is the callbackID.
	// We use this to send data back to the successCallback or failureCallback
	// through PluginResult.
	self.callbackID = [command.arguments objectAtIndex:0];
    NSLog([command.arguments objectAtIndex:0]);

	// Build returned result
	NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

	//self.progressHUD = [MBProgressHUD HUDForView:self.webView.superview];
	if(!self.progressHUD) {
		//NSLog(@"hide:!self.progressHUD");
		// Create Plugin Result
		CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_INVALID_ACTION messageAsDictionary:result];
		//Call  the Success Javascript function
		[self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
		return;
	}

	// Compiling options with defaults
	NSString *mode = [command.arguments objectForKey:@"mode"] ?: nil;
	NSString *labelText = [command.arguments objectForKey:@"labelText"] ?: nil;
	NSString *detailsLabelText = [command.arguments objectForKey:@"detailsLabelText"] ?: nil;
	float progress = [[command.arguments objectForKey:@"progress"] floatValue] ?: 0;
   
	if([mode isEqualToString:@"indeterminate"]) self.progressHUD.mode = MBProgressHUDModeIndeterminate;
	else if([mode isEqualToString:@"determinate"]) self.progressHUD.mode = MBProgressHUDModeDeterminate;
	else if([mode isEqualToString:@"annular-determinate"]) self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;

	if(labelText) self.progressHUD.labelText = labelText;
	if(detailsLabelText) self.progressHUD.detailsLabelText= detailsLabelText;
	if(progress) self.progressHUD.progress = progress;

	// Create Plugin Result
	//CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
	//Call  the Success Javascript function
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) hide:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    
    [self.progressHUD hide:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

@end