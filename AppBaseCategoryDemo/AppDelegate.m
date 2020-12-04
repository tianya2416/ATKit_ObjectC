//
//  AppDelegate.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/17.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import <UserNotifications/UserNotifications.h>
#import "ATMacro.h"
#import "UIViewController+ATKit.h"
#import "BaseTableViewController.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

//pod repo push CodingSpec AppBaseCategory.podspec --allow-warnings
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [BaseTabBarController new];
    [self.window makeKeyAndVisible];
    [self registerLocationPush];
    return YES;
}

- (void)registerLocationPush {
    if (@available(iOS 10.0, *)) { // iOS10 以上
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error.description);
            }
        }];
        center.delegate = self;
    } else {// iOS8.0 以上
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}
//app没有被杀死下调用 ： 常见主要有用户切后台
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"notification.userInfo = %@",notification.userInfo);
    NSLog(@"%@",@([UIApplication sharedApplication].applicationState));
    UIViewController *root = [UIViewController rootTopPresentedController];
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"程序没被杀死的情况下" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BaseTableViewController *vc = [[BaseTableViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vc showNavTitle:@"程序没被杀死的情况下"];
        [[UIViewController rootTopPresentedController].navigationController pushViewController:vc animated:YES];
    }];
    [vc addAction:ac];
    [root.navigationController presentViewController:vc animated:YES completion:nil];
}
//app被杀死下调用 ： 1、主要有用户切后台，内存不足被系统杀死 2、用户直接杀死程序
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSLog(@"%@",response);
    NSLog(@"%@",@([UIApplication sharedApplication].applicationState));
    UIViewController *root = [UIViewController rootTopPresentedController];
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"程序被杀死的情况下" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BaseTableViewController *vc = [[BaseTableViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vc showNavTitle:[NSString stringWithFormat:@"%lf",[ATMacro at_statusBar]]];
        [[UIViewController rootTopPresentedController].navigationController pushViewController:vc animated:YES];
    }];
    [vc addAction:ac];
    [root.navigationController presentViewController:vc animated:YES completion:nil];

    completionHandler();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%lf",[ATMacro at_statusBar]);
     
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
