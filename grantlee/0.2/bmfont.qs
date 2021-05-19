const ExportData = function (_root) {
    const bmfont = new exporter(_root);
    return bmfont.toString();
};

ExportData.filterName = "ExportData";
Library.addFilter("ExportData");

function exporter(_root) {
    this.tp = _root;
    this.lineHeight = 1;
    for (var i = 0; i < this.tp.allSprites.length; i++) {
        const sprite = this.tp.allSprites[i];
        if (sprite.frameRect.height > this.lineHeight) {
            this.lineHeight = sprite.frameRect.height;
        }
    }
}

exporter.prototype = {
    info: function () {
        return "info face=\"" + this.tp.exporterProperties.face + "\"" + " size=" + this.lineHeight + " bold=0 italic=0 charset=\"\" unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=1,1 outline=0"
    },

    common: function () {
        return "common lineHeight=" + this.lineHeight + " base=26 scaleW=" + this.tp.texture.size.width + " scaleH=" + this.tp.texture.size.height + " pages=1 packed=0 alphaChnl=1 redChnl=0 greenChnl=0 blueChnl=0"
    },

    spriteLines: function () {
        return this.page();
    },

    page: function () {
        var str = ""
        for (var i = 0; i < this.tp.allSprites.length; i++) {
            str += "\n"
                + this.char(this.tp.allSprites[i])
        }
        return this.pageHead() + str;
    },

    pageHead: function () {
        return "page id=0 file=\"" + this.tp.texture.fullName + "\""
            + "\n"
            + "chars count=" + this.tp.allSprites.length;
    },

    char: function (sprite) {
        return "char id=" + sprite.trimmedName.charCodeAt(0) + " x=" + sprite.frameRect.x + " y=" + sprite.frameRect.y + " width=" + sprite.untrimmedSize.width + " height=" + sprite.untrimmedSize.height + " xoffset=" + sprite.sourceRect.x + " yoffset=" + (this.lineHeight - sprite.frameRect.height) / 2 + " xadvance=" + sprite.frameRect.width + " page=0 chnl=0 letter=\"" + sprite.trimmedName + "\""
    },

    toString: function () {
        return this.info() + "\n"
            + this.common() + " key=" + this.tp.smartUpdateKey + " \n"
            + this.spriteLines();
    }
}