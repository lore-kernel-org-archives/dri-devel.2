Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8232CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0323910F27B;
	Wed, 30 Sep 2026 09:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OCZjJF9X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07C910F28C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:02:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5689B405CC;
 Wed, 30 Sep 2026 09:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A895B1F000FF;
 Wed, 30 Sep 2026 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790758930;
 bh=RY63kWp+PbsjEiU5+ocjp3W6yFNFuU1hkXJ+MZQbGO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OCZjJF9XmEz32HdF2BbYnNA/v6uS4bjo2UMsGEkjEq0YrEMVxDmN067rY0fuvMWap
 V/XQZPLPTmCsPuRivuMhQOqew+NOsfH738t0lg1oFrnda4YWb4eOTAH7ykhlthvKpj
 fZiMFtIeoD0ImI54tlvLGRpGKnR9IUZCuQEPq2+YLNR4YkiODetzhWe1567x5M5+sB
 w1IJ/rzTMPaYppU/4n0L5ZHuQ6w9TLX4rMPqpmJUtOJysl5VZ5LdJGGPgqT3kiRtRB
 DGpL7cSqryg7WiX+u+YKOnJUjAL1+x6gIsttvWOFL2Mz+jy6pLMapAhYdrChHTqV/6
 PqOAU/d4niL7g==
Date: Wed, 30 Sep 2026 11:02:07 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
Message-ID: <arzNgbx465QIKYdX@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tgtr4qv64tpbcraz"
Content-Disposition: inline
In-Reply-To: <20260930070535.47130-7-clamor95@gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--tgtr4qv64tpbcraz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 10:05:35AM +0300, Svyatoslav Ryhel wrote:
> Add a driver for panels used in LG Optimus 2X P990. Both panels are 4"
> WVGA MIPI DBI Type B linked to DRM encoder via RGB to DBI bridge.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  14 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 396 ++++++++++++++++++
>  3 files changed, 411 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
>=20
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 747f47347521a..47962197a9c76 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -273,6 +273,20 @@ config DRM_PANEL_HIMAX_HX8394
> =20
>  	  If M is selected the module will be called panel-himax-hx8394.
> =20
> +config DRM_PANEL_HITACHI_TX10D07VM0BAA
> +	tristate "Hitachi TX10D07VM0BAA and LG LH400WV3 MIPI DBI panels"
> +	depends on OF
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_MIPI_DBI
> +	select VIDEOMODE_HELPERS
> +	help
> +	  Say Y here if you want to enable support for the HITACHI
> +	  TX10D07VM0BAA and LG LH400WV3 MIPI DBI panels found in the
> +	  LG Optimus 2X P990 smartphone.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called panel-hitachi-tx10d07vm0baa.
> +
>  config DRM_PANEL_HYDIS_HV101HD1
>  	tristate "Hydis HV101HD1 panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index f2c9c80a218f0..414267a49d922 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) +=3D panel-himax=
-hx83112a.o
>  obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112B) +=3D panel-himax-hx83112b.o
>  obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) +=3D panel-himax-hx83121a.o
>  obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) +=3D panel-himax-hx8394.o
> +obj-$(CONFIG_DRM_PANEL_HITACHI_TX10D07VM0BAA) +=3D panel-hitachi-tx10d07=
vm0baa.o
>  obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) +=3D panel-hydis-hv101hd1.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) +=3D panel-ilitek-ili7807s.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7836A) +=3D panel-ilitek-ili7836a.o
> diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driver=
s/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> new file mode 100644
> index 0000000000000..d2c3b63649288
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +enum panel_dbi_id {
> +	PANEL_DBI_NONE,
> +	PANEL_DBI_TX10D07VM0BAA,
> +	PANEL_DBI_LH400WV3,
> +};
> +
> +static const struct regulator_bulk_data panel_dbi_supplies[] =3D {
> +	{ .supply =3D "avci" }, { .supply =3D "iovcc" },
> +};
> +
> +struct panel_dbi {
> +	struct drm_panel panel;
> +	struct mipi_dbi *dbi;
> +
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static inline struct panel_dbi *to_panel_dbi(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct panel_dbi, panel);
> +}
> +
> +#define panel_dbi_command(priv, cmd, seq...) \
> +({ \
> +	const u8 d[] =3D { seq }; \
> +	struct drm_panel *panel =3D &(priv)->panel; \
> +	struct device *dev =3D panel->dev; \
> +	int ret; \
> +	ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); \
> +	if (ret) \
> +		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret,=
 cmd); \
> +	ret; \
> +})
> +

[...]
> +static int panel_dbi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	const struct drm_panel_funcs *panel_dbi_funcs;
> +	struct panel_dbi *priv;
> +	enum panel_dbi_id id;
> +	int ret;
> +
> +	id =3D (uintptr_t)of_device_get_match_data(dev);
> +
> +	switch (id) {
> +	case PANEL_DBI_TX10D07VM0BAA:
> +		panel_dbi_funcs =3D &hitachi_tx10d07vm0baa_panel_funcs;
> +		break;
> +
> +	case PANEL_DBI_LH400WV3:
> +		panel_dbi_funcs =3D &lg_lh400wv3_panel_funcs;
> +		break;
> +
> +	default:
> +		return dev_err_probe(dev, -ENODEV, "Unknown device %d\n", id);
> +	}

This is a bit pointless. The only reason you need that default here is
because you have an enum that is "none" but that PANEL_DBI_NONE is never
even used.

> +
> +	priv =3D devm_drm_panel_alloc(dev, struct panel_dbi, panel,
> +				    panel_dbi_funcs, DRM_MODE_CONNECTOR_DPI);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	ret =3D devm_regulator_bulk_get_const(dev, ARRAY_SIZE(panel_dbi_supplie=
s),
> +					    panel_dbi_supplies, &priv->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get supplies\n");
> +
> +	priv->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> +	if (IS_ERR(priv->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> +				     "Failed to get reset gpio\n");
> +
> +	ret =3D drm_panel_of_backlight(&priv->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> +
> +	ret =3D devm_drm_panel_add(dev, &priv->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add panel\n");
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id panel_dbi_of_match[] =3D {
> +	{ .compatible =3D "hit,tx10d07vm0baa", .data =3D (void *)PANEL_DBI_TX10=
D07VM0BAA },
> +	{ .compatible =3D "lg,lh400wv3-sd04", .data =3D (void *)PANEL_DBI_LH400=
WV3 },

Why the detour through that PANEL_DB_* enum? You could just pass the
panel funcs pointers directly via .data here.

Also, looking at the enable/disable sequences these are in fact two
different drivers, with the only commonality being that they happen to
be used in the same device. Rolling them both into one driver seems a
bit odd. If you really want to avoid duplication, maybe they should go
into some kind of "simple" or "generic" DBI driver.

Thierry

--tgtr4qv64tpbcraz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq80AoACgkQ3SOs138+
s6EByA/46ZDHT40jp/0vHmyi9zd1CK2pAVuOxT+nvfW3+zKDBssQrmlEsSLIyKtD
HSV6oAbMGkcfMK47oqZtzVYt1xzqnZLNAhBOZm8ckVGDpYq7zyJ599pGO3qyaK4Q
FStfpxmZDwBAMsoH+P9puwy8jVXACBPRB1cYwVI6HlgpiuChE8CqyGKmR38KNE1/
cEWbmVkBnRtlSPVBaiAlRcwvy/t4lOkGcYGK04q5CAdiHroNJqwzrA8F4FtOet3x
SpGpL9sEDhzl3VifvgVW/VHjg0jtfFivmSW7p8JSUQtB0+bVyLgxmxtY+mZWEJ4p
n5d5DBJduPh7oHd6yReEs3o4RMrA0n0sJngSRhpYhhAwuWwivw8aSR9rIynvTlNK
NCfdZWQIFj1ifXy1vAWrlqfWVQv+hP3HwbAgHgN7fgqZZq0ZVN0Lao/3fLYGAjYg
JhBhosape51hw0LhkzpQF10lIePZt5m+wSSzTu9ElbFpmrTsbNfkXutpmq5jfLso
NPrhR2h3jOA4tBtFKNcUfq02xWm8MUTN8hhxG1Z1FiF1JOQGRyUYxeaDLKPyzNC9
h97n7Pfz9GT6FVMKqYt/mXB3NV0+u/rDhlNoZjk8eGzVGC2BmE2nB4+i5bq4XloX
NOlLjZnRVAA8tX3OqdL4fs3YSlNExOOIhsr7MMHLBMBzjZvPnA==
=UTkq
-----END PGP SIGNATURE-----

--tgtr4qv64tpbcraz--
