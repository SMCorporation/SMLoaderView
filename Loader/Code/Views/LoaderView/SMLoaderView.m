//
//  SMLoaderView.m
//  Loader
//
//  Created by Max Kuznetsov on 06.02.17.
//  Copyright © 2017 Max Kuznetsov. All rights reserved.
//

#import "SMLoaderView.h"


@interface SMLoaderView ()

@property (nonatomic, strong) CAShapeLayer *loaderLayer;

@end

@implementation SMLoaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetups];
    }
    return self;
}


#pragma mark -
#pragma mark Getters & setters

- (void)setDuration:(CGFloat)duration
{
    _duration = duration;
}


#pragma mark -
#pragma mark Configurations

- (void)initialSetups
{
    self.duration = 1.1;
    self.clockwise = YES;
    self.lineWidth = 4;
    self.tailLength = 0.6;
    self.lineColor = [UIColor whiteColor];
}

- (void)setupLoaderLayer
{
    CAShapeLayer *loaderLayer = [CAShapeLayer layer];
    loaderLayer.frame = self.bounds;
    loaderLayer.strokeColor = self.lineColor.CGColor;
    loaderLayer.strokeStart = 0;
    loaderLayer.strokeEnd = 1;
    loaderLayer.lineWidth = self.lineWidth;
    loaderLayer.lineCap = kCALineCapRound;
    loaderLayer.fillColor = [UIColor clearColor].CGColor;
 
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat radius = (self.frame.size.width / 2 - self.lineWidth) - self.radiusOffset;
    radius = MAX(radius, 0);
    
    loaderLayer.path = [UIBezierPath bezierPathWithArcCenter:center
                                                      radius:radius
                                                  startAngle:-90 * M_PI / 180
                                                    endAngle:270 * M_PI / 180
                                                   clockwise:self.clockwise].CGPath;
    self.loaderLayer = loaderLayer;

    [self.layer addSublayer:loaderLayer];
    [self setupAnimations];
}

- (void)setupAnimations
{
    CGFloat tailLength = MAX(MIN(0.99, self.tailLength), 0.1);
    CGFloat durationDelta = (self.duration * tailLength);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration  = self.duration - (durationDelta * 0.7); //0.7
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue   = @(1);
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.duration  = self.duration - (durationDelta * 0.3); //0.9
    strokeStartAnimation.removedOnCompletion = NO;
    strokeStartAnimation.fromValue = @(0);
    strokeStartAnimation.toValue   = @(1);
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = strokeStartAnimation.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[strokeEndAnimation, strokeStartAnimation];
    
    [self.loaderLayer addAnimation:animationGroup forKey:@"loader"];
}


#pragma mark -
#pragma mark Public Methods

- (void)startAnimating
{
    if (self.loaderLayer) {
        [self.loaderLayer removeFromSuperlayer];
        self.loaderLayer = nil;
    }
    
    [self setupLoaderLayer];
}

@end
