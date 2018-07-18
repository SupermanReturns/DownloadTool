//
//  DownloadedCell.m
//  DownloadTool
//
//  Created by Superman on 2018/7/18.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "DownloadedCell.h"
#import "SessionModel.h"

@implementation DownloadedCell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
//    UILabel *fileNameLabel;
//    @property (weak, nonatomic)UILabel *sizeLabel;
    UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(27, 17, 31, 35)];
    im.image=[UIImage imageNamed:@"file"];
    [self.contentView addSubview:im];
    
    
    UILabel *fileNameLabel=[[UILabel alloc]init];
    fileNameLabel.numberOfLines=0;
    [self.contentView addSubview:fileNameLabel];
    _fileNameLabel=fileNameLabel;
    
    self.sizeLabel=[[UILabel alloc]init];
    
    [self.contentView addSubview:self.sizeLabel];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _fileNameLabel.frame=CGRectMake(75, 27, 55, 16);
    _sizeLabel.frame=CGRectMake(93, 45, 42, 16);
}
-(void)setSessionModel:(SessionModel *)sessionModel
{
    _sessionModel = sessionModel;
    self.fileNameLabel.text = sessionModel.fileName;
    self.sizeLabel.text = sessionModel.totalSize;
    
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



















