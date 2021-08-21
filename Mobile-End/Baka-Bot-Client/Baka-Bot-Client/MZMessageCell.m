//
// Created by mizu bai on 2021/8/21.
//

#import "MZMessageCell.h"
#import "MZMessageFrame.h"
#import "MZMessage.h"

@interface MZMessageCell()

@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UIImageView *iconImageView;
@property (weak, nonatomic) UIButton *textButton;

@end

@implementation MZMessageCell {

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // create controls
        // time label
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;

        // icon image view
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;

        // text button
        UIButton *textButton = [[UIButton alloc] init];
        textButton.titleLabel.font = kTextFont;
        [textButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        // auto linefeed
        textButton.titleLabel.numberOfLines = 0;
        // edge insets
        textButton.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        [self.contentView addSubview:textButton];
        self.textButton = textButton;
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

+ (instancetype)messageCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"message_cell";
    MZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MZMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setMessageFrame:(MZMessageFrame *)messageFrame {
    _messageFrame = messageFrame;
    // set data & frame
    MZMessage *message = messageFrame.message;
    // set time label
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:message.time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"MM 月 dd 日 HH:mm";
    self.timeLabel.text = [dateFormatter stringFromDate:date];
    self.timeLabel.frame = messageFrame.timeLabelFrame;
    self.timeLabel.hidden = message.timeLabelHidden;
    // set icon
    NSString *iconImage = message.type == MZMessageClient ? @"me" : @"other";
    self.iconImageView.image = [UIImage imageNamed:iconImage];
    self.iconImageView.frame = messageFrame.iconImageFrame;
    // set text
    [self.textButton setTitle:message.content forState:UIControlStateNormal];
    self.textButton.frame = messageFrame.textButtonFrame;
    // set text background image
    NSString *imageNormalName;
    NSString *imageHighlightedName;
    if (message.type == MZMessageClient) {
        imageNormalName = @"chat_send_nor";
        imageHighlightedName = @"chat_send_press_pic";
        [self.textButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        imageNormalName = @"chat_receive_nor";
        imageHighlightedName = @"chat_receive_press_pic";
        [self.textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    // load image
    UIImage *imageNormal = [UIImage imageNamed:imageNormalName];
    UIImage *imageHighlighted = [UIImage imageNamed:imageHighlightedName];
    // stretch
    imageNormal = [imageNormal stretchableImageWithLeftCapWidth:imageNormal.size.width * 0.5 topCapHeight:imageNormal.size.height * 0.5];
    imageHighlighted = [imageHighlighted stretchableImageWithLeftCapWidth:imageHighlighted.size.width * 0.5 topCapHeight:imageHighlighted.size.height * 0.5];
    // set background image
    [self.textButton setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [self.textButton setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];

}

@end