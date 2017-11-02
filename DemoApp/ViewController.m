//
//  ViewController.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/10/26.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()<UITabBarControllerDelegate>{
    NSInvocation *_invocation;
}

@property (nonatomic, strong) MainTabBarViewController *mainTabBarViewController;
@property (nonatomic, assign) BOOL hasPresentLoginViewController;
@end

@implementation ViewController

static ViewController *viewController = nil;
+(ViewController *)getMainViewController{
    return viewController;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    viewController=self;
    if (!_mainTabBarViewController) {
        self.mainTabBarViewController = [[MainTabBarViewController alloc] init];
        self.mainTabBarViewController.delegate = self;
        NSArray *viewControllers = @[_mainTabBarViewController];
        [self setViewControllers:viewControllers];
    }
    
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginClosed:) name:Notification_Login_Closed object:nil];
}

- (void)showLogin:(NSInvocation *)invocation animated:(BOOL)animated{
    
    if (self.hasPresentLoginViewController){
        return;
    }
    
    _invocation = invocation;

    
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication displayUIViewController] presentViewController:nav animated:animated completion:^{
        self.hasPresentLoginViewController = YES;
    }];
    
}

- (void)loginClosed:(NSNotification *)noti{
    _invocation = nil;
    self.hasPresentLoginViewController = NO;
    [[UIApplication displayUIViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (![MySingleton sharedSingleton].loginedIn) {
        [self showLogin:nil animated:YES];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
