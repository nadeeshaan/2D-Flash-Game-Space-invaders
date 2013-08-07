package com.nsg.basics1
{
	//list of our imports these are classes we need in order to
	//run our application.
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	//our Engine class it extends MovieClip
	public class Engine extends MovieClip
	{
		private var numStars:int = 80;
		public static var enemyList:Array = new Array();
		private var ourShip:Ship;
 
		//our constructor function. This runs when an object of
		//the class is created
		public function Engine()
		{
 			ourShip= new Ship(stage);
			stage.addChild(ourShip);
			ourShip.x=stage.stageWidth/2;
			ourShip.y=stage.stageHeight/2;
			
			for (var i:int = 0; i < numStars; i++)
			{
				stage.addChildAt(new Star(stage), stage.getChildIndex(ourShip));
			}
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function loop(e:Event) : void
		{
			//run if condition is met.
			if (Math.floor(Math.random() * 90) == 5)
			{
				//create our enemy
				var enemy:Stringer = new Stringer(stage,ourShip);
 
				//listen for enemy being removed from stage
				enemy.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
 
				//add our enemy to the enemyList
				enemyList.push(enemy);
 
				stage.addChild(enemy);
			}
		}
 
		//run when an enemy is removed from stage
		private function removeEnemy(e:Event)
		{
			enemyList.splice(enemyList.indexOf(e.currentTarget), 1);
		}
		
 
	}
 
}