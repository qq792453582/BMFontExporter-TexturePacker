const exportData = function (_root) {
    const bmfont = new exporter(_root);
    return bmfont.toString();
};

exportData.filterName = "exportData";
Library.addFilter("exportData");

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
    writeHead: function () {
        return "info face=\"" + this.tp.exporterProperties.face + "\""
            + " size=" + this.lineHeight + " bold=0 italic=0 charset=\"\" unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=1,1 outline=0"
            + "\n"
            + "common lineHeight=" + this.lineHeight
            + " base=26 scaleW=" + this.tp.texture.size.width
            + " scaleH=" + this.tp.texture.size.height + " pages=1 packed=0 alphaChnl=1 redChnl=0 greenChnl=0 blueChnl=0"
    },

    writePages: function () {
        return this.writePage();
    },

    writePage: function () {
        for (var i = 0; i < this.tp.allSprites.length; i++) {
            str += "\n"
                + this.writeChar(this.tp.allSprites[i])
        }
        return this.writePageHead() + str;
    },

    writePageHead: function () {
        return "page id=0 file=\"" + this.tp.texture.fullName + "\""
            + "\n"
            + "chars count=" + this.tp.allSprites.length;
    },

    writeChar: function (sprite) {
        return "char id=" + sprite.trimmedName.charCodeAt(0)
            + " x=" + sprite.frameRect.x
            + " y=" + sprite.frameRect.y
            + " width=" + sprite.untrimmedSize.width
            + " height=" + sprite.untrimmedSize.height
            + " xoffset=" + sprite.sourceRect.x
            + " yoffset=" + (this.lineHeight - sprite.frameRect.height) / 2
            + " xadvance=" + sprite.frameRect.width
            + " page=0 chnl=0 letter=\"" + sprite.trimmedName + "\""
    },

    toString: function () {
        return this.writeHead()
            + "\n"
            + this.writePages();
    }
}