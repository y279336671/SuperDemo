//
//  TBCToolsItemBaseViewProtocol.h
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/5.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class TBCToolsItemBaseView;

@protocol TBCToolsItemBaseViewDelegate <NSObject>

//@required
//
//- (void)itemClicked;
//
//- (NSString *)itemBgImgName;
//
//- (CGSize)itemSize;
//
//- (BOOL)enable;

@optional

- (void)itemView:(TBCToolsItemBaseView *)itemView businessData:(id)data;

- (void)itemViewClicked:(TBCToolsItemBaseView *)itemView;

@end

NS_ASSUME_NONNULL_END
