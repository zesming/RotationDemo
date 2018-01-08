//
//  RDImageTableViewCell.m
//  RotationDemo
//
//  Created by 赵恩生 on 2018/1/8.
//  Copyright © 2018年 zesming. All rights reserved.
//

#import "RDImageTableViewCell.h"

@interface RDImageTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *imageButton;


@end

@implementation RDImageTableViewCell

- (IBAction)imageButtonAction:(UIButton *)sender {
    if (self.buttonAction) {
        CGRect buttonGlobalFrame = [self.contentView convertRect:self.imageButton.frame toView:nil];
        self.buttonAction(buttonGlobalFrame);
    }
}

@end
