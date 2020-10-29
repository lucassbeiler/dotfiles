static void gap_tile(Monitor*);

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static unsigned int gappx           = 5;        /* gaps size */

static const unsigned int systraypinning = 1;
static const unsigned int systrayspacing = 1;
static const unsigned int showsystray	 = 1;
static const int systraypinningfailfirst = 1;

static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Hack:size=10", "FontAwesome:size=8" };
static const char dmenufont[]       = "Hack:size=10";

/* dmenu colors */
static const char dmenunb[]	    = "#282828";
static const char dmenunf[]         = "#ebdbb2";
static const char dmenusb[]         = "#458588";
static const char dmenusf[]         = "#282828";

/* general colors */
static const char col_gray2[]       = "#444444";
static const char cores[]    	    = "#262626";
static const char col_fg_bar[]      = "#B0B0B0";
static const char col_cyan[]        = "#005577";
static const char col_black[]       = "#000000";
static const char col_white[]       = "#ffffff";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_fg_bar, cores, col_gray2 },
	[SchemeSel]  = { col_white, cores,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	{ "Android Studio", NULL, NULL, 0, 1, -1 },
};


/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[=]",      gap_tile },    /* gaps - first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[]=",      tile }, /* normal tiles */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* main commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spa/n() */
static const char *dmenucmd[] = { "dmenu_run", "-i", "-m", dmenumon, "-fn", dmenufont, "-nb", dmenunb, "-nf", dmenunf, "-sb", dmenusb, "-sf", dmenusf, NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
#include <X11/XF86keysym.h>
	{ 0,		                XF86XK_AudioRaiseVolume, spawn, SHCMD("pactl set-sink-volume 0 +5%") },
	{ 0,				XF86XK_AudioLowerVolume, spawn, SHCMD("pactl set-sink-volume 0 -5%") },
//	{ 0,				XF86XK_AudioMute,        spawn, SHCMD("maim -u -s | xclip -selection clipboard -t image/png") },

	/* standard bindings */
	{ MODKEY|ShiftMask,		XK_c,	   spawn,	   SHCMD("chromium --incognito --start-maximized") },
	{ MODKEY|ShiftMask,		XK_t,	   spawn,	   SHCMD("bwrap --ro-bind /usr/bin/telegram-desktop /usr/bin/telegram-desktop --ro-bind /usr/lib64 /usr/lib64 --ro-bind /usr/lib /usr/lib --ro-bind /usr/share/fonts /usr/share/fonts --ro-bind /etc/ca-certificates /etc/ca-certificates --ro-bind-try /etc/crypto-policies /etc/crypto-policies --ro-bind /etc/fonts /etc/fonts --ro-bind /etc/ld.so.cache /etc/ld.so.cache --ro-bind /etc/localtime /etc/localtime --ro-bind /etc/machine-id /etc/machine-id --ro-bind-try /etc/pki /etc/pki --ro-bind /etc/pulse /etc/pulse --ro-bind /etc/resolv.conf /etc/resolv.conf --ro-bind /etc/ssl /etc/ssl  --ro-bind /home /home --symlink /usr/lib64 /lib64 --proc /proc --dev /dev --tmpfs /tmp --unshare-all --share-net --die-with-parent --new-session --dir /run/user/$(id -u) --ro-bind /run/user/$(id -u)/pulse /run/user/$(id -u)/pulse  --cap-drop ALL --ro-bind /usr/share/X11/locale /usr/share/X11/locale --bind $HOME/.local/share/TelegramDesktop $HOME/.local/share/TelegramDesktop telegram-desktop") },
	{ MODKEY,			XK_z,	   spawn,	   SHCMD("flameshot gui") },
	{ MODKEY,			XK_a,	   spawn,	   SHCMD("flameshot") },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.03} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.03}},
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_w,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


void gap_tile(Monitor *m) {
	unsigned int gap = gappx, i, n, h, mw, my, ty;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);
	if (n == 0)
		return;

	if (n > m->nmaster)
		mw = m->nmaster ? m->ww * m->mfact : 0;
	else
		mw = m->ww;

	for (i = my = ty = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++)
		if (i < m->nmaster) {
			h = (m->wh - my - gap) / (MIN(n, m->nmaster) - i);
			resize(c, m->wx + gap, m->wy + my + gap, mw - (2*c->bw) - (2*gap), h - (2*c->bw) - gap, 0);
			my += HEIGHT(c) + gap;
		} else {
			h = (m->wh - ty - gap) / (n - i);
			resize(c, m->wx + mw + gap, m->wy + ty + gap, m->ww - mw - (2*c->bw) - (2*gap), h - (2*c->bw) - gap, 0);
			ty += HEIGHT(c) + gap;
		}
}
