//
//  XCPFileViewController.h
//  XCPFileDome
//
//  Created by Apple on 2017/1/11.
//  Copyright © 2017年 夏翠萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCPFileObject.h"
#import "XCPFileTableViewCell.h"


@interface XCPFileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UIDocumentInteractionControllerDelegate>
{
    NSMutableArray *fileList;
    UIDocumentInteractionController *_documentController; //文档交互控制器
}

@property(nonatomic, strong)NSArray *dataFileArray;
@property(nonatomic, strong)UITableView *tableView;

@end
