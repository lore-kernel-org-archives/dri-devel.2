Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736A5CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6382F10E995;
	Mon, 19 Oct 2026 10:20:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DC610E995
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:20:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C3CF43BF5;
 Mon, 19 Oct 2026 10:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC191F000C5;
 Mon, 19 Oct 2026 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792405252;
 bh=DjsBlWQSijPcFLZKgXE6mkzBx4kXm1KxPWCIYNRvK9Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KNYAWKm242hiclYsimNtOsD0qb0LXu724AESE4q+AN9mKqx26mf0YAyDxqhg9IxdV
 Cu4XcqwbTU99efc5W/aT+sLBPpfpay8TGWiNraXH7hgBZKekcKR8bKZYYlmz3kvAUi
 8Py/O7ASHcZQUCPO8sW5gkzl960phZBWdSbqWChQ+zBy3Lmvhbd2OSR1CqwVk+WCZh
 g59VZji5ccNTzcYdSM3sVgSG+ZYy7onn/pgxKT4lUHDbTtEwbqIP8ZyFavC1DEXkVm
 UVaR5EUHJSolbWgenyYj+L79ZdvT+LErBAkPN2/zAyn87qOuitDpFP1j5gEa3CKRpU
 ur73zycX8gskw==
Message-ID: <sashiko-outbox-176973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] drm/tegra: Add support for 8-bit CPU interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019095705.91062-5-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
 <20261019095705.91062-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:20:51 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] drm/tegra: dbi: use-after-free and ERR_PTR deref of priv->data=
_gpios
- [High] drm/tegra: dbi: duplicate panel enable/disable and broken disable =
order
- [High] drm/tegra: dbi: wrong V_PULSE position regs in tegra_dbi_atomic_en=
able()
- [High] drm/tegra: dc: unregistering dbi device on probe deferral blocks r=
eprobe
- [Medium] drm/tegra: dbi: drm_panel reference leak in tegra_dbi_probe()
- [Medium] drm/tegra: dbi: missing MODULE_ALIAS() in tegra_dbi_driver
--

commit 3433ae394a211380cb312bda5b319e1df0574de3
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: Add support for 8-bit CPU interface

This commit adds a DRM bridge driver for the Tegra20/30 8-bit CPU (MIPI DBI
Type B) display controller interface and registers its platform device from
the Tegra DC probe path.

> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..4b3966dea0438
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c
> @@ -0,0 +1,415 @@

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
> +
> +	tegra_dbi_write(priv, TEGRA_DBI_COMMAND, command);
> +
> +	for (int i =3D 0; i < num; i++)
> +		tegra_dbi_write(priv, TEGRA_DBI_DATA, param[i]);
> +
> +	return 0;
> +}
> +
> +static int tegra_dbi_prepare_gpios(struct tegra_dbi_priv *priv)
> +{
> +	struct device *dev =3D priv->dev;
> +	int ret;
> +
> +	if (priv->prepared)
> +		return 0;

[ ... ]

> +	priv->data_gpios =3D gpiod_get_array(dev, "data", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->data_gpios)) {
> +		ret =3D PTR_ERR(priv->data_gpios);
> +		dev_err(dev, "Failed to get data gpios %d\n", ret);
> +		goto free_dc;
> +	}
> +
> +	if (priv->data_gpios && priv->data_gpios->ndescs > TEGRA_DBI_DATA_PINS_=
MAX) {
> +		ret =3D -EINVAL;
> +		dev_err(dev, "Too many data gpios\n");
> +		goto free_data;
> +	}
> +
> +	priv->prepared =3D true;
> +
> +	return 0;
> +
> +free_data:
> +	gpiod_put_array(priv->data_gpios);
> +free_dc:
> +	gpiod_put(priv->dc_gpio);
> +free_rw:
> +	gpiod_put(priv->rw_gpio);
> +free_cs:
> +	gpiod_put(priv->cs_gpio);
> +
> +	return ret;
> +}

[Severity: Critical]
Can tegra_dbi_dbi_command() -> tegra_dbi_write() dereference a freed or
ERR_PTR priv->data_gpios pointer?

In tegra_dbi_atomic_enable() and tegra_dbi_atomic_disable(), the driver
releases priv->dc_gpio, priv->rw_gpio, and priv->cs_gpio via gpiod_put(),
frees priv->data_gpios via gpiod_put_array() (which calls kfree(descs)),
and sets priv->prepared =3D false without holding priv->dbi.cmdlock or
resetting the pointers to NULL.

Similarly, in tegra_dbi_prepare_gpios(), if gpiod_get_array() fails,
priv->data_gpios is left holding a non-NULL ERR_PTR(), and if
priv->data_gpios->ndescs > TEGRA_DBI_DATA_PINS_MAX, gpiod_put_array() frees
priv->data_gpios without clearing the pointer.

Because tegra_dbi_dbi_command() checks:

    if (!priv->data_gpios)
        return 0;

instead of checking priv->prepared, any MIPI DBI command sent while
priv->prepared is false (such as during modeset disable when
drm_atomic_bridge_chain_disable() runs panel_bridge_atomic_disable() ->
drm_panel_disable() before tegra_dbi_atomic_disable()) will pass a dangling
pointer or ERR_PTR to tegra_dbi_write(), dereferencing priv->data_gpios and
passing released GPIO descriptors to gpiod_set_value().

> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct tegra_dc *dc =3D priv->dc;
> +	u32 value;
> +	int ret;

[ ... ]

> +	tegra_dc_writel(dc, V_PULSE1_ENABLE, DC_DISP_DISP_SIGNAL_OPTIONS0);
> +	tegra_dc_writel(dc, PULSE_POLARITY_LOW, DC_DISP_V_PULSE1_CONTROL);
> +
> +	tegra_dc_writel(dc, PULSE_END(1), DC_DISP_V_PULSE0_POSITION_A);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE0_POSITION_B);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE0_POSITION_C);

[Severity: High]
Should these writes in tegra_dbi_atomic_enable() target
DC_DISP_V_PULSE1_POSITION_A, DC_DISP_V_PULSE1_POSITION_B, and
DC_DISP_V_PULSE1_POSITION_C instead of the V_PULSE0 position registers?

The surrounding code enables V_PULSE1_ENABLE, configures
DC_DISP_V_PULSE1_CONTROL, selects DC_SIGNAL_VPULSE1 in
DC_DISP_INIT_SEQ_CONTROL, and routes LDC_OUTPUT_SELECT_V_PULSE1, but leaves
DC_DISP_V_PULSE1_POSITION_A/B/C unconfigured while overwriting V_PULSE0.

[ ... ]

> +	ret =3D tegra_dbi_prepare_gpios(priv);
> +	if (ret)
> +		return;
> +
> +	if (priv->output.panel)
> +		drm_panel_enable(priv->output.panel);
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

[Severity: High]
Does wrapping the panel with devm_drm_panel_bridge_add_typed() in
tegra_dbi_probe() and attaching it in tegra_dbi_attach() cause duplicate
drm_panel_enable() and drm_panel_disable() calls and broken disable
ordering?

Because priv->output.bridge is attached to encoder->bridge_chain after
priv->bridge:

1. On enable, drm_atomic_bridge_chain_pre_enable() calls
panel_bridge_atomic_pre_enable() -> drm_panel_prepare() before
tegra_dbi_atomic_enable() acquires the DBI GPIOs. Then
drm_atomic_bridge_chain_enable() runs tegra_dbi_atomic_enable(), which calls
drm_panel_enable(priv->output.panel), and immediately afterward runs
panel_bridge_atomic_enable() -> drm_panel_enable(), triggering:

    dev_warn(panel->dev, "Skipping enable of already enabled panel\n");

2. On disable, drm_atomic_bridge_chain_disable() walks the bridge chain in
reverse order. It runs panel_bridge_atomic_disable() -> drm_panel_disable()
before tegra_dbi_atomic_disable() has prepared the DBI GPIOs, and sets
panel->enabled =3D false. When tegra_dbi_atomic_disable() then runs, prepar=
es
the GPIOs, and calls drm_panel_disable(priv->output.panel), drm_panel_disab=
le()
sees !panel->enabled, logs:

    dev_warn(panel->dev, "Skipping disable of already disabled panel\n");

and returns without invoking panel->funcs->disable().

[ ... ]

> +static int tegra_dbi_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	ret =3D devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to probe children\n");
> +
> +	/* Initialize MIPI DBI interface */
> +	mutex_init(&priv->dbi.cmdlock);
> +	priv->dbi.command =3D tegra_dbi_dbi_command;
> +
> +	ret =3D drm_of_find_panel_or_bridge(np, 1, 0, &panel, &bridge);
> +	if (ret)
> +		return ret;
> +
> +	if (panel) {
> +		bridge =3D devm_drm_panel_bridge_add_typed(dev, panel,
> +							 DRM_MODE_CONNECTOR_DPI);
> +		if (IS_ERR(bridge))
> +			return PTR_ERR(bridge);
> +	}

[Severity: Medium]
Does tegra_dbi_probe() leak the drm_panel reference acquired by
drm_of_find_panel_or_bridge()?

drm_of_find_panel_or_bridge() -> of_drm_find_panel() increments the panel
refcount via drm_panel_get(), and devm_drm_panel_bridge_add_typed() takes an
additional devres-managed reference on &panel->bridge, so the reference
from drm_of_find_panel_or_bridge() is never dropped with drm_panel_put().

[ ... ]

> +static struct platform_driver tegra_dbi_driver =3D {
> +	.driver.name =3D "tegra-dbi",
> +	.probe =3D tegra_dbi_probe,
> +};
> +module_platform_driver(tegra_dbi_driver);
> +
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver");
> +MODULE_LICENSE("GPL");

[Severity: Medium]
Should tegra_dbi_driver include MODULE_ALIAS("platform:tegra-dbi") (or a
platform_device_id table) so the module auto-loads when CONFIG_DRM_TEGRA_DB=
I=3Dm?

In tegra_dc_probe(), the device is registered with .name =3D "tegra-dbi" and
.of_node_reused =3D true, which causes platform_uevent() to emit
MODALIAS=3Dplatform:tegra-dbi rather than an OF modalias.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 5c67928bcabfa..8f12d30cd2d8b 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c

[ ... ]

> @@ -3382,6 +3389,28 @@ static int tegra_dc_probe(struct platform_device *=
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
> +
> +		err =3D devm_add_action_or_reset(&pdev->dev, tegra_dc_release_dbi_pdev,
> +					       dc->dbi);
> +		if (err)
> +			return err;
> +	}
> +
>  	err =3D tegra_dc_rgb_probe(dc);
>  	if (err < 0 && err !=3D -ENODEV)
>  		return dev_err_probe(&pdev->dev, err,

[Severity: High]
What happens when tegra_dc_rgb_probe() or tegra_dbi_probe() returns
-EPROBE_DEFER?

In tegra_dc_probe(), dc->dbi is registered right before tegra_dc_rgb_probe()
(which calls tegra_output_probe() -> drm_of_find_panel_or_bridge() to look =
up
the bridge on the dbi node). Similarly, tegra_dbi_probe() calls
devm_of_platform_populate(dev) and immediately requires the child panel in
drm_of_find_panel_or_bridge() before calling devm_drm_bridge_add().

If tegra-dbi or the child panel driver has not bound yet (for example, when
CONFIG_DRM_TEGRA_DBI=3Dm, the panel driver is a module, or a panel dependen=
cy
defers), tegra_dbi_probe() unpopulates the child panel via devres and
tegra_dc_probe() returns -EPROBE_DEFER.

When tegra_dc_probe() fails with -EPROBE_DEFER, devres_release_all(&pdev->d=
ev)
runs tegra_dc_release_dbi_pdev() -> platform_device_unregister(dc->dbi).
With both the tegra-dbi device and its child panel device removed from the
platform bus, what will match and bind to trigger a deferred reprobe of
tegra_dc?

>=20

=E5=AE=8C=E7=BE=8E! Let's double-check all constraints:
- Plain text only, no markdown, no backticks, no ALL CAPS in commentary.
- Wrapped at 78 characters.
- Ends with a blank line.
- No line numbers mentioned in commentary.
- Severity tags `[Severity: ...]` on their own line right above each inline=
 comment.
- All 6 findings (VF1, VF2, VF3, VF4, VF5, PVF1) included. Everything is cl=
ean and accurate. Ready to output!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019095705.9106=
2-1-clamor95@gmail.com?part=3D4
