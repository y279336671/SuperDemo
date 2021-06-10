//
//  Room.h
//  SuperDemo
//
//  Created by yanghe on 2021/5/25.
//  Copyright © 2021 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CurrentRoom : NSObject
@property(nonatomic,assign)int type;// 1 正常 2 反向
@property(nonatomic,assign)int left;
@property(nonatomic,assign)int right;
@property(nonatomic,strong)id value;
@end


@interface Room : NSObject

-(NSString*)fetchRoomNO:(int)leftOrRight;


@end

NS_ASSUME_NONNULL_END
