package tvmlkit.tvjs.externs;

/** Allowed values for the formatNumber function */
@:enum
abstract NumberFormat(String) {
    var NoStyle    = "noStyle";
    var Currency   = "currency";
    var Decimal    = "decimal";
    var Percent    = "percent";
    var Scientific = "scientific";
    var SpellOut   = "spellOut";
}
