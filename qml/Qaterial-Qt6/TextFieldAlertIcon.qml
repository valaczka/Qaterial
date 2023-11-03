/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick

// Qaterial
import Qaterial as Qaterial
import "." as Qaterial

Qaterial.TextFieldIcon
{
  id: _control
  color: Qaterial.Style.errorColor
  source: Qaterial.Icons.alertCircle

  visible: textField ? textField.errorState :
					   textArea ? textArea.errorState :
								  true

  onVisibleChanged: function()
  {
	if(visible)
	  _anim.start()
  }
  ErrorSequentialAnimation { id: _anim;target: _control; }
} // TextFieldIcon
