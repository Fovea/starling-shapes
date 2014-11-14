// =================================================================================================
//
//	Starling Shapes
//	Copyright 2014 Fovea. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package starling.display
{
    /** A Disk represents a circle filled with a uniform color. */
    public class Disk extends Ring
    {
        public function Disk(radius:Number, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
        {
            super(0, radius, color, premultipliedAlpha);
        }
    }
}
