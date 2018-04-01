//
//  ZiWeiViewController.m
//  ZiWeiApp
//
//  Created by chksong on 2018/3/10.
//  Copyright © 2018年 cn.goipc. All rights reserved.
//

#import "ZiWeiViewController.h"
#import "Masonry.h"

#import "ZiWeiItemView.h"

#import "CalcZiWei.h"

//#define  mainScreenWidth   [UIScreen mainScreen].bounds.size.width
//#define  mainScreenHeight   [UIScreen mainScreen].bounds.size.height


@interface ZiWeiViewController ()

//通过key--》subView
@property (nonatomic,strong)  NSMutableDictionary  *dictSubView ;

//12宫的名字
@property (nonatomic,strong)  NSArray      *array12Gong  ;

@end

@implementation ZiWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLocalData]  ;
    [self initSubView] ;
    
    [self CaluSubViewGongName];
}

-(void) initLocalData {
    
    self.dictSubView  = [[NSMutableDictionary alloc] init];
}



-(void) initSubView {
    NSArray *arrayTagLine1 = @[@5 ,@6, @7, @8] ;
    NSArray *arrayTagLine2 = @[@4,         @9] ;
    NSArray *arrayTagLine3 = @[@3,        @10] ;
    NSArray *arrayTagLine4 = @[@2, @1, @0,@11] ;
    
    
  
    
    UIView *thisView = self.view  ;
    int  mainScreenWidth  =  thisView.bounds.size.width  ;
    int  mainScreenHeight =   thisView.bounds.size.height - 64 ;
    
    CGRect viewRect = CGRectMake(0, 0, mainScreenWidth/4,  mainScreenHeight/4) ;
    
    //最上面的一行
    for(int i=0 ; i < 4 ; i++) {
        ZiWeiItemView *subView = [[ZiWeiItemView alloc] initWithFrame:viewRect] ;
        subView.layer.borderWidth = 1 ;
        subView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.view addSubview:subView];
        
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(mainScreenWidth/4);
            make.height.mas_equalTo(mainScreenHeight/4) ;
            make.top.equalTo(thisView).offset(64) ;
            make.left.equalTo(thisView).offset(mainScreenWidth / 4 * i+ 0.5) ;
        }];
        
        subView.gongWeiID = arrayTagLine1[i];
        [self.dictSubView setObject:subView forKey:arrayTagLine1[i]] ;
        [subView reDraw];
    }
   
  
    //第二行
    for(int i=0 ; i < 2 ; i++) {
        ZiWeiItemView  *subView = [[ZiWeiItemView alloc] initWithFrame:viewRect] ;
        
        subView.layer.borderWidth = 1 ;
        subView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.view addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(mainScreenWidth/4);
            make.height.mas_equalTo(mainScreenHeight/4) ;
            make.top.equalTo(thisView).offset(64 +  mainScreenHeight/4  ) ;
            make.left.equalTo(thisView).offset(mainScreenWidth * 3/ 4 * i+ 0.5) ;
        }];
        
        subView.gongWeiID = arrayTagLine2[i];
        [self.dictSubView setObject:subView forKey:arrayTagLine2[i]] ;
        [subView reDraw];
    }
    
    //第三行
    for(int i=0 ; i < 2 ; i++) {
         ZiWeiItemView  *subView = [[ZiWeiItemView alloc] initWithFrame:viewRect] ;
        //subView.backgroundColor  = [UIColor blueColor] ;
        subView.layer.borderWidth = 1 ;
        subView.layer.borderColor = [[UIColor redColor] CGColor];
        subView.tag = [arrayTagLine3[i] intValue];
        [self.view addSubview:subView];
        
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(mainScreenWidth/4);
            make.height.mas_equalTo(mainScreenHeight/4) ;
            make.top.equalTo(thisView).offset(64 +  mainScreenHeight/4 *2  ) ;
            make.left.equalTo(thisView).offset(mainScreenWidth * 3/ 4 * i+ 0.5) ;
        }];
        
        subView.gongWeiID = arrayTagLine3[i];
        [self.dictSubView setObject:subView forKey:arrayTagLine3[i]] ;
        [subView reDraw];
    }
    
    //第四行
    for(int i=0 ; i < 4 ; i++) {
        ZiWeiItemView *subView = [[ZiWeiItemView alloc] initWithFrame:viewRect] ;
        subView.layer.borderWidth = 1 ;
        subView.layer.borderColor = [[UIColor redColor] CGColor];
        subView.tag = [arrayTagLine4[i] intValue];
        [self.view addSubview:subView];
        
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(mainScreenWidth/4);
            make.height.mas_equalTo(mainScreenHeight/4) ;
            make.top.equalTo(thisView).offset(64 +  mainScreenHeight/4 *3 ) ;
            make.left.equalTo(thisView).offset(mainScreenWidth / 4 * i+ 0.5) ;
        }];
        
        
        subView.gongWeiID = arrayTagLine4[i];
        [self.dictSubView setObject:subView forKey:arrayTagLine4[i]] ;
        [subView reDraw];
    }
}

//计算十二宫的名字
-(void) CaluSubViewGongName {
    CalcZiWei *ziWei = [[CalcZiWei alloc] init];
    
    ziWei.month = @6 ;
    ziWei.timeID = @6 ;
    
    NSDictionary* dict12Gong = [ziWei  CalcMingAndShengGong];
    for (int i=0 ; i< 12 ; i++) {
        NSNumber *pos = [NSNumber numberWithInteger:i] ;
        ZiWeiItemView *subView = self.dictSubView[pos] ;
        [subView setGongName:dict12Gong[pos]] ;
    }
    
   // [ziWei  calcWuXingJu:0]  ;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
