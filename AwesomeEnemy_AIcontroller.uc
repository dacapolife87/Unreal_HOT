class AwesomeEnemy_AIcontroller extends AIController;

var() Vector TempDest;
var Actor Target;
var float AttackDistance;
var float MovementSpeed;
var vector NewLocation;
var bool bAttacking;

//That's in our AI Controller
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

//That's in our AI Controller
function GetEnemy()
{
    local AwesomeTemple AT;
    foreach DynamicActors(class'AwesomeTemple',AT)
    if(AT != none){
            Target = AT;
    }
}

function Attack()
{
    local UTProj_Rocket RocketAttack;
    RocketAttack = spawn(class'UTProj_Rocket',self,,Pawn.Location);
    RocketAttack.Init(normal(Target.Location-Pawn.Location));
    SetTimer(1.0,false,'EndAttack');
}
function EndAttack()
{
    bAttacking = false;
}


auto state Seeking
{

    function Tick(float DeltaTime)
    {
        if(Target == none)
        {
            GetEnemy();
        }
    }
    ///////////
    function bool FindNavMeshPath()
    {
        NavigationHandle.PathConstraintList = none;
        NavigationHandle.PathGoalList = none;
        
        class'NavMeshPath_Toward'.static.TowardGoal(NavigationHandle,Target);
        class'NavMeshGoal_At'.static.AtActor(NavigationHandle,Target,32,true);

        return NavigationHandle.FindPath();
    }

Begin:
    if(NavigationHandle.ActorReachable(Target))
    {
        FlushPersistentDebugLines();
        `log("test 1 point!!!!!!!!!!!!" @Target);
        MoveToward(Target,Target,300);
        `log("Pawn and targer distance  in  Seek State!!!!!!!!!!!!" @VSize(Pawn.Location - Target.Location));
        if(VSize(Pawn.Location - Target.Location) < AttackDistance)
        {
            GoToState('Attacking');
        }
    }

    else if(FindNavMeshPath())
    {
        NavigationHandle.SetFinalDestination(Target.Location);
        `log("test 2 point!!!!!!!!!!!!" @Target);
        FlushPersistentDebugLines();
        NavigationHandle.DrawPathCache(,true);

        if(NavigationHandle.GetNextMoveLocation(TempDest,Pawn.GetCollisionRadius()))
        {
            `log("test 3 point!!!!!!!!!!!!" @Target);
            DrawDebugLine(Pawn.Location,TempDest,255,0,0,true);
            DrawDebugSphere(TempDest,16,20,255,0,0,true);

            MoveTo(TempDest,Target);
        }
    }


    else
    {
        //GotoState('Idle');
    }

    ////////////

    /*
    Begin:
    MoveToward(Target, Target,300);
    `log("Pawn and targer distance  in  Seek State!!!!!!!!!!!!" @VSize(Pawn.Location - Target.Location));

    if(VSize(Pawn.Location - Target.Location) < AttackDistance)
    {
        GoToState('Attacking');
    }
    */
    goto 'Begin';
}

state Attacking
{
    function Tick(float DeltaTime)
    {
        if(Target == none)
            GetEnemy();

        if(Target != none)
        {
            if(VSize(Pawn.Location - Target.Location) > AttackDistance)
                GoToState('Seeking');
        }
    }
    function BeginState(Name PreviousStateName)
    {
        `log("Pawn and targer distance  in  Attack State!!!!!!!!!!!!" @VSize(Pawn.Location - Target.Location));
        SetTimer(2.0, True,'Attack');
    }
}

DefaultProperties
{
    AttackDistance=400.0
    MovementSpeed=100.0

}

/*
class AwesomeEnemy_AIController extends AIController;

var float AttackDistance;
var float BumpDamage;
var Actor Target;

//That's in our AI Controller
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

function GetEnemy()
{
    local AwesomeTemple AT;

    foreach DynamicActors(class'AwesomeTemple',AT)
    `log("test11111111111111111111111111111111111111111111111");
    if(AT != none){
            Target = AT;
    }
}


//That's in our AI Controller
auto state Follow
{
    local vector CurrentLocation;
    Begin:
    `log("test11111111111111111111111111111111111111111111111");
    if(Target==none)
    {
        GetEnemy();
    }
    //Target = GetALocalPlayerController().Pawn;
    if(Target!=none)
    {
        MoveToward(Target, Target, 100);
        if(VSize(CurrentLocation - Target.Location) < AttackDistance)
            GoToState('Attacking');
    }
}
state Attacking
{
    function Tick(float DeltaTime)
    {
        if(Target == none)
            GetEnemy();
    
        if(Target != none)
        {
            Target.Bump(self, CollisionComponent, vect(0,0,0));

            if(VSize(Location - Target.Location) > AttackDistance)
                GoToState('Seeking');
        }
    }
}

DefaultProperties
{
    BumpDamage=2.0
    AttackDistance=100
}*/