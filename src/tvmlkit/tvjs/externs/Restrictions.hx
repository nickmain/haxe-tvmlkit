package tvmlkit.tvjs.externs;

/** Rating restrictions - obtain from Settings */
extern class Restrictions {

    /** Whether any explicit media is allowed */
    var allowsExplicit(default,null): Bool;

    /** The maximum allowed ranking for a movie, ranging from 0 to 1000 */
    var maxMovieRank(default,null): Int;

    /** The maximum allowed ranking for a television show, ranging from 0 to 1000 */
    var maxTVShowRank(default,null): Int;

    /** Maximum movie rating allowed for the specified country */
    function maxMovieRatingForCountry(countryCode: String): String;

    /** Maximum television show rating allowed for the specified country */
    function maxTVShowRatingForCountry(countryCode: String): String;
}
