Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EBCC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D003F10E5D0;
	Mon, 13 Jul 2026 12:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D1VdA/rx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E4110E5D0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:33:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BD6E6004E;
 Mon, 13 Jul 2026 12:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D451F000E9;
 Mon, 13 Jul 2026 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946035;
 bh=h9/9Ck52OhNZfFT7j2WC5Ax7sMbqMkz80xzavUM8EJI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D1VdA/rxyKmTXfEejF9hc+zJ7BZKOS1x/lRgbk07/33sqvG07iNWpM0etQ9blpbGB
 aU3J21YN533PYyFHatoR+zSgIZUI/0FLFRxlJ5SPzihi1+jizBAONP2YLliMW1aVhV
 mFmrW0DVxVm4vXtyERJ/CgF4DKhFbj16WitSniWnB/EvEJnO4q608MdP1RvffSveO4
 J57JkcsRTHTePoRaLSXTtIQpI2cFrMToz3v3DtNw8eH8+KwTA6kLStsTQBr506FnZt
 yZC5aoR2xoxtbjzF9HMn8gtSzaKbIvTpxOEec3KTBl5UnMpyKuwgCo82LN5KVF80cD
 smiHrejsB6B8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/panel: of_drm_find_panel() return a counted
 reference
To: "Albert Esteve" <aesteve@redhat.com>
Cc: imx@lists.linux.dev, linux-sunxi@lists.linux.dev, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260713-drm_refcount_wiring-v2-3-d3bb61f4bd4d@redhat.com>
References: <20260713-drm_refcount_wiring-v2-0-d3bb61f4bd4d@redhat.com>
 <20260713-drm_refcount_wiring-v2-3-d3bb61f4bd4d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:33:55 +0000
Message-Id: <20260713123355.87D451F000E9@smtp.kernel.org>
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

New issues:
- [Critical] In the Tegra DSI driver, the panel reference is freed twice du=
ring driver removal, causing a use-after-free and a double free of the kref.
- [Medium] Widespread panel reference leaks in unmodified callers of `of_dr=
m_find_panel()` and `drm_of_find_panel_or_bridge()`.
- [Medium] Modified drivers leak the panel reference if their probe or init=
ialization functions fail after the panel lookup.
- [Medium] `tegra_dsi_host_attach()` overwrites the `output->panel` pointer=
, leaking the reference previously acquired during `tegra_output_probe()`.

Pre-existing issues:
- [Critical] `find_panel_by_fwnode()` was not updated to acquire a referenc=
e, preserving the use-after-free window that the commit intended to fix.
--

--- Patch [3]: [PATCH v2 3/5] drm/panel: of_drm_find_panel() return a count=
ed reference ---
commit a89c4180aa3b0d041a29e5173be0f8523bd150fe
Author: Albert Esteve <aesteve@redhat.com>

drm/panel: of_drm_find_panel() return a counted reference

This patch modifies of_drm_find_panel() to acquire a reference with
drm_panel_get() before returning the panel, preventing a race condition whe=
re
the device can be freed before first use. It also updates several drivers to
release this reference when the panel is no longer needed.

> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
[ ... ]
> @@ -225,7 +225,8 @@ EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
>   * @np: device tree node containing encoder output ports
>   * @port: port in the device tree node
>   * @endpoint: endpoint in the device tree node
> - * @panel: pointer to hold returned drm_panel, must not be NULL
> + * @panel: pointer to hold returned drm_panel, must not be NULL. On succ=
ess
> + *         the caller must call drm_panel_put() when done with the panel
>   * @bridge: pointer to hold returned drm_bridge
>   *
>   * Given a DT node's port and endpoint number, find the connected node a=
nd

[Severity: Medium]
Since of_drm_find_panel() and drm_of_find_panel_or_bridge() now return a
panel with an incremented reference count, do all unmodified callers need
to be updated?

For example, in samsung_dsim_host_attach():

drivers/gpu/drm/bridge/samsung-dsim.c:samsung_dsim_host_attach() {
    ...
    panel =3D of_drm_find_panel(remote);
    ...
}

And in rockchip_lvds_bind():

drivers/gpu/drm/rockchip/rockchip_lvds.c:rockchip_lvds_bind() {
    ...
    ret =3D drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
                                      &lvds->panel, &lvds->bridge);
    ...
}

Are these panel references leaked if the callers are not updated to call
drm_panel_put() upon success or error?

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
[ ... ]
> @@ -484,6 +487,7 @@ struct drm_panel *of_drm_find_panel(const struct devi=
ce_node *np)
> =20
>  	list_for_each_entry(panel, &panel_list, list) {
>  		if (panel->dev->of_node =3D=3D np) {
> +			drm_panel_get(panel);
>  			mutex_unlock(&panel_lock);
>  			return panel;
>  		}

[Severity: Critical]
This isn't a bug introduced by this patch, but find_panel_by_fwnode() in
drm_panel.c appears to have the same race condition this patch fixes for
of_drm_find_panel().

drivers/gpu/drm/drm_panel.c:find_panel_by_fwnode() {
    ...
    if (dev_fwnode(panel->dev) =3D=3D fwnode) {
        mutex_unlock(&panel_lock);
        return panel;
    }
    ...
}

Since it returns a raw panel pointer without acquiring its reference count,
could the panel device be unregistered and freed before the caller (like
drm_panel_add_follower()) uses it?

Does this function need the same drm_panel_get() treatment?

> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/=
exynos_dp.c
[ ... ]
> @@ -193,6 +193,16 @@ static int exynos_dp_probe(struct platform_device *p=
dev)
> =20
>  static void exynos_dp_remove(struct platform_device *pdev)
>  {
> +	struct exynos_dp_device *dp =3D platform_get_drvdata(pdev);
> +
> +	/*
> +	 * Release the probe-time reference from of_drm_find_panel(). If bind
> +	 * ran, the panel_bridge holds a second reference that devm cleanup
> +	 * will release when the bridge is destroyed after remove() returns.
> +	 */
> +	if (dp->plat_data.panel)
> +		drm_panel_put(dp->plat_data.panel);
> +

[Severity: Medium]
If exynos_dp_probe() fails after acquiring the panel reference, does it leak
the reference?

Looking at the probe function:

drivers/gpu/drm/exynos/exynos_dp.c:exynos_dp_probe() {
    ...
    // panel reference acquired here or earlier
    ...
    if (IS_ERR(dp->adp))
        return PTR_ERR(dp->adp);
    ...
}

Since the driver core does not invoke remove() for failed probes, will
returning an error without calling drm_panel_put() cause a memory leak?
(A similar error-path leak pattern seems to exist in tegra_output_probe()).

[ ... ]
> diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
> index 7f25c50621c94..57a016f47434d 100644
> --- a/drivers/gpu/drm/tegra/dsi.c
> +++ b/drivers/gpu/drm/tegra/dsi.c
> @@ -1516,6 +1516,7 @@ static int tegra_dsi_host_detach(struct mipi_dsi_ho=
st *host,
>  	struct tegra_output *output =3D &dsi->output;
> =20
>  	if (output->panel && &device->dev =3D=3D output->panel->dev) {
> +		drm_panel_put(output->panel);
>  		output->panel =3D NULL;

[Severity: Critical]
Could this lead to a use-after-free and double-free during driver removal?

During removal, tegra_dsi_remove() calls tegra_output_remove() which drops
the reference:

drivers/gpu/drm/tegra/output.c:tegra_output_remove() {
    if (output->panel)
        drm_panel_put(output->panel);
    ...
}

But output->panel is not set to NULL. Subsequently, mipi_dsi_host_unregiste=
r()
calls tegra_dsi_host_detach(), which executes this code:

    if (output->panel && &device->dev =3D=3D output->panel->dev) {
        drm_panel_put(output->panel);

Will this dereference the freed output->panel->dev in the condition, and th=
en
drop the kref a second time?

[Severity: Medium]
Also in the Tegra DSI driver, does tegra_dsi_host_attach() leak a reference?

drivers/gpu/drm/tegra/dsi.c:tegra_dsi_host_attach() {
    ...
    output->panel =3D of_drm_find_panel(device->dev.of_node);
    ...
}

If tegra_output_probe() already acquired a panel reference and stored it in
output->panel, won't this assignment overwrite the pointer without releasing
the previously acquired reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-drm_refcou=
nt_wiring-v2-0-d3bb61f4bd4d@redhat.com?part=3D3
