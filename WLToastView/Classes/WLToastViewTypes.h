//
//  WLToastViewTypes.h
//  WLToastView
//
//  Created by jzjy on 2020/12/31.
//  Copyright © 2020 0624pdy@sina.com. All rights reserved.
//

#ifndef WLToastViewTypes_h
#define WLToastViewTypes_h

typedef NS_ENUM(NSInteger, WLToastViewStyle) {
    WLToastViewStyle_ActivityIndicator  = 0,    //活动指示器（旋转的菊花）
    WLToastViewStyle_Image              = 1,    //图片
    WLToastViewStyle_Text               = 2,    //纯文本
    WLToastViewStyle_Custom             = 3,    //自定义视图
};

#endif /* WLToastViewTypes_h */
