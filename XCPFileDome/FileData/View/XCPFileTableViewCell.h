//
//  XCPFileTableViewCell.h
//  XCPFileDome
//
//  Created by Apple on 2017/1/11.
//  Copyright © 2017年 夏翠萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCPFileTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *fileImage;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *sizeLabel;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)NSDictionary *dataList;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
