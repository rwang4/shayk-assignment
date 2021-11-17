# Shayk Assignment

This is a flutter interview assignment assigned by Shayk

### State How you would achieve sending the text displayed with this widget to an email address as a PDF file

#### Procedures:

1. Extract the text from the widget and save them into a String variable

   Inside the program, the text is saved inside a txt file called "applecare_agreement.txt". And I read the text from the file with the function 

   ```dart
   Future<String> getTextFromFile(BuildContext context) async {
       return await DefaultAssetBundle.of(context)
           .loadString('assets/applecare_agreement.txt');
     }
   ```

   I can create a String variable and set the value to the text returned from the ```getTextFromFile()``` function. Since the function is an async function, I will first initialize the String variable and use ```getTextFromFile().then((String text))``` and ```setState((){text = text})``` to  set the value of the String variable. 

2. Create the PDF with the ```String text```, and save it to the local storage

   To create a PDF, I can use a package called "syncfusion_flutter_pdf". With this package, I can create a PDF document, add text into the PDF, and save the document to the local storage.

   Tutorial see: https://www.youtube.com/watch?v=tMM9ty4Wfq0

   ​					https://pub.dev/packages/syncfusion_flutter_pdf

3. Send an email with the PDF document created in the previous step

   To send an email with attachments, I will use a package called "mailer" to help me achieve this feature. 

   SourceCode:

   ```dart
   _sendMail(String username, String accessToken) async {
     String username = 'username@gmail.com';
     String password = 'password';
   
     final _smtpServer = gmail(username, password);
     // Use the SmtpServer class to configure an SMTP server:
     // final smtpServer = SmtpServer('smtp.domain.com');
     // See the named arguments of SmtpServer for further configuration
     // options.  
   
     var _message = new Message()
       ..from = "mymailaddress@gmail.com"
       ..recipients.add("recepient@gmail.com")
       ..subject = '{EMAIL_SUBJECT_GOES_HERE}'
       // Read https://pub.dev/documentation/mailer/latest/mailer/FileAttachment-class.html
       ..attachments
           .add(FileAttachment(File('{FILE_PATH}')))
       ..text = '{PLAIN_TEXT_GOES_HERE}'
       ..html = '{HTML_CONTENT_GOES_HERE}';
   
     send(_message, _smtpServer)
       ..then((envelope) => print('Email sent'))
       ..catchError((e) => print('Error occured: $e'));
   }
   ```

   Tutorial see: https://achinthaisuru444.medium.com/sending-emails-using-flutter-f588387280db

   ​					https://pub.dev/packages/mailer

   4. The above steps are triggered by the ```displayButton()``` button clicked and the functions will be called in 

   ```dart
   onTap: () {
             const popUpText = SnackBar(
               content: Text(
                   "Thanks for your collaboration, a copy of Term of Agreement has been sent to your email"),
             );
             Navigator.pop(context);
             ScaffoldMessenger.of(context).showSnackBar(popUpText);
           },
   ```

   inside the ```InkWell()``` Widget.

### Other Assumptions

- I designed and developed the widget based on the "Term of Agreement" of a mobile app. Thus, when the "display text" button is clicked a dialogue pops up and shows the scrollable text widget and the two buttons.
- Since the text is a long string, I put it into a text file called "applecare_agreement.txt" inside the assets folder. Edit the text inside the "applecare_agreement.txt" file.
- Buttons Widget Test and Widget Navigators Test are added and passed.