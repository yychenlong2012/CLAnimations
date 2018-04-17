//
//  emitterViewController.m
//  合集
//
//  Created by goat on 2018/3/29.
//  Copyright © 2018年 goat. All rights reserved.
//

#import "emitterViewController.h"
#import "UIImage+Additions.h"
#import "UIView+GestureCallback.h"

@interface emitterViewController ()
@property (nonatomic,strong) CAEmitterLayer *emitterLayer;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UIView *emitterView;
@end

@implementation emitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
//    [self ssss];
    [self.view addSubview:self.imageview];
    
    [self.view addSubview:self.emitterView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 0, 100, 100);
    [btn2 addTarget:self action:@selector(tap2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
//    __weak typeof(self) wself = self;
//    self.imageview.userInteractionEnabled = YES;
//    [self.imageview addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
//        wself.imageview.image = [UIImage imageNamed:@"2"];
//        CATransition *anim = [CATransition animation];
//        anim.duration = 2;
//
//        //anim.type = @"cube";
//        //anim.type = @"push";
//        //anim.type = @"suckEffect"; //额这个效果就是右下角变小然后整张图移到左上角消失
//        //    anim.type = @"oglFlip"; //绕中心翻转
//        anim.type = @"rippleEffect"; //文本抖动了一下 水滴
//        //  anim.type = @"p7ageCurl"; //淡入淡出
//        //    anim.type = @"pageUnCurl"; //翻书的效果
//        //   anim.type = @"cameraIrisHollowClose"; //相机关闭
//        //    anim.type = @"cameraIrisHollowOpen"; //类似相机照相效果
//
//        [wself.imageview.layer addAnimation:anim forKey:nil];
//    }];
    
}

-(void)tap{
    [self.emitterView.layer addSublayer:self.emitterLayer];
}
-(void)tap2{
    self.imageview.image = [UIImage imageNamed:@"2"];
    CATransition *anim = [CATransition animation];
    anim.duration = 2;
    
    anim.type = @"rippleEffect"; //文本抖动了一下 水滴
    
    [self.imageview.layer addAnimation:anim forKey:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(UIImageView *)imageview{
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc] init];
        _imageview.frame = CGRectMake(0, 0, 360, 480);
        _imageview.center = self.view.center;
        _imageview.image = [UIImage imageNamed:@"1"];
    }
    return _imageview;
}

-(UIView *)emitterView{
    if (_emitterView == nil) {
        _emitterView = [[UIView alloc] init];
        _emitterView.backgroundColor = [UIColor clearColor];
        _emitterView.frame = self.view.bounds;
    }
    return _emitterView;
}


-(CAEmitterLayer *)emitterLayer{
    if (_emitterLayer == nil) {
        _emitterLayer = [CAEmitterLayer layer];
//        _emitterLayer.borderColor = [UIColor redColor].CGColor;
//        _emitterLayer.borderWidth = 1.f;
        _emitterLayer.position = CGPointMake(self.view.bounds.size.width, 0);
        _emitterLayer.emitterSize = self.view.bounds.size;
        _emitterLayer.emitterShape = kCAEmitterLayerCircle;
        _emitterLayer.emitterMode = kCAEmitterLayerLine;
        
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.contents = (__bridge id)([self createCircle].CGImage);
        
        emitterCell.birthRate = 20.f;
        emitterCell.lifetime = 10.f;
        emitterCell.velocity = 30.f;
        emitterCell.velocityRange = 60.f;
        emitterCell.yAcceleration = 15.f;
        
        emitterCell.emissionLongitude = M_PI;
        emitterCell.emissionRange = M_PI_4;
        
        emitterCell.scale = 0.1;
        emitterCell.scaleRange = 0.2;
        emitterCell.scaleSpeed = 0.02;
        
//        emitterCell.color = [UIColor colorWithRed:.5f green:.5f blue:.5f alpha:1.f].CGColor;
        emitterCell.color = [UIColor colorWithRed:.8f green:.8f blue:.8f alpha:1.f].CGColor;

        emitterCell.redRange = 1.f;
        emitterCell.greenRange = 1.f;
        emitterCell.blueRange = 1.f;
        
        emitterCell.alphaRange = .8f;
        emitterCell.alphaSpeed = -.1f;
        
        _emitterLayer.emitterCells = @[emitterCell];
    }
    return _emitterLayer;
}


-(UIImage *)createCircle{
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    image = [self circleImage:image withParam:0];
    return image;
}


///把图片裁剪成圆形
//两个参数 image: 需要修改的图片
//inset: 内部偏移
-(UIImage *) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillPath(context);
    CGContextSetLineWidth(context, .5);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


//栗子系统🌰
-(void)ssss{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width, emitter.frame.size.height / 2.0);  //发射形状中点
    //    emitter.emitterZPosition = 5;
    emitter.emitterSize = CGSizeMake(300, 300);     //发射形状大小
    //    emitter.emitterDepth = 5;
    emitter.emitterShape = kCAEmitterLayerPoint;     //是粒子从什么形状发射出来，它并不是表示粒子自己的形状
    emitter.emitterMode = kCAEmitterLayerPoints;      //决定发射的区域是在发射形状的哪一部份  发射模式
    //    emitter.renderMode = kCAEmitterLayerAdditive;   //栗子叠加部分的 重叠方式
    //    emitter.preservesDepth = YES;
    //    emitter.scale = 0.5;                           //尺寸比例   设置有效
    //    emitter.spin = M_PI_4/4.0;                     //栗子旋转
    //    emitter.seed
    
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)([self createCircle].CGImage);     //cell的基本大小由图片大小控制
    
    
    cell.birthRate = 20;         //每秒产生的对象数
    cell.lifetime = 5.0;         //栗子的显示时间
    cell.lifetimeRange = 3.0;    // ±浮动区间
    //    cell.emissionLatitude = -M_PI_2;
    cell.emissionLongitude = M_PI;  //发射角度  粒子飞行方向跟水平坐标轴（x轴）之间的夹角
    cell.emissionRange = M_PI_4;  //发射的范围 以emissionLatitude的角度为中心的2*emissionRange的扇形区域
    cell.velocity = 40;        //每个发射物体的初始平均速度
    cell.velocityRange = 20;   //
    //    cell.xAcceleration = 150;
    cell.yAcceleration = 10;
    //    cell.zAcceleration = 150;
    cell.scale = 0.1;
    cell.scaleRange = 0.2;
    cell.scaleSpeed = 0.02;
    //    cell.spin = M_PI_4/4.0;
    //    cell.spinRange = M_PI_4/8.0;
    cell.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0].CGColor;
    cell.redRange = 0.2;
    cell.greenRange = 0.2;
    cell.blueRange = 0.2;
    cell.alphaRange = 0.3;
    cell.redSpeed = -0.05;
    cell.greenSpeed = -0.05;
    cell.blueSpeed = -0.05;
    cell.alphaSpeed = -0.1;
    
    emitter.emitterCells = @[cell];
}
@end
