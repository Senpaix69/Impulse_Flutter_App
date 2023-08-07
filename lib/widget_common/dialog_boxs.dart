import 'package:impulse/consts/consts.dart';

Future<void> errorDialogue({
  required BuildContext context,
  required String message,
  required String title,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        surfaceTintColor: lightGrey,
        title: Text(
          title,
          style: const TextStyle(
            color: mehroonColor,
            fontFamily: bold,
            fontSize: 20,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: lightGrey,
        content: Text(
          message,
          style: const TextStyle(
            color: darkFontGrey,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mehroonDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      );
    },
  );
}

Future<bool> confirmDialogue({
  required BuildContext context,
  required String message,
  required String title,
}) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(message),
          title: Text(title),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).shadowColor,
                ),
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      }).then(
    (value) => value ?? false,
  );
}
