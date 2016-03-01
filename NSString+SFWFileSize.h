//
//  NSString+SFWFileSize.h
//  
//
//  Created by 沈方武 on 15/8/20.
//  Copyright (c) 2015年 SanMao-SF5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SFWFileSize)

/**
 *  用路径对象调用此方法，返回路径文件的大小
 */
- (NSInteger)fileSize;


/**
 *  用文件路径调用，返回格式化的大小
 */
- (NSString *)fileSizeString;

@end
