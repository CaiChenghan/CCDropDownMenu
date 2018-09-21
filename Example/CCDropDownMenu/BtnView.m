//
//  BtnView.m
//  CCDropDownMenu_Example
//
//  Created by 蔡成汉 on 2018/9/20.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "BtnView.h"
#import <SDAutoLayout/SDAutoLayout.h>

@interface BtnView ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation BtnView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self initialView];
        [self makeConstraints];
    }
    return self;
}

- (void)initialView {
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
}

- (void)makeConstraints {
    self.leftBtn.sd_layout
    .leftEqualToView(self).offset(50)
    .centerYEqualToView(self)
    .widthIs(100)
    .heightIs(30);
    
    self.rightBtn.sd_layout
    .rightEqualToView(self).offset(-50)
    .centerYEqualToView(self)
    .widthIs(100)
    .heightIs(30);
}

- (void)leftBtnIsTouch {
    [self changeMenu:@"喜欢你" atIndex:1];
}

- (void)rightBtnIsTouch {
    [self changeMenu:@"我非常的喜欢你" status:CCDropDownMenuStatusSelected atIndex:1];
}

- (UIButton *)leftBtn {
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor yellowColor];
        [_leftBtn setTitle:@"测试1" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnIsTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (_rightBtn == nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor yellowColor];
        [_rightBtn setTitle:@"测试2" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnIsTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
