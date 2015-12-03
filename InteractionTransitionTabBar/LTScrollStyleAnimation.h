//
//  LTScrollStyleAnimation.h
//  InteractionTransitionTabBar
//
//  Created by 陈记权 on 12/1/15.
//  Copyright © 2015 陈记权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTScrollStyleAnimation : NSObject
<
UIViewControllerAnimatedTransitioning
>


@property (nonatomic, assign) BOOL reverse;
@property (nonatomic, assign) NSTimeInterval duration;

@end
