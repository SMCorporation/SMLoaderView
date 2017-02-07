//
//  SMLoaderView.h
//  Loader
//
//  Created by Max Kuznetsov on 06.02.17.
//  Copyright © 2017 Max Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMLoaderView : UIView

@property (nonatomic, assign) CGFloat duration;      // 0.4   - by default
@property (nonatomic, assign) BOOL clockwise;        // YES   - by default
@property (nonatomic, assign) CGFloat lineWidth;     // 5     - by default
@property (nonatomic, strong) UIColor *lineColor;    // white - by default
@property (nonatomic, assign) CGFloat radiusOffset;  // 0 - by default
//@property (nonatomic, assign) CGFloat pauseDuration; // 0.3 - by default
@property (nonatomic, assign) CGFloat tailLength; //from 0.1 to 1.0, 0.9 - by default

- (void)startAnimating;

@end
