//
//  PopoverTransition.h
//  AssistiveTouchSample
//
//  Created by Andrew Murdoch on 1/17/15.
//  Copyright (c) 2015 Andrew Murdoch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverTransition : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) BOOL appearing;

@end
