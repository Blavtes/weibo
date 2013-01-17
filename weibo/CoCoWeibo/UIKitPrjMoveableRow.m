//
//  UIKitPrjMoveableRow.m
//
//  Created by wang on 2011-10-18.
//

#import "UIKitPrjMoveableRow.h"

@implementation UIKitPrjMoveableRow
//设置限制单元
- (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath {
  // 最后单元之外的情况下YES
//  return ( dataSource_.count > indexPath.row + 1 );
    return YES;
}
//限制单元移动到最后一个单元格的下方
-(NSIndexPath *)tableView:(UITableView *)tableView 
     targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
	  toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	if (dataSource_.count > proposedDestinationIndexPath.row + 1) {
		return proposedDestinationIndexPath;
	}else {
		return sourceIndexPath;
	}

}
- (void)tableView:(UITableView*)tableView
  moveRowAtIndexPath:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath
{
  NSUInteger fromRow = fromIndexPath.row;
  NSUInteger toRow = toIndexPath.row;
  while ( fromRow < toRow ) {
    [dataSource_ exchangeObjectAtIndex:fromRow withObjectAtIndex:fromRow+1];
    fromRow++;
  }
  while ( fromRow > toRow ) {
    [dataSource_ exchangeObjectAtIndex:fromRow withObjectAtIndex:fromRow-1];
    fromRow--;
  }
}

@end
