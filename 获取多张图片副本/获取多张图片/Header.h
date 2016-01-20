//
//  Header.h
//  Warming
//
//  Created by Administrator on 15/9/21.
//  Copyright (c) 2015年 cxh.thankofsomethingclever. All rights reserved.
//

#ifndef Warming_Header_h
#define Warming_Header_h

//获取RGB颜色
#define RGBAA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBAA(r,g,b,1.0f)

#define WIDTH_SCREEN    [UIScreen mainScreen].bounds.size.width   //屏幕宽度
#define HEIGHT_SCREEN   [UIScreen mainScreen].bounds.size.height  //屏幕高度

#define WIDTH_FRAME    self.frame.size.width   //框架宽度
#define HEIGHT_FRAME    self.frame.size.height //框架高度

#define FONT(F) [UIFont systemFontOfSize:F]

//背景颜色
#define BACK_COLOR [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]

//标题字体颜色----字体大号15PX
#define TITLE_FONT_COLOR [UIColor colorWithRed:42.0/255.0 green:54.0/255.0 blue:68.0/255.0 alpha:1.0]

//内容字体颜色-----字体小号12PX
#define CONTENT_FONT_COLOR [UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:172.0/255.0 alpha:1.0]
//主体背景颜色
#define MAIN_FONT_COLOR [UIColor colorWithRed:99/255.0 green:206.0/255.0 blue:222.0/255.0 alpha:1.0]

#define SELECT_CITY_KEY @"c5264e3def05373c1427dfbd6b8bc7c8"
#define TRUE_ID_KEY @"c7eb07deefd441fd54fa3cbe39f06002"
#endif
