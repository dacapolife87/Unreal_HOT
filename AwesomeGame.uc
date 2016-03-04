class AwesomeGame extends UTDeathmatch;

var int EnemiesLeft;
var array<AwesomeEnemySpawner> EnemySpawners;
var int WaveCounter;
var int RoundCounter;
var AwesomeEnemy EnemyPawn;
var vector EnemyPawnPos;

simulated function PostBeginPlay()
{
    local AwesomeEnemySpawner ES;

    super.PostBeginPlay();

    EnemyPawnPos.x = 200.0f;
    EnemyPawnPos.y = 200.0f;
    EnemyPawnPos.z = 150.0f;
    EnemyPawn = Spawn(class'AwesomeGame.AwesomeEnemy',,,EnemyPawnPos,,,);


    GoalScore = EnemiesLeft;

    foreach DynamicActors(class'AwesomeEnemySpawner', ES){
        EnemySpawners[EnemySpawners.length] = ES;
    }

    SetTimer(5.0, false, 'ActivateSpawners');
}

function ActivateSpawners()
{
    local int i;
    local AwesomePlayerController PC;

    foreach LocalPlayerControllers(class'AwesomePlayerController', PC)
        break;
    if(PC.Pawn == none)
    {
        SetTimer(1.0, false, 'ActivateSpawners');
        return;
    }

    for(i=0; i<EnemySpawners.length; i++)
    {
            if(EnemySpawners[i].CanSpawnEnemy())
                EnemySpawners[i].SpawnEnemy();
    }

        //InRangeSpawners[Rand(InRangeSpawners.length)].SpawnEnemy();


        if(WaveCounter==1){
            WaveCounter=0;
            RoundCounter++;
            SetTimer(20.0, false, 'ActivateSpawners');
            return;
        }
        WaveCounter++;
        SetTimer(5.0, false, 'ActivateSpawners');
}

function ScoreObjective(PlayerReplicationInfo Scorer, Int Score)
{
    local int i;

    EnemiesLeft--;
    super.ScoreObjective(Scorer, Score);

    if(EnemiesLeft == 0)
    {
        for(i=0; i<EnemySpawners.length; i++){
            EnemySpawners[i].MakeEnemyRunAway();
        }
        ClearTimer('ActivateSpawners');
    }
}

defaultproperties
{
    WaveCounter=0
    EnemiesLeft=20
    bScoreDeaths=false
    PlayerControllerClass=class'AwesomeGame.AwesomePlayerController'
    DefaultPawnClass=class'AwesomeGame.AwesomePawn'
    DefaultInventory(0)=None
}
