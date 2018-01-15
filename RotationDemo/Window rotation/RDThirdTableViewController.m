//
//  RDThirdTableViewController.m
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/8.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import "RDThirdTableViewController.h"
#import "RDThirdRotableViewController.h"
#import "RDImageTableViewCell.h"

@interface RDThirdTableViewController ()

@end

@implementation RDThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RDImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RDThirdTableViewCell" forIndexPath:indexPath];
    
    __weak typeof(RDImageTableViewCell) *weakCell = cell;
    cell.buttonAction = ^(CGRect buttonFrame) {
        __strong typeof(RDImageTableViewCell) *cell = weakCell;
        RDThirdRotableViewController *viewController = [[RDThirdRotableViewController alloc] initWithImage:cell.currentButtonImage frame:buttonFrame];
        
        UIWindow *albumWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        albumWindow.backgroundColor = [UIColor clearColor];
        albumWindow.windowLevel = UIWindowLevelNormal;
        albumWindow.rootViewController = viewController;
        albumWindow.frame = [UIApplication sharedApplication].keyWindow.frame;
        [albumWindow makeKeyAndVisible];
        [viewController showWithAnimationUntilDismiss:^{
            [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
            albumWindow.hidden = YES;
            albumWindow.rootViewController = nil;
        }];
    };
    
    return cell;
}

@end
