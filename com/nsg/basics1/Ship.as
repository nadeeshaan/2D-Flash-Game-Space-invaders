package com.nsg.basics1
{
 
	import flash.display.MovieClip;
	import com.senocular.utils.KeyObject;
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
 
	public class Ship extends MovieClip
	{
 		private var stageReference:Stage;
		private var keyObj:KeyObject;
		private var speed:Number=1;
		private var veloX:Number=0;
		private var veloY:Number=0;
		private var friction:Number=0.93;
		private var maxSpeed:Number=12;
		private var fireTimer:Timer;
		private var canFire:Boolean = true;
		
		
		public function Ship(stageRef:Stage)
		{
 			this.stageReference=stageRef;
			keyObj=new KeyObject(stageReference);
			
			fireTimer = new Timer(300, 1);
			fireTimer.addEventListener(TimerEvent.TIMER,fireTimerHandler, false, 0, true);
			
			addEventListener(Event.ENTER_FRAME,loop,false,0,true)
		}
		
		public function loop(e:Event):void
		{
			if(keyObj.isDown(Keyboard.LEFT)){
				veloX-=speed;
			}
			else if(keyObj.isDown(Keyboard.RIGHT)){
				veloX+=speed;
			}
			else{
				veloX*=friction;
			}
			
			if(keyObj.isDown(Keyboard.UP)){
				veloY-=speed;
			}
			else if(keyObj.isDown(Keyboard.DOWN)){
				veloY+=speed;
			}
			else{
				veloY*=friction;
			}
			if(keyObj.isDown(Keyboard.SPACE)){
				fireLaser();
			}
			
			if(veloX>maxSpeed){
				veloX=maxSpeed;
			}
			else if(veloX<-maxSpeed){
				veloX=-maxSpeed;
			}
			
			if(veloY>maxSpeed){
				veloY=maxSpeed;
			}
			else if(veloY<-maxSpeed){
				veloY=-maxSpeed;
			}
			
			x+=veloX;
			y+=veloY;
			if(x<0){
				x=0;
				veloX=-veloX;
			}
			else if(x>stageReference.stageWidth){
				x=stageReference.stageWidth;
				veloX=-veloX;
			}
			if(y<0){
				y=0;
				veloY=-veloY;
			}
			else if(y>stageReference.stageHeight){
				y=stageReference.stageHeight;
				veloY=-veloY;
			}
			
			rotation=veloX;
			scaleX = (maxSpeed - Math.abs(veloX))/(maxSpeed*4) + 0.75;
			
			
		}
		
		public function fireLaser():void{
			//if canFire is true, fire a bullet
			//set canFire to false and start our timer
			//else do nothing.
			if (canFire)
			{
				stageReference.addChild(new LaserBlue(stageReference, x + veloX, y - 10));
				canFire = false;
				fireTimer.start();
			}
		}
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			//timer ran, we can fire again.
			canFire = true;
		}
		
 
	}
 
}