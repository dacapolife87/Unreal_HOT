class AwesomeEnemyPawn extends UDKPawn
    placeable;

DefaultProperties
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