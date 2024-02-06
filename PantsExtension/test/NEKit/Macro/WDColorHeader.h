//
//  WDColorHeader.h
//  IOS-Weidai
//
//  Created by yaoqi on 16/5/13.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#ifndef WDColorHeader_h
#define WDColorHeader_h

#pragma mark - ***** 颜色设置

/*! RGB色值 */
#define WD_RGBA(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
#define WD_RGB(R, G, B) WD_RGBA(R, G, B, 1.0)

/*! 随机色 */
#define WDRandomColor [UIColor colorWithRed:arc4random_uniform(256) % 255.0 green:arc4random_uniform(256) % 255.0 blue:arc4random_uniform(256) % 255.0 alpha:1.0]
#define WD_ColorFromRGB(rgbValue) [UIColor colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float) ((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float) (rgbValue & 0xFF)) / 255.0 alpha:1.0]

/*! navi蓝色 */
#define WD_NaviBgBlueColor WD_RGBA(0, 122, 255, 1.0)
#define WD_BGGrayColor WD_RGBA(239, 239, 239, 1.0)
#define WD_TEXTGrayColor WD_RGBA(148, 147, 133, 1.0)
#define WD_BLUEColor WD_RGBA(78, 164, 255, 1.0)
#define WD_6B3906_COLOR WD_RGBA(107, 57, 6, 1.0)

#define WD_BGClearColor [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.7f]
#define WD_bg_red_Color WD_RGBA(234, 71, 93, 1.0) //#EA475D
#define WD_Main_Color WD_RGBA(255, 236, 0, 1.0)  //#FFEC00
#define WD_Purple_Color WD_RGBA(120, 58, 243, 1.0)   //783AF3 主题紫深
#define WD_Blue_Color WD_RGBA(0, 0, 202, 1.0)   //#0000CA 主题篮
#define WD_Pink_Color WD_RGBA(255, 58, 200, 1.0)   //#FF3AC8 主题粉
#define WD_Gold_Color WD_RGBA(178, 136, 80, 1.0)   //#FF3AC8 主题粉
#define WD_Main_Yellow_Color WD_RGBA(254, 201, 1, 1.0)   //#FEC901 主题黄深
#define WD_Main_Red_Color WD_RGBA(255, 40, 70, 1.0)   //#FF2846 主题红
#define WD_Red_Bg_Color WD_RGBA(255, 235, 235, 1.0)//#ffebeb




//#define WD_Main_Text_COLOR  WD_RGBA(71, 45, 34, 1.0)  //472D22
#define WD_007A6E_Color WD_RGBA(0, 122, 110, 1.0)

#define WD_2c2048_Color WD_RGBA(44, 32, 72, 1.0)
#define WD_FF32C8_Color WD_RGBA(255, 50, 200, 1.0)      //主题粉
#define WD_595757_Color WD_RGBA(89, 87, 87, 1.0)        //主题灰


//#define WD_Main_Color WD_RGBA(178, 159, 116, 1.0)  //B29F74


//主题红色 #fc5830
#define WD_fc5830_Color WD_RGBA(252, 88, 48, 1.0)
//#333333
#define WD_333333_Color WD_RGBA(51, 51, 51, 1.0)
#define WD_555555_Color WD_RGBA(85, 85, 85, 1.0)

#define WD_TEXTRedColor WD_RGBA(252, 88, 48, 1.0)

//深灰 #666666
#define WD_666666_Color WD_RGBA(102, 102, 102, 1.0)
//#999999
#define WD_999999_Color WD_RGBA(153, 153, 153, 1.0)
//#bebebe
#define WD_bebebe_Color WD_RGBA(190, 190, 190, 1.0)
//#45b2f7
#define WD_45b2f7_Color WD_RGBA(69, 178, 247, 1.0)
//#e8faff
#define WD_e8faff_Color WD_RGBA(232, 250, 255, 1.0)
//#eaeaea  线灰色
#define WD_eaeaea_Color WD_RGBA(234, 234, 234, 1.0)
//#3eb1fa
#define WD_3eb1fa_Color WD_RGBA(62, 177, 250, 1.0)
//#aaaaaa
#define WD_aaaaaa_Color WD_RGBA(170, 170, 170, 1.0)
//#aaaaaa
#define WD_aeaeae_Color WD_RGBA(174, 174, 174, 1.0)
//#f9f9f9
#define WD_f9f9f9_Color WD_RGBA(249, 249, 249, 1.0)
//#dfdfdf
#define WD_dfdfdf_Color WD_RGBA(223, 223, 223, 1.0)
//#43b2f7 统一按钮背景颜色
#define WD_43b2f7_Color WD_RGBA(67, 178, 247, 1.0)
//#c6c6c6
#define WD_c6c6c6_Color WD_RGBA(198, 198, 198, 1.0)
//#3dacf2
#define WD_3dacf2_Color WD_RGBA(61, 172, 242, 1.0)
//#4dacf2
#define WD_4dacf2_Color WD_RGBA(77, 172, 242, 1.0)
//#e1e1e1
#define WD_e1e1e1_Color WD_RGBA(225, 225, 225, 1.0)
//#FCFCFC
#define WD_fcfcfc_Color WD_RGBA(252, 252, 252, 1.0)
//#b3e2ff
#define WD_b3e2ff_Color WD_RGBA(179, 226, 255, 1.0)
//#e1e1e1
#define WD_e1e1e1_Color WD_RGBA(225, 225, 225, 1.0)

#define WD_a0a0a0_Color WD_RGBA(160, 160, 160, 1.0)

#define WD_ebebeb_Color WD_RGBA(235, 235, 235, 1.0)

//#fbfbfb
#define WD_fbfbfb_Color WD_RGBA(251, 251, 251, 1.0)
//#8cbbf3
#define WD_8cbbf3_Color WD_RGBA(140, 187, 243, 1.0)
//#f8815c
#define WD_f8815c_Color WD_RGBA(248, 129, 92, 1.0)
//#f9ce5e
#define WD_f9ce5e_Color WD_RGBA(249, 206, 94, 1.0)
//#ba8bf6
#define WD_ba8bf6_Color WD_RGBA(186, 139, 246, 1.0)
//#ff705d
#define WD_ff705d_Color WD_RGBA(255, 112, 93, 1.0)
//##e0e0e0
#define WD_e0e0e0_Color WD_RGBA(224, 224, 224, 1.0)
//#d9d9d9
#define WD_d9d9d9_Color WD_RGBA(217, 217, 217, 1.0)
//#35abfe
#define WD_35abfe_Color WD_RGBA(53, 171, 254, 1.0)
//#44b2f7
#define WD_44b2f7_Color WD_RGBA(68, 178, 247, 1.0)
//#d4d4d4
#define WD_d4d4d4_Color WD_RGBA(212, 212, 212, 1.0)
//#8176eb
#define WD_8176eb_Color WD_RGBA(129, 118, 235, 1.0)
//#16c1d9
#define WD_16c1d9_Color WD_RGBA(22, 193, 217, 1.0)
//#e5eaf0
#define WD_e5eaf0_Color WD_RGBA(229, 234, 240, 1.0)
//#cecece
#define WD_cecece_Color WD_RGBA(206, 206, 206, 1.0)
//#C6E8FD
#define WD_c6e8fd_Color WD_RGBA(198, 232, 253, 1.0)
//#cccccc (_placeholderLabel.textColor)
#define WD_cccccc_Color WD_RGBA(204, 204, 204, 1.0)
#define WD_8e8e93_Color WD_RGBA(142, 142, 147, 1.0)
//#84c852
#define WD_84c852_Color  WD_RGBA(132, 200, 82, 1.0)
//所有按钮不可点击颜色 //#cae7f9
#define WD_cae7f9_Color   WD_RGBA(202,231,249, 1.0)
//按钮点击颜色(UIControlStateHighlighted)
#define WD_3ba8ed_Color  WD_RGBA(59,168,237, 1.0)
//#bad4ee
#define WD_bad4ee_Color  WD_RGBA(186,212,238,1.0)
//#FFB5A3
#define WD_ffb5a3_Color  WD_RGBA(255,181,163,1.0)
//#f6f6f6
#define WD_f6f6f6_Color WD_RGBA(246, 246, 246, 1.0)

#define WD_fafafa_Color WD_RGBA(250, 250, 250, 1.0)


/*! 白色 */
#define WD_White_Color [UIColor whiteColor]

/*! 红色 */
#define WD_Red_Color [UIColor redColor]

/*! 黄色 */
#define WD_Yellow_Color [UIColor yellowColor]

/*! 绿色 */
#define WD_Green_Color [UIColor greenColor]

/*! 无色 */
#define WD_Clear_Color [UIColor clearColor]

#endif /* WDColorHeader_h */
