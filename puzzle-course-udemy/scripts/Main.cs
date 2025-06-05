using Godot;
using System;

namespace Game;

public partial class Main : Node2D
{
	private Sprite2D cursor;
	private PackedScene buildingScene;
	private Button placeBuidingButton;

	public override void _Ready()
	{
		Logger.Info("Main scene is ready!");

		cursor = GetNode<Sprite2D>("Cursor");
		buildingScene = GD.Load<PackedScene>("res://scenes/building/Building.tscn");
		placeBuidingButton = GetNode<Button>("PlaceBuildingButton");

		cursor.Visible = false;

		//placeBuidingButton.Pressed += OnButtonPressed;
		placeBuidingButton.Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressed));
	}

	public override void _UnhandledInput(InputEvent @event)

	{
		if (cursor.Visible && @event.IsActionPressed("LeftClick"))
		{
			PlaceBuildingAtMousePosition();
			cursor.Visible = false;
		}
	}

	public override void _Process(double delta)
	{
		var gridPosition = GetMouseGridCellPosition();
		cursor.GlobalPosition = gridPosition * 64;
	}

	private Vector2 GetMouseGridCellPosition()
	{
		var mousePosition = GetGlobalMousePosition();
		var gridPosition = mousePosition / 64;
		gridPosition = gridPosition.Floor();
		return gridPosition;
	}

	private void PlaceBuildingAtMousePosition()
	{
		var building = buildingScene.Instantiate<Node2D>();
		AddChild(building);
		var gridPosition = GetMouseGridCellPosition();
		building.GlobalPosition = gridPosition * 64;
	}

	private void OnButtonPressed()
	{
		Logger.Info("Place Building button pressed!");
		cursor.Visible = true;
	}
}
