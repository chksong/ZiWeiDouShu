//
//  ZiWeiItemView.m
//  ZiWeiApp
//
//  Created by chksong on 2018/3/10.
//  Copyright © 2018年 cn.goipc. All rights reserved.
//

/*
 1）awakeFromNib和initWithCoder:差别
 awakeFromNib 从xib或者storyboard加载完毕就会调用
 initWithCoder: 只要对象是从文件解析来的，就会调用
 同时存在会先调用initWithCoder:
 */


#import "ZiWeiItemView.h"
#import "Masonry.h"

#define  mainScreenWidth   [UIScreen mainScreen].bounds.size.width
#define  mainScreenHeight   ([UIScreen mainScreen].bounds.size.height -64);


@interface ZiWeiItemView (){
  NSArray *strArray ;
  int viewWidth  ;
  int viewHeight ;
}

@property (nonatomic ,strong) UILabel *LabelGanZhi ;
@property (nonatomic ,strong) UILabel *labelGongName ;

@end



@implementation ZiWeiItemView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//    //self.LabelGong.text = strArray[[self.gongWeiID intValue]] ;
//}


-(void) reDraw {
    self.LabelGanZhi.text = strArray[[self.gongWeiID intValue]] ;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //宫位数组
        strArray = @[
                     @"子", @"丑",@"寅",@"卯",
                    @"辰", @"巳", @"午",@"未",
                    @"申", @"酉", @"戌", @"亥"];
        
        
        [self initSubView] ;
    }
    return self;
}


-(void) initSubView {
   
    self.LabelGanZhi = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20 , 20)];
    
    self.LabelGanZhi.text = strArray[[self.gongWeiID intValue]] ;
 //   titleLabel.backgroundColor = [UIColor clearColor];
    self.LabelGanZhi.textColor = [UIColor blueColor];
    self.LabelGanZhi.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.LabelGanZhi];
    [self.LabelGanZhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20) ;
        make.right.equalTo(self).offset(-2) ;
        make.bottom.equalTo(self).offset(-2) ;
    }];

}


-(void) setGongName:(NSString*) strGongName {
    self.labelGongName = [[UILabel alloc]initWithFrame:CGRectMake(0  , 0 , 60 , 20)];
    self.labelGongName.text = strGongName ;
    self.labelGongName.textColor = [UIColor blueColor];
    self.labelGongName.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.labelGongName];
    
    [self.labelGongName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20) ;
        make.left.equalTo(self).offset(2) ;
        make.bottom.equalTo(self).offset(-2) ;
    }];
    
}
@end
