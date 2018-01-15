//
//  RDThirdRotableViewController.h
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/10.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDThirdRotableViewController : UIViewController

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame;
- (void)showWithAnimationUntilDismiss:(void (^)(void))dismiss;

@end
