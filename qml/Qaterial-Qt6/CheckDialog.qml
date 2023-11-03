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

	property var selectedIndices: ([])

	Component
	{
		id: _defaultDelegate
		Qaterial.CheckDialogDelegate
		{
			text: model.text ? model.text : ""
			secondaryText: model.secondaryText ? model.secondaryText : ""

			backgroundColor: "transparent"

			onCheckStateChanged: {
				if (checkState == Qt.Unchecked) {
					var i = 0;
					while (i < _root.selectedIndices.length) {
						if (_root.selectedIndices[i] === index) {
							_root.selectedIndices.splice(i, 1);
						} else {
							++i;
						}
					}
				} else {
					_root.selectedIndices.push(index)
				}
			}
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
