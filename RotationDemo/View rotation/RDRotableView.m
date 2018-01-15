//
//  RDRotableView.m
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/8.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import "RDRotableView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface RDRotableView ()

@property (nonatomic, assign) CGRect thumbnailImageFrame;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation RDRotableView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image imageFrame:(CGRect)imageFrame {
    self = [super initWithFrame:frame];
    if (self) {
        _thumbnailImageFrame = imageFrame;
        
        self.backgroundColor = [UIColor clearColor];
        
        _containerView = [[UIView alloc] initWithFrame:frame];
        _containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:_containerView];
        
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.frame = _thumbnailImageFrame;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_containerView addSubview:_imageView];
        
        UITapGestureRecognizer *singelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singelTapAction:)];
        [_imageView addGestureRecognizer:singelTapGestureRecognizer];
        _imageView.userInteractionEnabled = YES;
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)showWithAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self showDetail];
        } completion:^(BOOL finished) {
            if (self.detailShown) {
                self.detailShown();
            }
        }];
    } else {
        [self showDetail];
    }
}

- (void)showDetail {
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.imageView.frame = self.containerView.frame;
}

- (void)hiddenDetail {
    [self orientationChange:UIDeviceOrientationPortrait];
    self.imageView.frame = self.thumbnailImageFrame;
    self.backgroundColor = [UIColor clearColor];
}

- (void)singelTapAction:(UITapGestureRecognizer *)recognizer {
    if (self.detailHidden) {
        self.detailHidden();
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenDetail];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

- (void)deviceOrientationDidChange
{
    NSLog(@"deviceOrientationDidChange:%ld", (long)[UIDevice currentDevice].orientation);
    NSLog(@"deviceOrientationDidChange:%ld", (long)[UIApplication sharedApplication].statusBarOrientation);
    [self orientationChange:[UIDevice currentDevice].orientation];
}

- (void)orientationChange:(UIDeviceOrientation)orientation
{
    [UIView animateWithDuration:0.25f animations:^{
        switch (orientation) {
            case UIDeviceOrientationPortrait:
                self.containerView.transform = CGAffineTransformMakeRotation(0);
                self.containerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                self.imageView.frame = self.frame;
                break;
            case UIDeviceOrientationLandscapeLeft:
                self.containerView.transform = CGAffineTransformMakeRotation(M_PI_2);
                self.containerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                self.imageView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
                break;
            case UIDeviceOrientationLandscapeRight:
                self.containerView.transform = CGAffineTransformMakeRotation(-M_PI_2);
                self.containerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                self.imageView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
                break;
            default:
                break;
        }
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
