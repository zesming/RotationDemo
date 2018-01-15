//
//  RDFirstRotableViewController.m
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/10.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import "RDFirstRotableViewController.h"

@interface RDFirstRotableViewController ()

@property (nonatomic, strong) UIControl *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect thumbnailImageFrame;

@end

@implementation RDFirstRotableViewController

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _image = image;
        _thumbnailImageFrame = frame;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.containerView = [[UIControl alloc] initWithFrame:CGRectZero];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.containerView addTarget:self action:@selector(didTapContainerView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = self.thumbnailImageFrame;
    [self.containerView addSubview:self.imageView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.imageView.frame = self.view.frame;
    }];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.backgroundColor = [UIColor clearColor];
        self.imageView.frame = self.thumbnailImageFrame;
    }];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didTapContainerView:(UIControl *)control {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end
