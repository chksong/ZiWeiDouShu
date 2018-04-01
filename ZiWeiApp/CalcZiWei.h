//
//  CalcZiWei.h
//  ZiWeiApp
//
//  Created by chksong on 2018/3/14.
//  Copyright © 2018年 cn.goipc. All rights reserved.
//

#import <Foundation/Foundation.h>


//计算紫微斗数x

@interface CalcZiWei : NSObject


@property(nonatomic ,strong) NSNumber *year ; 
@property(nonatomic ,strong) NSNumber *month ;
@property(nonatomic ,strong) NSNumber *day   ;
@property(nonatomic, strong) NSNumber *timeID ; 


/*
 *  计算命宫和身宫
 */
-(NSDictionary*)  CalcMingAndShengGong ;



/*
 *  计算五行局
 */
-(void)calcWuXingJu:(NSUInteger)yearTianGan  ;


@end
