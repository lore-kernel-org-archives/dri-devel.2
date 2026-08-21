Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24495C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 12:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5514310E293;
	Fri, 21 Aug 2026 12:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X2pHkczR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AF810E293
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 12:52:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A27060A6E;
 Fri, 21 Aug 2026 12:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D11F000E9;
 Fri, 21 Aug 2026 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787316114;
 bh=RtvGrKa6OAg1aYHccKfYOz4sodKKguzXiQooFBazjlo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X2pHkczRbe6u/CuwB/g5wD3liWMnR0Tk6rI8mXduzVdaRlPOXHy48lpiUxHU/YV+a
 WXeeFnBwBTt3YTZ0BuQPcgj5uF0lh4Xq2cpfLQXexNaahz0eK9xg+wFK889Z7GK3oF
 E98thnlHcFuh41oBgo+6IEDLdZEmC5ElmhpaM89yB6+HsX4t00QD3WLOPgyoSm3dv6
 LcKNacOHjLXAhdS/Tf5GU4bcKg4WtOsCXFxcbFLVhz8O76vl6zexGVlYV/bntS50hY
 HpMzMvpWpxRduVuFy1r1WARP3iY4DofPOxwD8nkrdtHgekyzU+WYM/l6XSP1PA/1Qj
 dt13HlJthFovA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imx: dcss: Silence blend mode not set boot warning
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260821122608.2077746-1-laurentiu.palcu@oss.nxp.com>
References: <20260821122608.2077746-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 12:41:53 +0000
Message-Id: <20260821124153.C00D11F000E9@smtp.kernel.org>
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
- [High] Initial pixel_blend_mode property is set to an unsupported value (=
PREMULTI), causing userspace compositor crashes.
- [High] Fast-path atomic commits silently drop alpha and pixel_blend_mode =
property updates.
--

--- Patch [1]: [PATCH] drm/imx: dcss: Silence blend mode not set boot warni=
ng ---
commit b8d70d6b989c5f19b4322dbd26927d62d307bf28
Author: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

drm/imx: dcss: Silence blend mode not set boot warning

This addresses a boot warning about missing blend mode when a pixel format
with alpha is exposed. It adds the alpha and blending properties to the
primary plane.

> diff --git a/drivers/gpu/drm/imx/dcss/dcss-crtc.c b/drivers/gpu/drm/imx/d=
css/dcss-crtc.c
> index ab41759a9f52d..8358219c94c0d 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-crtc.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-crtc.c
[ ... ]
> @@ -202,6 +203,11 @@ int dcss_crtc_init(struct dcss_crtc *crtc, struct dr=
m_device *drm)
>  		return ret;
>  	}
> =20
> +	drm_plane_create_alpha_property(&crtc->plane[0]->base);
> +	drm_plane_create_blend_mode_property(&crtc->plane[0]->base,
> +					     BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +					     BIT(DRM_MODE_BLEND_COVERAGE));

[Severity: High]
Does exposing only PIXEL_NONE and COVERAGE cause issues with the default pl=
ane
reset?

Looking at the driver, it uses the default drm_atomic_helper_plane_reset ho=
ok:

drivers/gpu/drm/imx/dcss/dcss-plane.c:
struct drm_plane_funcs dcss_plane_funcs =3D {
    ...
    .reset =3D drm_atomic_helper_plane_reset,
    ...
};

This core helper unconditionally initializes state->pixel_blend_mode to
DRM_MODE_BLEND_PREMULTI. If the property is created here with only
PIXEL_NONE and COVERAGE supported, will userspace compositors (like Weston)
receive an invalid enum value during startup and crash when querying
properties?

> +
>  	crtc->irq =3D platform_get_irq_byname(pdev, "vblank");
>  	if (crtc->irq < 0)
>  		return crtc->irq;
[ ... ]
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/imx/=
dcss/dcss-plane.c
> index 1746dc5d4b642..06413d0612349 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-plane.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
[ ... ]
> @@ -336,7 +344,8 @@ static void dcss_plane_atomic_update(struct drm_plane=
 *plane,
>  	dcss_dtg_plane_pos_set(dcss->dtg, dcss_plane->ch_num,
>  			       dst.x1, dst.y1, dst_w, dst_h);
>  	dcss_dtg_plane_alpha_set(dcss->dtg, dcss_plane->ch_num,
> -				 fb->format, new_state->alpha >> 8);
> +				 fb->format, new_state->alpha >> 8,
> +				 new_state->pixel_blend_mode);

[Severity: High]
Does the fast-path logic earlier in this function silently drop alpha and
pixel_blend_mode updates?

Earlier in dcss_plane_atomic_update(), there is an early return based on
dcss_plane_needs_setup():

    if (old_state->fb && !drm_atomic_crtc_needs_modeset(crtc_state) &&
        !dcss_plane_needs_setup(new_state, old_state)) {
        dcss_plane_atomic_set_base(dcss_plane);
        return;
    }

Since dcss_plane_needs_setup() only checks geometry, formatting, rotation, =
and
scaling:

    return state->crtc_x !=3D old_state->crtc_x ||
           ...
           state->scaling_filter !=3D old_state->scaling_filter;

Will an atomic commit that only modifies the alpha or pixel_blend_mode
properties cause dcss_plane_needs_setup() to return false?

This would result in returning early and skipping the
dcss_dtg_plane_alpha_set() hardware update entirely.

> =20
>  	if (!dcss_plane->ch_num && (new_state->alpha >> 8) =3D=3D 0)
>  		enable =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821122608.2077=
746-1-laurentiu.palcu@oss.nxp.com?part=3D1
