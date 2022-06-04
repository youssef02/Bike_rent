

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class QRscanner extends StatefulWidget{
  const QRscanner({Key? key}) : super(key: key);

  @override
  State<QRscanner> createState() => _QRscanner();

}


class _QRscanner extends State<QRscanner> {
  @override
  Widget build(BuildContext context) {
    var onescan = false;

    return MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if(!onescan){
            onescan = true;
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(

                      title:const Text('GeeksforGeeks'),
                      children: <Widget>[
                        Center(child: Text("424234",style: TextStyle(fontSize: 20),)),
                        ElevatedButton(
                          onPressed: () {
                            onescan = false;
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );

                  }
              );

              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('Snackbar message'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100- 32,
                    right: 20,
                    left: 20),
              ));
            }
          }

        });

  }
}