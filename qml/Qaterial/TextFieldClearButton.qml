/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial
import "." as Qaterial

Qaterial.TextFieldIconButton
{
	visible: textField ? textField.length :
						 textArea ? textArea.length :
									true

  icon.source: Qaterial.Icons.backspace // VJP //Qaterial.Icons.closeCircle
  onClicked: function()
  {
	if(textField) textField.clear()
	if(textArea) textArea.clear()
  }
} // TextFieldIconButton
