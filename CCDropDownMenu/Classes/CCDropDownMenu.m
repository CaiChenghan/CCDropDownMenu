//
//  CCDropDownMenu.m
//  CCDropDownMenu_Example
//
//  Created by 蔡成汉 on 2018/9/20.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "CCDropDownMenu.h"
#import "CCDropDownMenuButton.h"
#import "CCDropDownView.h"

@interface CCDropDownMenu ()<CCDropDownViewDelegate>

@property (nonatomic, assign) BOOL opened;
@property (nonatomic, assign) NSInteger openedIndex;

@property (nonatomic, strong) NSArray<CCDropDownMenuButton *> *dropDownButtons;
@property (nonatomic, copy) NSArray<CCDropDownView *> *dropDownViews;
@property (nonatomic, copy) NSArray<NSString *> *dropDownTitles;
@property (nonatomic, copy) NSMutableArray<NSNumber *> *alwaysOnIndex;
@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic, assign) NSInteger numberOfMenu;

@property (nonatomic, assign) struct CCImages buttonImages;
@property (nonatomic, assign) struct CCColors buttonLabColors;
@property (nonatomic, assign) struct CCFonts buttonLabFonts;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation CCDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame dropDownViews:(NSArray<CCDropDownView *> *)dropDownViews dropDownTitles:(NSArray<NSString *> *)dropDownTitles {
    NSCAssert(dropDownViews.count == dropDownTitles.count, @"Please make dropDownViews count same with dropDownViewsTitles count");
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        _blurEffectViewAlpha = 1.0;
        _backgroundBlurEnabled = YES;
        _showMenuDuration = 0.5;
        _hideMenuDuration = 0.3;
        _showMenuSpringVelocity = 0.5;
        _showMenuSpringWithDamping = 0.8;
        _hideMenuSpringVelocity = 0.9;
        _hideMenuSpringWithDamping = 0.8;
        _opened = NO;
        _openedIndex = 0;
        _alwaysOnIndex = [NSMutableArray array];
        self.numberOfMenu = dropDownViews.count;
        self.dropDownViews = dropDownViews;
        self.dropDownTitles = dropDownTitles;
        self.menuHeight = self.frame.size.height;
        [self initialViews];
    }
    return self;
}

- (void)initialViews {
    CGFloat itemWidth = self.bounds.size.width / self.numberOfMenu;
    NSMutableArray<CCDropDownMenuButton *> *btns = [NSMutableArray array];
    for (NSInteger i=0; i<self.numberOfMenu; i++) {
        CCDropDownMenuButton *btn = [CCDropDownMenuButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(itemWidth*i, 0, itemWidth, self.menuHeight);
        btn.tag = i;
        [btn setTitle:self.dropDownTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(menuClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:btn];
        [self addSubview:btn];
        
        // Setup Views
        CCDropDownView *dropDownView = self.dropDownViews[i];
        dropDownView.frame = CGRectMake(0, self.menuHeight - dropDownView.bounds.size.height, dropDownView.bounds.size.width, dropDownView.bounds.size.height);
    }
    self.dropDownButtons = btns;
    
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.menuHeight-0.5, self.bounds.size.width, 0.5)];
    self.bottomLine.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1];
    [self addSubview:self.bottomLine];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
}

- (void)setMenuImage:(UIImage *)normalImage selected:(UIImage *)selectedImage disabled:(UIImage *)disabledImage {
    struct CCImages imgages = {normalImage, selectedImage, disabledImage};
    self.buttonImages = imgages;
    for (CCDropDownMenuButton *btn in self.dropDownButtons) {
        btn.images = self.buttonImages;
    }
}

- (void)setMenuTitleColor:(UIColor *)normalColor selected:(UIColor *)selectedColor disabled:(UIColor *)disabledColor {
    struct CCColors colors = {normalColor, selectedColor, disabledColor};
    self.buttonLabColors = colors;
    for (CCDropDownMenuButton *btn in self.dropDownButtons) {
        btn.colors = self.buttonLabColors;
    }
}

- (void)setMenuTitleFont:(UIFont *)normalFont selected:(UIFont *)selectedFont disabled:(UIFont *)disabledFont {
    struct CCFonts fonts = {normalFont, selectedFont, disabledFont};
    self.buttonLabFonts = fonts;
    for (CCDropDownMenuButton *btn in self.dropDownButtons) {
        btn.fonts = self.buttonLabFonts;
    }
}

- (void)setDropDownViews:(NSArray<CCDropDownView *> *)dropDownViews {
    _dropDownViews = dropDownViews;
    for (CCDropDownView *dropDownView in _dropDownViews) {
        dropDownView.delegate = self;
    }
}

- (void)setBlurEffectView:(UIView *)blurEffectView {
    _blurEffectView = blurEffectView;
    _blurEffectView.alpha = 0;
    _blurEffectView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.frame.origin.y);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blurEffectViewClicked:)];
    [_blurEffectView addGestureRecognizer:tapGesture];
    
}

- (void)menuClicked:(UIButton *)sender {
    [self showAndHideMenuAtIndex:sender.tag];
}

- (void)showAndHideMenuAtIndex:(NSInteger)index {
    [self checkIndex:index];
    if (self.openedIndex != index && self.opened) {
        __weak typeof(self) weakSelf = self;
        [self hideMenu:self.dropDownButtons[self.openedIndex] dropDownView:self.dropDownViews[self.openedIndex] complete:^{
            [weakSelf showMenu:weakSelf.dropDownButtons[index] dropDownView:self.dropDownViews[index] complete:nil];
        }];
        self.openedIndex = index;
        return;
    }
    self.openedIndex = index;
    if (!self.opened) {
        [self showMenu:self.dropDownButtons[index] dropDownView:self.dropDownViews[index] complete:nil];
    } else {
        [self hideMenu:self.dropDownButtons[index] dropDownView:self.dropDownViews[index] complete:nil];
    }
    self.opened = !self.opened;
}

- (void)checkIndex:(NSInteger)index {
    NSCAssert(index < self.numberOfMenu, @"index should be smaller than menu count");
}

- (void)blurEffectViewClicked:(UIGestureRecognizer *)recognizer {
    [self hideMenu];
}

- (void)showMenu:(CCDropDownMenuButton *)dropDwonButton dropDownView:(CCDropDownView *)dropDownView complete:(void(^)(void))complete {
    dropDownView.hidden = NO;
    [self addSubview:dropDownView];
    [self sendSubviewToBack:dropDownView];
    
    if ([dropDownView isKindOfClass:[CCDropDownView class]]) {
        [dropDownView dropDownViewOpened];
    }
    
    if (self.backgroundBlurEnabled && self.blurEffectView) {
        if (self.superview) {
            [self.superview insertSubview:self.blurEffectView belowSubview:self];
        }
    }
    
    [UIView animateWithDuration:self.showMenuDuration
                          delay:0
         usingSpringWithDamping:self.showMenuSpringWithDamping
          initialSpringVelocity:self.showMenuSpringVelocity
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, dropDownView.bounds.size.height + self.menuHeight);
                         dropDownView.frame = CGRectMake(0, self.menuHeight, dropDownView.bounds.size.width, dropDownView.bounds.size.height);
                         if (self.backgroundBlurEnabled && self.blurEffectView) {
                             self.blurEffectView.alpha = self.blurEffectViewAlpha;
                         }
                         if (dropDwonButton.imageView) {
                             [dropDwonButton setImage:self.buttonImages.selected forState:UIControlStateNormal];
                             [dropDwonButton setImage:self.buttonImages.selected forState:UIControlStateHighlighted];
                             dropDwonButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
                         }
                         [dropDwonButton setTitleColor:self.buttonLabColors.selected forState:UIControlStateNormal];
                         dropDwonButton.titleLabel.font = self.buttonLabFonts.selected;
                     }
                     completion:^(BOOL finished) {
                         if (complete) {
                             complete();
                         }
                     }];
}

- (void)hideMenu:(CCDropDownMenuButton *)dropDwonButton dropDownView:(CCDropDownView *)dropDownView complete:(void(^)(void))complete  {
    if ([dropDownView isKindOfClass:[CCDropDownView class]]) {
        [dropDownView dropDownViewClosed];
    }
    [UIView animateWithDuration:self.hideMenuDuration
                          delay:0
         usingSpringWithDamping:self.hideMenuSpringWithDamping
          initialSpringVelocity:self.hideMenuSpringVelocity
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.menuHeight);
                         dropDownView.frame = CGRectMake(dropDownView.frame.origin.x, self.menuHeight, dropDownView.bounds.size.width, dropDownView.bounds.size.height);
                         if (self.backgroundBlurEnabled) {
                             self.blurEffectView.alpha = 0;
                         }
                         if (dropDwonButton.imageView) {
                             dropDwonButton.imageView.transform = CGAffineTransformMakeRotation(0);
                         }
                         
                         if (self.alwaysOnIndex) {
                             if (![self.alwaysOnIndex containsObject:@(dropDwonButton.tag)]) {
                                 [dropDwonButton setTitleColor:self.buttonLabColors.normal forState:UIControlStateNormal];
                                 dropDwonButton.titleLabel.font = self.buttonLabFonts.normal;
                                 [dropDwonButton setImage:self.buttonImages.normal forState:UIControlStateNormal];
                                 [dropDwonButton setImage:self.buttonImages.normal forState:UIControlStateHighlighted];
                             }
                         }
                     } completion:^(BOOL finished) {
                         if (self.backgroundBlurEnabled && self.blurEffectView) {
                             [self.blurEffectView removeFromSuperview];
                         }
                         dropDownView.hidden = YES;
                         if (complete) {
                             complete();
                         }
                     }];
}

- (void)setMenuStatus:(CCDropDownMenuStatus)status atIndex:(NSInteger)index {
    [self checkIndex:index];
    switch (status) {
            case CCDropDownMenuStatusNormal:
            if ([self.alwaysOnIndex containsObject:@(index)]) {
                [self.alwaysOnIndex removeObject:@(index)];
            }
            [self.dropDownButtons[index] setTitleColor:self.buttonLabColors.normal forState:UIControlStateNormal];
            self.dropDownButtons[index].titleLabel.font = self.buttonLabFonts.normal;
            break;
            
            case CCDropDownMenuStatusSelected:
            if (![self.alwaysOnIndex containsObject:@(index)]) {
                [self.alwaysOnIndex addObject:@(index)];
            }
            [self.dropDownButtons[index] setTitleColor:self.buttonLabColors.selected forState:UIControlStateNormal];
            self.dropDownButtons[index].titleLabel.font = self.buttonLabFonts.selected;
            break;
            
            case CCDropDownMenuStatusAbled:
            self.dropDownButtons[index].userInteractionEnabled = YES;
            break;
            
            case CCDropDownMenuStatusDisabled:
            self.dropDownButtons[index].userInteractionEnabled = NO;
            break;
    }
}

#pragma mark - CCDropDownViewDelegate

- (void)hideMenu {
    if (self.opened) {
        [self hideMenu:self.dropDownButtons[self.openedIndex] dropDownView:self.dropDownViews[self.openedIndex] complete:nil];
        self.opened = !self.opened;
    }
}

- (void)changeMenu:(NSString *)title atIndex:(NSInteger)index {
    [self.dropDownButtons[index]setTitle:title forState:UIControlStateNormal];
}

- (void)changeMenu:(NSString *)title status:(CCDropDownMenuStatus)status atIndex:(NSInteger)index {
    [self changeMenu:title atIndex:index];
    [self setMenuStatus:status atIndex:index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
