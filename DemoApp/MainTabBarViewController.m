//
//  MainTabBarViewController.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/10/27.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "CustomeTabBar.h"

@interface MainTabBarViewController ()<ZTTabBarDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController *home = [[UIViewController alloc] init];
    [self setupChildViewController:home title:@"首页" image:@"tab_home" selectedImage:@"tab_home_pressed"];
    UIViewController *service = [[BaseViewController alloc] init];
    [self setupChildViewController:service title:@"服务" image:@"tab_home" selectedImage:@"tab_home_pressed"];
    UIViewController *distribution = [[BaseViewController alloc] init];
    [self setupChildViewController:distribution title:@"发布" image:@"" selectedImage:@""];
    UIViewController *find = [[BaseViewController alloc] init];
    [self setupChildViewController:find title:@"发现" image:@"tab_home" selectedImage:@"tab_home_pressed"];
    UIViewController *mine = [[BaseViewController alloc] init];
    [self setupChildViewController:mine title:@"我的" image:@"tab_home" selectedImage:@"tab_home_pressed"];
    
    CustomeTabBar *tabBar = [[CustomeTabBar alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        //去掉黑线
        [tabBar setShadowImage:[UIImage imageWithColor:[UIColor redColor]]];
        [tabBar setBackgroundImage:[UIImage new]];
    }

    //取消tabBar的透明效果
    tabBar.translucent = NO;
    tabBar.myDelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupChildViewController:(UIViewController *)controller
                           title:(NSString *)title
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage{
    NSDictionary *normalAttribute = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor blueColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:12.0f],NSFontAttributeName,nil];
    NSDictionary *selectAttribute = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor redColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:12.0f],NSFontAttributeName,nil];
   
    controller.tabBarItem.title = title;
    controller.title = title;
    
    
    UIImage *normalImage = [UIImage imageNamed:image];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.image = normalImage;
    
    UIImage *highlightImage = [UIImage imageNamed:selectedImage];
    highlightImage = [highlightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = highlightImage;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [nav.tabBarItem setTitleTextAttributes:normalAttribute forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:selectAttribute forState:UIControlStateSelected];
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1,0,1,0);
    [nav.tabBarItem setTitlePositionAdjustment: UIOffsetMake(0,-1)];
    //造图 （去掉导航栏下面的线）
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 3);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *imagea = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [nav.navigationBar setShadowImage:imagea];
    
    [self addChildViewController:nav];
    
}

- (void)tabBarDidClickPlusButton:(CustomeTabBar *)tabBar{
    NSLog(@"+++++");
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
       return [self.delegate tabBarController:tabBarController shouldSelectViewController:viewController];
    }
    return NO;
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
