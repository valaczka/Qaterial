/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick

// Qaterial
import Qaterial as Qaterial
import "." as Qaterial

Qaterial.TextFieldIconButton
{
	visible: textField ? !textField.readOnly && textField.length :
						 textArea ? !textArea.readOnly && textArea.length :
									true

  icon.source: Qaterial.Icons.backspace // VJP //Qaterial.Icons.closeCircle
  onClicked: function()
  {
	if(textField && !textField.readOnly) {
		textField.clear()
		textField.textEdited()
		textField.forceActiveFocus()
	}
	if(textArea && !textArea.readOnly) textArea.clear()
  }
} // TextFieldIconButton
