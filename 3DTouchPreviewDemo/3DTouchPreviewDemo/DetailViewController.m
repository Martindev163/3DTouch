//
//  DetailViewController.m
//  3DTouchPreviewDemo
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getHome) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height)];
    textView.font = [UIFont systemFontOfSize:24];
    textView.text = self.text;
    [bgView addSubview:textView];
    
}

-(void)getHome
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    UIPreviewAction *itemShare = [UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享" message:@"分享内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertView show];
        
    }];
    
    return @[itemShare];
    
}

@end
