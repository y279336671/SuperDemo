//
//  CYLUser.h
//  SuperDemo
//
//  Created by admin on 2020/11/23.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//typedef enum{
//    UserSex_Man,
//    UserSex_Woman
//}UserSex;

typedef NS_ENUM(NSInteger,CYLSex){
    CYLSexMan,
    CYLSexWoman
};
@interface CYLUser : NSObject
//@property(nonatomic, strong) NSString *name;
@property(nonatomic, copy) NSString *name;
//@property(nonatomic, assign) int age;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) CYLSex sex;
//-(id)initUserModelWithUserName:(NSString *)name withAge:(int)age;
-(instancetype)initWithName:(NSString *)name age:(NSInteger)age sex:(CYLSex)sex;
//-(void)doLogIn;
@end

NS_ASSUME_NONNULL_END
