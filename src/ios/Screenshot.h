//
//  Screenshot.h
//
//  Created by Simon Madine on 29/04/2010.
//  Copyright 2010 The Angry Robot Zombie Factory.
//   - Converted to Cordova 1.6.1 by Josemando Sobral.
//  MIT licensed
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Cordova/CDVPlugin.h>

@protocol ScreenshotPluginDelegate <NSObject>
- (UIImage *)postProcessScreenShot:(UIImage *)screenshot;
@end

@interface Screenshot : CDVPlugin {
}

//- (void)saveScreenshot:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)saveScreenshot:(CDVInvokedUrlCommand*)command;

@property (nonatomic, weak) id<ScreenshotPluginDelegate> screenshotDelegate;

@end
