//
//  MilkViewController.m
//  合集
//
//  Created by goat on 2017/12/13.
//  Copyright © 2017年 goat. All rights reserved.
//

#import "MilkViewController.h"
#import "milkView.h"
#import "milkView2.h"

@interface MilkViewController ()<NSURLSessionDataDelegate>
@property (nonatomic,strong) NSMutableData *dataM;
@end

@implementation MilkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sss)];
    [self.view addGestureRecognizer:tap];
    
    milkView2 *view = [[milkView2 alloc] init];
    view.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 500);
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
    
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url];
    [task resume];
    
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
    
    
}


-(void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask
didReceiveResponse:(nonnull NSHTTPURLResponse *)response
completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"response = %@",response.suggestedFilename);
    NSLog(@"%ld",[response.allHeaderFields[@"Content-Length"] integerValue]);
    self.dataM = [NSMutableData data];
    //默认情况下不接收数据
    //必须告诉系统是否接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    //拼接服务器返回的数据
    [self.dataM appendData:data];
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    NSLog(@"请求完成或者是失败的时候调用");
    //解析服务器返回数据
    NSLog(@"%lu   %@", (unsigned long)self.dataM.length  ,[NSThread currentThread]);
    
    [session invalidateAndCancel];
//    self.dataM = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
}
-(void)dealloc
{
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
    NSLog(@"dealloc");
}

/*emoji
 
 -(NSString *)decodeUnicodeBytes:(char *)stringEncoded {
 unsigned int    unicodeValue;
 char            *p, buff[5];
 NSMutableString *theString;
 NSString        *hexString;
 NSScanner       *pScanner;
 
 theString = [[NSMutableString alloc] init];
 p = stringEncoded;
 
 buff[4] = 0x00;
 while (*p != 0x00) {
 
 if (*p == '\\') {
 p++;
 if (*p == 'u') {
 memmove(buff, ++p, 4);
 
 hexString = [NSString stringWithUTF8String:buff];
 pScanner = [NSScanner scannerWithString: hexString];
 [pScanner scanHexInt: &unicodeValue];
 
 [theString appendFormat:@"%C", (unichar)unicodeValue];
 p += 4;
 continue;
 }
 }
 
 [theString appendFormat:@"%c", *p];
 p++;
 }
 
 return [NSString stringWithString:theString];
 }
 */

@end
