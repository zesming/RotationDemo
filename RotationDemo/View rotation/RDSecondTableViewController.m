//
//  RDSecondTableViewController.m
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/8.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import "RDSecondTableViewController.h"
#import "RDImageTableViewCell.h"
#import "RDRotableView.h"

@interface RDSecondTableViewController ()

@property (nonatomic, assign) BOOL statusBarHidden;

@end

@implementation RDSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
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
    RDImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RDSecondTableViewCell" forIndexPath:indexPath];
    
    __weak typeof(RDImageTableViewCell) *weakCell = cell;
    cell.buttonAction = ^(CGRect buttonFrame) {
        __strong typeof(RDImageTableViewCell) *cell = weakCell;
        RDRotableView *imageDetailView = [[RDRotableView alloc] initWithFrame:self.view.window.frame image:cell.currentButtonImage imageFrame:buttonFrame];
        [self.view.window addSubview:imageDetailView];
        [imageDetailView showWithAnimated:YES];
        
        imageDetailView.detailShown = ^{
            self.statusBarHidden = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        };
        imageDetailView.detailHidden = ^{
            self.statusBarHidden = NO;
            [self setNeedsStatusBarAppearanceUpdate];
        };
    };
    
    return cell;
}


@end
