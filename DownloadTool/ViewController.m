//
//  ViewController.m
//  DownloadTool
//
//  Created by Superman on 2018/7/17.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "DownloadManager.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray       *dataSource;

@property (nonatomic, strong) UITableView *tableView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"下载列表";
    self.tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
//    self.tableView.selectst
    [self.view addSubview:self.tableView];
    
    self.dataSource = @[@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.2.4.dmg",
                        @"http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
                        @"http://baobab.wdjcdn.com/14525705791193.mp4",
                        @"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
                        @"http://baobab.wdjcdn.com/1455968234865481297704.mp4"].mutableCopy;
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = self.dataSource[indexPath.row];
    __block NSIndexPath *blockIndexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    cell.downloadCallBack = ^{
        
        NSString *urlString = self.dataSource[blockIndexPath.row];
        [[DownloadManager sharedInstance] download:urlString progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([weakSelf.dataSource containsObject:urlString]) {
                    [weakSelf.dataSource removeObjectAtIndex:blockIndexPath.row];
                    [weakSelf.tableView deleteRowsAtIndexPaths:@[blockIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [weakSelf.tableView reloadData];
                }
            });
        } state:^(DownloadState state) {}];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
