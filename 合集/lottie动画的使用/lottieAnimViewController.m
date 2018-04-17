//
//  lottieAnimViewController.m
//  合集
//
//  Created by goat on 2017/12/14.
//  Copyright © 2017年 goat. All rights reserved.
//

#import "lottieAnimViewController.h"
#import <Lottie/Lottie.h>

@interface lottieAnimViewController ()

@end

@implementation lottieAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LOTAnimationView *animView = [LOTAnimationView animationNamed:@"A"];
    animView.frame = CGRectMake(100, 100, 50, 50);
    animView.backgroundColor = [UIColor yellowColor];
    animView.animationSpeed = 0.5;
    animView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animView];
    [animView play];
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
