/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial
import "." as Qaterial

Qaterial.TabBar
{
  id: _root
  property alias model: _repeater.model
  property int display: AbstractButton.TextOnly
  property double minWidth: Qaterial.Style.tabBar.minTabWidth
  property double maxWidth: Qaterial.Style.tabBar.maxTabWidth
  property int maxElement: 5
  implicitWidth: width

  property string textRole: "text"
  property string iconRole: "source"

  leftPadding: !mirrored ? Qaterial.Style.tabBar.minLeftWidth : 0
  rightPadding: mirrored ? Qaterial.Style.tabBar.minLeftWidth : 0

  clip: true

  Repeater
  {
	id: _repeater
	delegate: Qaterial.TabButton
	{
	  width: Math.max(_root.minWidth, Math.min(_root.width / _root.maxElement, _root.maxWidth))
	  implicitWidth: width
	  display: _root.display
	  text: model[textRole] ? model[textRole] : ""
	  icon.source: model[iconRole] ? model[iconRole] : ""
	  onPrimary: _root.onPrimary
	  enabled: _root.enabled
	} // TabButton
  } // Repeater
} // TabBar
