//
// Created by mizu bai on 2021/8/21.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMargin 10
#define kTextFont [UIFont systemFontOfSize:16]

@class MZMessage;

@interface MZMessageFrame : NSObject

@property(strong, nonatomic) MZMessage *message;
@property(assign, nonatomic, readonly) CGRect timeLabelFrame;
@property(assign, nonatomic, readonly) CGRect iconImageFrame;
@property(assign, nonatomic, readonly) CGRect textButtonFrame;
@property(assign, nonatomic, readonly) CGFloat rowHeight;

@end