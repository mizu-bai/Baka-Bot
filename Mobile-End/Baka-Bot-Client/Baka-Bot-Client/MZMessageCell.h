//
// Created by mizu bai on 2021/8/21.
//

#import <UIKit/UIKit.h>

@class MZMessageFrame;

@interface MZMessageCell : UITableViewCell

@property (strong, nonatomic) MZMessageFrame *messageFrame;

+ (instancetype)messageCellWithTableView:(UITableView *)tableView;


@end
