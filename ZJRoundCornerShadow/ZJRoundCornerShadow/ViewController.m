//
//  ViewController.m
//  ZJRoundCornerShadow
//
//  Created by gleen on 2016/12/7.
//  Copyright © 2016年 gleen. All rights reserved.
//

#import "ViewController.h"

//物理屏幕尺寸
#define MAIN_SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define MAIN_SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width

//定义UIImage对象
#define ZJ_IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect = CGRectMake(30, 84, MAIN_SCREEN_WIDTH-60, MAIN_SCREEN_HEIGHT - 84-69);
    //初始化UIImageView，并添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:ZJ_IMAGE(@"beautyGirl.jpg")];
    
    //调用阴影效果设置的方法
    UIView *shadow = [self getViewShadow:imageView withFrame:rect shadowColor:[UIColor greenColor] shadowOffset:CGSizeMake(5, 5) shadowOpacity:0.4 shadowRadius:5 cornerRadius:15 clipsToBounds:NO];
    //shadowOffset设置方法：左、上（-x,-y）；左、下（-x,y）右上（x,-y）;右、下（x,y）;(0,0)表示四边都阴影；一边为0 时有三边有阴影
    
    //添加到父视图上
    [self.view addSubview:shadow];
    
    //给图片上添加毛玻璃效果
    //1.创建毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //2.创建毛玻璃视图
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
    //3.设置毛玻璃视图的大小
    [visualView setFrame:CGRectMake(0, imageView.bounds.size.height/2, imageView.bounds.size.width, imageView.bounds.size.height/2)];
    //4.将毛玻璃视图添加到图片的view上
    [imageView addSubview:visualView];
    
}


- (UIView *)getViewShadow:(UIView *)setView withFrame:(CGRect)frame
              shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset
            shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius
             cornerRadius:(CGFloat)cornerRadius  clipsToBounds:(BOOL)clipsToBounds {
    //给视图设置圆角
    CALayer *layer = [setView layer];
    [layer setMasksToBounds:YES];//这个tMasksToBounds  设置为YES
    [layer setCornerRadius:cornerRadius];//设置需要设置的视图setView圆角圆角半径
    
    //给视图设置阴影，
    //1.创建一个视图设置他的阴影样式，注意这个frame和需要的setView的frame一样大小
    //***层级是   ： setView在shadow之上  ---->  [shadow addSubview:setView]  ***//
    UIView *shadow = [[UIView alloc] initWithFrame:frame];//初始化一个视图并设置frame
    shadow.layer.shadowColor =shadowColor.CGColor;//设置阴影颜色
    shadow.layer.shadowOffset = shadowOffset;//设置阴影的位移
    shadow.layer.shadowOpacity = shadowOpacity;//设置阴影的透明度
    shadow.layer.shadowRadius = shadowRadius;//设置阴影的圆角半径
    shadow.layer.cornerRadius = cornerRadius;//设置该视图的圆角半径
    shadow.clipsToBounds = clipsToBounds;
    //！！！注意要重新设置需要添加的视图shadow的frame和阴影视图shadow保持一样大小
    setView.frame = shadow.bounds;
    //将需要设置的视图setView添加到阴影视图shadow上
    [shadow addSubview:setView];
    return shadow;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
