//
//  CalcZiWei.m
//  ZiWeiApp
//
//  Created by chksong on 2018/3/14.
//  Copyright © 2018年 cn.goipc. All rights reserved.
//

#import "CalcZiWei.h"


@interface CalcZiWei()

/**
 * 宫位字典
 */
@property(nonatomic, strong) NSArray  *arrayGongName ;

/**
 *  天干字典
 */
@property(nonatomic, strong) NSArray *arrayTianGan ;

/**
 *  地址字典
 */
@property(nonatomic ,strong) NSArray *arrayDizhi ;


/**
 *  北斗星的布局
 */
@property(nonatomic ,strong) NSArray *arrayBeiDouXing ;


/**
 *  南斗星的布局
 */
@property(nonatomic ,strong) NSArray *arrayNanDouXing ;



@property(nonatomic) NSInteger idMing  ;   //命宫的位置
@property(nonatomic) NSInteger iYearingGan ; //年的天干，，用于计算五行局。
/*
 * 返回数据的结果
 */
@property(nonatomic ,strong) NSMutableDictionary  *dictData  ;

-(void) calcXing  ;
@end


@implementation CalcZiWei


-(instancetype)  init {
    
    self = [super init] ;
    if (self) {
        self.arrayGongName =  @[
                              @"命宫",@"兄弟宫",@"夫妻宫", @"子女宫" ,
                              @"财帛宫",@"疾厄宫",@"迁移宫" ,@"仆役宫" ,
                              @"官禄宫",@"田宅宫",@"福德宫", @"父母宫"] ;
        
        self.arrayTianGan =    @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"] ;
        self.arrayDizhi  =     @[@"子",@"丑" ,@"寅" ,@"卯",@"辰",@"巳" ,@"午" ,@"未" ,@"申" ,@"酉" ,@"戌" ,@"亥"] ;
        self.arrayBeiDouXing = @[@"紫微",@"天机" ,@""  ,@"太阳",@"武曲",@"天同",@""   ,@"" ,@"廉贞",@"",@""    ,@""] ;
        self.arrayNanDouXing = @[@"天府",@"太阴",@"贪狼",@"巨门",@"天相",@"天梁",@"七杀",@"" ,@""   ,@"",@"破军" ,@""] ;
        
       // self.strYearing
        self.dictData = [NSMutableDictionary dictionary]  ;
    }
    
    return self ;
}

// 第一步  计算命宫和身宫
// 寅正顺数生月逢，生月起子两头通，逆至生时为命宫，顺至生时按身宫。
-(NSDictionary*) CalcMingAndShengGong {
    int YinGongKey = 2 ; // 寅宫的KEY
    // 计算生月宫
    int shengYueGongY = (YinGongKey + [self.month intValue] - 1 ) % 12;
    
    /**
     * 计算命宫和身宫
     */
    int idSheng = (shengYueGongY + [self.timeID intValue] - 1) % 12 ;
    self.idMing  = (shengYueGongY -([self.timeID intValue] - 1) + 12) % 12 ;
    
    //计算命盘十二宫。
    NSMutableDictionary *dictGong = [[NSMutableDictionary alloc] init ];
    for (int index=0 ; index < 12; index++) {
        int tmpID = (self.idMing - index + 12) % 12 ;    //逆时针

        if (idSheng  == tmpID) {
            NSString *strgong= self.arrayGongName[index] ;
            NSString *strTmp = [NSString stringWithFormat:@"身*%@", [strgong substringToIndex:2]] ;
             [dictGong setObject:strTmp forKey:  [NSNumber numberWithInt:(tmpID)] ] ;
        }
        else {
            [dictGong setObject:self.arrayGongName[index] forKey:  [NSNumber numberWithInt:(tmpID)] ] ;
        }
    }
    
    [self.dictData setObject:dictGong forKey:@"GongName"] ;
    
    //计算五行局
    [self calcWuXingJu:0];
    
    //计算星星
    [self calcXing];
    
    return dictGong ;
}

// 第2部 计算命宫的干支属性
// 计算命
-(void)calcWuXingJu:(NSUInteger)yearTianGan {
    self.iYearingGan =  6 ; //  计算出生年的年干，用于计算命宫的干支
    NSInteger wuHuduanNianGan = 0 ;// 五虎遁
    //五虎遁干, 求出年
    if( 0 == self.iYearingGan % 5) {     // 甲己 ===》丙
        wuHuduanNianGan = 2;
    }
    else if (1 == self.iYearingGan % 5) { //乙庚 ==》 戊
        wuHuduanNianGan = 4 ;
    }
    else if (2 == self.iYearingGan % 5) { //丙辛 ==》 庚
        wuHuduanNianGan = 6;
    }
    else if (3 == self.iYearingGan % 5) { //丁壬 ==》 壬
        wuHuduanNianGan = 8;
    }
    else if (3 == self.iYearingGan % 8 ) { //癸水 ==》 甲
        wuHuduanNianGan = 0;
    }
    
    //计算命盘的干支
    NSMutableDictionary *dict = [NSMutableDictionary dictionary] ;
    for (NSInteger index = 0 ; index < 12; index++) {
        NSInteger tmpID  = (2 + index) % 12 ;    //正月开始起五虎墩
        NSInteger tianGan = (wuHuduanNianGan + index) % 10 ;
        NSInteger dizhi  = (2 + index) % 10 ;
        NSString *str = [NSString stringWithFormat:@"%@%@" ,self.arrayTianGan[tianGan], self.arrayDizhi[dizhi]] ;
        
        [dict setObject:str forKey:[NSNumber numberWithInteger:tmpID]];
    }
    [self.dictData  setObject:dict forKey:@"GanZhi"];
    
    
    //计算出命宫的的的天干， 年干是寅上起五虎遁
    NSInteger mingGongNianGan = (wuHuduanNianGan + self.idMing -2 ) % 10 ;
    //计算五星局，
    NSInteger mingID = (self.idMing /2) % 3 ;
    NSInteger headHunTianWuXing = mingGongNianGan /2 ; //浑天五行局
    
    // 金四局，水二局， 火二局  土5局， 木三局
    NSArray *arrayWuxingValue = @[@4 ,@2,@6,@5,@3] ;
    NSArray *arratWuxingString = @[@"金四局",@"水二局",@"火六局" ,@"土五局",@"木三局"] ;
    headHunTianWuXing = (headHunTianWuXing + mingID) % 5 ;
    NSNumber *mingWuxing = arrayWuxingValue[headHunTianWuXing] ;
    
    [self.dictData setObject:mingWuxing forKey:@"WuXingJuValue"];
    [self.dictData setObject:arratWuxingString[headHunTianWuXing] forKey:@"WuXingJuString"];
}


/**
 * 计算紫微星在哪里宫
 * 通过命宫计算五行局
 */
-(NSUInteger) calcZiweiPos:(NSInteger)wuxingJu {
    
}


/**
 *  从紫微的位置，计算天府的位置
 */
-(NSInteger) CalcTianFuPos:(NSInteger)ziWeiPos
{
    if ( ziWeiPos >= 0 && ziWeiPos <=4) {
        return  4 - ziWeiPos ;
    }
    else if(ziWeiPos >=5 && ziWeiPos <= 11) {
        return 16 - ziWeiPos ;
    }
    else {
        return 1;
    }
}


/**
 * 计算星座
 */
-(void) calcXing {
    NSMutableDictionary*  dictXing =  [NSMutableDictionary dictionary] ;
    // 计算北斗星的排列
    for (NSInteger index = 0 ; index < 12; index++) {
        NSInteger tmpID = (self.idMing - index + 12) % 12 ;    //逆时针
        
        NSMutableArray *arrayXing = [NSMutableArray array] ;
        [arrayXing addObject:self.arrayBeiDouXing[index]];
        [dictXing setObject:arrayXing forKey:[NSNumber numberWithInteger:(tmpID)] ] ;
    }
    
    //计算南斗的星星
    /*
    NSInteger tianFuPos = [self CalcTianFuPos:self.idMing];
    for (NSInteger index = 0 ; index < 12; index++) {
        NSInteger tmpID = (tianFuPos + index ) % 12 ;    //逆时针
        
        NSMutableArray *arrayXing = [dictXing objectForKey:[NSNumber numberWithInteger:(tmpID)] ];
        [arrayXing addObject:self.arrayNanDouXing[index]];
        [dictXing setObject:arrayXing forKey:[NSNumber numberWithInteger:(tmpID)] ] ;
    }
     */
    
    [self.dictData setObject:dictXing forKey:@"XingXing"];
}

@end
