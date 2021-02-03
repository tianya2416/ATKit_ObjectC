//
//  ViewController.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/17.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "ViewController.h"
#import "ATKit.h"
#import "BaseNavigationController.h"
#import <UserNotifications/UserNotifications.h>
#import "ATGridViewController.h"

@interface ViewController ()
@property (nonatomic) NSMutableArray *listData;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self showNavTitle:@"首页" backItem:false];
    self.listData = @[].mutableCopy;
    [self.listData addSafeObject:@"push"];
    [self.listData addSafeObject:@"present"];
    [self.listData addSafeObject:@"本地推送测试"];
    [self.listData addSafeObject:@"定时器"];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [UITableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.textLabel.text = self.listData[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.listData[indexPath.row];
    if ([title isEqualToString:@"push"]) {

        BaseViewController *vc = [[BaseViewController alloc] init];
        vc.hidesBottomBarWhenPushed = true;
        [[UIViewController rootTopPresentedController].navigationController pushViewController:vc animated:YES];
        [vc showNavTitle:title backItem:YES];
        vc.view.backgroundColor = [UIColor whiteColor];
    }else if([title isEqualToString:@"present"]){
        ATGridViewController *vc = [[ATGridViewController alloc] init];
        BaseNavigationController *nvc = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [[UIViewController rootTopPresentedController] presentViewController:nvc animated:YES completion:nil];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vc showNavTitle:title backItem:YES];
    }else if([title isEqualToString:@"本地推送测试"]){
        [self addLocalNotice];
    }else{
        __block int time = 100;
        [self.timer invalidate];
        self.timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            time = time - 1;
             
            NSLog(@"=============%@",@(time));
            if (time <= 0) {
                [timer invalidate];
                NSLog(@"=============%@==========",@(time));
            }
        }];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
- (void)addLocalNotice {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"标题";
        content.subtitle = @"副标题";
        content.body = @"具体内容";
        // 默认声音
        content.sound = [UNNotificationSound defaultSound];
        //当前时间多少秒后发送,可以将固定的日期转化为时间
        NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:10] timeIntervalSinceNow];
        // repeats，是否重复，如果重复的话时间必须大于60s，要不会报错
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];

        // 添加通知的标识符，可以用于移除，更新等操作
        NSString *identifier = @"noticeId";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
    }else {
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        // 发出推送的日期
        notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        // 推送的内容
        notif.alertBody = @"你已经10秒没出现了";
        // 可以添加特定信息
        notif.userInfo = @{@"noticeId":@"00001"};
        // 角标
        notif.applicationIconBadgeNumber = 1;
        // 提示音
        notif.soundName = UILocalNotificationDefaultSoundName;
        // 每周循环提醒
        notif.repeatInterval = NSCalendarUnitWeekOfYear;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

- (void)removeLocalNotice:(NSString *)noticeId {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            for (UNNotificationRequest *req in requests){
                NSLog(@"存在的ID:%@\n",req.identifier);
            }
            NSLog(@"移除currentID:%@",noticeId);
        }];
        [center removePendingNotificationRequestsWithIdentifiers:@[noticeId]];
    }else {
        NSArray *array=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (UILocalNotification *localNotification in array){
            NSDictionary *userInfo = localNotification.userInfo;
            NSString *obj = [userInfo objectForKey:@"noticeId"];
            if ([obj isEqualToString:noticeId]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            }
        }
    }
}
- (void)removeAllLocalNotice {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
    }else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)localNoticeEnable {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                NSLog(@"打开了推送");
            }else {
                NSLog(@"关闭了推送");
            }
        }];
    }else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone){
            NSLog(@"关闭了推送");
        }else {
            NSLog(@"打开了推送");
        }
    }
}
@end
