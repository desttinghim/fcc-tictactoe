
import luxe.GameConfig;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.*;
import mint.layout.margins.Margins;
import mint.focus.Focus;

class Main extends luxe.Game {

    var focus: Focus;
    var layout: Margins;
    var canvas: AutoCanvas;
    var rendering: LuxeMintRender;

    var back : Sprite;
    var grid : Sprite;

    override function config(config:GameConfig) {

        config.window.title = 'luxe game';
        config.window.width = 480;
        config.window.height = 640;
        config.window.fullscreen = false;

        config.preload.textures.push({ id: 'assets/grid.png' });
        config.preload.textures.push({ id: 'assets/cross.png' });
        config.preload.textures.push({ id: 'assets/knot.png' });

        return config;

    } //config

    override function ready() {

        rendering = new LuxeMintRender();
        layout = new Margins();

        var _scale = Luxe.screen.device_pixel_ratio;
        canvas = new AutoCanvas({
            name: 'canvas',
            rendering: rendering,
            options: { color: new Color().rgb(0xffffff) },
            x: 0, y: 0, scale: _scale, w: Luxe.screen.w/_scale, h: Luxe.screen.h/_scale
        });

        focus = new Focus(canvas);
        canvas.auto_listen();

        new mint.Button({
            parent: canvas,
            name: 'button',
            x: 90, y: 40, w: 60, h: 32,
            text: 'mint',
            text_size: 14,
            options: { label: { color: new Color().rgb(0x9dca63) }},
            onclick: function (e,c) { trace('mint button! ${Luxe.time}'); }
        });

        var grid_image = Luxe.resources.texture('assets/grid.png');
        var cross_image = Luxe.resources.texture('assets/cross.png');
        var knot_image = Luxe.resources.texture('assets/knot.png');

        back = new Sprite({
        color: new Color().rgb(0xffffff),
        pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
        size: new Vector(Luxe.screen.size.x, Luxe.screen.size.y),
        });

        grid = new Sprite({
        name: 'grid',
        texture: grid_image,
        pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y + 40),
        size: new Vector(480, 480),
        });

    } //ready

} //Main
