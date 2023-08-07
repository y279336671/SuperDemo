//
//  TBCToolsItemView.h
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCToolsItemBaseViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBCToolsItemBaseView : UIView

@property (nonatomic, weak, nullable) id<TBCToolsItemBaseViewDelegate> delegate;


//- (NSString *)itemBgImgName;
//
//- (CGSize)itemSize;
//
//- (BOOL)enable;
//
//- (void)itemClicked;
@end

NS_ASSUME_NONNULL_END
