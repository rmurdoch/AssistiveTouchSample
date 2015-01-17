//
//  PopoverTransition.m
//  AssistiveTouchSample
//
//  Created by Andrew Murdoch on 1/17/15.
//  Copyright (c) 2015 Andrew Murdoch. All rights reserved.
//

#import "PopoverTransition.h"

@implementation PopoverTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (_appearing)
    {
        fromView.userInteractionEnabled = NO;
        
        toView.layer.cornerRadius = 5;
        toView.layer.masksToBounds = YES;
        
        toView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:duration animations:^{
            
            toView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            fromView.alpha = 0.5;
        } completion:^(BOOL completed){
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else
    {
        [UIView animateWithDuration:duration animations:^{
            
            fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            toView.alpha = 1.0;
        } completion:^(BOOL completed){
            
            [fromView removeFromSuperview];
            toView.userInteractionEnabled = YES;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.appearing = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.appearing = NO;
    return self;
}

@end
