//
//  DownloadedCell.h
//  DownloadTool
//
//  Created by Superman on 2018/7/18.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionModel.h"


@interface DownloadedCell : UITableViewCell

@property (strong, nonatomic)UILabel *fileNameLabel;

@property (strong, nonatomic)UILabel *sizeLabel;

@property (nonatomic, strong) SessionModel *sessionModel;

@end
