Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DAFCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89FA10F5AC;
	Fri, 26 Jun 2026 12:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BillWao9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CD510F5AE
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:23:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83A6544110;
 Fri, 26 Jun 2026 12:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBC21F000E9;
 Fri, 26 Jun 2026 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782476621;
 bh=FzJpcxO7gu0CJT9XiofJ34FlCHXb6Gyg0LPTjg4aHrE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BillWao9pvEHWETKiIguS3O2cIDQ4sY3NT0nGwOxfJGfU7u33/P9a6h4NtKQY64n6
 HoNM1qc1QL/Uq78Ts3Y76f9Vdd1/oA4l6llqMqvcsToh4DbVLb6MI91lMjPXZhd9gz
 KA0XyVLxET5M6QPmuroMsT1bqcqLcO/A4JXWDUsuJzgOKdHHC75V7bLmoiINsgBTWp
 FyhkuStF36cbvTBHgOwXF1cTV78u6XhHYfcpURE2WpPhNHg1pxw++tD+zMBexvUX9y
 St37FrCZvv/ltrpvUmcf7dF3Obww6AIi9SJW6pdmVzXkFGyVmy50GMYUjQbbOeI6rh
 gSKRfoRgyTe9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/bridge: release panel reference on all lookup
 exit paths
To: "Albert Esteve" <aesteve@redhat.com>
Cc: linux-sunxi@lists.linux.dev, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 imx@lists.linux.dev
In-Reply-To: <20260626-drm_refcount_wiring-v1-4-cca1a7b3bdef@redhat.com>
References: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
 <20260626-drm_refcount_wiring-v1-4-cca1a7b3bdef@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:23:40 +0000
Message-Id: <20260626122341.0DBC21F000E9@smtp.kernel.org>
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
- [High] Dropping the panel reference before removing the bridge creates a =
Use-After-Free window during driver removal.
- [Medium] Panel references acquired during probe/attach are not released o=
n error paths, causing memory leaks.
- [Medium] Panel reference leaks when wrapping a panel in a bridge without =
dropping the lookup reference.
--

commit 621578b5ce602b599c8bef0b18966f05081671b7
Author: Albert Esteve <aesteve@redhat.com>

drm/bridge: release panel reference on all lookup exit paths

of_drm_find_panel() and drm_of_find_panel_or_bridge() now return a
counted reference that the caller must release with drm_panel_put().

For bridge drivers that immediately wrap the panel in a panel_bridge
(which acquires its own reference), release the lookup reference right
after the bridge creation call.

[Severity: Medium]
Since the lookup functions now return a counted reference, does this
change introduce memory leaks on driver probe error paths?

If a driver successfully acquires the panel reference during probe or
attach, but a subsequent initialization step fails (like clock
registration, component addition, or memory allocation), it appears the
reference is leaked if drm_panel_put is not called before returning the
error.

For example, in exynos_dp_probe, if component_add fails, the panel
reference is not released. Similar leaks appear to happen on error
paths in analogix_dp_aux_done_probing, sun6i_dsi_attach,
tegra_output_probe, and lvds_probe.

[Severity: Medium]
Additionally, are there missing conversions for drivers that wrap the
panel in a bridge?

The commit message notes that bridge drivers immediately wrapping the
panel must release the lookup reference right after the bridge creation
call, since the bridge acquires its own reference.

However, it looks like several drivers were missed, such as
lvds_codec_probe, fsl_ldb_probe, lt9211_parse_dt, ssd2825_probe,
tc358767_probe, and tc358768_probe. In these functions, the panel is
wrapped with devm_drm_panel_bridge_add or drm_panel_bridge_add_typed,
but the initial lookup reference is never dropped.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers=
/gpu/drm/bridge/analogix/analogix-anx6345.c
> index f3fe47b12edca..1fe11b075f860 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -756,6 +756,9 @@ static void anx6345_i2c_remove(struct i2c_client *cli=
ent)
>  {
>  	struct anx6345 *anx6345 =3D i2c_get_clientdata(client);
> =20
> +	if (anx6345->panel)
> +		drm_panel_put(anx6345->panel);
> +
>  	drm_bridge_remove(&anx6345->bridge);

[Severity: High]
Does this create a use-after-free window?

By dropping the last reference to the panel here, the panel object might
be freed. However, the bridge is removed after this step. During this
window, the bridge remains globally visible and registered.

If a concurrent drm commit or modeset (like an atomic disable) executes
on the display pipeline before drm_bridge_remove is called, it could
invoke the bridge callbacks which would dereference the already-freed
panel pointer.

Would it be safer to unregister the bridge before dropping the reference
to the internal structures it relies on?

[ ... ]

> diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
> index 50a878688e477..77735e26c56e3 100644
> --- a/drivers/gpu/drm/stm/lvds.c
> +++ b/drivers/gpu/drm/stm/lvds.c
> @@ -1189,6 +1189,9 @@ static void lvds_remove(struct platform_device *pde=
v)
>  {
>  	struct stm_lvds *lvds =3D platform_get_drvdata(pdev);
> =20
> +	if (lvds->panel)
> +		drm_panel_put(lvds->panel);
> +
>  	lvds_pixel_clk_unregister(lvds);
> =20
>  	drm_bridge_remove(&lvds->lvds_bridge);

[Severity: High]
Could this also trigger a use-after-free for the panel?

Similar to the anx6345 driver, the panel reference is dropped before the
bridge is removed. A concurrent atomic disable could execute in this
window and dereference the freed panel inside the bridge callbacks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-drm_refcou=
nt_wiring-v1-0-cca1a7b3bdef@redhat.com?part=3D4
