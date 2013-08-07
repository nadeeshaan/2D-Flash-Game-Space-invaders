package com.nsg.basics1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class Stringer extends MovieClip
	{
 
		private var stageRef:Stage;
		private var vy:Number = 3; //y velocity
		private var ay:Number = .4; //y acceleration
		private var target:Ship;
 
		public function Stringer(stageRef:Stage,target:Ship) : void
		{	
			stop();
				 
			this.stageRef = stageRef;
			this.target = target;
 
			x = Math.random() * stageRef.stageWidth;
			y = -5;
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
 
		private function loop(e:Event) : void
		{
			if (currentLabel != "destroyed"){
				vy += ay;
				y += vy;
 
				if (y > stageRef.stageHeight)
					removeSelf();
				
				if (y - 15 < target.y && y + 15 > target.y)
					fireWeapon();
			}
			if(currentLabel=="destroyComplete"){
				removeSelf();
			}
			
		}
 
		private function removeSelf() : void {
 
			removeEventListener(Event.ENTER_FRAME, loop);
 
			if (stageRef.contains(this))
				stageRef.removeChild(this);
		}
		
		private function fireWeapon() : void
		{
			stageRef.addChild(new Bullet(stageRef, target, x, y, -5));
			stageRef.addChild(new Bullet(stageRef, target, x, y, 5));
		}
		
		public function takeHit() : void
		{
			if (currentLabel != "destroyed" && currentLabel != "destroyComplete") { //make sure out ship isn't destroyed
				rotation = Math.random() * 360; //make the parts seem to fly in random directions
				gotoAndPlay("destroyed"); //start playing at our destroyed frame
			}
		}
 
	}
 
}