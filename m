Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCF9C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6993A10FC3A;
	Tue, 15 Sep 2026 15:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cMJJpPWf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7120D10FC3A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:11:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 553FF43F4D;
 Tue, 15 Sep 2026 15:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180501F000FF;
 Tue, 15 Sep 2026 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789485077;
 bh=6jZ3ICbtn08eZfwl0AK+knyY+36Zj/fzo7VnZ7nqJrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cMJJpPWf0oq8+Ya581cTfoMYhpphHbioIDGmDvz2Z1UAqDnVjjwEbSbQgjmnAvMdn
 0g7AU/xselplkshm0oo3GJKlaUAjxo9bHRPhKzcwFGn7rK9RiLFhPxCunM2BBOG10G
 4Dg3qdGypNrJrRi2zjZ6M0ntK4Er5n/DrqLX8lCN/tHNQjnGOug8hAdgZnUAplPKnH
 stlxk/iRcyz7AAT3Rdx47QS521DsMpg7AGu36B/dRuESdojohwd+lw8az+waH5Fcji
 0Cqkw53mUy6eBtfddZy9npdUuyIIHNq9eyekZhd2IJrmvfLiiuCbyiTAGOjfUH2VAm
 qX7xMJerrzrRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] drm/panel: Use managed helpers in assorted panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915145935.60397-4-osama.abdelkader@gmail.com>
References: <20260915145935.60397-1-osama.abdelkader@gmail.com>
 <20260915145935.60397-4-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:11:16 +0000
Message-Id: <20260915151117.180501F000FF@smtp.kernel.org>
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
- [High] drm/panel: Use-After-Free in panel-dsi-cm due to delayed drm_panel=
_remove
- [Low] drm/panel: khadas-ts050 compilation error due to undeclared variable
- [Low] drm/panel: tdo-tl070wsh30 compilation error due to undeclared varia=
ble
--

commit e1629ed943636f060c6cfc7188b70cdb9700480c
Author: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: drm/panel: Use managed helpers in assorted panels

This commit converts multiple panel drivers to use managed device helpers
for DRM panels and MIPI DSI attach operations. It removes the corresponding
manual detach and panel remove calls from the driver removal paths.

> diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel=
/panel-dsi-cm.c
> --- a/drivers/gpu/drm/panel/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
> @@ -559,16 +559,17 @@ static int dsicm_probe(struct mipi_dsi_device *dsi)
>  	dsi->hs_rate =3D ddata->panel_data->max_hs_rate;
>  	dsi->lp_rate =3D ddata->panel_data->max_lp_rate;
> =20
> -	drm_panel_add(&ddata->panel);
> +	r =3D devm_drm_panel_add(dev, &ddata->panel);
> +	if (r)
> +		goto err_sysfs;

[Severity: High]
Does using the managed version of drm_panel_add() here introduce a potential
use-after-free in dsicm_remove()?

By relying on devm, the execution of drm_panel_remove() is deferred to the
devres cleanup phase, which runs after the driver's .remove callback
(dsicm_remove) has already completed.

[ ... ]

> @@ -580,12 +581,13 @@ static int dsicm_probe(struct mipi_dsi_device *dsi)
>  static void dsicm_remove(struct mipi_dsi_device *dsi)
>  {
>  	struct panel_drv_data *ddata =3D mipi_dsi_get_drvdata(dsi);
> +	int ret;
> =20
>  	dev_dbg(&dsi->dev, "remove\n");
> =20
> -	mipi_dsi_detach(dsi);
> -
> -	drm_panel_remove(&ddata->panel);
> +	ret =3D mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> =20
>  	sysfs_remove_group(&dsi->dev.kobj, &dsicm_attr_group);
> =20

[Severity: High]
With the manual drm_panel_remove() gone, the panel remains registered with
the DRM core when dsicm_remove() subsequently cleans up the external
backlight reference just below this code block:

    if (ddata->extbldev)
        put_device(&ddata->extbldev->dev);

If a concurrent operation (such as a userspace DRM ioctl triggering a
display modeset) calls dsicm_disable() on the panel during the window
between dsicm_remove() returning and the devres cleanup executing, could
it attempt to use the freed extbldev pointer to disable the backlight?

[ ... ]

> diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm=
/panel/panel-khadas-ts050.c
> --- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
> +++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> @@ -825,7 +825,9 @@ static int khadas_ts050_panel_add(struct khadas_ts050=
_panel *khadas_ts050)
>  	if (err)
>  		return err;
> =20
> -	drm_panel_add(&khadas_ts050->base);
> +	ret =3D devm_drm_panel_add(dev, &khadas_ts050->base);
> +	if (ret)
> +		return ret;

[Severity: Low]
Will this cause a compilation error? It appears the variable "ret" is used
here, but looking at khadas_ts050_panel_add() in the source, only "err"
has been declared in this scope.

[ ... ]

> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/d=
rm/panel/panel-tdo-tl070wsh30.c
> --- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> @@ -150,7 +150,9 @@ static int tdo_tl070wsh30_panel_add(struct tdo_tl070w=
sh30_panel *tdo_tl070wsh30)
>  	if (err)
>  		return err;
> =20
> -	drm_panel_add(&tdo_tl070wsh30->base);
> +	ret =3D devm_drm_panel_add(dev, &tdo_tl070wsh30->base);
> +	if (ret)
> +		return ret;

[Severity: Low]
Does this also fail to compile for the same reason? The variable "ret" is
assigned and checked, but only "err" is declared in tdo_tl070wsh30_panel_ad=
d().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915145935.6039=
7-1-osama.abdelkader@gmail.com?part=3D3
