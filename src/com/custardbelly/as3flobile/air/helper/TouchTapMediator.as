/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: TouchTapMediator.as</p>
 * <p>Version: 0.1</p>
 *
 * <p>Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:</p>
 *
 * <p>The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.</p>
 *
 * <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.</p>
 *
 * <p>Licensed under The MIT License</p>
 * <p>Redistributions of files must retain the above copyright notice.</p>
 */
package com.custardbelly.as3flobile.air.helper
{
	import com.custardbelly.as3flobile.helper.TapMediator;
	
	import flash.display.InteractiveObject;
	import flash.events.TouchEvent;

	/**
	 * TouchTapMediator is an ITapMediator implementation that uses touch event to monitor tap gestures. 
	 * @author toddanderson
	 * 
	 */
	public class TouchTapMediator extends TapMediator
	{
		/**
		 * Constructor. 
		 * @param threshold int The maximum amount of time in milliseconds that relates to the time for a tap gesture. 
		 */
		public function TouchTapMediator( threshold:int = 700 )
		{
			super(threshold);
		}
		
		/**
		 * @inherit
		 */
		override public function mediateTapGesture( display:InteractiveObject, handler:Function ):void
		{
			super.mediateTapGesture( display, handler );
			display.addEventListener( TouchEvent.TOUCH_BEGIN, handleTouchBegin, false, 0, true );
			display.addEventListener( TouchEvent.TOUCH_END, handleTouchEnd, false, 0, true );
		}
		
		/**
		 * @inherit
		 */
		override public function unmediateTapGesture( display:InteractiveObject ):void
		{
			super.unmediateTapGesture( display );
			display.removeEventListener( TouchEvent.TOUCH_BEGIN, handleTouchBegin, false );
			display.removeEventListener( TouchEvent.TOUCH_END, handleTouchEnd, false );
		}
	}
}