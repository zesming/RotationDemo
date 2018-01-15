//
//  RDImageTableViewCell.h
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/8.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDImageTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^buttonAction)(CGRect buttonFrame);
@property (nonatomic, strong, readonly) UIImage *currentButtonImage;

@end
