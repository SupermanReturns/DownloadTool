//
//  DownloadingCell.m
//  DownloadTool
//
//  Created by Superman on 2018/7/18.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "DownloadingCell.h"
#import "UIView+Addition.h"


@implementation DownloadingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

-(void)setupUI{
    
    UILabel *fileNameLabel=[[UILabel alloc]init];
    [self.contentView addSubview:fileNameLabel];
    _fileNameLabel=fileNameLabel;
    
    UIProgressView *progress=[[UIProgressView alloc]init];
    [self.contentView addSubview:progress];
    _progress=progress;
    
    UILabel *progressLabel=[[UILabel alloc]init];
    [self.contentView addSubview:progressLabel];
    _progressLabel=progressLabel;
    
    UILabel *speedLabel=[[UILabel alloc]init];
    [self.contentView addSubview:speedLabel];
    _speedLabel=speedLabel;
    
    UIButton *downloadBtn=[[UIButton alloc]init];
    [self.contentView addSubview:downloadBtn];
    _downloadBtn=downloadBtn;
    
    self.downloadBtn.clipsToBounds = true;
    [self.downloadBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.downloadBtn setTitle:@"🕘" forState:UIControlStateNormal];
    [self.downloadBtn addTarget:self action:@selector(clickDownload:) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadBtn setTitle:@"↓" forState:UIControlStateSelected];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _fileNameLabel.frame=CGRectMake(15, 8, self.width-30, 16);
    _downloadBtn.frame=CGRectMake(self.width-60,14 , 40, 40);

    _progress.frame=CGRectMake(15,_fileNameLabel.bottom+9 , self.downloadBtn.left-10, 2);
    
    _speedLabel.frame=CGRectMake(_downloadBtn.left-60, _progress.bottom+10, 50, 16);

    _progressLabel.frame=CGRectMake(15, _progress.bottom+10, _speedLabel.left-10, 16);
}
-(void)setSessionModel:(SessionModel *)sessionModel
{
    _sessionModel = sessionModel;
    self.fileNameLabel.text = sessionModel.fileName;
    NSUInteger receivedSize = DownloadLength(sessionModel.url);
    NSString *writtenSize = [NSString stringWithFormat:@"%.2f %@",
                             [sessionModel calculateFileSizeInUnit:(unsigned long long)receivedSize],
                             [sessionModel calculateUnit:(unsigned long long)receivedSize]];
    CGFloat progress = 1.0 * receivedSize / sessionModel.totalLength;
    self.progressLabel.text = [NSString stringWithFormat:@"%@/%@ (%.2f%%)",writtenSize,sessionModel.totalSize,progress*100];
    self.progress.progress = progress;
    self.speedLabel.text = @"已暂停";
}
-(void)clickDownload:(UIButton *)sender{
    if (self.downloadBlock) {
        self.downloadBlock(sender);
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
