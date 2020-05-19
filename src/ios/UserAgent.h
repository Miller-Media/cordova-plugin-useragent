#import <Cordova/CDVPlugin.h>
#import <WebKit/WebKit.h>

@interface UserAgent : CDVPlugin

@property (nonatomic, strong) IBOutlet WKWebView* webView;
// @property (nonatomic, strong) WKWebView* dummyWebView;

- (void)get:(CDVInvokedUrlCommand*)command;

- (void)set:(CDVInvokedUrlCommand*)command;

- (void)reset:(CDVInvokedUrlCommand*)command;

@end
