//
//  RDRotableView.h
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/8.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDRotableView : UIView

@property (nonatomic, copy) void (^detailShown)(void);
@property (nonatomic, copy) void (^detailHidden)(void);

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image imageFrame:(CGRect)imageFrame;
- (void)showWithAnimated:(BOOL)animated;

@end
