//
//  LTInteractionTabBarController.m
//  InteractionTransitionTabBar
//
//  Created by 陈记权 on 12/1/15.
//  Copyright © 2015 陈记权. All rights reserved.
//

#import "LTInteractionTabBarController.h"
#import "LTScrollStyleAnimation.h"
#import "LTInteractionTransition.h"

@interface LTInteractionTabBarController ()
<
UIGestureRecognizerDelegate,
UITabBarControllerDelegate
>
{
    LTScrollStyleAnimation *m_scrollStyleAnimation;
    LTInteractionTransition *m_interationTransition;
}

@end

@implementation LTInteractionTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _defaultInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _defaultInit];
    }
    return self;
}

- (void)_defaultInit
{
    self.delegate = self;
    m_interationTransition = [[LTInteractionTransition alloc]init];
    m_scrollStyleAnimation = [[LTScrollStyleAnimation alloc]init];
    [self _addObserverForSelectedViewController];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
    
    for (UIViewController *viewController in viewControllers) {
        [m_interationTransition prepareGestureInView:viewController.view];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)_addObserverForSelectedViewController
{
    [self addObserver:self
           forKeyPath:@"selectedIndex"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController
{
    return m_interationTransition.interactionInProgress ? m_interationTransition : nil;
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    NSUInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    m_scrollStyleAnimation.reverse = fromIndex < toIndex;
    
    return m_scrollStyleAnimation;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedViewController"] || [keyPath isEqualToString:@"selectedIndex"]){
        
        NSObject *obj = [change objectForKey:@"new"];
        NSLog(@"changed to %@", obj);
        [m_interationTransition wireToViewController:self.selectedViewController];
    }
}

@end
