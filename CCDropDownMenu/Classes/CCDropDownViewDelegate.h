//
//  CCDropDownViewDelegate.h
//  CCDropDownMenu_Example
//
//  Created by 蔡成汉 on 2018/9/21.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CCDropDownMenuStatus) {
    CCDropDownMenuStatusNormal,
    CCDropDownMenuStatusSelected,
    CCDropDownMenuStatusAbled,
    CCDropDownMenuStatusDisabled
};

NS_ASSUME_NONNULL_BEGIN

@protocol CCDropDownViewDelegate <NSObject>

- (void)hideMenu;
- (void)changeMenu:(NSString *)title atIndex:(NSInteger)index;
- (void)changeMenu:(NSString *)title status:(CCDropDownMenuStatus)status atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
