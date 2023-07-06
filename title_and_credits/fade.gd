extends ColorRect

###This script fades the color rect when the game starts

func fade():
	$AnimationPlayer.play("fade")
