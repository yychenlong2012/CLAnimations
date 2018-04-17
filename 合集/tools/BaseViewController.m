//
//  BaseViewController.m
//  合集
//
//  Created by goat on 2017/12/13.
//  Copyright © 2017年 goat. All rights reserved.
//


#import "BaseViewController.h"
#import <Lottie/Lottie.h>


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip)];
    swip.numberOfTouchesRequired = 2;
    swip.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swip];
}

-(void)swip{
    [self dismissViewControllerAnimated:YES completion:nil];
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
