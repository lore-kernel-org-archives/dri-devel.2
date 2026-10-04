Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028D2CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FDE10EA9B;
	Sun,  4 Oct 2026 16:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L5gJpuTo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00D910EA9B
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:44:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87E1A41B69;
 Sun,  4 Oct 2026 16:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247FD1F000FF;
 Sun,  4 Oct 2026 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791132269;
 bh=ZmiGYnUEqS+sQUGNM0ZqBViugxpbMBQ8gFD/1a3C0HU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L5gJpuTon/GGT1Fv1VTUj2iYUgkN4bawPEmlm+DIXZ71k8N/oa9QTWpIuApD5aNCr
 5kdgOS6l8XXsHlAFJy3RKhJiBknDm0yNakIJAB3PpcQb20FovVIQ0b3VCSJOEIG+xz
 lEAGPgdavMDmCkhvawCfC/bDtFyQQiLyDy6zXWoSM50SCub0svutMrBspOIv+Ebr8v
 e7PdAnZy2TmOmM7em9+OhrIMXPP4YkABaeTNiUjqxRyEpRv03smZ92OtLHrmnwBIrI
 Q1OWDPdUXmd0znPiL9fXt+jeeK+MPa0QDtMV/mC6O31dCfYd9O+B58Vywpx/2GTFac
 4qraGdeSzzi/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] drm/tegra: Add support for 8-bit CPU interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261004163114.181800-5-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
 <20261004163114.181800-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:44:28 +0000
Message-Id: <20261004164429.247FD1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] drm/tegra: UAF of GPIO descriptors during MIPI DCS panel disab=
le
- [High] drm/tegra: panel init commands in prepare() silently dropped
- [High] drm/tegra: sleeping in atomic context in bridge callbacks
- [Medium] drm/tegra: tegra-dbi platform device leaked on dc probe error pa=
ths
- [Medium] drm/tegra: double-enable/disable warnings from redundant manual =
panel calls
- [Medium] drm/tegra: leaked DRM panel reference from drm_of_find_panel_or_=
bridge
- [Low] drm/tegra: unused idx variable in tegra_dbi_priv
--

commit 0271b6e2272161d6c9c79ab99f61fc6699770373
Author: Svyatoslav Ryhel <clamor95@gmail.com>
Subject: drm/tegra: Add support for 8-bit CPU interface

The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
that closely resembles the MIPI DBI Type B protocol and is referred to as
'8-bit CPU'. Each display controller provides two such interfaces, which
can be used to send MIPI DCS commands to initialize and control the panel
while image data is transmitted via 16/18/24-line RGB.

> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..74a1051b86778
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c
> @@ -0,0 +1,416 @@
[ ... ]
> +struct tegra_dbi_priv {
> +	struct mipi_dbi dbi;		/* must be first */
> +	struct device *dev;
> +	struct tegra_dc *dc;
> +
> +	struct gpio_desc *dc_gpio;
> +	struct gpio_desc *rw_gpio;
> +	struct gpio_desc *cs_gpio;
> +	struct gpio_descs *data_gpios;
> +
> +	struct drm_bridge bridge;
> +	struct tegra_dbi_output output;
> +
> +	u32 spi_init_seq[4];
> +	u32 bus_width;
> +	u32 idx;

[Severity: Low]
Is the idx field needed here? It doesn't appear to be used anywhere in the
driver.

> +	bool prepared;
> +};
[ ... ]
> +static void tegra_dbi_write(struct tegra_dbi_priv *priv, u8 type, u8 val=
ue)
> +{
> +	DECLARE_BITMAP(value_bitmap, 8);
> +
> +	value_bitmap[0] =3D value;
> +
> +	gpiod_set_value(priv->dc_gpio, type);
> +
> +	gpiod_set_value(priv->cs_gpio, 0);
> +	gpiod_set_value(priv->rw_gpio, 0);
> +
> +	gpiod_set_array_value(priv->data_gpios->ndescs, priv->data_gpios->desc,
> +			      priv->data_gpios->info, value_bitmap);

[Severity: Critical]
Could this dereference freed memory during display teardown?

During a disable cycle, panel_bridge_disable() runs before
tegra_dbi_atomic_disable() and sends DCS commands through
tegra_dbi_dbi_command() -> tegra_dbi_write(). However, the GPIO descriptors
were already freed by gpiod_put_array() at the end of tegra_dbi_atomic_enab=
le(),
leaving dangling pointers in priv->data_gpios.

> +
> +	gpiod_set_value(priv->cs_gpio, 1);
> +	gpiod_set_value(priv->rw_gpio, 1);
> +
> +	udelay(10);
> +}
> +
> +static int tegra_dbi_dbi_command(struct mipi_dbi *dbi, u8 *cmd, u8 *para=
m, size_t num)
> +{
> +	struct tegra_dbi_priv *priv =3D mipi_dbi_to_tegra_dbi(dbi);
> +	u8 command =3D *cmd;
> +
> +	if (!priv->data_gpios)
> +		return 0;

[Severity: High]
Does this silently drop panel initialization commands?

The drm_panel_prepare() hook executes during panel_bridge_pre_enable(), whi=
ch
happens before tegra_dbi_atomic_enable(). Because data_gpios is only alloca=
ted
later during atomic_enable, priv->data_gpios is NULL here and the initializ=
ation
commands get ignored.

> +
> +	tegra_dbi_write(priv, TEGRA_DBI_COMMAND, command);
[ ... ]
> +static int tegra_dbi_prepare_gpios(struct tegra_dbi_priv *priv)
> +{
> +	struct device *dev =3D priv->dev;
> +	int ret;
> +
> +	if (priv->prepared)
> +		return 0;
> +
> +	/*
> +	 * Control and data GPIOs are shared between SPI and DPI. The bridge
> +	 * driver must get and put the required GPIOs each time DCS commands
> +	 * are transmitted.
> +	 */
> +
> +	priv->cs_gpio =3D gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
[ ... ]
> +	priv->data_gpios =3D gpiod_get_array(dev, "data", GPIOD_OUT_LOW);

[Severity: High]
Can this sleep in atomic context?

tegra_dbi_prepare_gpios() is called unconditionally by tegra_dbi_atomic_ena=
ble(),
which executes in an atomic context during non-blocking commits. Both
gpiod_get() and gpiod_get_array() can sleep as they acquire mutexes and per=
form
GFP_KERNEL allocations.

> +	if (IS_ERR(priv->data_gpios)) {
[ ... ]
> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (priv->output.panel)
> +		drm_panel_enable(priv->output.panel);

[Severity: Medium]
Is this manual panel enablement redundant?

The DRM core automatically manages panel enablement via the attached panel_=
bridge
in the bridge chain. Calling drm_panel_enable() here duplicates the operati=
on
that panel_bridge_enable() will perform immediately afterward, which will c=
ause
kernel warnings about enabling an already enabled panel.

> +
> +	gpiod_set_value(priv->cs_gpio, 0);
> +
> +	gpiod_put(priv->dc_gpio);
> +	gpiod_put(priv->rw_gpio);
> +	gpiod_put(priv->cs_gpio);
> +
> +	gpiod_put_array(priv->data_gpios);
> +	priv->prepared =3D false;
> +}
> +
> +static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	int ret;
> +
> +	ret =3D tegra_dbi_prepare_gpios(priv);
> +	if (ret)
> +		return;
> +
> +	if (priv->output.panel)
> +		drm_panel_disable(priv->output.panel);

[Severity: Medium]
Same issue as above. Does this redundant call conflict with the panel_bridg=
e's
automatic lifecycle management, causing warnings about disabling an already
disabled panel?

> +
> +	gpiod_set_value(priv->cs_gpio, 0);
[ ... ]
> +static int tegra_dbi_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	/* Initialize MIPI DBI interface */
> +	mutex_init(&priv->dbi.cmdlock);
> +	priv->dbi.command =3D tegra_dbi_dbi_command;
> +
> +	ret =3D drm_of_find_panel_or_bridge(np, 1, 0, &panel, &bridge);

[Severity: Medium]
Does this code leak the panel reference?

drm_of_find_panel_or_bridge() acquires a reference to the panel, but
drm_panel_put() is never called in the error paths, and there doesn't appear
to be a driver remove function to drop the reference when the driver unbind=
s.

> +	if (ret)
> +		return ret;
[ ... ]
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 5c67928bcabfa..dae2b14f79e31 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
[ ... ]
> @@ -3382,6 +3383,23 @@ static int tegra_dc_probe(struct platform_device *=
pdev)
>  		}
>  	}
> =20
> +	dbi_np =3D of_get_available_child_by_name(pdev->dev.of_node, "dbi");
> +	if (dbi_np) {
> +		struct platform_device_info dbi_info =3D {
> +			.parent =3D &pdev->dev,
> +			.name =3D "tegra-dbi",
> +			.id =3D PLATFORM_DEVID_AUTO,
> +			.fwnode =3D of_fwnode_handle(dbi_np),
> +			.of_node_reused =3D true,
> +		};
> +
> +		dc->dbi =3D platform_device_register_full(&dbi_info);
> +		of_node_put(dbi_np);
> +		if (IS_ERR(dc->dbi))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(dc->dbi),
> +					     "Failed to create DBI device\n");
> +	}
> +
>  	err =3D tegra_dc_rgb_probe(dc);
>  	if (err < 0 && err !=3D -ENODEV)
>  		return dev_err_probe(&pdev->dev, err,
>  				     "failed to probe RGB output\n");

[Severity: Medium]
Are we leaking the dc->dbi platform device on error paths?

If tegra_dc_rgb_probe() or host1x_client_register() fails, the function ret=
urns
without calling platform_device_unregister() to clean up the registered dc-=
>dbi
device. This cleanup also appears to be missing in the disable_pm error lab=
el.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004163114.1818=
00-1-clamor95@gmail.com?part=3D4
