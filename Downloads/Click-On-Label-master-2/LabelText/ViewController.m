//
//  ViewController.m
//  LabelText
//
//  Created by 吴狄 on 16/9/5.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "ViewController.h"
#import "LWLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *str =@"刘文回复彭刚涛:你在搞么斯啊?";
    CGFloat height = [str boundingRectWithSize:CGSizeMake(375, 200) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    LWLabel *lab=[[LWLabel alloc]initWithFrame:CGRectMake(30, 200, 300, height)];
    lab.text=str;
    lab.font = [UIFont systemFontOfSize:17];
    
    lab.rangeArr=(id)@[NSStringFromRange(NSMakeRange(0, 2)),NSStringFromRange(NSMakeRange(4, 3))];
    lab.selectBlobk=^(NSString *str,NSRange range){
        NSLog(@"%@",str);
    };
    [self.view addSubview:lab];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
