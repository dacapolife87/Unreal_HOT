class AwesomeEnemySpawner extends AwesomeActor
    placeable;

var AwesomeEnemyPawn MySpawnedEnemy;

function SpawnEnemy()
{
   // if(MySpawnedEnemy == none)
   //     MySpawnedEnemy = spawn(class'AwesomeEnemyPawn',,, Location);
}

function bool CanSpawnEnemy()
{
    return MySpawnedEnemy == none;
}

function EnemyDied()
{
        SpawnEnemy();
}

function MakeEnemyRunAway()
{
   // if(MySpawnedEnemy != none)
   //     MySpawnedEnemy.RunAway();
}

defaultproperties
{
    Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.S_NavP'
        HiddenGame=True
    End Object
    Components.Add(Sprite)
}