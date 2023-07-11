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

Row {
	id: _container

	property Qaterial.TextField textField: null
	property Qaterial.TextArea textArea: null
	property Qaterial.ComboBox comboBox: null

	readonly property real _parentHeight:
		textField ? (textField.height - textField.bottomPadding) :
					textArea ? (textArea.height - textArea.bottomPadding) :
							   comboBox ? (comboBox.height - comboBox.bottomPadding) : 0


	y: Math.max(0, (_parentHeight-height)/2)

	function assignToContentItem()
	{
		for (let i=0; i<children.length; ++i) {
			let item = children[i]

			if(item && ((typeof item.textField) == "object"))
				item.textField = _container.textField

			if(item && ((typeof item.textArea) == "object"))
				item.textArea = _container.textArea

			if(item && ((typeof item.comboBox) == "object"))
				item.comboBox = _container.comboBox

		}
	}

	onTextFieldChanged: assignToContentItem()
	onTextAreaChanged: assignToContentItem()
	onComboBoxChanged: assignToContentItem()

	onVisibleChildrenChanged: assignToContentItem()

	onParentChanged: {
		if (parent && (parent instanceof Loader)) {
			let p = parent.parent

			if (p instanceof Qaterial.TextField)
				textField = p

			if (p instanceof Qaterial.TextArea)
				textArea = p

			if (p instanceof Qaterial.ComboBox)
				comboBox = p
		}
	}
}
