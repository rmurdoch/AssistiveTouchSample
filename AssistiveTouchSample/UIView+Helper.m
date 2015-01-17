//
//  UIView+Helper.m
//  AssistiveTouchSample
//
//  Created by Andrew Murdoch on 1/17/15.
//  Copyright (c) 2015 Andrew Murdoch. All rights reserved.
//

#import "UIView+Helper.h"

typedef NS_ENUM(NSInteger, SnapView)
{
    SnapViewTop,
    SnapViewBottom,
    SnapViewHMiddle,
    SnapViewVMiddle,
    SnapViewLeft,
    SnapViewRight
};

@implementation UIView (Helper)

- (void)snapViewToEdge:(void (^)())completion
{
    [UIView animateWithDuration:0.15 animations:^
     {
         self.frame = [self snapView:self.frame inSuperview:self.superview.frame];
     }completion:^(BOOL done)
     {
         if (completion)
             completion();
     }];
}

- (CGRect)snapView:(CGRect)view inSuperview:(CGRect)superview
{
    CGRect frame = view;
    CGRect sFrame = superview;
    
    SnapView snapViewV;
    
    CGFloat quarterV = (CGRectGetMidY(sFrame) / 2) / 2;
    
    if (frame.origin.y <= quarterV * 2)
    {
        snapViewV = SnapViewTop;
        
        frame.origin.y = 17;
    }
    else if (frame.origin.y > quarterV * 2 && frame.origin.y < quarterV * 5)
    {
        snapViewV = SnapViewVMiddle;
        
        frame.origin.y = CGRectGetMidY(sFrame) - frame.size.height / 2;
    }
    else
    {
        snapViewV = SnapViewBottom;
        
        frame.origin.y = CGRectGetMaxY(sFrame) - frame.size.height - 10;
    }
    
    CGFloat quarterH = (CGRectGetMidX(sFrame) / 2) / 2;
    
    if (frame.origin.x <= quarterH * 2)
    {
        frame.origin.x = 10;
    }
    else if (frame.origin.x > quarterH * 2 && frame.origin.x < quarterH * 5 && snapViewV != SnapViewVMiddle)
    {
        frame.origin.x = CGRectGetMidX(sFrame) - frame.size.width / 2;
    }
    else
    {
        frame.origin.x = CGRectGetMaxX(sFrame) - frame.size.width - 10;
    }
    
    return frame;
}


@end
