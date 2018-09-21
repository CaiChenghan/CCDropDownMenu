//
//  CCDropDownMenuButton.m
//  CCDropDownMenu_Example
//
//  Created by 蔡成汉 on 2018/9/21.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "CCDropDownMenuButton.h"

@implementation CCDropDownMenuButton

- (void)setImages:(struct CCImages)images {
    _images = images;
    [self setImage:_images.normal forState:UIControlStateNormal];
    [self setImage:_images.normal forState:UIControlStateHighlighted];
    [self resetEdgeInsets];
}

- (void)setColors:(struct CCColors)colors {
    _colors = colors;
    [self setTitleColor:_colors.normal forState:UIControlStateNormal];
    [self resetEdgeInsets];
}

- (void)setFonts:(struct CCFonts)fonts {
    _fonts = fonts;
    self.titleLabel.font = _fonts.normal;
    [self resetEdgeInsets];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self resetEdgeInsets];
}

- (void)resetEdgeInsets {
    CGSize imageSize = self.imageView.bounds.size;
    CGSize titleSize = self.titleLabel.bounds.size;
    CGFloat offset = 2.5;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width-offset, 0, imageSize.width+offset);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width+offset, 0, -titleSize.width-offset);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
