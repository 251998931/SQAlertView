//
//  ViewController.m
//  SQAlertView
//
//  Created by shu on 15/8/20.
//  Copyright (c) 2015年 shu. All rights reserved.
//

#import "ViewController.h"
#import "SQAlertView.h"

@interface ViewController ()<SQAlertViewDelegate>

@property(nonatomic,strong)SQAlertView* alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(150, 150, 50, 50)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)click
{
   NSString* message = @"北京时间8月21日消息，迪亚曼蒂和吉拉迪诺两位前意大利国脚成为广州恒大目前急于甩掉的包袱，前者已经租借加盟英超升班马沃特福德，而吉拉迪诺也即将离开。意甲巴勒莫队主席赞帕里尼昨日接受采访时透露，吉拉迪诺即将以租借形式加盟，目前仅剩一些合同细节等待确认";

    self.alertView = [[SQAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds Tittle:@"这是标题" TittleFont:[UIFont systemFontOfSize:17] tittleColor:[UIColor redColor] message:message messageFont:[UIFont systemFontOfSize:15] meaageColor:[UIColor blueColor] attriButedRange:NSMakeRange(0, 1) attriButedColor:[UIColor lightGrayColor] cancelTitle:@"取消" cancelTitleColor:[UIColor blackColor] cancelFont:[UIFont systemFontOfSize:13] otherTitles: [NSArray arrayWithObjects:@"确定",@"查看",@"啊哈哈",nil] otherTitlesColor:[NSArray arrayWithObjects:[UIColor greenColor],[UIColor orangeColor],[UIColor redColor],nil] otherFont:[UIFont systemFontOfSize:13] delegate:self];
    
    [self.view addSubview:self.alertView];

}
#pragma mark - SQAlertViewDelegate
//取消按钮点击事件
-(void)sqAlertViewCancleBtnClick:(SQAlertView *)alertView
{
    
    [self.alertView viewDismiss];
}
//有两个按钮时，除了“取消”按钮，另一个按钮的点击事件
-(void)sqAlertViewAnotherBtnClick:(SQAlertView *)alertView
{
    NSLog(@"另一个按钮");
}
//有两个以上按钮时，其他按钮的点击事件
-(void)sqAlertViewOtherBtnsClick:(SQAlertView *)alertView otherBtnsIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"第%d按钮被点击",index);
            break;
        
        case 1:
             NSLog(@"第%d按钮被点击",index);
            break;
        
        case 2:
             NSLog(@"第%d按钮被点击",index);
            break;
        case 3:
             NSLog(@"第%d按钮被点击",index);
            break;
            
        default:
            break;
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
