//
//  GiftCollectionViewFlowLayout.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "GiftCollectionViewFlowLayout.h"
#define kScreenScale ([ UIScreen mainScreen ].bounds.size.width/320)

@interface GiftCollectionViewFlowLayout ()
@property (strong, nonatomic) NSMutableArray *allAttributes;


@end

@implementation GiftCollectionViewFlowLayout

//1
- (void)prepareLayout {    //准备布局
    [super prepareLayout];
    
#if 0
    //设置item尺寸
    CGFloat itemW = kScreenWidth * 0.253;
    self.itemSize = CGSizeMake(itemW, itemW + 20);
    
    self.rowCount = 2;
    self.itemCountPerRow = 4;
    self.allAttributes = [NSMutableArray array];
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.allAttributes addObject:attributes];
    }
#else
#endif
}


//2
- (CGSize)collectionViewContentSize
{
    if (!self.collectionView.superview) {
        return CGSizeZero;
    }
    NSUInteger  numOfSection = [self.collectionView numberOfSections];
    CGSize size = [super collectionViewContentSize];
    CGFloat width = 0;
    for (NSInteger i = 0;i < numOfSection ; i++) {
        width +=  [self sectionWidth:i];
    }
    size.width = width;
    return size;
}
//3  返回目标区域对应的Attributes 数组
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //    NSLog(@"___________%@",NSStringFromCGRect(rect));
    //获取对应rect中的展示indexpath ，生成attribu
    NSMutableArray *attributeArray = [NSMutableArray array];
    
    for (int section = 0; section < self.collectionView.numberOfSections; section++) {
        for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
            UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            [attributeArray addObject:att];
        }
    }
    
    for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
        UICollectionViewLayoutAttributes* attHeader = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        [attributeArray addObject:attHeader];
    }
    return attributeArray;
}

//生成对应的item Attributes
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    NSInteger totoalColumn = [self numColumnOfSection:indexPath.section];
    NSInteger line = (indexPath.item)/(CGFloat)totoalColumn;
    NSInteger column = indexPath.item%totoalColumn;  //
    CGRect tempFrame = attributes.frame;
    tempFrame.origin.x = column*(self.itemSize.width) + [self sectionItemStarX:indexPath.section];
    tempFrame.origin.y = line*(self.itemSize.height)  +self.headerReferenceSize.height;
    attributes.frame = tempFrame;
    return attributes;
}
//生成对应的SupplementaryView Attributes
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *orgAttributes = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CGRect tempFrame = orgAttributes.frame;
        NSInteger section = orgAttributes.indexPath.section;
        CGFloat perx = [self sectionItemStarX:section];
        tempFrame.origin.x = perx;
        tempFrame.origin.y = 0;
        tempFrame.size = self.headerReferenceSize;
        orgAttributes.frame = tempFrame;
    }
    return orgAttributes;
}

#pragma mrak - tool method
//每个section宽
- (CGFloat)sectionWidth:(NSUInteger)section
{
    NSInteger column = [self numColumnOfSection:section];
    CGFloat re = self.sectionInset.left+self.sectionInset.right+column*(self.itemSize.width+self.minimumLineSpacing);
    if (self.headerReferenceSize.width > re) {
        re = self.headerReferenceSize.width+self.sectionInset.left+self.sectionInset.right;
    }
    return re;
}
//根据视图的高度，计算section中Itme 行列数
- (NSInteger)numColumnOfSection:(NSUInteger)section {
    NSInteger numOfItmes = [self.collectionView numberOfItemsInSection:section];
    CGFloat viewHeight = self.collectionView.frame.size.height;
    NSInteger line = viewHeight/self.itemSize.height;
    CGFloat fcolumn = (CGFloat)numOfItmes/line;
    NSInteger  column = ceil(fcolumn);
    return column;
}
- (CGFloat)sectionItemStarX:(NSUInteger)section {
    CGFloat x = self.sectionInset.left;//计算每个head.x
    for (NSInteger i = 1;i <= section ;i++) {
        x += [self sectionWidth:i - 1];
    }
    return x;
}

@end
