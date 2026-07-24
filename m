Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1616C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF17610E63D;
	Fri, 24 Jul 2026 08:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S2IebWs7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1DB10E63D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:24:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37A0342E0B;
 Fri, 24 Jul 2026 08:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE27D1F000E9;
 Fri, 24 Jul 2026 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784881494;
 bh=YHJ109yjTJOIv0UelJRvqx+JhHETW5UMWtLDsFBE74o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S2IebWs7UQhO4MAX1oTb8oF91hghzoKQ11ri4tbT2pyDHpMdzvRaF8luOCa10B/aK
 SsChhKA37mEt/gvI4I4qiWTHRwpg2xUQnC1I7JkaXxlxPiQn6FNFlrATh/4evHdF+z
 jAzJKDvqYFqtMskDm/HSIgFj7nL9Z7LHJjui82o7FW6E9Bfw5WTHE/KrD+bGrhq20A
 FTD9oNZt+8uclbmFMBvgTqy77lowotJQJk98ZskP5D5X++3YSriauPGIVzslQ7H6IZ
 IU3yN5iA/5wMKZjaoZiUADkxCUuU++xcFgxqSACjY5+v/1IApIajcslGnREGIyhq/h
 4cOcYLk3fH1Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/rockchip: lvds: add RK3568 support
To: "Rok Markovic" <rok@kanardia.eu>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260724080824.115260-4-rok@kanardia.eu>
References: <20260724080824.115260-1-rok@kanardia.eu>
 <20260724080824.115260-4-rok@kanardia.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 08:24:53 +0000
Message-Id: <20260724082453.BE27D1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Missing `phy_exit()` cleanup for the PHY initialized in `rk3568_=
lvds_probe()`.

Pre-existing issues:
- [High] The driver illegally overwrites the `funcs`, `ops`, and `driver_pr=
ivate` fields of a `drm_bridge` object obtained via `drm_of_find_panel_or_b=
ridge()`.
- [High] Unbalanced `of_node_put()` causes a use-after-free/double-free of =
a device node reference.
--

--- Patch [3]: [PATCH v2 3/4] drm/rockchip: lvds: add RK3568 support ---
commit ff72089a77c6360b2f3e3636251c56b8d17b88e7
Author: Rok Markovic <rok@kanardia.eu>

drm/rockchip: lvds: add RK3568 support

The RK3568 LVDS transmitter has no register block of its own. It is
driven entirely through the GRF and re-uses the MIPI DSI0 D-PHY in
PHY_MODE_LVDS.

Link: https://lore.kernel.org/all/20230119184807.171132-1-a1ba.omarov@gmail=
.com/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/r=
ockchip/rockchip_lvds.c
> index 150299c12298a..fcf599ae6c6dd 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c

[ ... ]

> @@ -512,6 +614,17 @@ static int px30_lvds_probe(struct platform_device *p=
dev,
>  	return phy_power_on(lvds->dphy);
>  }
> =20
> +static int rk3568_lvds_probe(struct platform_device *pdev,
> +			     struct rockchip_lvds *lvds)
> +{
> +	/* The phy is powered on from the encoder enable path, not here. */
> +	lvds->dphy =3D devm_phy_get(&pdev->dev, "dphy");
> +	if (IS_ERR(lvds->dphy))
> +		return PTR_ERR(lvds->dphy);
> +
> +	return phy_init(lvds->dphy);
> +}
> +

[Severity: Medium]
Since devm_phy_get() does not automatically call phy_exit(), does this code
leak the PHY's initialization state and resources when the driver is unbound
or fails to probe after initialization?

rk3568_lvds_probe() calls phy_init(lvds->dphy) directly. If phy_init()
succeeds but the probe later fails, or when the device is removed, it
appears phy_exit() is never called to clean up.

[ ... ]

> @@ -601,6 +723,8 @@ static int rockchip_lvds_bind(struct device *dev, str=
uct device *master,
>  	encoder =3D &lvds->encoder.encoder;
>  	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm_dev,
>  							     dev->of_node);
> +	rockchip_drm_encoder_set_crtc_endpoint_id(&lvds->encoder,
> +						  dev->of_node, 0, 0);
> =20
>  	ret =3D drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS=
);
>  	if (ret < 0) {

[Severity: High]
This is a pre-existing issue, but I noticed a potential reference counting
issue in rockchip_lvds_bind():

drivers/gpu/drm/rockchip/rockchip_lvds.c:rockchip_lvds_bind() {
    ...
	if (lvds->panel)
		remote =3D lvds->panel->dev->of_node;
	else
		remote =3D lvds->bridge->of_node;
    ...
	pm_runtime_enable(dev);
	of_node_put(remote);
	of_node_put(port);
}

The remote node pointer is borrowed directly without taking a new reference
(e.g. via of_node_get()), but is then unconditionally passed to
of_node_put(). Can this cause a double-free or use-after-free of the
device node when the reference count is decremented incorrectly?

[Severity: High]
This isn't a bug introduced by this patch, but I also noticed that
rockchip_lvds_bind() overwrites the bridge fields:

drivers/gpu/drm/rockchip/rockchip_lvds.c:rockchip_lvds_bind() {
    ...
	if (lvds->bridge) {
		lvds->bridge->driver_private =3D lvds;
		lvds->bridge->ops =3D DRM_BRIDGE_OP_MODES;
		lvds->bridge->funcs =3D &rockchip_lvds_bridge_funcs;
    ...
}

If drm_of_find_panel_or_bridge() returns an external bridge (when
lvds->panel is NULL), does this overwrite the external bridge's own
function pointers and private data?

This could erase the original operations like atomic_enable and
atomic_disable, preventing the external bridge from functioning, and could
cause memory corruption or crashes when the DRM core invokes the
overwritten function pointers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724080824.1152=
60-1-rok@kanardia.eu?part=3D3
