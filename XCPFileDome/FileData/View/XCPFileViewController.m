//
//  XCPFileViewController.m
//  XCPFileDome
//
//  Created by Apple on 2017/1/11.
//  Copyright © 2017年 夏翠萍. All rights reserved.
//

#import "XCPFileViewController.h"

@interface XCPFileViewController ()
{
    NSString *docDirs;
}

@end

@implementation XCPFileViewController
@synthesize tableView = _tableView;
@synthesize dataFileArray = _dataFileArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[XCPFileTableViewCell class] forCellReuseIdentifier:@"taskFileCell"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //在这里获取应用程序Documents文件夹里的文件及文件夹列表
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDirs = [paths objectAtIndex:0];
    NSError *error = nil;
    
    //_dataFileArray是包含有该文件夹下所有文件的文件名及文件夹名的数组
    _dataFileArray = [fileManager contentsOfDirectoryAtPath:docDirs error:&error];
    fileList = [NSMutableArray array];
    XCPFileObject *fileObj;
    for (NSString *name in _dataFileArray) {
        fileObj = [[XCPFileObject alloc] init];
        fileObj.fileName = name;
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:[docDirs stringByAppendingPathComponent:name] error:nil];
        fileObj.filemTime = [fileAttributes objectForKey:@"NSFileCreationDate"];
        fileObj.fileSize = [[fileAttributes objectForKey:@"NSFileSize"] integerValue];
        fileObj.fileOwner = [fileAttributes objectForKey:@"NSFileGroupOwnerAccountName"];
        
        [fileList addObject:fileObj];
    }
    
    //列出给定一个文件夹里的所有子文件夹名
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    
    for (NSString *file in _dataFileArray) {
        NSString *path = [docDirs stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:file];
        }
        isDir = NO;
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    //注意：此处要求的控制器，必须是它的页面view，已经显示在window之上了
    return self.navigationController;
}

#pragma mark - delegate   - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fileList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XCPFileObject *fileObj = (XCPFileObject *)[fileList objectAtIndex:indexPath.row];
    XCPFileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskFileCell" forIndexPath:indexPath];
    cell.titleLabel.text = fileObj.fileName;//文件名
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];//日期
    cell.timeLabel.text = [dateFormatter stringFromDate:fileObj.filemTime];
    
    //文件大小
    NSString *sizeStr;
    if (fileObj.fileSize > 1048576) {
        sizeStr = [NSString stringWithFormat:@"%.2fMB", (double)(fileObj.fileSize/1048576)];
    }else {
        sizeStr = [NSString stringWithFormat:@"%.2fKB", (double)(fileObj.fileSize/1024)];
    }
    
    cell.sizeLabel.text = sizeStr;
    //所有者
    cell.nameLabel.text = fileObj.fileOwner;
    
    NSArray *strDivision = [cell.titleLabel.text componentsSeparatedByString:@"."];
    NSString *strIntercept = [strDivision lastObject];
//    NSLog(@"%@",strIntercept);
    if ([strIntercept isEqualToString:@"plist"]) {
        cell.fileImage.image = [UIImage imageNamed:@"plista.png"];
    }
    else if ([strIntercept isEqualToString:@"doc"] || [strIntercept isEqualToString:@"docx"]) {
        cell.fileImage.image = [UIImage imageNamed:@"doc.png"];
    }
    else if ([strIntercept isEqualToString:@"html"]) {
        cell.fileImage.image = [UIImage imageNamed:@"htmlaa.png"];
    }
    else if ([strIntercept isEqualToString:@"ppt"] || [strIntercept isEqualToString:@"pptx"]) {
        cell.fileImage.image = [UIImage imageNamed:@"pptx.png"];
    }
    else if ([strIntercept isEqualToString:@"rar"] || [strIntercept isEqualToString:@"zip"]) {
        cell.fileImage.image = [UIImage imageNamed:@"zip.png"];
    }
    else if ([strIntercept isEqualToString:@"xls.png"] || [strIntercept isEqualToString:@"xlsx"]) {
        cell.fileImage.image = [UIImage imageNamed:@"xsl.png"];
    }
    else if ([strIntercept isEqualToString:@"txt1.png"]) {
        cell.fileImage.image = [UIImage imageNamed:@"txta.png"];
    }
    else if ([strIntercept isEqualToString:@"pdf1.png"])
    {
        cell.fileImage.image = [UIImage imageNamed:@"txta.png"];
    }
    else if ([strIntercept isEqualToString:@"png"] || [strIntercept isEqualToString:@"jpg"]) {
        //获取应用程序Documents文件夹里的文件及文件夹列表
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *strRoute = [NSString stringWithFormat:@"%@/%@",docDir,cell.titleLabel.text];
        cell.fileImage.image = [UIImage imageNamed:strRoute];
    }else
    {
        cell.fileImage.image = [UIImage imageNamed:@"ss.png"];
    }
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果是本地的，从本地删除；
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:docDir error:nil];
    
    // 移除tableView中的数据
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去除选中之后的效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *preview = [_dataFileArray objectAtIndex:indexPath.row];
    NSString *path = [docDirs stringByAppendingPathComponent:preview];
    
    //准备文档的Url
    _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
    [_documentController setDelegate:self];
    
    //当前APP打开  需实现协议方法才可以完成预览功能
    [_documentController presentPreviewAnimated:YES];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
