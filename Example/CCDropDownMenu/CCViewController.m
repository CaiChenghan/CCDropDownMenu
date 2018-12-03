//
//  CCViewController.m
//  CCDropDownMenu
//
//  Created by 1178752402@qq.com on 09/20/2018.
//  Copyright (c) 2018 1178752402@qq.com. All rights reserved.
//

#import "CCViewController.h"
#import "CCDropDownMenu.h"
#import "ListView.h"
#import "BtnView.h"

@interface CCViewController ()

@property (nonatomic, strong) CCDropDownMenu *menu;

@property (nonatomic, copy) NSArray *dropDownViews;
@property (nonatomic, copy) NSArray *dropDownTitles;

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menu];
    [self.menu changeMenu:@"测试" status:CCDropDownMenuStatusSelected | CCDropDownMenuStatusDisabled atIndex:0];
}

- (CCDropDownMenu *)menu {
    if (_menu == nil) {
        _menu = [[CCDropDownMenu alloc]initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, 44.0) dropDownViews:self.dropDownViews dropDownTitles:self.dropDownTitles];
        [_menu setMenuTitleColor:[UIColor blackColor] selected:[UIColor colorWithRed:176.0/255.0 green:148.0/255.0 blue:109.0/255.0 alpha:1] disabled:[UIColor redColor]];
        [_menu setMenuTitleFont:[UIFont systemFontOfSize:14] selected:[UIFont systemFontOfSize:14] disabled:[UIFont systemFontOfSize:14]];
        [_menu setMenuImage:[UIImage imageNamed:@"mall_button_down"] selected:[UIImage imageNamed:@"mall_button_down_golden"] disabled:nil];
        _menu.itemSpacing = 100.0;
    }
    return _menu;
}

- (NSArray *)dropDownViews {
    ListView *listView = [[ListView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    BtnView *btnView = [[BtnView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    return @[listView,btnView];
}

- (NSArray *)dropDownTitles {
    return @[@"标题1",@"标题2"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
