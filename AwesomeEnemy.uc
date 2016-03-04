class AwesomeEnemy extends UTPawn;

var float BumpDamage;
var Actor Enemy;
var float MovementSpeed;
var float AttackDistance;
var int Health;

/*
event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    if(EventInstigator != none && EventInstigator.PlayerReplicationInfo != none)
        WorldInfo.Game.ScoreObjective(EventInstigator.PlayerReplicationInfo, 1);

    if(AwesomeEnemySpawner(Owner) != none)
        AwesomeEnemySpawner(Owner).EnemyDied();


    Health -= DamageAmount;
    if(Health==0){
        Destroy();
    }
}




function Attack()
{
    local UTProj_Rocket RocketAttack;
    RocketAttack = spawn(class'UTProj_Rocket',self,,Location);
    RocketAttack.Init(normal(Enemy.Location-Location));
    //Enemy.Bump(self, CollisionComponent, vect(0,0,0));
    SetTimer(1.0,false,'EndAttack');
}
function GetEnemy()
{

    local AwesomeTemple AT;

    foreach DynamicActors(class'AwesomeTemple',AT)
    if(AT != none){
            Enemy = AT;
    }
}

function RunAway()
{
    GoToState('Fleeing');
}

auto state Seeking
{
    function Tick(float DeltaTime)
    {
        local vector NewLocation;

        if(Enemy == none)
            GetEnemy();

        if(Enemy != none)
        {
            NewLocation = Location;
            NewLocation += normal(Enemy.Location - Location) * MovementSpeed * DeltaTime;
            SetLocation(NewLocation);

            if(VSize(NewLocation - Enemy.Location) < AttackDistance)
                GoToState('Attacking');
        }
    }
}

state Attacking
{
    function Tick(float DeltaTime)
    {
        if(Enemy == none)
            GetEnemy();

        if(Enemy != none)
        {
//            SetTimer(2.0, True,'Attack');
            if(VSize(Location - Enemy.Location) > AttackDistance)
                GoToState('Seeking');
        }
    }
    function BeginState(Name PreviousStateName)
    {
        `log("testpoint!!!!!!!!!!!!" @PreviousStateName);
        SetTimer(2.0, True,'Attack');
    }
}

state Fleeing
{
    function Tick(float DeltaTime)
    {
        local vector NewLocation;

        if(Enemy == none)
            GetEnemy();

        if(Enemy != none)
        {
            NewLocation = Location;
            NewLocation -= normal(Enemy.Location - Location) * MovementSpeed * DeltaTime;
            SetLocation(NewLocation);
        }
    }
}
*/
defaultproperties
{
    Begin Object Name=CollisionCylinder
    CollisionHeight=+44.000000
    end object
    Begin Object class=SkeletalMeshComponent Name=PawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
    HiddenGame=FALSE
    HiddenEditor=FALSE
    End Object
    Mesh=PawnSkeletalMesh
    Components.Add(PawnSkeletalMesh)

    ControllerClass=class'AwesomeGame.AwesomeEnemy_AIcontroller'
    bJumpCapable=false
    bCanJump=false
    GroundSpeed=200.0
}
