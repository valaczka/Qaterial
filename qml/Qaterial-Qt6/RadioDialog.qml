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

Qaterial.ModalDialog
{
  id: _root

  property
  var model: null
  property int currentIndex: 0

  property
  var delegate: defaultDelegate
  readonly property
  var defaultDelegate: _defaultDelegate

  Component
  {
	id: _defaultDelegate
	Qaterial.RadioDialogDelegate
	{
	  text: model.text ? model.text : ""
	  secondaryText: model.secondaryText ? model.secondaryText : ""
	  icon.source: model.icon ? model.icon: ""
	  iconColor: model.iconColor ? model.iconColor : Qaterial.Style.accentColor
	} // RadioDialogDelegate
  } // Component

  horizontalPadding: 0
  bottomPadding: 1
  drawSeparator: _list.height < _list.contentHeight
  property double maxHeight: Qaterial.Style.dialog.maxHeight

  standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
  contentItem: ListView
  {
	implicitHeight: Math.min(_root.maxHeight, _list.contentHeight)
	//height: 200
	interactive: contentHeight > height
	id: _list
	clip: true
	model: _root.model
	delegate: _root.delegate
	highlightFollowsCurrentItem: true
	currentIndex: _root.currentIndex

	onCurrentIndexChanged:
	{
	  if(_root.currentIndex !== currentIndex)
		_root.currentIndex = currentIndex
	}
  } // ListView
} // ModelDialog
