import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  SocialButton({
    this.imageDirectory: "",
    this.icon,
    @required this.onPressed,
    this.text,
    this.color,
    this.textColor,
    this.height: 50.0,
    this.borderRadius: 2.0,
  });

  final String imageDirectory;
  final IconData icon;
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: RaisedButton(
          onPressed: onPressed,
          color: color,
          disabledColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _image(context),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
              Opacity(
                opacity: 0.0,
                child: _image(context),
              )
            ],
          ),
        )
    );
  }
  
  Widget _image(BuildContext context){
    if(icon != null) {
      return Icon(icon);
    } else if(imageDirectory != "" || imageDirectory != null){
      return Image.asset(imageDirectory);
    } else{
      return Icon(Icons.error);
    }
  }
}