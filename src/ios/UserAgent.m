#import "UserAgent.h"
#import "AppDelegate.h"
#import <Cordova/CDVPluginResult.h>
#import <Cordova/CDVViewController.h>
#import <Cordova/CDVUserAgentUtil.h>

@implementation UserAgent

- (void)get: (CDVInvokedUrlCommand*)command
{
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError* error) {
        NSString* userAgent = result;
        NSString* callbackId = command.callbackId;
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:userAgent];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    }];
}

- (void)set: (CDVInvokedUrlCommand*)command
{
    [CDVUserAgentUtil acquireLock:^(NSInteger lockToken) {
        NSString* newUserAgent = [command argumentAtIndex:0];
        self.webView.customUserAgent = newUserAgent;
        [CDVUserAgentUtil setUserAgent:newUserAgent lockToken:lockToken];
        [CDVUserAgentUtil releaseLock:&lockToken];
        
        // NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:newUserAgent, @"Cordova-User-Agent", nil];
        // [[NSUserDefaults standardUserDefaults] registerDefaults:dict];        
        
        NSString* callbackId = command.callbackId;
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:newUserAgent];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    }];
}

- (void)reset: (CDVInvokedUrlCommand*)command
{
    self.webView.customUserAgent = nil;
    [self get:command];
}

@end
