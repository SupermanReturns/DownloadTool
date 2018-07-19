//
//  TableViewCell.m
//  DownloadTool
//
//  Created by Superman on 2018/7/18.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "TableViewCell.h"
#import "UIView+Addition.h"


@implementation TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];

    }
    return self;
}
-(void)setupUI{
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.numberOfLines=0;
    [self.contentView addSubview:titleLabel];
    _titleLabel=titleLabel;
    
    self.downloadBtn=[[UIButton alloc]init];
    [self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    self.downloadBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.downloadBtn.titleLabel.textColor=[UIColor blackColor];
    self.downloadBtn.tintColor=[UIColor blackColor];
    
    
    [self.downloadBtn addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.downloadBtn];
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _downloadBtn.frame=CGRectMake(self.width-50, 10, 50, 40);
//    [self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];

    _titleLabel.frame=CGRectMake(20, 17, _downloadBtn.left-20, 18);
//    _downloadBtn.frame=CGRectMake(85, 11, 30, 30);
    
}
-(void)downloadAction{
    if (self.downloadCallBack) {
        self.downloadCallBack();
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
