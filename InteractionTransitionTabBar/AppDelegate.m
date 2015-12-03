//
//  AppDelegate.m
//  InteractionTransitionTabBar
//
//  Created by 陈记权 on 12/1/15.
//  Copyright © 2015 陈记权. All rights reserved.
//

#import "AppDelegate.h"
#import "LTViewController.h"
#import "LTInteractionTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    LTInteractionTabBarController *tabController = [[LTInteractionTabBarController alloc]init];
    _window.rootViewController = tabController;
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < 5; i ++) {
        LTViewController *viewController = [[LTViewController alloc]init];
        viewController.title = [NSString stringWithFormat:@"VC[%@]", @(i)];
        viewController.view.backgroundColor = [self randomColor];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        [array addObject:nav];
    }
    [tabController setViewControllers:array];
    
    [_window makeKeyAndVisible];
    return YES;
}

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = (arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0 ) + 0.5;

    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
