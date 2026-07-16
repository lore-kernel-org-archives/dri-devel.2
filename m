Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DDBC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC9910E764;
	Thu, 16 Jul 2026 09:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kf9Z3JaT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A8B10E764
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:26:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 700B660054;
 Thu, 16 Jul 2026 09:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C091F00A3A;
 Thu, 16 Jul 2026 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784193982;
 bh=nCSwnqQabuJMg8q90sAMwf14yyJp0QSnd6qco2rkM5U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kf9Z3JaTqc2FLQqXll7oyB3RgdSEKkWMohpV9z6ATmTQl66lGPE8LBFlBb+6WOGgC
 xSjmmci5y60CHltYc/sc9VieAEoYvH0qVks/IeXRyVF0XR8s0hOmFGJqDyQfT0fLvt
 7VWdFsMTAobklwMkmoDHyp13MbRLKAYONn1sCse76PEyZYhgAwn6YkJfjCJr1Thtnm
 kB1CpwIZdmpsigmwLGnEOV/MsiZ72OUGzu2OVEsMWts8xOXoaaVMC21LMf3akMW8PR
 TFssdxuLeGlr7qums9GsiYQ2THxWiu1rfPcPrqUyvo4CmMFg90AX92iNzFmYopfv7G
 ghrIOn96NPGBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] drm/pl111: replace struct
 drm_simple_display_pipe with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260716-drm-simple-kms-removal-v2-4-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-4-1133a8fc3785@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:26:21 +0000
Message-Id: <20260716092621.D8C091F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pending vblank events are leaked during CRTC disable. The DRM subs=
ystem requires that pending vblank events requested by userspace (e.g., dur=
ing a pageflip) are consumed and sent when the CRTC is disabled. In this pa=
tch, event consumption is implemented in `pl111_crtc_helper_atomic_flush()`=
. However, the DRM core (`drm_atomic_helper_commit_planes`) only calls `ato=
mic_flush` for active CRTCs. When a CRTC is being disabled, `atomic_flush` =
is skipped, and the event must be consumed in the `atomic_disable` hook. `p=
l111_crtc_helper_atomic_disable()` fails to check for or consume `cstate->e=
vent`. As a result, the event is leaked.
- [High] Unsafe access to global plane state in `pl111_crtc_helper_atomic_e=
nable()`. The function retrieves the framebuffer using `priv->plane.state->=
fb` directly instead of using the committed atomic state via `drm_atomic_ge=
t_new_plane_state()`. In the DRM core, non-blocking atomic commits synchron=
ously swap the global state pointers before the asynchronous commit workers=
 run. This creates a Time-of-Check to Time-of-Use (TOCTOU) vulnerability.
- [High] Sleeping functions are called from atomic context. The DRM subsyst=
em guide explicitly defines CRTC `atomic_enable` and `atomic_disable` callb=
acks as executing in an atomic context during non-blocking commits, where s=
leeping is strictly forbidden. However, `pl111_crtc_helper_atomic_enable()`=
 and `pl111_crtc_helper_atomic_disable()` call blocking functions: `clk_pre=
pare_enable()`, `clk_disable_unprepare()`, and `msleep(20)`.
--

--- Patch [4]: [PATCH v2 4/8] drm/pl111: replace struct drm_simple_display_=
pipe with regular atomic helpers ---
commit 07a755e3243c0f70ec87dc33910c7d68aa70590c
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/pl111: replace struct drm_simple_display_pipe with regular atomic helpe=
rs
   =20
Replace PL111 simple display pipe with explicit plane, CRTC and encoder
objects. Keep the existing PL111 timing, format and pitch validation, but
move it into the explicit atomic check paths. Move event handling to the CR=
TC
commit path.

> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl11=
1/pl111_display.c
> index 5d10bc5fdf1f6..beb6423d4d439 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c

[ ... ]

> @@ -117,16 +137,14 @@ static int pl111_display_check(struct drm_simple_di=
splay_pipe *pipe,
> -static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
> -				 struct drm_crtc_state *cstate,
> -				 struct drm_plane_state *plane_state)
> +static void pl111_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					    struct drm_atomic_commit *commit)
>  {
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> -	struct drm_plane *plane =3D &pipe->plane;
>  	struct drm_device *drm =3D crtc->dev;
>  	struct pl111_drm_dev_private *priv =3D drm->dev_private;
> +	struct drm_crtc_state *cstate =3D drm_atomic_get_new_crtc_state(commit,=
 crtc);
>  	const struct drm_display_mode *mode =3D &cstate->mode;
> -	struct drm_framebuffer *fb =3D plane->state->fb;
> +	struct drm_framebuffer *fb =3D priv->plane.state->fb;

[Severity: High]
This is a pre-existing issue, but does this direct access to the global pla=
ne
state in pl111_crtc_helper_atomic_enable() introduce a time-of-check to
time-of-use vulnerability?

By retrieving the framebuffer using priv->plane.state->fb directly instead
of fetching the committed atomic state via drm_atomic_get_new_plane_state(),
this might race with subsequent commits. If userspace submits a non-blocking
commit to enable the CRTC, followed immediately by another commit that
disables the primary plane (setting fb to NULL), the global state pointer
updates to the second commit. When the first commit's asynchronous worker
executes this function, it could read the new global state where fb is NULL,
causing a null pointer dereference when accessing fb->format->format.

>  	struct drm_connector *connector =3D priv->connector;
>  	struct drm_bridge *bridge =3D priv->bridge;
>  	bool grayscale =3D false;
>  	u32 cntl;
>  	u32 ppl, hsw, hfp, hbp;
>  	u32 lpp, vsw, vfp, vbp;
>  	u32 cpl, tim2;
>  	int ret;
> =20
>  	ret =3D clk_set_rate(priv->clk, mode->clock * 1000);
>  	if (ret) {
>  		drm_err(drm,
>  			"Failed to set pixel clock rate to %d: %d\n",
>  			mode->clock * 1000, ret);
>  	}
> =20
>  	clk_prepare_enable(priv->clk);

[Severity: High]
This is a pre-existing issue, but are blocking functions being called from =
an
atomic context here?

The DRM subsystem explicitly defines CRTC atomic_enable and atomic_disable
callbacks as executing in an atomic context during non-blocking commits,
where sleeping is strictly forbidden. However,=20
pl111_crtc_helper_atomic_enable() calls blocking functions such as=20
clk_prepare_enable() and msleep(). This might lead to system instability,=20
kernel warnings, or deadlocks.

[ ... ]

>  	/* The PL110 in Integrator/Versatile does the BGR routing externally */
>  	if (priv->variant->external_bgr)
>  		cntl &=3D ~CNTL_BGR;
> =20
>  	/* Power sequence: first enable and chill */
>  	writel(cntl, priv->regs + priv->ctrl);
> =20
>  	/*
>  	 * We expect this delay to stabilize the contrast
>  	 * voltage Vee as stipulated by the manual
>  	 */
>  	msleep(20);

[Severity: High]
This is a pre-existing issue, but similar to the clk_prepare_enable() call,
does calling msleep() in pl111_crtc_helper_atomic_enable() violate the DRM
subsystem guidelines for atomic context execution?

Sleeping from this path could cause warnings or deadlocks during non-blocki=
ng
commits.

[ ... ]

> @@ -355,9 +373,9 @@ static void pl111_display_enable(struct drm_simple_di=
splay_pipe *pipe,
>  		drm_crtc_vblank_on(crtc);
>  }
> =20
> -static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
> +static void pl111_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +					     struct drm_atomic_commit *commit)
>  {

[Severity: High]
This is a pre-existing issue, but does pl111_crtc_helper_atomic_disable() l=
eak
pending vblank events during CRTC disable?

The DRM subsystem requires that pending vblank events requested by userspace
(like during a pageflip) are consumed and sent when the CRTC is disabled. In
this code, event consumption happens in pl111_crtc_helper_atomic_flush().
However, the DRM core skips atomic_flush() for disabled CRTCs, meaning the
event must be consumed in the atomic_disable hook.

Since pl111_crtc_helper_atomic_disable() fails to check for or consume
cstate->event, the event might be leaked. This could trigger a kernel warni=
ng
in drm_atomic_helper_commit_hw_done() and cause the userspace compositor to
hang indefinitely.

> -	struct drm_crtc *crtc =3D &pipe->crtc;
>  	struct drm_device *drm =3D crtc->dev;
>  	struct pl111_drm_dev_private *priv =3D drm->dev_private;
>  	u32 cntl;

[ ... ]

>  	/* Power Down */
>  	cntl =3D readl(priv->regs + priv->ctrl);
>  	if (cntl & CNTL_LCDPWR) {
>  		cntl &=3D ~CNTL_LCDPWR;
>  		writel(cntl, priv->regs + priv->ctrl);
>  	}
> =20
>  	/*
>  	 * We expect this delay to stabilize the contrast voltage Vee as
>  	 * stipulated by the manual
>  	 */
>  	msleep(20);
> =20
>  	if (priv->variant_display_disable)
>  		priv->variant_display_disable(drm);
> =20
>  	/* Disable */
>  	writel(0, priv->regs + priv->ctrl);
> =20
>  	clk_disable_unprepare(priv->clk);
>  }

[Severity: High]
This is a pre-existing issue, but does calling msleep() and
clk_disable_unprepare() in pl111_crtc_helper_atomic_disable() block executi=
on
in an atomic context?

Since this callback runs in an atomic context during non-blocking commits,
these blocking calls might lead to system instability or deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-drm-simple=
-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com?part=3D4
