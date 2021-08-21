//
//  MZChatViewController.m
//  Baka-Bot-Client
//
//  Created by mizu bai on 2021/8/17.
//

#import "MZChatViewController.h"
#import "MZMessage.h"
#import "MZMessageFrame.h"
#import "MZMessageCell.h"
#import <SocketRocket/SocketRocket.h>

#define kApiUrlString @"ws://localhost:3000/api/ws"

@interface MZChatViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SRWebSocketDelegate>

@property(weak, nonatomic) IBOutlet UITableView *chatTableView;
@property(weak, nonatomic) IBOutlet UITextField *inputTextField;
@property(strong, nonatomic) NSMutableArray *messageFrames;
@property(strong, nonatomic) SRWebSocket *webSocket;

@end

@implementation MZChatViewController

- (NSMutableArray *)messageFrames {
    if (_messageFrames == nil) {
        // TODO: load previous messages from db
        _messageFrames = [NSMutableArray array];
    }
    return _messageFrames;
}

#pragma mark - View Did Load

- (void)viewDidLoad {
    [super viewDidLoad];
    // table view configurations
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatTableView.backgroundColor = [UIColor colorWithRed:(236 / 255.0)
                                                         green:(236 / 255.0)
                                                          blue:(236 / 255.0)
                                                         alpha:1.0];
    self.chatTableView.allowsSelection = NO;
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;

    // text field configurations
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 1)];
    self.inputTextField.leftView = leftView;
    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    self.inputTextField.delegate = self;

    // keyboard configurations (KVO)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];

    // webSocket configurations
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:kApiUrlString]];
    self.webSocket.delegate = self;
    [self.webSocket open];

}

#pragma mark - Keyboard

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    // calculate transform value
    CGRect rectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y;
    CGFloat transformValue = keyboardY - self.view.frame.size.height;
    // transformValue < 0, keyboard will pop up
    // transformValue = 0, keyboard will go back
    if (transformValue < 0) {
        // consider the safe area view
        transformValue += self.view.safeAreaInsets.bottom;
    }
    // translation
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformValue);
    }];
    // if no message should be shown in the table view, table view will not need to scroll
    if (self.messageFrames.count == 0) {
        return;
    }
    // scroll to the last cell in table view
    NSIndexPath *lastCellIndexPath = [NSIndexPath indexPathForRow:(self.messageFrames.count - 1) inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:lastCellIndexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZMessageFrame *messageFrame = self.messageFrames[(NSUInteger) indexPath.row];
    MZMessageCell *messageCell = [MZMessageCell messageCellWithTableView:tableView];
    messageCell.messageFrame = messageFrame;
    return messageCell;
}

#pragma mark - Table View Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // call the keyboard back
    [self.view endEditing:YES];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // TODO: send message
    self.inputTextField.text = nil;
    return YES;
}

#pragma mark - SRWebSocket Delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {

}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {

}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {

}

#pragma mark - View Will Disappear

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    // clear webSocket configurations
    [self.webSocket close];
    self.webSocket.delegate = nil;
    self.webSocket = nil;
}

#pragma mark - Dealloc

- (void)dealloc {
    // remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
