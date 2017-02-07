//
//  SMLoader.m
//  Loader
//
//  Created by Max Kuznetsov on 06.02.17.
//  Copyright © 2017 Max Kuznetsov. All rights reserved.
//

#import "SMLoader.h"
@import UIKit;


CGFloat UIInterfaceOrientationAngleOfOrientation(UIInterfaceOrientation orientation)
{
    CGFloat angle;
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    return angle;
}


@interface SMLoader ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation SMLoader

+ (instancetype)sharedLoader
{
    static SMLoader *loader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [SMLoader new];
    });
    
    return loader;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialSetups];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(statusBarFrameOrOrientationChanged:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)statusBarFrameOrOrientationChanged:(NSNotification *)notification
{
    
}


#pragma mark -
#pragma mark Configurations

- (void)initialSetups
{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.window.windowLevel = UIWindowLevelStatusBar + 1;
}


#pragma mark -
#pragma mark Public Methods

- (void)showLoader
{
    
}

- (void)hideLoader
{
    
}


#pragma mark -
#pragma mark Help Methods

- (void)rotateAccordingToStatusBarOrientation
{
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGFloat angle = UIInterfaceOrientationAngleOfOrientation(statusBarOrientation);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    self.window.transform = transform;
    
    UIWindow *rootWindow = [[[UIApplication sharedApplication] delegate] window];
    CGRect frame = self.window.frame;
    frame.size.width = frame.size.height = statusBarHeight;
    
    switch (statusBarOrientation) {
        case UIInterfaceOrientationLandscapeRight:
            frame.origin.x = rootWindow.frame.size.height - statusBarHeight;
            frame.origin.y = 0;
            frame.size.height = rootWindow.frame.size.width;
            break;
            
        case UIInterfaceOrientationPortrait:
            frame.origin.x = frame.origin.y = 0;
            frame.size.width = rootWindow.frame.size.width;
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            frame.origin.x = frame.origin.y = 0;
            frame.size.height = rootWindow.frame.size.width;
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            frame.origin.x = 0;
            frame.origin.y = rootWindow.frame.size.height - statusBarHeight;
            frame.size.width = rootWindow.frame.size.width;
            break;
            
        default:
            break;
    }
    
    self.window.frame = frame;
}


@end
