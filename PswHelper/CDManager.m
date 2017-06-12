//
//  CDManager.m
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "CDManager.h"
#import <CoreData/CoreData.h>

static NSString *const EntityName = @"Record";

@interface CDManager()

@property (nonatomic, readwrite, strong) NSManagedObjectContext *context;

@end
@implementation CDManager

+ (instancetype)shareCDManager
{
    static CDManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[CDManager alloc] init];
    });
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"CoreData" withExtension:@"momd"];
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSURL *sqliteURL = [[self documentDirectoryURL] URLByAppendingPathComponent:@"CoreData.sqlite"];
        NSError *error = nil;
        [psc addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:sqliteURL
                                                        options:nil
                                                          error:&error];
        if (error) {
            NSLog(@"falied to create persistentStoreCoordinator %@", error.localizedDescription);
        }

        _context = [[NSManagedObjectContext alloc ] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = psc;
    }
    return self;
}
- (void)insertRecordTitle:(NSString *)title username:(NSString *)username psw:(NSString *)psw remark:(NSString *)remark
{
    Record *record = [NSEntityDescription insertNewObjectForEntityForName:EntityName inManagedObjectContext:_context];
    record.title = title;
    record.username = username;
    record.psw = psw;
    record.remark = remark;
    [_context save:nil];
}
- (NSArray *)readRecord
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityName inManagedObjectContext:_context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entity];
    NSArray *records = [_context executeFetchRequest:request error:nil];
    return records;
}
- (void)update
{
    [_context save:nil];
}
- (void)deleteRecord:(Record *)record
{
    [_context deleteObject:record];
    [_context save:nil];
}



- (nullable NSURL *)documentDirectoryURL {
//    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]];
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}
@end
