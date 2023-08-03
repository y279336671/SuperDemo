//
//  TBCToolsItemView.h
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TBCToolsItemBaseView;

@protocol TBCToolsItemBaseViewProtocol <NSObject>

@optional

- (void)itemView:(TBCToolsItemBaseView *)itemView businessData:(id)data;

- (void)itemView:(TBCToolsItemBaseView *)itemView;

- (void)itemView:(TBCToolsItemBaseView *)itemView enable:(BOOL)enable;
@end

@interface TBCToolsItemBaseView : UIView

@property (nonatomic, weak) id<TBCToolsItemBaseViewProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
