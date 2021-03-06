//
//  SIOuterCollectionViewCell.h
//  SICollectionViewInCollectionViewCell
//
//  Created by Christian Otkjær on 03/06/14.
//  Copyright (c) 2014 Silverback IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIInnerCollectionViewController;

@interface SIOuterCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, readonly) SIInnerCollectionViewController* collectionViewController;

@end
