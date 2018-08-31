//
//  CCRootViewController.m
//  Contacts
//
//  Created by Kris Liu on 2018/8/28.
//  Copyright © 2018 Kris Liu. All rights reserved.
//

#import "CCRootViewController.h"
@import Navigator;

@interface CCRootViewController () <DataProtocol>

@property (nonatomic, copy) NSString *letterString;

@end

@implementation CCRootViewController

- (instancetype)init {
    if (self = [super init]) {
        self.letterString = @"ABCDEFHIJKLMNOPQRSTUVWXYZ";
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
    }
    return self;
}

- (void)onDataReceiveBeforeShow:(DataDictionary *)data fromViewController:(UIViewController *)fromViewController {
    NSLog(@"Receive data from %@ before show: %@", NSStringFromClass(fromViewController.class), data);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Contacts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.letterString.length;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"name"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"name"];
    }
    NSString *str = @(10000000000 + random() % 9999999999).stringValue;
    cell.textLabel.text = [self.letterString substringWithRange:NSMakeRange(indexPath.row, 1)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@-%@", [str substringToIndex:3], [str substringWithRange:NSMakeRange(3, 4)], [str substringFromIndex:7]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *message = [NSString stringWithFormat:@"Phone number is %@", cell.detailTextLabel.text];
    DataDictionary *data = [[DataDictionary alloc] init:@{
                                                          NavigatorParametersKey.viewControllerName : @"MORootViewController",
                                                          NavigatorParametersKey.navigationCtrlName : NSStringFromClass(UINavigationController.class),
                                                          NavigatorParametersKey.transitionName : NSStringFromClass(CircleTransition.self),
                                                          NavigatorParametersKey.mode : @(NavigatorModePresent),
                                                          @"message" : message,
                                                          }];
    [self.navigator show:data animated:YES completion:nil];
}

@end
