//
//  ViewController.m
//  Loader
//
//  Created by Max Kuznetsov on 18.01.17.
//  Copyright © 2017 Max Kuznetsov. All rights reserved.
//

#import "ViewController.h"
#import "SMLoaderView.h"

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SMLoaderView *loaderView = [[SMLoaderView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    loaderView.backgroundColor = [UIColor blueColor];
    loaderView.radiusOffset = 20;
    loaderView.lineWidth = 10;
    loaderView.tailLength = 0.9;
    loaderView.duration = 5;
//    loaderView.pauseDuration = 1;
    
    [self.view addSubview:loaderView];
    [loaderView startAnimating];
    
    return;
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    subview.backgroundColor = RGB(0, 147, 229); //[UIColor clearColor]; //[UIColor colorWithRed:0 green:147 / 255 blue:229 / 255 alpha:1];
    
    CAShapeLayer *loaderLayer = [CAShapeLayer layer];
    loaderLayer.frame = subview.bounds;
    loaderLayer.strokeColor = [UIColor whiteColor].CGColor;
    loaderLayer.strokeStart = 0;
    loaderLayer.strokeEnd = 1;
    loaderLayer.lineWidth = 5;
    loaderLayer.lineCap = kCALineCapRound;
    loaderLayer.fillColor = [UIColor clearColor].CGColor;
    
    CGFloat duration = 0.4;
    
    CGPoint center = CGPointMake(subview.frame.size.width / 2, subview.frame.size.height / 2);
    loaderLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle: -90 * M_PI / 180 endAngle: 270 * M_PI / 180 clockwise:YES].CGPath;
    
    [subview.layer addSublayer:loaderLayer];
    [self.view addSubview:subview];
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration  = duration + 0.3;
    drawAnimation.fromValue = [NSNumber numberWithFloat:0];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    drawAnimation.removedOnCompletion = NO;
//    drawAnimation.removedOnCompletion = NO;
//    drawAnimation.repeatCount = 3;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration + 0.5;
    animationGroup.removedOnCompletion = NO;
    animationGroup.repeatCount = INFINITY;
    
    animationGroup.animations = @[drawAnimation];
    
//    [loaderLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    drawAnimation.duration   = duration + 0.5;
    drawAnimation.removedOnCompletion = NO;
    drawAnimation.fromValue = [NSNumber numberWithFloat:0];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animationGroup.animations = [[animationGroup animations] arrayByAddingObject:drawAnimation];
    [loaderLayer addAnimation:animationGroup forKey:@"pulse"];
    
//    animationGroup = [CAAnimationGroup animation];
//    animationGroup.duration = 5;
//    animationGroup.repeatCount = INFINITY;
    
//    animationGroup.animations = @[drawAnimation];
//    [loaderLayer addAnimation:animationGroup forKey:@"drawCircleAnimation2"];
    
//    [loaderLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation2"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
