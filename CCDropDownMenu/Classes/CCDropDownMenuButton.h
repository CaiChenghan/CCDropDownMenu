//
//  CCDropDownMenuButton.h
//  CCDropDownMenu_Example
//
//  Created by 蔡成汉 on 2018/9/21.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCImages;
@class CCColors;
@class CCFonts;

NS_ASSUME_NONNULL_BEGIN

@interface CCDropDownMenuButton : UIButton

@property (nonatomic, strong) CCImages *images;
@property (nonatomic, strong) CCColors *colors;
@property (nonatomic, strong) CCFonts *fonts;

@end

@interface CCImages : NSObject

@property (nonatomic, strong) UIImage *normal;
@property (nonatomic, strong) UIImage *selected;
@property (nonatomic, strong) UIImage *disabled;

- (instancetype)initWithNormalImage:(UIImage *)normal selectedImage:(UIImage *)selected disabledImage:(UIImage *)disabled;

@end

@interface CCColors : NSObject

@property (nonatomic, strong) UIColor *normal;
@property (nonatomic, strong) UIColor *selected;
@property (nonatomic, strong) UIColor *disabled;

- (instancetype)initWithNormalColor:(UIColor *)normal selectedColor:(UIColor *)selected disabledColor:(UIColor *)disabled;

@end

@interface CCFonts : NSObject

@property (nonatomic, strong) UIFont *normal;
@property (nonatomic, strong) UIFont *selected;
@property (nonatomic, strong) UIFont *disabled;

- (instancetype)initWithNormalFont:(UIFont *)normal selectedFont:(UIFont *)selected disabledFont:(UIFont *)disabled;

@end

NS_ASSUME_NONNULL_END
