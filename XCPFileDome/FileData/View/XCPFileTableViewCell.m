//
//  XCPFileTableViewCell.m
//  XCPFileDome
//
//  Created by Apple on 2017/1/11.
//  Copyright © 2017年 夏翠萍. All rights reserved.
//

#import "XCPFileTableViewCell.h"

@implementation XCPFileTableViewCell

@synthesize fileImage = _fileImage;
@synthesize titleLabel = _titleLabel;
@synthesize sizeLabel = _sizeLabel;
@synthesize timeLabel = _timeLabel;
@synthesize nameLabel = _nameLabel;

@synthesize dataList = _dataList;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
        
        [self addSubview:bgView];
        
        _fileImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [bgView addSubview:_fileImage];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, self.frame.size.width-160, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
        [bgView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-80, 10, 80, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:13.0];
        _timeLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
        [bgView addSubview:_timeLabel];
        
        _sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 60, 20)];
        _sizeLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
        _sizeLabel.font = [UIFont systemFontOfSize:12.0];
        [bgView addSubview:_sizeLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, 100, 20)];
        _nameLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        _nameLabel.font = [UIFont systemFontOfSize:12.0];
        [bgView addSubview:_nameLabel];
        
    }
    return self;
}

@end
