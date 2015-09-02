//
// Screenshot.h
//
// Created by Simon Madine on 29/04/2010.
// Copyright 2010 The Angry Robot Zombie Factory.
// - Converted to Cordova 1.6.1 by Josemando Sobral.
// MIT licensed
//
// Modifications to support orientation change by @ffd8
//

#import <Cordova/CDV.h>
#import "Screenshot.h"

@implementation Screenshot

@synthesize webView;

//- (void)saveScreenshot:(NSArray*)arguments withDict:(NSDictionary*)options

 - (void)saveScreenshot:(CDVInvokedUrlCommand*)command
{
	NSString *filename = [command.arguments objectAtIndex:2];
	NSNumber *quality = [command.arguments objectAtIndex:1];
	NSString *path = [NSString stringWithFormat:@"%@.jpg",filename];

	NSString *jpgPath = [NSTemporaryDirectory() stringByAppendingPathComponent:path ];

	CGRect imageRect;
	CGRect screenRect = [[UIScreen mainScreen] bounds];

	imageRect = CGRectMake(0, 0, CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));

	// Adds support for Retina Display. Code reverts back to original if iOs 4 not detected.
	if (NULL != UIGraphicsBeginImageContextWithOptions)
		UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0);
	else
		UIGraphicsBeginImageContext(imageRect.size);

	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[[UIColor blackColor] set];
	CGContextFillRect(ctx, imageRect);
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
  [window.layer renderInContext:ctx];

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	NSData *imageData = UIImageJPEGRepresentation(image,[quality floatValue]);
	[imageData writeToFile:jpgPath atomically:NO];

	UIGraphicsEndImageContext();

	CDVPluginResult* pluginResult = nil;
	NSDictionary *jsonObj = [ [NSDictionary alloc]
		initWithObjectsAndKeys :
		jpgPath, @"filePath",
		@"true", @"success",
		nil
		];

	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
	[self writeJavascript:[pluginResult toSuccessCallbackString:command.callbackId]];
}

@end
