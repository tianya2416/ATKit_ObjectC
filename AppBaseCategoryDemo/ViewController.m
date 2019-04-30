//
//  ViewController.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/17.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "ViewController.h"
#import "CategoryKit.h"
#import "BaseNavigationController.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *listData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showNavTitle:@"首页" backItem:YES];
    self.listData = @[].mutableCopy;
    [self.listData addSafeObject:@"push"];
    [self.listData addSafeObject:@"present"];
    [self.tableView reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALEW(60);
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
        UIViewController *vc = [[UIViewController alloc] init];
        [[UIViewController rootTopPresentedController].navigationController pushViewController:vc animated:YES];
        [vc showNavTitle:title backItem:YES];
        vc.view.backgroundColor = [UIColor whiteColor];
    }else{
        UIViewController *vc = [[UIViewController alloc] init];
        BaseNavigationController *nvc = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [[UIViewController rootTopPresentedController] presentViewController:nvc animated:YES completion:nil];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vc showNavTitle:title backItem:YES];
    }
}
@end
