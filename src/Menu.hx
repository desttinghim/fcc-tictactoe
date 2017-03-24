import luxe.Color;
import luxe.Vector;
import luxe.Input;
import luxe.Text;
import luxe.States;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.Convert;
import mint.render.luxe.Label;
import mint.layout.margins.Margins;
import luxe.utils.Maths;

import Piece;

class Menu extends State {

    var bg : luxe.Sprite;
    var xbtn : mint.Button;
    var obtn : mint.Button;
    var canvas : mint.Canvas;

    override function onleave<T>(_:T) {

        bg.destroy();

        xbtn = null;
        obtn = null;

    } //onleave

    override function onenter<T>(_:T) {

        canvas = Main.canvas;

        bg = new luxe.Sprite({
            color: new Color().rgb(0xffffff),
            pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
            size: new Vector(Luxe.screen.size.x, Luxe.screen.size.y),
        });

        xbtn = new mint.Button({
            parent: canvas,
            name: 'button',
            x: Luxe.screen.mid.x-160, y: Luxe.screen.mid.y-160, w: 128, h: 128,
            text: 'crosses',
            text_size: 24,
            options: { label: { color: new Color().rgb(0x9dca63) }},
            onclick: function (e,c) { Main.piece = X; Main.changeState('state1'); }
        });

        obtn = new mint.Button({
            parent: canvas,
            name: 'button',
            x: Luxe.screen.mid.x+32, y: Luxe.screen.mid.y-160, w: 128, h: 128,
            text: 'knots',
            text_size: 24,
            options: { label: { color: new Color().rgb(0x9dca63) }},
            onclick: function (e,c) { Main.piece = O; Main.changeState('state1'); }
        });

    }

}
