//
//  RDThirdRotableViewController.m
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/10.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import "RDThirdRotableViewController.h"

@interface RDThirdRotableViewController ()

@property (nonatomic, strong) UIControl *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect thumbnailImageFrame;

@property (nonatomic, copy) void (^dismissed)(void);

@end

@implementation RDThirdRotableViewController

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _image = image;
        _thumbnailImageFrame = frame;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleStatusBarOrientationDidChange) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
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
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)showWithAnimationUntilDismiss:(void (^)(void))dismiss {
    [self showWithAnimation];
    self.dismissed = dismiss;
}

- (void)showWithAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.imageView.frame = self.view.frame;
    }];
}

- (void)hideWithAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.backgroundColor = [UIColor clearColor];
        self.imageView.frame = self.thumbnailImageFrame;
    } completion:^(BOOL finished) {
        if (self.dismissed) {
            self.dismissed();
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didTapContainerView:(UIControl *)control {
    [self hideWithAnimation];
}

- (void)handleStatusBarOrientationDidChange {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
        NSLog(@"status Bar OrientationDidChange:%ld", (long)[UIApplication sharedApplication].statusBarOrientation);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"%@", newCollection.description);
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
            self.imageView.alpha = 0.5;
        } else {
            self.imageView.alpha = 1.0;
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

@end
