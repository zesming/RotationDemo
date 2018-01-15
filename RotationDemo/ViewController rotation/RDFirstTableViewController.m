//
//  RDFirstTableViewController.m
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/8.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import "RDFirstTableViewController.h"
#import "RDFirstRotableViewController.h"
#import "RDImageTableViewCell.h"

@interface RDFirstTableViewController ()

@end

@implementation RDFirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RDImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RDFirstTableViewCell" forIndexPath:indexPath];
    
    __weak typeof(RDImageTableViewCell) *weakCell = cell;
    cell.buttonAction = ^(CGRect buttonFrame) {
        __strong typeof(RDImageTableViewCell) *cell = weakCell;
        RDFirstRotableViewController *viewController = [[RDFirstRotableViewController alloc] initWithImage:cell.currentButtonImage frame:buttonFrame];
        
        [self rd_presentViewController:viewController];
//        [self rd_pushViewController:viewController];
    };
    
    return cell;
}

- (void)rd_presentViewController:(UIViewController *)viewController {
    self.definesPresentationContext = YES;
    viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:NO completion:nil];
    //        [self presentViewController:viewController animated:NO completion:nil];
}

- (void)rd_pushViewController:(UIViewController *)viewController {
    [self.navigationController pushViewController:viewController animated:NO];
}

@end
