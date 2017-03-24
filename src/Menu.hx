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


class Menu extends State {

    var bg : luxe.Sprite;
    var playbtn : mint.Button;
    var canvas : mint.Canvas;

    override function onleave<T>(_:T) {

        bg.destroy();

        playbtn = null;

    } //onleave

    override function onenter<T>(_:T) {

        canvas = Main.canvas;

        bg = new luxe.Sprite({
            color: new Color().rgb(0xffffff),
            pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
            size: new Vector(Luxe.screen.size.x, Luxe.screen.size.y),
        });

        playbtn = new mint.Button({
            parent: canvas,
            name: 'button',
            x: 90, y: 40, w: 60, h: 32,
            text: 'mint',
            text_size: 14,
            options: { label: { color: new Color().rgb(0x9dca63) }},
            onclick: function (e,c) { Main.change('state1'); }
        });

    }

}
