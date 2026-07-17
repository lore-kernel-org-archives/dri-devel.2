Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D57C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C035510E47B;
	Fri, 17 Jul 2026 14:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V18+U9mT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CA110E47B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:24:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A440F40598;
 Fri, 17 Jul 2026 14:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6EE1F000E9;
 Fri, 17 Jul 2026 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784298273;
 bh=3XjrOuqHA7mYLwjd+EZ8PT/2Yl3q8MM7mwSvFIsrdKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V18+U9mTy9meP4PwSN5Uz7ZcOdmmU4+0nAMKyMjGzWgL/F4r1/8MlngZLo+Z7Kh+1
 Nr+sD6WA3CddbTBfuLb4uVPyPIoJoAGeYYnvPLn5ywGKtn3vM1foZvNxtMFNhzjGim
 ck6VEUc8UuMzDDiTGeaiRUC9r/iBBEe+gMiZOS+VskybFwf69GwY0Eh9ovC4eAgmkV
 doJ98va5m69ZqUtvpa4yJSsngiXqvqFzNc7tVzsfHXF3kOyaQWfxc7TpMkxh0joIw8
 GWQuUbeNL/PQJCJs8jnLS/l/3TTKyub2dbid0vFBE7wtcxYwLrpr80Z7jFlJjCDVYV
 if57DUTrR9NqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] drm/panel: of_drm_find_panel() return a counted
 reference
To: "Albert Esteve" <aesteve@redhat.com>
Cc: linux-sunxi@lists.linux.dev, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev
In-Reply-To: <20260717-drm_refcount_wiring-v3-3-023900c32e01@redhat.com>
References: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
 <20260717-drm_refcount_wiring-v3-3-023900c32e01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:24:32 +0000
Message-Id: <20260717142433.3B6EE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [Critical] Using `devm_add_action_or_reset()` to manage panel references =
inside component bind callbacks causes reference leaks, devres accumulation=
, and double-free on rebind.
- [High] Panel reference acquired in `tegra_output_probe()` is leaked in `t=
egra_dc_rgb_init()`.
- [High] Panel reference is leaked if `component_add()` or `analogix_dp_fin=
ish_probe()` fails in `exynos_dp_probe()`.
- [High] Panel reference is leaked if `component_add()` fails in `analogix_=
dp_aux_done_probing()`.
- [High] Panel reference is leaked if `component_add()` fails in Exynos FIM=
D / DECON probe error paths.
- [Medium] Panel reference is leaked when looping over multiple endpoints i=
n `pl111_modeset_init()`.

Pre-existing issues:
- [High] An `ERR_PTR` is passed to `drm_panel_bridge_remove()` in the error=
 path of `tve200_modeset_init()`, causing a kernel panic.
- [High] The panel bridge, encoder, and internal panel reference are leaked=
 if encoder attachment fails in `rockchip_rgb_init()`.
- [High] Dereferencing `ERR_PTR` causes a kernel panic in the Ingenic DRM d=
river.
--

--- Patch [3]: [PATCH v3 3/4] drm/panel: of_drm_find_panel() return a count=
ed reference ---
commit 5ff0041b676bfa0b0285edf9631f1c23402a5814
Author: Albert Esteve <aesteve@redhat.com>
Subject: drm/panel: of_drm_find_panel() return a counted reference

Callers of of_drm_find_panel() and drm_of_find_panel_or_bridge() receive a
pointer with no reference held, creating a window where the panel device can
be unregistered and freed between the lookup and first use. Fix the lookup
function by acquiring a reference with drm_panel_get() before returning,
under panel_lock. Callers are now responsible for calling drm_panel_put()
when they no longer need the pointer.

Link: [not provided in metadata]

> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/=
exynos_dp.c
> index b805403281504..a418011f7d4d6 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
[ ... ]
> @@ -182,8 +182,15 @@ static int exynos_dp_probe(struct platform_device *p=
dev)
> =20
>  out:
>  	dp->adp =3D analogix_dp_probe(dev, &dp->plat_data);
> -	if (IS_ERR(dp->adp))
> +	if (IS_ERR(dp->adp)) {
> +		/*
> +		 * The driver core does not invoke remove() for failed probes,
> +		 * so release the probe-time panel reference here.
> +		 */
> +		if (dp->plat_data.panel)
> +			drm_panel_put(dp->plat_data.panel);
>  		return PTR_ERR(dp->adp);
> +	}
> =20
>  	if (dp->plat_data.panel || dp->plat_data.next_bridge)
>  		return component_add(&pdev->dev, &exynos_dp_ops);
>  	else
>  		return analogix_dp_finish_probe(dp->adp);

[Severity: High]
Does this leak the panel reference if component_add() or
analogix_dp_finish_probe() fails?=20

The failure path for analogix_dp_probe() correctly drops the reference, but
the subsequent returns do not seem to handle failures. Because failed probes
do not trigger the remove() callback, the reference acquired via
of_drm_find_panel() might remain permanently leaked in those paths.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 42c86f195c66b..1887e01d29701 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
[ ... ]
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
>  		ib =3D drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
>  					NULL, DRM_MODE_ENCODER_DPI, NULL);

[Severity: High]
This is a pre-existing issue, but does this code cause a kernel panic if
devm_drm_panel_bridge_add_typed() fails?=20

When the bridge allocation fails, it returns an ERR_PTR. This value is=20
eventually assigned to ib->next_bridge and passed to drm_bridge_attach().=20
Since drm_bridge_attach() checks for NULL but not IS_ERR(), it will=20
dereference the error pointer.

> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl=
111_drv.c
> index ac7b1d12a0f59..8ec659b3c08eb 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
[ ... ]
> @@ -145,6 +145,7 @@ static int pl111_modeset_init(struct drm_device *dev)
>  	if (panel) {
>  		bridge =3D drm_panel_bridge_add_typed(panel,
>  						    DRM_MODE_CONNECTOR_Unknown);
> +		drm_panel_put(panel);
>  		if (IS_ERR(bridge)) {
>  			ret =3D PTR_ERR(bridge);
>  			goto finish;

[Severity: Medium]
Will this overwrite and leak panel references when looping over multiple
endpoints?=20

In pl111_modeset_init(), for_each_endpoint_of_node() iterates over endpoints
and calls drm_of_find_panel_or_bridge() on each. If multiple panels are
found, the assignment:
    panel =3D tmp_panel;
overwrites the previously acquired pointer without calling drm_panel_put()
on the old one, leaking all but the last panel found.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/ro=
ckchip/rockchip_rgb.c
> index add3123e5ce70..c908ea4cfa67a 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
[ ... ]
> @@ -139,6 +141,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device =
*dev,
>  	if (panel) {
>  		bridge =3D drm_panel_bridge_add_typed(panel,
>  						    DRM_MODE_CONNECTOR_LVDS);
> +		drm_panel_put(panel);
>  		if (IS_ERR(bridge))
>  			return ERR_CAST(bridge);
>  	}

[Severity: High]
This is a pre-existing issue, but does the error path fail to clean up the
bridge created by drm_panel_bridge_add_typed()?=20

If a panel is found, a bridge is allocated and a panel reference is acquire=
d.
If subsequent calls like drm_bridge_attach() or drm_bridge_connector_init()
fail, the code jumps to err_free_encoder. This cleans up the encoder but=20
appears to miss calling drm_panel_bridge_remove() to free the bridge and dr=
op
the panel reference.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/s=
un4i_lvds.c
> index 6716e895ae8a4..e1b342c922224 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
[ ... ]
> @@ -113,6 +118,14 @@ int sun4i_lvds_init(struct drm_device *drm, struct s=
un4i_tcon *tcon)
>  		return 0;
>  	}
> =20
> +	if (lvds->panel) {
> +		ret =3D devm_add_action_or_reset(tcon->dev,
> +					       sun4i_panel_put_action,
> +					       lvds->panel);
> +		if (ret)
> +			return ret;
> +	}
> +

[Severity: Critical]
Can using devm_add_action_or_reset() here cause lifecycle mismatches?

This code is called during sun4i_tcon_bind(), which is a component bind
callback. Devres actions are tied to the device's probe/remove lifecycle,
not the component bind/unbind lifecycle.=20

When the component unbinds, the action will not execute, leaking the panel
reference. If the component rebinds, it adds another action. When the device
is finally removed, the accumulated actions will execute multiple times,
causing a double-free or refcount underflow on the panel.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/su=
n4i_rgb.c
> index dfb6acc42f02e..0066bec5a9e5a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
[ ... ]
> @@ -205,6 +210,14 @@ int sun4i_rgb_init(struct drm_device *drm, struct su=
n4i_tcon *tcon)
>  		return 0;
>  	}
> =20
> +	if (rgb->panel) {
> +		ret =3D devm_add_action_or_reset(tcon->dev,
> +					       sun4i_panel_put_action,
> +					       rgb->panel);
> +		if (ret)
> +			return ret;
> +	}
> +

[Severity: Critical]
Can using devm_add_action_or_reset() here also cause lifecycle mismatches f=
or
the same reasons as in sun4i_lvds.c?

> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200=
/tve200_drv.c
> index 562f3f11812a3..f858c58ccb994 100644
> --- a/drivers/gpu/drm/tve200/tve200_drv.c
> +++ b/drivers/gpu/drm/tve200/tve200_drv.c
[ ... ]
> @@ -84,6 +84,7 @@ static int tve200_modeset_init(struct drm_device *dev)
>  	if (panel) {
>  		bridge =3D drm_panel_bridge_add_typed(panel,
>  						    DRM_MODE_CONNECTOR_Unknown);
> +		drm_panel_put(panel);
>  		if (IS_ERR(bridge)) {
>  			ret =3D PTR_ERR(bridge);
>  			goto out_bridge;

[Severity: High]
This is a pre-existing issue, but does this lead to a kernel panic in the
error path?=20

If drm_panel_bridge_add_typed() fails, it returns an ERR_PTR. The code then
jumps to out_bridge and unconditionally calls drm_panel_bridge_remove(bridg=
e).
Since drm_panel_bridge_remove() only checks if (!bridge) before dereferenci=
ng
the pointer, passing an ERR_PTR will cause a crash.


Additional observations about panel references in related files:

[Severity: High]
Could the panel reference acquired in tegra_output_probe() be leaked in
tegra_dc_rgb_init()?=20

When tegra_dc_rgb_init() (in drivers/gpu/drm/tegra/rgb.c) wraps the panel i=
n a
bridge using devm_drm_panel_bridge_add(), it sets output->panel =3D NULL. T=
his
seems to break the cleanup path in tegra_output_remove(), which checks
if (output->panel) before calling drm_panel_put(), resulting in the probe-t=
ime
reference being permanently leaked.

[Severity: High]
Can the panel reference leak in the error paths of decon_probe() and
fimd_probe()?=20

The exynos_dpi_probe() function acquires a panel reference and relies on the
callers to explicitly call exynos_dpi_remove() to release it. However, if
component_add() fails in exynos7_drm_decon.c:decon_probe() or
exynos_drm_fimd.c:fimd_probe(), they branch to an error path that skips
calling exynos_dpi_remove(), potentially leaking the reference.

[Severity: High]
Looking at analogix_dp_aux_done_probing() in analogix_dp_core.c, does this
code leak the panel reference if component_add() fails?=20

A reference is acquired via drm_of_find_panel_or_bridge(), but if
component_add() fails, the error is propagated back without dropping the
reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-drm_refcou=
nt_wiring-v3-0-023900c32e01@redhat.com?part=3D3
