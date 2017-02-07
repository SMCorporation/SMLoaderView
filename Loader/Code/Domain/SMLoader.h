//
//  SMLoader.h
//  Loader
//
//  Created by Max Kuznetsov on 06.02.17.
//  Copyright © 2017 Max Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMLoader : NSObject

+ (instancetype)sharedLoader;

- (void)showLoader;
- (void)hideLoader;

@end
