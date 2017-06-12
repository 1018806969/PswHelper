//
//  CDManager.h
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"


@interface CDManager : NSObject

+ (instancetype)shareCDManager;

- (void)insertRecordTitle:(NSString *)title username:(NSString *)username psw:(NSString *)psw remark:(NSString *)remark;

- (NSArray *)readRecord;

- (void)update;

- (void)deleteRecord:(Record *)record;

@end
