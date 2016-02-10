//
//  ViewController.m
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/6/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Note.h"
#import "Model.h"

@interface ViewController () 



@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UITextField *titleText;
@property (weak, nonatomic) UITextView *bodyText;
@property (weak, nonatomic) UIButton *saveButton;
@property (weak, nonatomic) Note *note;




@end

@implementation ViewController

- (id)initWithNote:(Note *)note {
    self = [super init];
    self.note = note;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Edit note";

    //visual components
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;

    UITextField *titleText = [UITextField new];
    [self.view addSubview:titleText];
    self.titleText = titleText;
    self.titleText.delegate = self;

    
    
    
    UITextView *bodyText = [UITextView new];
    [self.view addSubview:bodyText];
    self.bodyText = bodyText;
    
    UIButton *saveButton = [UIButton new];
    [self.view addSubview:saveButton];
    self.saveButton = saveButton;
    
    int padding = 10;
    
    self.titleLabel.text = @"Title:";
    [self.titleLabel sizeToFit];
    
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor colorWithRed:1.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor colorWithRed:1.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:0.5] forState:UIControlStateHighlighted];
    [self.saveButton addTarget:self action:@selector(tappedSave:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [self.saveButton sizeToFit];
    
    [self.titleText setBorderStyle:UITextBorderStyleLine];
    [self.bodyText.layer setBorderWidth:1.0];
    [self.bodyText.layer setBorderColor:[[UIColor blackColor] CGColor]];

    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(padding);
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-padding);
    }];

    [self.titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.right.equalTo(saveButton.mas_left).offset(-padding);
        make.left.equalTo(titleLabel.mas_right).offset(padding);
        make.width.greaterThanOrEqualTo(@1);

    }];
    
    

    [self.bodyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(padding);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.bottom.equalTo(self.view.mas_bottom).offset(-padding);
    }];

    
    
    if (self.note) {
        self.titleText.text = self.note.title;
        self.bodyText.text = self.note.detail;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark: NSNotifications
-(void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWasShown:(NSNotification*)notification {
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;

    [self.bodyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-(10+keyboardHeight));
    }];

    
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    [self.bodyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];

    
}



-(void) tappedSave:(UIButton*)sender {
    if (self.titleText.text.length > 0 && self.bodyText.text.length > 0) {
        //We have data to save, let's save it!
        [self saveNote];
    } else {
        //No data to save!
        [self noDataToSave];
    }
}
-(void)saveNote {
    //Note *note = [[Note alloc] initWithTitle:self.titleText.text detail:self.bodyText.text];
    //[[Model sharedModel] saveNote:note];
    self.note.title = self.titleText.text;
    self.note.detail = self.bodyText.text;
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)noDataToSave {
    NSString *wheresTheProblem;
    if (self.titleText.text.length == 0 && self.bodyText.text.length == 0) {
        wheresTheProblem = @"title and note text fields";
    } else if (self.titleText.text.length == 0) {
        wheresTheProblem = @"title text field";
    } else {
        wheresTheProblem = @"note text field";
    }
    NSString *theProblem = [NSString stringWithFormat:@"There needs to be text in the %@ to be able to save.",wheresTheProblem];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save problem"
                                                                   message:theProblem
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.titleText.text.length == 0) {
            [self.titleText becomeFirstResponder];
        } else {
            [self.bodyText becomeFirstResponder];
        }
    }];
    [alert addAction:defaultAction];

    [self presentViewController:alert animated:YES completion:nil];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.titleText) {
        [textField resignFirstResponder];
        [self.bodyText becomeFirstResponder];

        return NO;
    }
    return YES;
}


@end
