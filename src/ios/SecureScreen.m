/********* SecureScreen.m Cordova Plugin Implementation *******/

#import "SecureScreen.h"

@interface SecureScreen() {
   CDVInvokedUrlCommand * _eventCommand;
}

@end

@implementation SecureScreen

UIImageView* cover;
UITextField* txtField;
- (void)pluginInitialize {
    NSLog(@"Starting ScreenshotBlocker plugin");

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(appDidBecomeActive)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(applicationWillResignActive)
                                                name:UIApplicationWillResignActiveNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tookScreeshot)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(goingBackground)
                                                name:UIApplicationWillResignActiveNotification
                                              object:nil];


    /*
     userDidTakeScreenshotNotification
     */

}

- (void)enable:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSLog(@"Abilita observers");
    
    txtField.secureTextEntry = false;
    
  


}
- (void)disable:(CDVInvokedUrlCommand *)command
{
    //CDVPluginResult* pluginResult = nil;
    NSLog(@"Disable observers");
   CGRect someRect = [self.webView frame];
    
    txtField = [[UITextField alloc] initWithFrame:someRect];
    txtField.secureTextEntry = true;
    [self.webView addSubview:txtField];
    //txtField.backgroundColor = [UIColor redColor];
    //[[txtField.centerYAnchor constraintEqualToAnchor:self.webView.centerYAnchor] isActive] = true;
    [[txtField.centerYAnchor constraintEqualToAnchor:self.webView.centerYAnchor] setActive:NO];
    [[txtField.centerXAnchor constraintEqualToAnchor:self.webView.centerXAnchor] setActive:NO];
    [self.webView.layer.superlayer addSublayer:txtField.layer];
    [txtField.layer.sublayers.firstObject addSublayer:self.webView.layer];
    txtField.userInteractionEnabled = NO;


}
-(void)listen:(CDVInvokedUrlCommand*)command {
    _eventCommand = command;
}


-(void) goingBackground {
    NSLog(@"Background Observer");
    if(_eventCommand!=nil) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"background"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:_eventCommand.callbackId];
    }
}
-(void)tookScreeshot {
    NSLog(@"Took Screenshot?");
    if(_eventCommand!=nil) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"tookScreenshot"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:_eventCommand.callbackId];
    }

}

-(void)setupView {
    BOOL isCaptured = [[UIScreen mainScreen] isCaptured];
    NSLog(@"Is screen captured? %@", (isCaptured?@"SI":@"NO"));

//    if ([[ScreenRecordingDetector sharedInstance] isRecording]) {
//        [self webView].alpha = 0.f;
//        NSLog(@"Registro o prendo screenshots");
//    } else {
        [self webView].alpha = 1.f;
        NSLog(@"Non registro");

    //}
}

-(void)appDidBecomeActive {
//    [ScreenRecordingDetector triggerDetectorTimer];
    if(cover!=nil) {
        [cover removeFromSuperview];
        cover = nil;
    }
}
-(void)applicationWillResignActive {
//    [ScreenRecordingDetector stopDetectorTimer];
    if(cover == nil) {
        cover = [[UIImageView alloc] initWithFrame:[self.webView frame]];
        cover.backgroundColor = [UIColor blackColor];
        [self.webView addSubview:cover];
    }
}
-(void)screenCaptureStatusChanged {
    [self setupView];
}


@end
