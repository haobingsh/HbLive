//
//  HbColor.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/23.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#ifndef HbColor_h
#define HbColor_h

/**********************Color宏定义*************************/
#define RGBA(r,g,b,a) [UIColor colorWithRed:((r)/255.0f) green:((g)/255.0f) blue:((b)/255.0f) alpha:(a)]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//十六进位颜色转换
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//十六进位颜色转换（带alpha）
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
//讯卫视主色调-蓝色
#define xwsColor [UIColor colorWithRed:81.0/255.0 green:162.0/255.0 blue:246.0/255.0 alpha:1];
#define MAIN_COLOR [UIColor colorWithRed:81.0/255.0 green:162.0/255.0 blue:246.0/255.0 alpha:1]
//View整体色调
#define MAIN_BG_COLOR RGB(241, 241, 241)
//HexRGB(0xf4f4f4)

//导航栏颜色
//#define NAV_COLOR RGB(82, 165, 254)
#define NAV_COLOR HexRGB(0x3974e6)

//Tabbar标题颜色(选中)
#define SystemColorTabbarSel NAV_COLOR
//Tabbar标题颜色(普通)
#define SystemColorTabbarNor TEXT_GRAY_COLOR
//“小红点”
#define NOTICE_RED RGB(241, 109, 135)

//分割线
#define LINE_COLOR MAIN_BG_COLOR

//文本颜色 new
#define TEXT_BLACK_COLOR HexRGB(0x2d2d2d)
#define TEXT_GRAY_COLOR HexRGB(0xa0a0a0)
#define TEXT_BLACKGRAY_COLOR HexRGB(0x6b6b6b)
#define TEXT_BLACKLIGHTGRAY_COLOR HexRGB(0x666666)
#define TEXT_LIGHTMidGRAY_COLOR HexRGB(0x595959)
#define TEXT_LIGHTGRAY_COLOR HexRGB(0xbcbcbc)
#define TEXT_RED_COLOR HexRGB(0xFE5E76)

//view背景色
#define  VIEW_BACKGROUND_COLOR HexRGB(0xf4f4f4)


#endif /* HbColor_h */
