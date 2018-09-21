//
//  CCDropDownView.m
//  CCDropDownMenu
//
//  Created by 蔡成汉 on 2018/9/20.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "CCDropDownView.h"

@implementation CCDropDownView

// Override this method if you want to get call back opened
- (void)dropDownViewOpened {
    
}

// Override this method if you want to get call back opened
- (void)dropDownViewClosed {
    
}

// hide menu self
- (void)hideMenu {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hideMenu)]) {
        [self.delegate hideMenu];
    }
}

// Change menu title at index
- (void)changeMenu:(NSString *)title atIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeMenu:atIndex:)]) {
        [self.delegate changeMenu:title atIndex:index];
    }
}

- (void)changeMenu:(NSString *)title status:(CCDropDownMenuStatus)status atIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeMenu:status:atIndex:)]) {
        [self.delegate changeMenu:title status:status atIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
