/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 * Copyright (c) Valaczka János Pál 2023
 */

// Qt
import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial
import "." as Qaterial

T.ItemDelegate
{
  id: control

  // TEXT
  property alias overlineText: _content.overlineText
  property alias secondaryText: _content.secondaryText

  property alias leftSource: _content.leftSource
  property alias leftSourceComponent: _content.leftSourceComponent

  property alias rightSource: _content.rightSource
  property alias rightSourceComponent: _content.rightSourceComponent

  property alias largeThumbnail: _content.largeThumbnail

  // ALIGNMENT
  property alias alignTextRight: _content.alignTextRight
  readonly property int lines: _content.lines
  readonly property int type: _content.type

  // COLOR
  property alias backgroundColor: _background.color
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property alias textColor: _content.textColor
  property alias overlineColor: _content.overlineColor
  property alias secondaryTextColor: _content.secondaryTextColor

  // SEPARATOR
  property bool drawSeparator: forceDrawSeparator
  property bool forceDrawSeparator: false

  implicitWidth: Math.max(background ? implicitBackgroundWidth : 0,
	implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(background ? implicitBackgroundHeight : 0,
	Math.max(implicitContentHeight,
	  indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding) + bottomInset

  leftPadding: !mirrored ? Qaterial.Style.delegate.leftPadding(control.type, control.lines) : Qaterial.Style.delegate
	.rightPadding(control.type, control.lines)
  rightPadding: mirrored ? Qaterial.Style.delegate.leftPadding(control.type, control.lines) : Qaterial.Style.delegate
	.rightPadding(control.type, control.lines)
  topPadding: 0
  bottomPadding: 0
  spacing: Qaterial.Style.delegate.spacing(control.type, control.lines)
  bottomInset: _separator.visible ? 1 : 0
  focusPolicy: Qt.StrongFocus

  property bool drawline: Qaterial.Style.debug.drawDebugDelegate
  Qaterial.DebugRectangle
  {
	anchors.fill: parent
	border.color: "pink"
	visible: control.drawline
  } // DebugRectangle

  contentItem: Qaterial.ListDelegateLoaderContent
  {
	id: _content
	text: control.text
	spacing: control.spacing
	enabled: control.enabled
	mirrored: control.mirrored
	drawline: control.drawline
	onPrimary: control.onPrimary
	colorReversed: control.colorReversed
  } // ListDelegateContent

  background: Qaterial.ListDelegateBackground
  {
	id: _background
	type: control.type
	lines: control.lines
	pressed: control.pressed
	rippleActive: control.down || control.visualFocus || control.hovered
	rippleAnchor: control
	onPrimary: control.onPrimary
	highlighted: control.highlighted
  } // ListDelegateBackground

  property alias toolSeparatorLeftPadding: _separator.leftPadding
  property alias toolSeparatorRightPadding: _separator.rightPadding

  Qaterial.ToolSeparator
  {
	id: _separator
	anchors.right: control.right
	anchors.left: control.left
	anchors.bottom: control.bottom
	verticalPadding: 0
	orientation: Qt.Horizontal
	visible:
	{
	  if(control.forceDrawSeparator)
		return true

	  if(control.drawSeparator)
	  {
		if(control.ListView.view.verticalLayoutDirection === ListView.TopToBottom)
		{
		  // No separator for last element (top of the list)
		  return control.ListView.view.count > 1 &&
			index < (control.ListView.view.count - 1)
		}
		else
		{
		  // No separator for first element (bottom of the list)
		  return control.ListView.view.count > 1 && index
		}
	  }
	  return false
	}
  } // ToolSeparator
} // ItemDelegate
