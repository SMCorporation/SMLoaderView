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
    self.duration = 0.4;
    self.clockwise = YES;
    self.lineWidth = 5;
    self.tailLength = 0.9;
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
//    CGFloat delay = 0.5;
    CGFloat tailLength = MAX(MIN(1.0, self.tailLength), 0.1);
    CGFloat tailValue = (1.0 - tailLength);
    
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration  = (self.duration * tailValue) / 2;//+ self.duration * (1.0 - tailLength);
    drawAnimation.fromValue = @(0);
    drawAnimation.toValue   = @(1);
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    drawAnimation.removedOnCompletion = NO;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = self.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[drawAnimation];
    
    drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    drawAnimation.duration  = self.duration;
    drawAnimation.removedOnCompletion = NO;
    drawAnimation.fromValue = @(0);
    drawAnimation.toValue   = @(1);
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animationGroup.animations = [[animationGroup animations] arrayByAddingObject:drawAnimation];
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
