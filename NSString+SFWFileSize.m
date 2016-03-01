//
//  NSString+SFWFileSize.m
//  
//
//  Created by 沈方武 on 15/8/20.
//  Copyright (c) 2015年 SanMao-SF5. All rights reserved.
//

#import "NSString+SFWFileSize.h"

@implementation NSString (SFWFileSize)

- (NSInteger)fileSize{

    // 先判断文件是否存在
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL exist = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    if (exist == NO) return 0;
    
    // 判断是文件夹还是文件
    if (isDirectory) { // 是文件夹
        NSInteger size = 0;
        // 利用文件夹遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        // 遍历，获取文件全路径
        for (NSString *path in enumerator) {
            
            NSString *fullPath = [self stringByAppendingPathComponent:path];
            
            // 获得属性
            NSDictionary *dict = [mgr attributesOfItemAtPath:fullPath error:nil];
            // 过滤文件夹
            if ([dict[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
            
            size += [dict[NSFileSize] integerValue];
        }
        return size;
    }
    // 是文件
    return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
}

- (NSString *)fileSizeString{

    // 获得文件大小
    NSInteger fileSize = self.fileSize;
    CGFloat unit = 1000.0;
    
    if (fileSize >= unit * unit * unit) { // fileSize >= 1GB
        return [NSString stringWithFormat:@"%.1fGB", fileSize/(unit * unit * unit)];
    } else if (fileSize >= unit * unit) { // 1GB > fileSize >= 1MB
        return [NSString stringWithFormat:@"%.1fMB", fileSize/(unit * unit)];
    } else if (fileSize >= unit) { // 1MB > fileSize >= 1KB
        return [NSString stringWithFormat:@"%.1fKB", fileSize/ unit];
    } else { // 1KB > fileSize
        return [NSString stringWithFormat:@"%zdB", fileSize];
    }
}

@end
