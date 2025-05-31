using Godot;
using System;

public partial class Main : Node2D
{
	public override void _Ready()
	{
		// This method is called when the node is added to the scene.
		GD.Print("Main scene is ready!");
	}

	public override void _Process(double delta)
	{
		// This method is called every frame.
		// You can use it to update game logic or animations.
	}
}
