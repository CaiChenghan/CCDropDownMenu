//
//  CCDropDownMenu.h
//  CCDropDownMenu_Example
//
//  Created by 蔡成汉 on 2018/9/20.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDropDownView.h"
@protocol CCDropDownMenuDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface CCDropDownMenu : UIView

@property (nonatomic, weak) id<CCDropDownMenuDelegate>delegate;

// Blur effect view
@property (nonatomic, strong) UIView *blurEffectView;

// Alpha Value if animation ended in *hideMenu()* function
@property (nonatomic, assign) CGFloat blurEffectViewAlpha;

// Blur effect style in background view
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;

// Make background blur view enabled
@property (nonatomic, assign) BOOL backgroundBlurEnabled;

// Show menu second default value: *0.5*
@property (nonatomic, assign) CGFloat showMenuDuration;

// Hide menu second default value: *0.3*
@property (nonatomic, assign) CGFloat hideMenuDuration;

// Show menu spring velocity default value: *0.5*
@property (nonatomic, assign) CGFloat showMenuSpringVelocity;

// Show menu spring damping default value: *0.8*
@property (nonatomic, assign) CGFloat showMenuSpringWithDamping;

// Hide menu spring velocity Default value: *0.9*
@property (nonatomic, assign) CGFloat hideMenuSpringVelocity;

// Hide menu spring damping Default value: *0.8*
@property (nonatomic, assign) CGFloat hideMenuSpringWithDamping;

// Bottom 0.5px line
@property (nonatomic, strong, readonly) UIView *bottomLine;

- (instancetype)initWithFrame:(CGRect)frame dropDownViews:(NSArray<CCDropDownView *> *)dropDownViews dropDownTitles:(NSArray<NSString *> *)dropDownTitles;

- (void)setMenuImage:(UIImage *)normalImage selected:(UIImage *)selectedImage disabled:(UIImage *)disabledImage;
- (void)setMenuTitleColor:(UIColor *)normalColor selected:(UIColor *)selectedColor disabled:(UIColor *)disabledColor;
- (void)setMenuTitleFont:(UIFont *)normalFont selected:(UIFont *)selectedFont disabled:(UIFont *)disabledFont;

- (void)hideMenu;
- (void)changeMenu:(NSString *)title atIndex:(NSInteger)index;
- (void)changeMenu:(NSString *)title status:(CCDropDownMenuStatus)status atIndex:(NSInteger)index;

@end


@protocol CCDropDownMenuDelegate <NSObject>

@optional

- (void)dropDownViewWillOpen:(CCDropDownMenu *)menu;
- (void)dropDownViewDidOpened:(CCDropDownMenu *)menu;
- (void)dropDownViewWillClose:(CCDropDownMenu *)menu;
- (void)dropDownViewDidClosed:(CCDropDownMenu *)menu;

@end


NS_ASSUME_NONNULL_END
