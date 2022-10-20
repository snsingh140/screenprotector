#import <Cordova/CDV.h>

@interface SecureScreen : CDVPlugin

- (void)enable:(CDVInvokedUrlCommand*)command;
- (void)disable:(CDVInvokedUrlCommand*)command;
-(void)listen:(CDVInvokedUrlCommand*)command;

@end