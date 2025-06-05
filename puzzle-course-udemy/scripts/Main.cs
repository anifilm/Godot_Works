using Godot;
using System;
using System.Collections.Generic;

namespace Game;

public partial class Main : Node2D
{
	private Sprite2D cursor;
	private PackedScene buildingScene;
	private Button placeBuidingButton;
	private TileMapLayer highlightTilemapLayer;

	private Vector2? hoveredGridCell;
	private HashSet<Vector2> occupiedCells = new HashSet<Vector2>();

	public override void _Ready()
	{
		Logger.Info("Main scene is ready!");

		cursor = GetNode<Sprite2D>("Cursor");
		buildingScene = GD.Load<PackedScene>("res://scenes/building/Building.tscn");
		placeBuidingButton = GetNode<Button>("PlaceBuildingButton");
		placeBuidingButton.Pressed += OnButtonPressed;

		highlightTilemapLayer = GetNode<TileMapLayer>("HighlightTileMapLayer");

		cursor.Visible = false;
	}

	public override void _UnhandledInput(InputEvent @event)
	{
		if (cursor.Visible && @event.IsActionPressed("LeftClick") && !occupiedCells.Contains(GetMouseGridCellPosition()))
		{
			PlaceBuildingAtMousePosition();
			cursor.Visible = false;
		}
	}

	public override void _Process(double delta)
	{
		var gridPosition = GetMouseGridCellPosition();
		cursor.GlobalPosition = gridPosition * 64;
		if (cursor.Visible && (!hoveredGridCell.HasValue || hoveredGridCell != gridPosition))
		{
			hoveredGridCell = gridPosition;
			UpdateHighlightTileMapLayer();
		}
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
		occupiedCells.Add(gridPosition);

		hoveredGridCell = null;
		UpdateHighlightTileMapLayer();
	}

	private void UpdateHighlightTileMapLayer()
	{
		highlightTilemapLayer.Clear();
		if (!hoveredGridCell.HasValue) return;

		for (var x = hoveredGridCell.Value.X - 3; x <= hoveredGridCell.Value.X + 3; x++)
		{
			for (var y = hoveredGridCell.Value.Y - 3; y <= hoveredGridCell.Value.Y + 3; y++)
			{
				highlightTilemapLayer.SetCell(new Vector2I((int)x, (int)y), 0, Vector2I.Zero);
			}
		}
	}

	private void OnButtonPressed()
	{
		//Logger.Info("Place Building button pressed!");
		cursor.Visible = true;
	}
}
