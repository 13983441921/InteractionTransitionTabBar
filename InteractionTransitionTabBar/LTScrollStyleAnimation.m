//
//  LTScrollStyleAnimation.m
//  InteractionTransitionTabBar
//
//  Created by 陈记权 on 12/1/15.
//  Copyright © 2015 陈记权. All rights reserved.
//

#import "LTScrollStyleAnimation.h"

@interface LTScrollStyleAnimation ()

@end

@implementation LTScrollStyleAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultInit];
    }
    return self;
}

- (void)defaultInit
{
    self.duration = 1.0f;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return _duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    
    CGRect toViewFinalFrame = containerView.bounds;
    CGRect toViewInitialFrame = CGRectOffset(toViewFinalFrame, ( _reverse ?  1 : -1 ) * CGRectGetWidth(toViewFinalFrame), 0);
    toViewController.view.frame = toViewInitialFrame;
    
    CGRect fromViewInitialFrame = containerView.bounds;
    CGRect fromViewFinalFrame = CGRectOffset(fromViewInitialFrame, ( _reverse ?  -1 : 1 ) * CGRectGetWidth(fromViewInitialFrame), 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        fromViewController.view.frame = fromViewFinalFrame;
        toViewController.view.frame = toViewFinalFrame;
    } completion:^(BOOL finished) {
        BOOL cancelled = [transitionContext transitionWasCancelled];
        if (cancelled || !finished) {
            [toViewController.view removeFromSuperview];
        } else {
            [fromViewController.view removeFromSuperview];
        }
        NSLog(@"index:%@", @(fromViewController.tabBarController.selectedIndex));
        [transitionContext completeTransition:!cancelled];
    }];
}

@end
