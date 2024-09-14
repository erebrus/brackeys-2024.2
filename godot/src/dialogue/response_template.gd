extends TextureButton

var response:DialogueResponse:
	set(_response):
		$Margin/Label.text = _response.text
