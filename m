Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6384CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEDF10EA53;
	Wed, 17 Jun 2026 14:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cQAH80HU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3046E10EA53
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:44:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBB8C40A28;
 Wed, 17 Jun 2026 14:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773351F000E9;
 Wed, 17 Jun 2026 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781707489;
 bh=i1QGyEzd9SfN/JmsrXIU4CHzDaY9YbgegFFRVptvylk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cQAH80HUwiVGrVPmzepK4Op6xb5F22tZcmyd7P9EN/7kBbFlyxOkfERMZT9tUl2iG
 YPd08/22Zs1HCuWwZ1cw3JUyhuz26R489EKZTJj63Qs3KUH8PIPiYvapMbCu3y1F6P
 pn58+IjdgUTYIYV8GjnFtQZvJ57KNNdeOeWTbWp6HHtezls6NPWzBd7XoMR/feq7Ba
 ZakwJZQB6EFADLntjBaks/J0EkKt6jLgoChKFvHrOFKsywmr8pviPMNNDAkjVcA6+t
 q2TRm8MSU8XpS76aU9Stom7nmlY88vCnuFxzXVgRy4GKAZA7Cc+b731xDL2WFWQAPw
 AcO0YKvE+5Ilg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/panel: Add Ilitek ILI9488 controller driver
To: "Igor Reznichenko" <igor@reznichenko.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617143245.372182-3-igor@reznichenko.net>
References: <20260617143245.372182-1-igor@reznichenko.net>
 <20260617143245.372182-3-igor@reznichenko.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:44:49 +0000
Message-Id: <20260617144449.773351F000E9@smtp.kernel.org>
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
- [High] Missing NULL check for the result of device_get_match_data() leads=
 to a kernel oops.
- [High] Undefined function call and missing DRM panel unregistration leadi=
ng to Use-After-Free.
--

commit c22f05cd630ecc7dace66102729e2ea4cdfd93fc
Author: Igor Reznichenko <igor@reznichenko.net>

drm/panel: Add Ilitek ILI9488 controller driver

This commit adds support for the Ilitek ILI9488 DSI controller.
It introduces power sequencing and DSI initialization tailored
for the FocusLCDs E35GH-I-MW800-CB panel.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9488.c b/drivers/gpu/d=
rm/panel/panel-ilitek-ili9488.c
> new file mode 100644
> index 0000000000000..7302766034fc9
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
[ ... ]
> +static int ili9488_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct ili9488 *ili;
> +	int i, ret;
> +
> +	ili =3D devm_drm_panel_alloc(dev, struct ili9488, panel, &ili9488_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ili))
> +		return PTR_ERR(ili);
> +
> +	ili->desc =3D device_get_match_data(dev);
> +	ili->dsi =3D dsi;
> +
> +	dsi->mode_flags =3D ili->desc->mode_flags;

[Severity: High]
Can this dereference a NULL pointer if the device is instantiated without
matching firmware data?

The function device_get_match_data() can return NULL, for example via sysfs
or string-based matching. Verifying the return value before accessing
ili->desc->mode_flags would prevent a potential NULL pointer dereference.

[ ... ]
> +	ret =3D drm_panel_of_backlight(&ili->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get backlight\n");
> +
> +	ili->panel.prepare_prev_first =3D true;
> +
> +	ret =3D devm_drm_panel_add(dev, &ili->panel);

[Severity: High]
Does the devm_drm_panel_add() function exist in the kernel, or will this
cause a build failure?

Additionally, if this call is replaced with drm_panel_add(), the driver
lacks a corresponding .remove() callback or a devres action to unregister
the panel with drm_panel_remove(). Since the panel structure is allocated
with devm_drm_panel_alloc() and freed on driver unbind, failing to unregist=
er
the panel will leave it on the DRM core's global panel list, leading to a
Use-After-Free when the list is later accessed.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to attach to DSI host\n");
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617143245.3721=
82-1-igor@reznichenko.net?part=3D2
