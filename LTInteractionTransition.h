//
//  LTInteractionTransition.h
//  InteractionTransitionTabBar
//
//  Created by 陈记权 on 12/1/15.
//  Copyright © 2015 陈记权. All rights reserved.
//

#import <UIKit/UIKit.h>
//UIPageViewControllerTransitionStyleScroll
@interface LTInteractionTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interactionInProgress;

- (void)prepareGestureInView:(UIView *)view;
- (void)wireToViewController:(UIViewController *)viewController;

@end
