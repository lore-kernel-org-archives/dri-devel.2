Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA96D6AAF5
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971D510E493;
	Thu,  2 Apr 2026 16:50:55 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C78A10E493
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 16:50:53 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 403AD1F8005C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 16:50:47 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id CD928B40125; Thu,  2 Apr 2026 16:50:32 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 14645B4011E;
 Thu,  2 Apr 2026 16:50:26 +0000 (UTC)
Date: Thu, 2 Apr 2026 18:50:09 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 3/3] drm: lcdif: Wait for vblank before disabling DMA
Message-ID: <ac6eQcDS8lr-A4ia@shepard>
References: <20260330224619.2620782-1-paulk@sys-base.io>
 <20260330224619.2620782-4-paulk@sys-base.io>
 <m3y0j8mhoz.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a2mfjKByZ2U6+wpv"
Content-Disposition: inline
In-Reply-To: <m3y0j8mhoz.fsf@t19.piap.pl>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--a2mfjKByZ2U6+wpv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue 31 Mar 26, 12:11, Krzysztof Ha=C5=82asa wrote:
> Paul Kocialkowski writes:
> > It is necessary to wait for the full frame to finish streaming
> > through the DMA engine before we can safely disable it by removing
> > the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
> > hardware confused and unable to resume streaming for the next frame.
> >
> > This causes the FIFO underrun and empty status bits to be set and
> > a single solid color to be shown on the display, coming from one of
> > the pixels of the previous frame. The issue occurs sporadically when
> > a new mode is set, which triggers the crtc disable and enable paths.
> >
> > Setting the shadow load bit and waiting for it to be cleared by the
> > DMA engine allows waiting for completion.
> >
> > The NXP BSP driver addresses this issue with a hardcoded 25 ms sleep.
>=20
> ...or "addressed" in the previous version :-)
>=20
> Test results: it works for me: at 1080p60 and 2160p30. I.e. it fixed the
> underrun problem. It's interesting how a CRTC shutdown can affect it's
> subsequent start following an SW_RESET.

Thanks for confirming! Indeed it's a bit surprising. I'm not sure what SW_R=
ESET
does exactly but it may not concern the DMA part. I've tried using it in the
irq handler when the underrun is reported and it didn't do anything at all.

> Or... perhaps it has something to do with the clocks? Also see below.
> If somehow the DMA engine was "running" with it's clock disabled, it
> would result in an underrun, or worse.

Interestingly I tried to keep the clocks always on as an experiment and it
had the opposite effect: the DMA engine would get confused every time after=
 the
first mode set and disable. So for some reason the disabling of the clocks =
seems
to mitigate the issue rather than aggravate it.

I think the issue probably boils down to a corrupted internal state of the =
DMA
engine if it is disabled while streaming pixels. This is more or less what =
the
comment from NXP suggests.

> BTW apparently something converted your tab characters into spaces.

Ah good to know, thanks!

> > --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > @@ -393,6 +393,22 @@ static void lcdif_disable_controller(struct lcdif_=
drm_private *lcdif)
> >         if (ret)
> >                 drm_err(lcdif->drm, "Failed to disable controller!\n");
> >
> > +       /*
> > +        * It is necessary to wait for the full frame to finish streami=
ng
> > +        * through the DMA engine before we can safely disable it by re=
moving
> > +        * the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave =
the
> > +        * hardware confused and unable to resume streaming for the nex=
t frame.
> > +        */
> > +       reg =3D readl(lcdif->base + LCDC_V8_CTRLDESCL0_5);
> > +       reg |=3D CTRLDESCL0_5_SHADOW_LOAD_EN;
> > +       writel(reg, lcdif->base + LCDC_V8_CTRLDESCL0_5);
> > +
> > +       ret =3D readl_poll_timeout(lcdif->base + LCDC_V8_CTRLDESCL0_5,
> > +                                reg, !(reg & CTRLDESCL0_5_SHADOW_LOAD_=
EN),
> > +                                0, 36000);     /* Wait ~2 frame times =
max */
>=20
> I guess this comment is not necessarily correct - at 2160p30 one frame =3D
> ca. 33 ms. Still works, though (I guess anything more than one frame is
> enough). I don't know how long a frame on HDMI (or LVDS, MIPI etc.) can
> take. 30 FPS on 2160p is common because the i.MX8MP can't display 2160p60.

Honestly I think we're good assuming 30 fps (33 ms) is a lower bound.
And the current 36 ms goes even beyond, so I think it's fine.

> Also, found an issue. Perhaps unrelated? Powered the board without HDMI
> connected. Then connected 1080p60 display. It came in 1024x768, console
> 64x24 :-)

That looks more related to a failure to fetch the EDID from the monitor.
1024x768 is the default fallback that is used in this situation.
Maybe check if there is something wrong with the DDC lines from the hdmi
controller, maybe pinmux etc.

> Run weston. Pressed ctrl-alt-backspace. It deadlocked. Sysrq (serial
> console, show blocked state) showed (with *lcdif* in it):
> task:systemd-logind  state:D stack:0     pid:253   tgid:253   ppid:1     =
 task_flags:0x400100 flags:0x00000800
> Call trace:
>  ...
>  schedule+0x34/0x118
>  rpm_resume+0x188/0x678
>  __pm_runtime_resume+0x4c/0x98
>  clk_pm_runtime_get.part.0.isra.0+0x1c/0x94
>  clk_core_set_rate_nolock+0xd0/0x2fc
>  clk_set_rate+0x38/0x158
>  lcdif_crtc_atomic_enable+0x74/0x8d0
>  drm_atomic_helper_commit_crtc_enable+0xac/0x104
>  drm_atomic_helper_commit_tail_rpm+0x68/0xd8
>  commit_tail+0xa4/0x1a4
>  drm_atomic_helper_commit+0x178/0x1a0
>  drm_atomic_commit+0x8c/0xcc
>  drm_client_modeset_commit_atomic+0x1f8/0x25c
>  drm_client_modeset_commit_locked+0x60/0x17c
>  __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x2c/0x8c
>  drm_fb_helper_set_par+0x5c/0x78
>  fb_set_var+0x190/0x35c
>  fbcon_blank+0x178/0x24c
>  do_unblank_screen+0xa8/0x19c
>  vt_ioctl+0x4fc/0x14c0
>  tty_ioctl+0x228/0xb88
>  __arm64_sys_ioctl+0x90/0xe4
>  ...
>=20
> This is reproducible, though not always.

That seems to be in the enable path and related to runtime pm.
I don't think it is related to my patch at all.

> It seems it locks on some mutex - the shell works until I do 'cat
> log.txt' or similar. Now (with std output/error redirection?), weston
> doesn't even start.
>=20
> dmesg doesn't show anything of interest.
> weston: 14.0.2
> using /dev/dri/card1
> DRM: supports atomic modesetting
> DRM: supports GBM modifiers
> DRM: does not support Atomic async page flip
> DRM: supports picture aspect ratio
> Loading module '/usr/lib64/libweston-14/gl-renderer.so'
> Using rendering device: /dev/dri/renderD128
> EGL version: 1.5
> EGL vendor: Mesa Project
> EGL client APIs: OpenGL OpenGL_ES
> ...
> Registered plugin API 'weston_drm_output_api_v1' of size 40
> Registered plugin API 'weston_drm_virtual_output_api_v2' of size 48
> Color manager: no-op
>   protocol support: no
> Output 'HDMI-A-1' attempts EOTF mode SDR and colorimetry mode default.
> Output 'HDMI-A-1' using color profile: stock sRGB color profile
> Chosen EGL config details: id:  17 rgba: 8 8 8 0 buf: 24 dep:  0 stcl: 0 =
int: 1-1 type: win vis_id: XRGB8
> )
> Output HDMI-A-1 (crtc 37) video modes:
> 1920x1080@60.0, preferred, current, 148.5 MHz
>=20
> Output 'HDMI-A-1' enabled with head(s) HDMI-A-1
> Loading module '/usr/lib64/weston/desktop-shell.so'
> launching '/usr/libexec/weston-keyboard'
> launching '/usr/libexec/weston-desktop-shell'
> Warning: computed repaint delay for output [HDMI-A-1] is abnormal: -69164=
 msec (happens always)
>=20
> could not load cursor 'dnd-copy'
> could not load cursor 'dnd-copy'
> could not load cursor 'dnd-none'
> could not load cursor 'dnd-none'
>=20
> Why all these clk* mutexes? Perhaps something didn't work out as it
> should there? clk_set_rate isn't supposed to take much time, is it?

Maybe something to do with the clock driver.
It seems pretty much unrelated to the lcdif driver.

All the best,

Paul

> $ grep clk /tmp/minicom.cap -C1
> [  728.310054]  __pm_runtime_resume+0x4c/0x98
> [  728.310059]  clk_pm_runtime_get.part.0.isra.0+0x1c/0x94
> [  728.310065]  clk_core_set_rate_nolock+0xd0/0x2fc
> [  728.310071]  clk_set_rate+0x38/0x158
> [  728.310076]  lcdif_crtc_atomic_enable+0x74/0x8d0
> --
> [  728.310210]  mutex_lock+0x48/0x58
> [  728.310216]  clk_prepare_lock+0x80/0xc0
> [  728.310223]  clk_unprepare+0x28/0x44
> [  728.310227]  fsl_samsung_hdmi_phy_suspend+0x24/0x40
> --
> [  728.310344]  mutex_lock+0x48/0x58
> [  728.310350]  clk_prepare_lock+0x80/0xc0
> [  728.310359]  clk_unprepare+0x28/0x44
> [  728.310364]  etnaviv_gpu_clk_disable.isra.0+0x28/0x80
> [  728.310372]  etnaviv_gpu_rpm_suspend+0x78/0x1dc
> --
> [  728.310494]  mutex_lock+0x48/0x58
> [  728.310499]  clk_prepare_lock+0x80/0xc0
> [  728.310506]  clk_unprepare+0x28/0x44
> [  728.310512]  sdhci_esdhc_runtime_suspend+0x7c/0x198
> --
> [  728.310627]  mutex_lock+0x48/0x58
> [  728.310632]  clk_prepare_lock+0x80/0xc0
> [  728.310639]  clk_round_rate+0x38/0x1d8
> [  728.310646]  dev_pm_opp_set_rate+0xe4/0x2e0
> --
> [  728.310760]  mutex_lock+0x48/0x58
> [  728.310765]  clk_prepare_lock+0x80/0xc0
> [  728.310771]  clk_prepare+0x1c/0x50
> [  728.310778]  sdhci_esdhc_runtime_resume+0x34/0x180
> --
> [  728.311286]  mutex_lock+0x48/0x58
> [  728.311292]  clk_prepare_lock+0x80/0xc0
> [  728.311298]  clk_prepare+0x1c/0x50
> [  728.311303]  sdhci_esdhc_runtime_resume+0x34/0x180
>=20
> Something fishy here.
> --
> Krzysztof "Chris" Ha=C5=82asa
>=20
> Sie=C4=87 Badawcza =C5=81ukasiewicz
> Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--a2mfjKByZ2U6+wpv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnOnkEACgkQhP3B6o/u
lQymaA/8Cu27/yyOshfCvqQopelEL+8j4/DcmCUAm138wEi8rWc/EG+eZ5P9Falz
x3trgpduIM3oiIPxLR47PGUGiUTSLcs+XnlZVTYUp/Tu3iFG47n6JY6SiQUev43L
bEFjXvIvzMew71be3QyVRKNDOxSXDvONIK5Qtx+/dDyok55iYEm8kWrZDnwbAbE6
yfr0Iqo+FEiLcHqT8RhB/jesQPRS1PiCxkJlMEQMEN4mKXQqm2uPCZ1dMmMD1GXQ
jDj7NaqhnSVQfpsOa/PpoeBgUjtlisku3ypcC1/e8mC+ZmNFZseTfXaUIceOwBTw
LmJc8UFyt4peZfJilrj4kWDbVpn8P3zL9Tj9+JsPbGZW4/klJZ5LSYCLbZCQT4n5
LkxGxSjqNCO4A/fUvBhIClyp0+WpDrC+guIUk+pg5WrIsN4hLxWXpO0lxjDT+qyp
IsDeUcDEqHA95gP9LogZzy0H0yhq5HTBhXx7EDs4pXGKf4nTrfB8JLrIGhQO6QFH
g1VEEkRq8XvByVCGaByNcPIUh1uWqYDx9ybHsc1+/5GF+qzhXpPGTDRGjj8L0GMs
WQ8NaGNVPSeEEMWbqghtb5lTdqTdPndFhyJXJWY73o60oAGZiE+wW8fZpcvY8DK7
N231m3Ihf/BmRWl5jujv95ju1zvIsqs9UEDwUUpJwKdrnjSPbeE=
=87Mt
-----END PGP SIGNATURE-----

--a2mfjKByZ2U6+wpv--
