//
//  ViewController.m
//  3DTouchPreviewDemo
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#define _ScreenWidth [UIScreen mainScreen].bounds.size.width
#define _ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *items;

@property (assign, nonatomic) CGRect sourceRect; //用户手势点

@property (strong, nonatomic) NSIndexPath *indexPath; //用户手势点

@end

@implementation ViewController

/*
 实现peek和pop手势：
 1、遵守协议 UIViewControllerPreviewingDelegate
 2、注册    [self registerForPreviewingWithDelegate:self sourceView:self.view];
 3、实现代理方法
 */


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadTableview];
    
    //注册Peek和Pop
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        /**
         *  这个判断的作用是检测当前设备是否支持 3D Touch
         */
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    
}

//加载tableview
-(void)loadTableview
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _ScreenWidth, _ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate= self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSArray *)items
{
    if (_items == nil)
    {
        _items = [[NSArray alloc]initWithObjects:@"第一条",@"第二条",@"第三条",@"第四条",@"第五条",@"第六条",nil];
    }
    return _items;
}

#pragma mark - tableViewDelage
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.items[indexPath.row];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        //给cell注册3d touch的peek（预览）和pop功能
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    else
    {
        NSLog(@"3D Touch 无效");
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了/pop第%zdcell",indexPath.row+1);
}

#pragma mark - peek&& pop代理
/** peek手势  */
-(nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取按压cell 的所在行，[previewingContext sourceView]就是按压的所在行
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    //设置不被虚化的范围
    CGRect rect = CGRectMake(0, 0, _ScreenWidth, 50);
    previewingContext.sourceRect = rect;
    
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    
    if(cell != nil ){
        
        DetailViewController *detailViewController = [[DetailViewController alloc] init];
        
        detailViewController.text = [NSString stringWithFormat:@"点击了第%zd个cell,预览图层，再用力按调用pop手势的代理方法", indexPath.row+1];
        
        return detailViewController;
        
    }
    
    return nil;
}

/** pop手势  */
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}


@end
