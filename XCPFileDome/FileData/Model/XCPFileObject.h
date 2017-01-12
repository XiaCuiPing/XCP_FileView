//
//  XCPFileObject.h
//  XCPFileDome
//
//  Created by Apple on 2017/1/11.
//  Copyright © 2017年 夏翠萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCPFileObject : NSObject

@property(nonatomic, strong)NSString *fileName;//文件名
@property(nonatomic, strong)NSString *fileOwner;//所有人
@property(nonatomic, strong)NSDate *filemTime;//创建时间
@property(nonatomic, assign)NSInteger fileSize;

@end
