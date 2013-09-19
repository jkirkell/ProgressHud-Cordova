//
//  ProgressHud.m
//
// Originally created by Olivier Louvignes on 04/25/2012.
// Updated by Jeff Kirkell on 09/16/2013
//
// Copyright 2013 Jeff Kirkell. All rights reserved.
// MIT Licensed

#import "ProgressHud.h"

// Help create NSNull objects for nil items (since neither NSArray nor NSDictionary can store nil values).
#define NILABLE(obj) ((obj) != nil ? (NSObject *)(obj) : (NSObject *)[NSNull null])

@implementation ProgressHud

@synthesize callbackID = _callbackID;
@synthesize progressHUD = _progressHUD;

-(void)show:(CDVInvokedUrlCommand*)command {
    self.progressHUD = nil;
	self.progressHUD = [MBProgressHUD showHUDAddedTo:self.webView.superview animated:YES];
	self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    
	[self set:command];
}

-(void)set:(CDVInvokedUrlCommand*)command {
    // We use this to send data back to the successCallback or failureCallback
	// through PluginResult.
    NSString* callbackId = command.callbackId;
    
    //Retrieve the optional arguments and apply to the ProgressHud.
    NSMutableDictionary *result = [command.arguments objectAtIndex:0];
    NSString *mode = [result objectForKey:@"mode"] ?: nil;
    NSString *labelText = [result objectForKey:@"labelText"] ?: nil;
    NSString *detailsLabelText = [result objectForKey:@"detailsLabelText"] ?: nil;
    float progress = [[result objectForKey:@"progress"] floatValue] ?: 0;
    
    //set the ProgressHud's spinner based on the mode passed.
    if([mode isEqualToString:@"indeterminate"]) self.progressHUD.mode = MBProgressHUDModeIndeterminate;
	else if([mode isEqualToString:@"determinate"]) self.progressHUD.mode = MBProgressHUDModeDeterminate;
	else if([mode isEqualToString:@"annular-determinate"]) self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    //set the ProgressHud's text and progress is using the "determinate" or "annular-determinate" mode.
	if(labelText) self.progressHUD.labelText = labelText;
    //only set this if something was passed.
	if(detailsLabelText.length > 0) self.progressHUD.detailsLabelText = detailsLabelText;
	if(progress) self.progressHUD.progress = progress;

	// Create Plugin Result
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
	//Call  the Success Javascript function
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

-(void)hide:(CDVInvokedUrlCommand*)command {
    // We use this to send data back to the successCallback or failureCallback
	// through PluginResult.
    NSString* callbackId = command.callbackId;
    
    //hide ProgressHud
    [self.progressHUD hide:true];
    	self.progressHUD = nil;
    
	// Create Plugin Result
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
	//Call  the Success Javascript function
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

@end