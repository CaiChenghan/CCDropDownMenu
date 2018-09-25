//
//  CCDropDownMenuStatus.h
//  CCDropDownMenu
//
//  Created by 蔡成汉 on 2018/9/21.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#ifndef CCDropDownMenuStatus_h
#define CCDropDownMenuStatus_h
#import <UIKit/UIKit.h>

struct CCImages {
    __unsafe_unretained UIImage *normal;
    __unsafe_unretained UIImage *selected;
    __unsafe_unretained UIImage *disabled;
};

struct CCColors {
    __unsafe_unretained UIColor *normal;
    __unsafe_unretained UIColor *selected;
    __unsafe_unretained UIColor *disabled;
};

struct CCFonts {
    __unsafe_unretained UIFont *normal;
    __unsafe_unretained UIFont *selected;
    __unsafe_unretained UIFont *disabled;
};

#endif /* CCDropDownMenuStatus_h */
