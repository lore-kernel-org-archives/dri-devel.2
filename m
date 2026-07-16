Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B016AC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB8F10F24B;
	Thu, 16 Jul 2026 09:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zek3X1m/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E30AD10F24B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:21:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94105411EB;
 Thu, 16 Jul 2026 09:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355731F000E9;
 Thu, 16 Jul 2026 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784193702;
 bh=R7imvZFow9XqRL6ugh0hs5hzAXfxyrZnmpuN2TJwGEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zek3X1m/xsQ85g2HGPqvlCw/9xpPXqgJoLBrKO4/vJtjrkT9Qt3Wa1hYYG5LgG4xK
 AaV4xZr5fY7GQnavNhoFIAf9RD6o9tY6+XreGtPdyWtRu4eYJoyz+SMzGVsqiysTfY
 +Bq9ITMgGETAgwak3swdIDCf4UelEJGpc9m+YsO1OS2gVyjj9VXZEXjqgcGRVv2dRo
 tt9HOlNkLVLpXitE7KysnApVpydXHJMHB/9cx8LYRMve04IcsUp7z7TKHJ8nwGakS5
 BwgeqKN2N/5gyGY2vNxNQXpYKxGQ0P11g7Hn+b9SVHxqgBPl3Ij4g1zCM/YW5mFhhV
 SWCapRoKR8klw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] drm/repaper: replace struct
 drm_simple_display_pipe with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260716-drm-simple-kms-removal-v2-6-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-6-1133a8fc3785@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:21:41 +0000
Message-Id: <20260716092142.355731F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing CRTC active check in the plane's atomic_update callback ca=
uses the driver to send SPI framebuffer updates to a powered-off display pa=
nel.

Pre-existing issues:
- [High] The CRTC atomic enable/disable and plane atomic update callbacks e=
xecute sleeping functions and allocate memory with GFP_KERNEL, which is for=
bidden in atomic context.
--

--- Patch [6]: [PATCH v2 6/8] drm/repaper: replace struct drm_simple_displa=
y_pipe with regular atomic helpers ---
commit 3d9748839d37276a557c720301a5a848296e54b7
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/repaper: replace struct drm_simple_display_pipe with regular atomic hel=
pers
   =20
Convert repaper to explicit primary plane, CRTC and encoder objects.
Keep shadow-plane helpers, framebuffer access handling and no-scaling
plane-state validation from simple-KMS path.

> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repape=
r.c
> index c8270591afc7f..7057075161c4d 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c

[ ... ]

> -static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
> -				struct drm_crtc_state *crtc_state,
> -				struct drm_plane_state *plane_state)
> +static void repaper_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					      struct drm_atomic_commit *commit)
>  {
> -	struct repaper_epd *epd =3D drm_to_epd(pipe->crtc.dev);
> +	struct repaper_epd *epd =3D drm_to_epd(crtc->dev);

[Severity: High]
This is a pre-existing issue, but do the CRTC atomic enable/disable and pla=
ne
atomic update callbacks execute sleeping functions in atomic context?

The DRM subsystem explicitly forbids sleeping in CRTC enable/disable and pl=
ane
update callbacks. However:
- repaper_crtc_helper_atomic_enable() calls usleep_range()
- repaper_crtc_helper_atomic_disable() calls msleep()
- repaper_plane_helper_atomic_update() calls repaper_fb_dirty(), which
  allocates memory using GFP_KERNEL

Since these operations are now wired directly to the standard atomic helpers
which run in atomic context (for example, during non-blocking commits), can
this cause system instability or deadlocks?

[ ... ]

> -static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
> -				struct drm_plane_state *old_state)
> +static void repaper_plane_helper_atomic_update(struct drm_plane *plane,
> +					       struct drm_atomic_commit *commit)
>  {
> -	struct drm_plane_state *state =3D pipe->plane.state;
> -	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(state);
> +	struct drm_plane_state *old_pstate =3D drm_atomic_get_old_plane_state(c=
ommit, plane);
> +	struct drm_plane_state *pstate =3D drm_atomic_get_new_plane_state(commi=
t, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(pstate);
>  	struct drm_rect rect;
> =20
> -	if (!pipe->crtc.state->active)
> +	if (!pstate->fb)
>  		return;
> =20
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> -		repaper_fb_dirty(state->fb, shadow_plane_state->data,
> +	if (drm_atomic_helper_damage_merged(old_pstate, pstate, &rect))
> +		repaper_fb_dirty(pstate->fb, shadow_plane_state->data,
>  				 &shadow_plane_state->fmtcnv_state);

[Severity: High]
Can this cause the driver to send SPI framebuffer updates to a powered-off
display panel?

The previous code checked !pipe->crtc.state->active here to ensure we
do not update inactive displays. During a DPMS OFF request,
drm_atomic_helper_commit_modeset_disables() runs first and disables the
panel by calling repaper_crtc_helper_atomic_disable().=20

Next, drm_atomic_helper_commit_planes() will still call this update
function because active_only is not set by default and pstate->visible
can remain true.

Without the crtc_state->active check, doesn't this result in writing data
to dead hardware via repaper_fb_dirty(), potentially causing SPI timeouts
or driver hangs?

>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-drm-simple=
-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com?part=3D6
