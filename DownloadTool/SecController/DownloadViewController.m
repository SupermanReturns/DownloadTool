//
//  DownloadViewController.m
//  DownloadTool
//
//  Created by Superman on 2018/7/18.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "DownloadViewController.h"
#import "DownloadingCell.h"
#import "DownloadedCell.h"
#import "DownloadManager.h"

@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource,DownloadDelegate>
@property (nonatomic, strong) UITableView *tableView ;

@property (atomic, strong) NSMutableArray *downloadObjectArr;


@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    // 更新数据源
    [self initData];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 70.0f;

}
- (void)initData
{
    NSMutableArray *downladed = [DownloadManager sharedInstance].downloadedArray;
    NSMutableArray *downloading = [DownloadManager sharedInstance].downloadingArray;
    _downloadObjectArr = @[].mutableCopy;
    [_downloadObjectArr addObject:downladed];
    [_downloadObjectArr addObject:downloading];
    
    [self.tableView reloadData];
}

#pragma mark - DownloadDelegate

- (void)downloadResponse:(SessionModel *)sessionModel
{
    if (self.downloadObjectArr) {
        // 取到对应的cell上的model
        NSArray *downloadings = self.downloadObjectArr[1];
        if ([downloadings containsObject:sessionModel]) {
            
            NSInteger index = [downloadings indexOfObject:sessionModel];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
            __block DownloadingCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            __weak typeof(self) weakSelf = self;
            sessionModel.progressBlock = ^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.progressLabel.text   = [NSString stringWithFormat:@"%@/%@ (%.2f%%)",writtenSize,totalSize,progress*100];
                    cell.speedLabel.text      = speed;
                    cell.progress.progress    = progress;
                    cell.downloadBtn.selected = YES;
                });
            };
            
            sessionModel.stateBlock = ^(DownloadState state){
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新数据源
                    if (state == DownloadStateCompleted) {
                        [weakSelf initData];
                        cell.downloadBtn.selected = NO;
                    }
                    // 暂停
                    if (state == DownloadStateSuspended) {
                        cell.speedLabel.text = @"已暂停";
                        cell.downloadBtn.selected = NO;
                    }
                });
            };
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.downloadObjectArr[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block SessionModel *downloadObject = self.downloadObjectArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        DownloadedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadedCell"];
        cell.sessionModel = downloadObject;
        return cell;
    }else if (indexPath.section == 1) {
        DownloadingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadingCell"];
        cell.sessionModel = downloadObject;
        [DownloadManager sharedInstance].delegate = self;
        cell.downloadBlock = ^(UIButton *sender) {
            [[DownloadManager sharedInstance] download:downloadObject.url progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {} state:^(DownloadState state) {}];
        };
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *downloadArray = _downloadObjectArr[indexPath.section];
    SessionModel * downloadObject = downloadArray[indexPath.row];
    // 根据url删除该条数据
    [[DownloadManager sharedInstance] deleteFile:downloadObject.url];
    [downloadArray removeObject:downloadObject];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[@"下载完成",@"下载中"][section];
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
