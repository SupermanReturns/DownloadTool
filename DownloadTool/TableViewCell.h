//
//  TableViewCell.h
//  DownloadTool
//
//  Created by Superman on 2018/7/18.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^downloadCallBack)(void);

@interface TableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *downloadBtn;


@property (nonatomic, copy)downloadCallBack downloadCallBack;

@end
