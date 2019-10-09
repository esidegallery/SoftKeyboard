package
{
    import cc.cote.feathers.softkeyboard.CharCode;
    import cc.cote.feathers.softkeyboard.Key;
    import cc.cote.feathers.softkeyboard.SoftKeyboard;

    import feathers.controls.Callout;
    import feathers.controls.Label;
    import feathers.controls.text.TextFieldTextRenderer;
    import feathers.core.FeathersControl;
    import feathers.core.ITextRenderer;
    import feathers.themes.StyleNameFunctionTheme;

    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.BitmapFont;
    import feathers.skins.ImageSkin;
    import feathers.controls.text.BitmapFontTextRenderer;
    import feathers.text.BitmapFontTextFormat;

    public class Theme extends StyleNameFunctionTheme
    {
        [Embed("/assets/theme.png")]
		private static const ATLAS_BITMAP:Class;
		
		[Embed("/assets/theme.xml", mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;

        [Embed(source="assets/MarkerFelt.fnt", mimeType="application/octet-stream")]
        public static const FONT_XML:Class;

        protected var atlas:TextureAtlas;
        protected var bitmapFont:BitmapFont;

        /**
         * Instantiates a new feathers theme which will be actively monitoring the Starling stage
         * and skinning components as they are added to it.
         */
        public function Theme()
        {
            super();

            initializeTextures();
            initializeFonts();
            initializeStyleProviders();
        }

        protected function getTexture(name:String):Texture
		{
			return atlas.getTexture(name);
		}

        protected function initializeTextures():void
        {
            var atlasTexture:Texture = Texture.fromEmbeddedAsset(ATLAS_BITMAP);
			var atlasXML:XML = XML(new ATLAS_XML);
			atlas = new TextureAtlas(atlasTexture, atlasXML);
        }

        protected function initializeFonts():void
        {
            // // SCENARIO 1: Use a TextFieldTextRenderer
            // FeathersControl.defaultTextRendererFactory = function():ITextRenderer
            // {
            //     var tftr:TextFieldTextRenderer = new TextFieldTextRenderer();
            //     tftr.textFormat = new TextFormat('_sans', 16, 0xFFFFFF, true);
            //     tftr.textFormat.align =ddd TextFormatAlign.CENTER
            //     return tftr;
            // };

            // // SCENARIO 2: Use a BitmapFontTextRenderer
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer 
            {
				var bftr:BitmapFontTextRenderer = new BitmapFontTextRenderer;
				bftr.textFormat = new BitmapFontTextFormat(bitmapFont, 24);
				bftr.textFormat.align = TextFormatAlign.CENTER;
				return bftr;
			};

            bitmapFont = new BitmapFont(getTexture("MarkerFelt"), XML(new FONT_XML));
        }

        protected function initializeStyleProviders():void
        {
            getStyleProviderForClass(SoftKeyboard).defaultStyleFunction = setSoftKeyboardStyles;
            getStyleProviderForClass(Key).defaultStyleFunction = setKeyStyles;
            getStyleProviderForClass(Label).defaultStyleFunction = setKeyLabelStyles;
            getStyleProviderForClass(Callout).defaultStyleFunction = setCalloutStyles;
        }

        /** Initializer for the Key subcomponent */
        private function setKeyStyles(k:Key):void
        {
            // Assign regular key skins
            k.regularKeyUpSkin = new Image(getTexture("SoftKeyboardKeySkinRegularUp"));
            (k.regularKeyUpSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);
            k.regularKeyHoverSkin = new Image(getTexture("SoftKeyboardKeySkinRegularHover"));
            (k.regularKeyHoverSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);
            k.regularKeyDownSkin = new Image(getTexture("SoftKeyboardKeySkinRegularDown"));
            (k.regularKeyDownSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);

            // Assign special key skins
            k.specialKeyUpSkin = new Image(getTexture("SoftKeyboardKeySkinSpecialUp"));
            (k.specialKeyUpSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);
            k.specialKeyHoverSkin = new Image(getTexture("SoftKeyboardKeySkinSpecialHover"));
            (k.specialKeyHoverSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);
            k.specialKeyDownSkin = new Image(getTexture("SoftKeyboardKeySkinSpecialDown"));
            (k.specialKeyDownSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);

            // Assign skins for key that have variants
            k.hasVariantsKeyUpSkin = new Image(getTexture("SoftKeyboardKeySkinHasVariantsUp"));
            (k.hasVariantsKeyUpSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);
            k.hasVariantsKeyHoverSkin = new Image(getTexture("SoftKeyboardKeySkinHasVariantsHover"));
            (k.hasVariantsKeyHoverSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);
            k.hasVariantsKeyDownSkin = new Image(getTexture("SoftKeyboardKeySkinHasVariantsDown"));
            (k.hasVariantsKeyDownSkin as Image).scale9Grid = new Rectangle(5, 5, 40, 40);

            switch (k.charCode)
            {
                case CharCode.NUM_LOCK:
                {
                    k.icon = new ImageSkin(getTexture("SoftKeyboardIconBackspace"));
                    break;
                }
                case CharCode.BACKSPACE:
                {
                    k.icon = new ImageSkin(getTexture("SoftKeyboardIconBackspace"));
                }
                case CharCode.RETURN:
                {
                    k.icon = new ImageSkin(getTexture("SoftKeyboardIconEnter"));
                }
                case CharCode.TAB:
                {
                    k.icon = new ImageSkin(getTexture("SoftKeyboardIconTab"));
                }
                case k.charCode == CharCode.CAPS_LOCK:
                {
                    k.icon = new ImageSkin(getTexture("SoftKeyboardIconCapsLock"));
                    k.selectedIcon = new ImageSkin(getTexture("SoftKeyboardIconCapsLockSelected"));
                }
            }
        }

        private function setKeyLabelStyles(l:Label):void
        {

            // Example: if you want to style the letter 'M' differently
//			if (l.nameList.contains('M')) {
//				l.textRendererProperties.textFormat = new TextFormat('_sans', 22, 0xFF0000);
//			}

        }

        /** Initializer for the Callout component */
        public function setCalloutStyles(c:Callout):void
        {
            c.backgroundSkin = new Image(getTexture("SoftKeyboardCalloutBackground"));
            (c.backgroundSkin as Image).scale9Grid = new Rectangle(15, 15)

            c.topArrowSkin = new Image(getTexture("SoftKeyboardCalloutTopArrow"));
            c.rightArrowSkin = new Image(getTexture("SoftKeyboardCalloutRightArrow"));
            c.bottomArrowSkin = new Image(getTexture("SoftKeyboardCalloutBottomArrow"));
            c.leftArrowSkin = new Image(getTexture("SoftKeyboardCalloutLeftArrow"));

            c.paddingLeft = 8;
            c.paddingRight = 12;
            c.paddingTop = 7;
            c.paddingBottom = 12;

            c.bottomArrowGap = c.topArrowGap = c.leftArrowGap = c.rightArrowGap = -2;
        }

        private function setSoftKeyboardStyles(s:SoftKeyboard):void
        {
            s.backgroundSkin = new Image(getTexture("SoftKeyboardGlobalBackground"));
            (s.backgroundSkin as Image).scale9Grid = new Rectangle(15, 15);
            s.padding = 10;
        }
    }
}
