//
//  CCDropDownView.h
//  CCDropDownMenu
//
//  Created by 蔡成汉 on 2018/9/20.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDropDownViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCDropDownView : UIView

@property (nonatomic, weak) id<CCDropDownViewDelegate>delegate;

// Override this method if you want to get call back opened
- (void)dropDownViewOpened;

// Override this method if you want to get call back opened
- (void)dropDownViewClosed;

// hide menu self
- (void)hideMenu;

// Change menu title at index
- (void)changeMenu:(NSString *)title atIndex:(NSInteger)index;
- (void)changeMenu:(NSString *)title status:(CCDropDownMenuStatus)status atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
