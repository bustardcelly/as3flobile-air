/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: ScrollViewportTouchContext.as</p>
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
package com.custardbelly.as3flobile.air.controls.viewport.context
{
	import com.custardbelly.as3flobile.controls.viewport.context.AbstractScrollViewportContext;
	import com.custardbelly.as3flobile.controls.viewport.context.IScrollViewportStrategy;
	
	import flash.display.InteractiveObject;
	import flash.events.TouchEvent;
	import flash.geom.Point;

	/**
	 * ScrollViewportTouchContext is a context for scrolling strategy that bases its mediated user interaction for a scroll event using touch. 
	 * @author toddanderson
	 * 
	 */
	public class ScrollViewportTouchContext extends AbstractScrollViewportContext
	{
		protected var _touchTarget:InteractiveObject;
		
		/**
		 * Constructor. 
		 * @param strategy IScrollViewportStrategy The strategy to use during mediation of a scrolling seqeunce.
		 */
		public function ScrollViewportTouchContext( strategy:IScrollViewportStrategy )
		{
			super( strategy );
		}
		
		/**
		 * @private 
		 * 
		 * Grabs reference to touch target instance and adds initial hanlder for scroll.
		 */
		protected function addTargetHandler():void
		{
			// Grab reference.
			_touchTarget = _viewport.content;
			// If we are live, add handler fro touch begin.
			if( _touchTarget && _isActive )
				_touchTarget.addEventListener( TouchEvent.TOUCH_BEGIN, handleTouchBegin, false, 0, true );
		}
		
		/**
		 * @private 
		 * 
		 * Removes initial handler for scroll.
		 */
		protected function removeTargetHandler():void
		{
			if( _touchTarget )
				_touchTarget.removeEventListener( TouchEvent.TOUCH_BEGIN, handleTouchBegin, false );
		}
		
		/**
		 * @private 
		 * 
		 * Adds handlers for rest of scrolling sequence. 
		 */
		protected function addTouchHandlers():void
		{
			_touchTarget.addEventListener( TouchEvent.TOUCH_MOVE, handleTouchMove, false, 0, true );
			_touchTarget.addEventListener( TouchEvent.TOUCH_END, handleTouchEnd, false, 0, true );
			_touchTarget.addEventListener( TouchEvent.TOUCH_OUT, handleTouchEnd, false, 0, true );
		}
		
		/**
		 * @private 
		 * 
		 * Removes hanlders for rest of scrolling sequence.
		 */
		protected function removeTouchHandlers():void
		{
			if( !_touchTarget ) return;
			_touchTarget.removeEventListener( TouchEvent.TOUCH_MOVE, handleTouchMove, false );
			_touchTarget.removeEventListener( TouchEvent.TOUCH_END, handleTouchEnd, false );
			_touchTarget.removeEventListener( TouchEvent.TOUCH_OUT, handleTouchEnd, false );
		}
		
		/**
		 * @private
		 * 
		 * Event handler for the begin of a touch/scroll sequence. 
		 * @param evt TouchEvent
		 */
		protected function handleTouchBegin( evt:TouchEvent ):void
		{
			addTouchHandlers();
			// Tell the strategy to start.
			_strategy.start( new Point( evt.stageX, evt.stageY ) );
		}
		
		/**
		 * @private
		 * 
		 * Event handler for the move of a touch/scroll sequence. 
		 * @param evt TouchEvent
		 */
		protected function handleTouchMove( evt:TouchEvent ):void
		{
			_strategy.move( new Point( evt.stageX, evt.stageY ) );
		}
		
		/**
		 * @private
		 * 
		 * Event handler for the end of a touch/scroll sequence. 
		 * @param evt TouchEvent
		 */
		protected function handleTouchEnd( evt:TouchEvent ):void
		{
			removeTouchHandlers();
			_strategy.end( new Point( evt.stageX, evt.stageY ) );
		}
		
		/**
		 * @inherit
		 */
		override public function update():void
		{
			super.update();
			addTargetHandler();
		}
		
		/**
		 * @inherit
		 */
		override public function deactivate():void
		{
			super.deactivate();
			removeTargetHandler();
			removeTouchHandlers();
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			_touchTarget = null;
		}
	}
}