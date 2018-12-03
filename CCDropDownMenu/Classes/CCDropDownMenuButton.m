//
//  CCDropDownMenuButton.m
//  CCDropDownMenu_Example
//
//  Created by 蔡成汉 on 2018/9/21.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "CCDropDownMenuButton.h"

@implementation CCDropDownMenuButton

- (void)setImages:(CCImages *)images {
    _images = images;
    [self setImage:_images.normal forState:UIControlStateNormal];
    [self setImage:_images.normal forState:UIControlStateHighlighted];
    [self resetEdgeInsets];
}

- (void)setColors:(CCColors *)colors {
    _colors = colors;
    [self setTitleColor:_colors.normal forState:UIControlStateNormal];
    [self resetEdgeInsets];
}

- (void)setFonts:(CCFonts *)fonts {
    _fonts = fonts;
    self.titleLabel.font = _fonts.normal;
    [self resetEdgeInsets];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    self.titleLabel.text = title;
    [self resetEdgeInsets];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    self.imageView.image = image;
    [self resetEdgeInsets];
}

- (void)resetEdgeInsets {
    CGSize imageSize = CGSizeZero;
    if (self.imageView.image) {
        imageSize = self.imageView.bounds.size;
    }
    CGSize titleSize = CGSizeZero;
    if (self.titleLabel.text) {
        titleSize = self.titleLabel.bounds.size;
    }
    if (imageSize.width > 0) {
        CGFloat offset = 2.5;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width-offset, 0, imageSize.width+offset);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width+offset, 0, -titleSize.width-offset);
    } else {
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
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


@implementation CCImages

- (instancetype)initWithNormalImage:(UIImage *)normal selectedImage:(UIImage *)selected disabledImage:(UIImage *)disabled {
    self = [super init];
    if (self) {
        self.normal = normal;
        self.selected = selected;
        self.disabled = disabled;
    }
    return self;
}

@end


@implementation CCColors

- (instancetype)initWithNormalColor:(UIColor *)normal selectedColor:(UIColor *)selected disabledColor:(UIColor *)disabled {
    self = [super init];
    if (self) {
        self.normal = normal;
        self.selected = selected;
        self.disabled = disabled;
    }
    return self;
}

@end


@implementation CCFonts

- (instancetype)initWithNormalFont:(UIFont *)normal selectedFont:(UIFont *)selected disabledFont:(UIFont *)disabled {
    self = [super init];
    if (self) {
        self.normal = normal;
        self.selected = selected;
        self.disabled = disabled;
    }
    return self;
}

@end
