using Godot;

public partial class Main : Node
{
	[Export]
	public PackedScene MobScene { get; set; }

	private int _score;

	public override void _Ready()
	{

	}

	public void GameOver()
	{
		GetNode<AudioStreamPlayer>("Music").Stop();
		GetNode<AudioStreamPlayer>("DeathSound").Play();

		GetNode<HUD>("HUD").ShowGameOver();

		GetNode<Timer>("MobTimer").Stop();
		GetNode<Timer>("ScoreTimer").Stop();
	}

	public void NewGame()
	{
		GetNode<AudioStreamPlayer>("Music").Play();
		GetTree().CallGroup("mobs", Node.MethodName.QueueFree);

		_score = 0;

		var hud = GetNode<HUD>("HUD");
		hud.UpdateScore(_score);
		hud.ShowMessage("Get Ready!");

		GetNode<Timer>("StartTimer").Start();

		var startPosition = GetNode<Marker2D>("StartPosition");
		var player = GetNode<Player>("Player");
		player.Start(startPosition.Position);
	}

	private void OnScoreTimerTimeout()
	{
		_score++;
		GetNode<HUD>("HUD").UpdateScore(_score);
	}

	private void OnStartTimerTimeout()
	{
		GetNode<Timer>("MobTimer").Start();
		GetNode<Timer>("ScoreTimer").Start();
	}

	private void OnMobTimerTimeout()
	{
		Mob mob = MobScene.Instantiate<Mob>();

		var mobSpawnLocation = GetNode<PathFollow2D>("MobPath/MobSpawnLocation");
		mobSpawnLocation.ProgressRatio = GD.Randf();

		float direction = mobSpawnLocation.Rotation + Mathf.Pi / 2;

		mob.Position = mobSpawnLocation.Position;

		direction += (float)GD.RandRange(-Mathf.Pi / 4, Mathf.Pi / 4);
		mob.Rotation = direction;

		var velocity = new Vector2((float)GD.RandRange(150.0, 250.0), 0);
		mob.LinearVelocity = velocity.Rotated(direction);

		AddChild(mob);
	}
}
