//
//  MLAppDefine.h
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#ifndef MLAppDefine_h
#define MLAppDefine_h

//是某个机型
#define MLIPONE_4                         CGSizeEqualToSize([[UIScreen mainScreen] bounds].size,CGSizeMake(320, 480)) ? YES : NO
#define MLIPONE_5                         CGSizeEqualToSize([[UIScreen mainScreen] bounds].size,CGSizeMake(320, 568)) ? YES : NO
#define MLIPONE_6                         CGSizeEqualToSize([[UIScreen mainScreen] bounds].size,CGSizeMake(375, 667)) ? YES : NO
#define MLIPONE_6P                        CGSizeEqualToSize([[UIScreen mainScreen] bounds].size,CGSizeMake(414, 736)) ? YES : NO

//基本数据
#define MLScreenBounce                        [UIScreen mainScreen].bounds
#define MLScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define MLScreenHeight                        [[UIScreen mainScreen] bounds].size.height

// 是否大于等于iOS7
#define MLNoticeficationCenter            [NSNotificationCenter defaultCenter]

//颜色
#define MLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]          // 颜色
#define MLColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]     // 随机色
#define MLRandomColor MLColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))    //随机色
#define MLColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**以iphone6屏幕做的比例 */
#define MLScreenScaleNum (ScreenWidth/375.0)

// 调试状态, 打开LOG功能
#ifdef DEBUG
#define MLLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define MLLog(...)
#endif

//


#endif /* MLAppDefine_h */
