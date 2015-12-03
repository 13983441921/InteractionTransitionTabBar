//
//  LTInteractionTransition.m
//  InteractionTransitionTabBar
//
//  Created by 陈记权 on 12/1/15.
//  Copyright © 2015 陈记权. All rights reserved.
//

#import "LTInteractionTransition.h"

@interface LTInteractionTransition ()
<
UIGestureRecognizerDelegate
>
{
    UIViewController *m_viewController;
    UIPanGestureRecognizer *m_panGesture;
    BOOL m_shouldCompleteTransition;
}

@end

@implementation LTInteractionTransition

- (void)wireToViewController:(UIViewController *)viewController
{
    NSParameterAssert(viewController);
    
    m_viewController = viewController;
}

- (void)prepareGestureInView:(UIView *)view
{
    UIPanGestureRecognizer *panGes = [UIPanGestureRecognizer new];
    [panGes addTarget:self action:@selector(_panGestureRecognizerAction:)];
    panGes.delegate = self;
    [view addGestureRecognizer:panGes];
}

- (void)_panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:recognizer.view.superview];
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            if (velocity.x < 0) {
                if (m_viewController.tabBarController.selectedIndex < m_viewController.tabBarController.viewControllers.count - 1) {
                    self.interactionInProgress = YES;
                    m_viewController.tabBarController.selectedIndex ++;
                }
            } else {
                if (m_viewController.tabBarController.selectedIndex > 0) {
                    self.interactionInProgress = YES;
                    m_viewController.tabBarController.selectedIndex --;
                }
            }
            break;
            
        case UIGestureRecognizerStateChanged:
            if (_interactionInProgress) {
                CGFloat percent = fmin(fmax(fabs(translation.x / 200), 0.0), 1.0f) ;
                m_shouldCompleteTransition = percent > 0.5;
                
                if (percent >= 1.0f) {
                    percent = 0.99f;
                }
                [self updateInteractiveTransition:percent];
            }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (_interactionInProgress) {
                self.interactionInProgress = NO;
                if (!m_shouldCompleteTransition || recognizer.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                } else {
                    [self finishInteractiveTransition];
                }
            }
            break;
            
        default:
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", sel_getName(_cmd));
    CGPoint startPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
    if ((startPoint.x > 0 && startPoint.x < 60) ||
        ((startPoint.x > CGRectGetWidth(gestureRecognizer.view.bounds) - 60) &&
         (startPoint.x < CGRectGetWidth(gestureRecognizer.view.bounds)))) {
        return YES;
    }
    return NO;
}

- (void)dealloc
{
    
}

@end
