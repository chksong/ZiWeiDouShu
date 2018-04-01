//
//  ZiWeiItemView.h
//  ZiWeiApp
//
//  Created by chksong on 2018/3/10.
//  Copyright © 2018年 cn.goipc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiWeiItemView : UIView

@property(nonatomic , strong) NSNumber*  gongWeiID ;  //用于显示 子，丑。。。。

/*
 *  设置宫的名称
 */
-(void) setGongName:(NSString*) strGongName ;


/**
 *  设置宫位的干支
 */
-(void) setGongGanZhi:(NSString*)strGanZhi  ;

-(void) reDraw ;
@end
