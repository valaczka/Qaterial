/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial
import "." as Qaterial

Qaterial.LabelOverline
{
  id: _control
  property bool separatorVisible: false

  width: ListView.view.width
  text: section

  background: Rectangle {
	  color: Qaterial.Style.primaryColor
  }

  color: Qaterial.Style.iconColor()

  Qaterial.ToolSeparator
  {
	id: _separator
	width: parent.width
	y: Math.floor(Qaterial.Style.card.horizontalPadding / 2)
	verticalPadding: 0
	orientation: Qt.Horizontal
	visible: _control.separatorVisible
  } // ToolSeparator

  padding: Qaterial.Style.card.horizontalPadding
  bottomPadding: Qaterial.Style.card.verticalPadding
  topPadding: _separator.visible ? Qaterial.Style.card.horizontalPadding : Qaterial.Style.card.verticalPadding
  elide: Text.ElideRight
} // Label
