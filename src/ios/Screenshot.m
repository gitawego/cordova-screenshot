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

CGFloat statusBarHeight()
{
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

- (UIImage *)getScreenshot
{
	UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
	CGRect rect = [keyWindow bounds];
	UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
	[keyWindow drawViewHierarchyInRect:keyWindow.bounds afterScreenUpdates:NO];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	// cut the status bar from the screenshot
	CGRect smallRect = CGRectMake (0,statusBarHeight()*img.scale,rect.size.width*img.scale,rect.size.height*img.scale);
 
	CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, smallRect);
	CGRect smallBounds = CGRectMake(0,0,CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));

	UIGraphicsBeginImageContext(smallBounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextDrawImage(context,smallBounds,subImageRef);
	UIImage* cropped = [UIImage imageWithCGImage:subImageRef];
	UIGraphicsEndImageContext();  

	CGImageRelease(subImageRef);

	return cropped;
}

- (void)saveScreenshot:(CDVInvokedUrlCommand*)command
{
	NSString *filename = [command.arguments objectAtIndex:2];
	NSNumber *quality = [command.arguments objectAtIndex:1];

	NSString *path = [NSString stringWithFormat:@"%@.jpg",filename];
	NSString *jpgPath = [NSTemporaryDirectory() stringByAppendingPathComponent:path];

	UIImage *image = [self getScreenshot];
	NSData *imageData = UIImageJPEGRepresentation(image,[quality floatValue]);
	[imageData writeToFile:jpgPath atomically:NO];

	CDVPluginResult* pluginResult = nil;
	NSDictionary *jsonObj = [ [NSDictionary alloc]
		initWithObjectsAndKeys :
		jpgPath, @"filePath",
		@"true", @"success",
		nil
	];

	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
	NSString* callbackId = command.callbackId;
	[self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void) getScreenshotAsURI:(CDVInvokedUrlCommand*)command
{
	NSNumber *quality = command.arguments[0];
	UIImage *image = [self getScreenshot];
	NSData *imageData = UIImageJPEGRepresentation(image,[quality floatValue]);
	NSString *base64Encoded = [imageData base64EncodedStringWithOptions:0];
	NSDictionary *jsonObj = @{
	    @"URI" : [NSString stringWithFormat:@"data:image/jpeg;base64,%@", base64Encoded]
	};
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:[command callbackId]];
}
@end
