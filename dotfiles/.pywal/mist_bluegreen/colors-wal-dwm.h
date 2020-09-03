static const char norm_fg[] = "#e3e0dc";
static const char norm_bg[] = "#191e22";
static const char norm_border[] = "#9e9c9a";

static const char sel_fg[] = "#e3e0dc";
static const char sel_bg[] = "#637291";
static const char sel_border[] = "#e3e0dc";

static const char urg_fg[] = "#e3e0dc";
static const char urg_bg[] = "#3B5D85";
static const char urg_border[] = "#3B5D85";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
