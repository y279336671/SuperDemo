//
//  Room.m
//  SuperDemo
//
//  Created by yanghe on 2021/5/25.
//  Copyright © 2021 yanghe. All rights reserved.
//

//输入 left  right
//输出00  10

//00  01  02  03
//10  11  12  13
//20  21  22  23
//30  31  32  33

#import "Room.h"

@interface Room()
@property(nonatomic,strong)NSArray<NSArray*>* rooms;

@property(nonatomic,assign)int left;
@property(nonatomic,assign)int right;
@end

@implementation Room

-(instancetype)init{
    if(self = [super init]){

        for (int m=0; m<10; m++) {
            for (int n=0; n<10; n++) {

            }
        }

        self.rooms = @[@[@"00",@"01",@"02",@"03"],
                       @[@"10",@"11",@"12",@"13"],
                       @[@"20",@"21",@"22",@"23"],
                       @[@"30",@"31",@"32",@"33"]];
    }
    return self;
}

-(void)firstRoomWithLeft:(int)left right:(int)right{

}

-(NSString*)fetchRoomNO:(int)leftOrRight{

}

@end
