//
//  DownloadingCell.h
//  DownloadTool
//
//  Created by Superman on 2018/7/18.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DownloadManager.h"
#import "DownloadManager.h"

#import "SessionModel.h"



typedef void(^DownloadBlock)(UIButton *);

@interface DownloadingCell : UITableViewCell
@property (nonatomic, copy  ) DownloadBlock downloadBlock;
@property (nonatomic, strong) SessionModel  *sessionModel;


@property(nonatomic,strong)UILabel *fileNameLabel;
@property(nonatomic,strong)UIProgressView *progress;
@property(nonatomic,strong) UILabel *progressLabel;
@property(nonatomic,strong)UILabel *speedLabel;
@property(nonatomic,strong)UIButton *downloadBtn;


@end
