//
//  SIInnerCollectionViewCell.m
//  SICollectionViewInCollectionViewCell
//
//  Created by Christian Otkjær on 03/06/14.
//  Copyright (c) 2014 Silverback IT. All rights reserved.
//

#import "SIInnerCollectionViewCell.h"

@implementation SIInnerCollectionViewCell
#pragma mark - Init

- (void)setup
{
    self.backgroundView = nil;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
