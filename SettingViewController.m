//
//  SettingViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingBaseCell.h"
#import "SettingFunctionCell.h"

#define kDocument_Folder1 [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/com.hackemist.SDWebImageCache.default"]
#define kDocument_Folder2 [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Jary.Poor-Travel"]

@interface SettingViewController () <UIAlertViewDelegate> {
    NSMutableArray * _sectionNamesArr;
}

@end

@implementation SettingViewController

- (void)createSearchBar {

}

- (void)myDataInit {
    NSArray * section1titles = @[@"穷游账号",@"立即更新到最新版本",@"关于穷游",@"清除缓存"];
    [_dataArr addObject:section1titles];
    
    NSArray * section2titles = @[@"绑定新浪微博",@"只在WIFI环境下下载锦囊",@"聊天室消息提醒",@"私信提醒"];
    [_dataArr addObject:section2titles];
    
    NSArray * section3titles = @[@"意见反馈",@"评价我们",@"应用分享",@"推荐应用"];
    [_dataArr addObject:section3titles];
    
    _sectionNamesArr = [[NSMutableArray alloc] initWithObjects:@"基本设置",@"功能设置",@"其他", nil];
    
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64 - 49);
    [self myDataInit];
    // Do any additional setup after loading the view.
}

- (NSString *)cacheCalculate {
    NSArray * url = @[kDocument_Folder1,kDocument_Folder2];
    
    NSNumber * total;
    float totalSize;
    for (int i = 0; i < 2; i++) {
        NSFileManager * fm = [NSFileManager defaultManager];
        NSArray * fileList = [fm contentsOfDirectoryAtPath:url[i] error:nil];
        NSString * path;
        const unsigned int bytes = 1024 * 1024;
        float size = 0.0;
        for (NSString * file in fileList) {
            path = [url[i] stringByAppendingPathComponent:file];
            NSDictionary * fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
            size = size + (float)[fileAttributes fileSize];
        }
        totalSize += size/bytes;
        total = [NSNumber numberWithFloat:totalSize];
    }
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setPositiveFormat:@"##0.0"];
    return [NSString stringWithFormat:@"%@MB",[formatter stringFromNumber:total]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        SettingFunctionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettingFunctionCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingFunctionCell" owner:self options:nil]lastObject];
        }
        cell.titleLabel.text = _dataArr[indexPath.section][indexPath.row];
      
        return cell;
    } else {
        SettingBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettingBaseCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingBaseCell" owner:self options:nil]lastObject];
        }
        cell.titleLabel.text = _dataArr[indexPath.section][indexPath.row];
        
        if (indexPath.section == 0 && indexPath.row == 3) {
            cell.subTitle.text = [self cacheCalculate];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要清楚缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
}

#pragma mark alertViewDelegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSFileManager * fileManager = [NSFileManager defaultManager];
        
        NSLog(@"kDocument_Folder1 : %@",kDocument_Folder1);
        NSLog(@"kDocument_Folder2 : %@",kDocument_Folder2);
        
        [fileManager removeItemAtPath:kDocument_Folder1 error:nil];
        [fileManager removeItemAtPath:kDocument_Folder2 error:nil];
        
        [_tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionNamesArr[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionNamesArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr[section] count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
