
import luxe.GameConfig;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.States;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.*;
import mint.layout.margins.Margins;
import mint.focus.Focus;

class Main extends luxe.Game {

    public static var focus: Focus;
    public static var layout: Margins;
    public static var canvas: AutoCanvas;
    public static var rendering: LuxeMintRender;

    public static var state : States;
    public static var piece : Piece;

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

        state = new States();
        piece = X;

        state.add( new Menu({ name: 'state0' }) );
        state.add( new Board({ name: 'state1' }) );

        state.set('state0');

    } //ready

    public static function changeState(to:String) {

        canvas.destroy_children();
        state.set(to);

    }

} //Main
