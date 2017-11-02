//
//  BaseViewController.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "BaseViewController.h"
#define BACK_BUTTON_WIDTH 40

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize backButton,navigtionBar,contentView;

- (instancetype)init{
    if (self = [super init]) {
        contentView=[[UIView alloc]initWithFrame:CGRectMake(0, iPhoneInfo().NavigationBarHeight, ScreenWidth, ScreenHeight-iPhoneInfo().NavigationBarHeight)];
    }
    return self;
}

//设置导航条是否透明
-(void)setNavigtionBarTransparent:(BOOL)_transparent{
    if(_transparent){
        navigtionBar.backgroundImage.hidden=YES;
        navigtionBar.lineView.hidden = YES;
    }else{
        navigtionBar.backgroundImage.hidden=NO;
        navigtionBar.lineView.hidden = NO;
    }
}

- (UIColor *)titleColor
{
    
        return [UIColor blackColor];
    
}

- (UIImage *)backImage
{
   
        return [UIImage imageNamed:@"navigtionbar_back"];
   
}

//添加返回按钮
- (void)addBackButton:(NSString *)_titleStr{
    // 设置返回btn
    UIColor *titleColor = [self titleColor];
    UIImage *backImage = [self backImage];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, iPhoneInfo().StatusBarHeight, BACK_BUTTON_WIDTH , 44);
    [backButton addTarget:self action:@selector(backBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateHighlighted];
    [backButton setTitleColor:titleColor forState:UIControlStateNormal];
    [backButton setTitleColor:titleColor forState:UIControlStateHighlighted];
    backButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    backButton.titleLabel.backgroundColor = [UIColor clearColor];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    
    CGSize titleSize = VD_MULTILINE_TEXTSIZE(_titleStr, backButton.titleLabel.font, CGSizeMake(CGFLOAT_MAX, 16), backButton.titleLabel.lineBreakMode);
    backButton.frame = CGRectMake(0, iPhoneInfo().StatusBarHeight, BACK_BUTTON_WIDTH + titleSize.width, 44);
    
    [navigtionBar addSubview:backButton];
    [self setBackTitle:_titleStr];
    
   
    
}
//设置返回按钮文字
-(void)setBackTitle:(NSString *)_titleStr{
    [backButton setTitle:_titleStr forState:UIControlStateNormal];
    [backButton setTitle:_titleStr forState:UIControlStateHighlighted];
    CGSize titleSize = VD_MULTILINE_TEXTSIZE(_titleStr, backButton.titleLabel.font, CGSizeMake(CGFLOAT_MAX, 16), backButton.titleLabel.lineBreakMode);
    backButton.frame = CGRectMake(0, iPhoneInfo().StatusBarHeight, BACK_BUTTON_WIDTH + titleSize.width, 44);
    
}

-(void)backBtnEvent:(id)_sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTitle:(NSString *)title
{
    super.title = title;
    
    self.navigtionBar.titleText.text = title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (contentView == nil) {
        contentView=[[UIView alloc]initWithFrame:CGRectMake(0, iPhoneInfo().NavigationBarHeight, ScreenWidth, ScreenHeight-iPhoneInfo().NavigationBarHeight)];
    }
    [contentView setBackgroundColor:[UIColor colorFromHexCode:@"eeeeee"]];
    [self.view addSubview:contentView];
    navigtionBar=[[HJNavigtionBar alloc]init];
    [self.view addSubview:navigtionBar];
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
