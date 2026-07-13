Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0F4C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D8310E948;
	Mon, 13 Jul 2026 12:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iwqCuq98";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7713C10E94B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:08:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB7996004E;
 Mon, 13 Jul 2026 12:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF3C1F000E9;
 Mon, 13 Jul 2026 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783944483;
 bh=/aYN/zji52JE50Z8K1sfRhmyCL9AH/yeX+d6wrZ8ZEM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iwqCuq98h+TMlXlWJU+siwxZqb3DX3Ltp75tAcg2JTXcZyDPjZ6FU6x8qjViiep6/
 lOFXBIg+B6J2gOUb9lapdXu5jLXiBJdIwRtQ7kzr3GeddoUg/15jiUYh5/UR0BomoX
 acjUEMbP6NaCa5IH/aO40azhC2oXNLxUcXyYGDpBjm6wL5xqGzWeDEdWjnaU2yWa4V
 zbWTXqWB9/NQ3pHjxUVSeyP3EtjoYZEzDn1kRdzNupZXrSeTEnOcksWM4CSU4Kcujc
 P+gpNSoD3IWTUNjPTNPNWwlwQqVNxpMx3jbp6iGZ71dXHRQk3ASao9zUrzmms9rYv9
 8yLSXLTPqtzEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] drm: release panel reference after panel bridge
 creation
To: "Albert Esteve" <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 Frank.Li@kernel.org, imx@lists.linux.dev, linux-sunxi@lists.linux.dev
In-Reply-To: <20260713-drm_refcount_wiring-v2-5-d3bb61f4bd4d@redhat.com>
References: <20260713-drm_refcount_wiring-v2-0-d3bb61f4bd4d@redhat.com>
 <20260713-drm_refcount_wiring-v2-5-d3bb61f4bd4d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:08:02 +0000
Message-Id: <20260713120803.2CF3C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `drm_panel_bridge_remove` with an `ERR_PTR` on the error p=
ath causes a kernel oops.
- [High] Missing `IS_ERR` check for `devm_drm_panel_bridge_add_typed` retur=
n value leads to `ERR_PTR` dereference in `drm_bridge_attach`.
- [High] Error handling failures in `rockchip_rgb_init()` lead to a danglin=
g encoder in DRM core lists and a leaked panel bridge.
- [Medium] Hijacking `bridge->funcs` in `rockchip_lvds_bind` breaks panel b=
ridge cleanup, causing memory and reference leaks.
- [Medium] The `mcde_drv` driver leaks the panel bridge and panel reference=
 on error paths and during teardown.
--

--- Patch [5]: [PATCH v2 5/5] drm: release panel reference after panel brid=
ge creation ---
commit 03ed59fea0a81ee259951270dc961716491dc0bd
Author: Albert Esteve <aesteve@redhat.com>
Subject: drm: release panel reference after panel bridge creation

This commit updates a second batch of drivers calling of_drm_find_panel() or
drm_of_find_panel_or_bridge() to release the lookup reference after wrapping
the panel in a bridge. It also handles paths where a panel is found but
cannot be used by dropping the reference immediately.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1297,9 +1297,11 @@ static int ingenic_drm_bind(struct device *dev, bo=
ol has_components)
>  			goto err_drvdata;
>  		}
> =20
> -		if (panel)
> +		if (panel) {
>  			bridge =3D devm_drm_panel_bridge_add_typed(dev, panel,
>  								 DRM_MODE_CONNECTOR_DPI);
> +			drm_panel_put(panel);
> +		}
> =20

[Severity: High]
This is a pre-existing issue, but I noticed devm_drm_panel_bridge_add_typed=
()
can return an ERR_PTR on failure. Since there is no IS_ERR() check here in
ingenic_drm_bind(), the error pointer gets assigned to ib->next_bridge a few
lines later and is passed indirectly to drm_bridge_attach().=20

Could this cause the DRM core to dereference the error pointer (e.g., acces=
sing
bridge->dev) and crash during initialization?

[ ... ]

> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_=
drv.c
> --- a/drivers/gpu/drm/mcde/mcde_drv.c
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c
> @@ -153,6 +153,7 @@ static int mcde_modeset_init(struct drm_device *drm)
>  		if (panel) {
>  			bridge =3D drm_panel_bridge_add_typed(panel,
>  					DRM_MODE_CONNECTOR_DPI);
> +			drm_panel_put(panel);
>  			if (IS_ERR(bridge)) {
>  				dev_err(drm->dev,
>  					"Could not connect panel bridge\n");

[Severity: Medium]
This isn't a bug introduced by this patch, but it looks like the unmanaged
bridge created here in mcde_modeset_init() is never removed.=20

If mcde_modeset_init() fails later (for example, if drm_vblank_init() fails=
),
or during standard driver teardown, does this permanently leak the panel br=
idge
and the panel reference?

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/r=
ockchip/rockchip_lvds.c
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -605,6 +605,7 @@ static int rockchip_lvds_bind(struct device *dev, str=
uct device *master,
> =20
>  	if (lvds->panel) {
>  		lvds->bridge =3D drm_panel_bridge_add_typed(lvds->panel, DRM_MODE_CONN=
ECTOR_LVDS);
> +		drm_panel_put(lvds->panel);
>  		if (IS_ERR(lvds->bridge)) {
>  			ret =3D PTR_ERR(lvds->bridge);
>  			goto err_free_encoder;

[Severity: Medium]
This is a pre-existing issue, but right after this check in
rockchip_lvds_bind(), the driver overwrites the bridge functions:

	lvds->bridge->funcs =3D &rockchip_lvds_bridge_funcs;

If drm_panel_bridge_remove() is called later in an error path or on unbind,=
 it
checks the bridge identity via drm_bridge_is_panel(), which specifically lo=
oks
for bridge->funcs =3D=3D &panel_bridge_bridge_funcs. Does overwriting the f=
unction
pointers here cause the removal to fail silently and leak the panel bridge?

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/ro=
ckchip/rockchip_rgb.c
> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> @@ -139,6 +139,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device =
*dev,
>  	if (panel) {
>  		bridge =3D drm_panel_bridge_add_typed(panel,
>  						    DRM_MODE_CONNECTOR_LVDS);
> +		drm_panel_put(panel);
>  		if (IS_ERR(bridge))
>  			return ERR_CAST(bridge);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but returning ERR_CAST(bridge)
directly here skips the err_free_encoder label. Since the embedding rgb str=
uct
is allocated with devm_kzalloc(), does this leave a dangling encoder in the
DRM core lists when the memory is freed, potentially leading to a
use-after-free?

Additionally, in the err_free_encoder error path later in rockchip_rgb_init=
(),
drm_encoder_cleanup() is called but drm_panel_bridge_remove() is skipped. D=
oes
that path permanently leak the unmanaged panel bridge?

[ ... ]

> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200=
/tve200_drv.c
> --- a/drivers/gpu/drm/tve200/tve200_drv.c
> +++ b/drivers/gpu/drm/tve200/tve200_drv.c
> @@ -84,6 +84,7 @@ static int tve200_modeset_init(struct drm_device *dev)
>  	if (panel) {
>  		bridge =3D drm_panel_bridge_add_typed(panel,
>  						    DRM_MODE_CONNECTOR_Unknown);
> +		drm_panel_put(panel);
>  		if (IS_ERR(bridge)) {
>  			ret =3D PTR_ERR(bridge);
>  			goto out_bridge;
>  		}

[Severity: High]
This is a pre-existing issue, but when drm_panel_bridge_add_typed() fails h=
ere
in tve200_modeset_init(), the code jumps to out_bridge with an error pointe=
r in
the bridge variable.=20

The out_bridge label handles cleanup like this:

	out_bridge:
		if (panel)
			drm_panel_bridge_remove(bridge);

Since drm_panel_bridge_remove() calls drm_bridge_is_panel() which dereferen=
ces
bridge->funcs, won't this cause an immediate kernel panic when it tries to
dereference the error pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-drm_refcou=
nt_wiring-v2-0-d3bb61f4bd4d@redhat.com?part=3D5
