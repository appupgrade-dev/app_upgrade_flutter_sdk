enum DialogStyle { cupertino, material }

class DialogConfig {
  DialogStyle? dialogStyle = DialogStyle.material;
  String? title = "App Update Required!";
  String? updateButtonTitle = 'Update';
  String? laterButtonTitle = 'Later';
  Function()? onUpdateCallback = () {};
  Function()? onLaterCallback = () {};

  DialogConfig({
    this.dialogStyle,
    this.title,
    this.updateButtonTitle,
    this.laterButtonTitle,
    this.onUpdateCallback,
    this.onLaterCallback
  });
}