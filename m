Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1D606A337
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE7OG7C7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842C010E3F3;
	Thu, 22 Oct 2026 13:53:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD16F10E3F3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:53:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 839ED4351C;
 Thu, 22 Oct 2026 13:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B811F000C4;
 Thu, 22 Oct 2026 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792677193;
 bh=tg+CHFuZf9QNTjBeGBrhONfoehGTt8da85PUqPcAl8w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OE7OG7C7v0p7Fnp5F+EWUcyUnpF3Y+K3Vgm+izD9GFtTmYkbOLq53Nbx8Eaf3/Yfe
 LZ6+Id8tmHYevd5W9vWzwwSyWqkGO+749OOSHxFb58/Ep/FquTRUqCMRSvEa9GCMT3
 k28H8LIAINRcNFWggFvXhmSmeYmbXBEhCQXCkRax357twdMcu68dGlFb9aavW8CSNs
 Vxr5O0dYPhNRCjH3uVnK50b8QcD63L8VX9QF55tcW4kuTMi93wjcWEzXw78Zs83R+8
 5rB7Vu6WkC/UayBAZlDnsi4QmUZ1NNVWcHtJ8yBDD7dwJjNX7EyL00bct0W2HgCc48
 rIHS2D/7/rveQ==
Message-ID: <sashiko-outbox-181587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261022132259.240717-8-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-8-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 13:53:12 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/tegra: duplicate panel enable and broken disable in tegra_dbi
- [High] drm/tegra: dbi child devices destroyed on -EPROBE_DEFER in probe()
- [High] drm/tegra: shadowed registers updated with WRITE_MUX set in tegra_=
dbi_atomic_enable()
- [Medium] drm/tegra: shared mutable com_pin_output array races across DBI =
instances
- [Medium] drm/tegra: dbi: missing drm_panel_put() in tegra_dbi_probe()
--

commit 7920d1e9b99c981c6e715c2c232ac6f4896a683b
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: Add support for 8-bit CPU interface

This commit adds a DRM bridge driver for the 8-bit CPU (MIPI DBI Type B)
display controller interface on Tegra20/30 SoCs and registers the child
tegra-dbi platform device from tegra_dc_probe().

> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..7bd90d32053f2
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c
> @@ -0,0 +1,536 @@

[ ... ]

> +struct reg_entry {
> +	u32 offset;
> +	u32 value;
> +};
> +
> +/*
> + * This is used to backup and restore COM pin state during
> + * tegra_dbi_atomic_enable/disable.
> + */
> +static struct reg_entry com_pin_output[] =3D {
> +	{ DC_COM_PIN_OUTPUT_ENABLE(0),   0 },
> +	{ DC_COM_PIN_OUTPUT_ENABLE(1),   0 },
> +	{ DC_COM_PIN_OUTPUT_ENABLE(2),   0 },
> +	{ DC_COM_PIN_OUTPUT_ENABLE(3),   0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(0), 0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(1), 0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(2), 0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(3), 0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(0),     0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(1),     0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(2),     0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(3),     0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(0),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(1),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(2),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(3),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(4),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(5),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(6),   0 },
> +};

[Severity: Medium]
Can concurrent modesets on two display controllers race on com_pin_output[]?

In drivers/gpu/drm/tegra/dbi.c, com_pin_output[] is a single mutable
file-scope array shared across all tegra-dbi instances without locking.

Both tegra_dbi_atomic_enable() and tegra_dbi_atomic_disable() save per-DC
DC_COM_PIN_OUTPUT_* register values into com_pin_output[i].value, sleep
inside drm_panel_enable() or drm_panel_disable() while bitbanging panel
commands, and then write com_pin_output[i].value back to the DC registers.

If non-blocking atomic commits run concurrently on two CRTCs with DBI
interfaces, won't one instance overwrite com_pin_output[] while the other
is sleeping and restore corrupted register state? Should the saved values
live in struct tegra_dbi_priv or on the stack instead?

[ ... ]

> +static int tegra_dbi_dbi_command(struct mipi_dbi *dbi, u8 *cmd, u8 *para=
m, size_t num)
> +{
> +	struct tegra_dbi_priv *priv =3D mipi_dbi_to_tegra_dbi(dbi);
> +	u8 command =3D *cmd;
> +
> +	/* Blocks all commands when interface is not active */
> +	if (!priv->active)
> +		return -ENODEV;
> +
> +	tegra_dbi_write(priv, TEGRA_DBI_COMMAND, command);
> +
> +	for (int i =3D 0; i < num; i++)
> +		tegra_dbi_write(priv, TEGRA_DBI_DATA, param[i]);
> +
> +	return 0;
> +}

[ ... ]

> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct tegra_dc *dc =3D priv->dc;
> +	u32 value;
> +
> +	value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> +	value &=3D ~DISP_CTRL_MODE_MASK;
> +	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> +
> +	/* Disable all options except cursor if enabled */
> +	value =3D tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
> +	value &=3D CURSOR_ENABLE;
> +	tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
> +
> +	tegra_dc_commit(dc);

[ ... ]

> +	/*
> +	 * Backup registers before unshadowing since actual register values
> +	 * may differ and their state backed up now is the correct one.
> +	 */
> +	for (int i =3D 0; i < ARRAY_SIZE(com_pin_output); i++)
> +		com_pin_output[i].value =3D tegra_dc_readl(dc, com_pin_output[i].offse=
t);
> +
> +	/* Unshadow to set up command and data pins */
> +	tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
> +
> +	if (priv->idx)
> +		tegra_dbi_init_secondary_interface(priv);
> +	else
> +		tegra_dbi_init_primary_interface(priv);
> +
> +	priv->active =3D true;
> +
> +	if (priv->output.panel)
> +		drm_panel_enable(priv->output.panel);
> +
> +	tegra_dbi_pin_set(dc, &priv->index->cs, 0);
> +
> +	priv->active =3D false;
> +
> +	for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> +		tegra_dc_writel(dc, com_pin_output[i].value, com_pin_output[i].offset);
> +
> +	/* Set LDC pin to V Pulse 1 */
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> +	value |=3D LDC_OUTPUT_SELECT_V_PULSE1;
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
> +
> +	value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> +	value &=3D ~DISP_CTRL_MODE_MASK;
> +	value |=3D DISP_CTRL_MODE_C_DISPLAY;
> +	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +}

[Severity: High]
Won't updating DC_COM_PIN_OUTPUT_SELECT(6) and DC_CMD_DISPLAY_COMMAND while
WRITE_MUX is set leave the assembly registers with stale values that overwr=
ite
the active configuration on the next plane flush?

At the start of tegra_dbi_atomic_enable() in drivers/gpu/drm/tegra/dbi.c,
while DC_CMD_STATE_ACCESS is 0 (targeting the assembly registers), the code
clears DISP_CTRL_MODE_MASK (setting DISP_CTRL_MODE_STOP) in
DC_CMD_DISPLAY_COMMAND and calls tegra_dc_commit(dc). It then writes the
V_PULSE1, init sequence, shift clock, and color control settings to the
assembly registers without committing them.

Next, it sets WRITE_MUX in DC_CMD_STATE_ACCESS so writes go directly to the
active registers during panel bitbanging. However, after restoring
com_pin_output[], it sets LDC_OUTPUT_SELECT_V_PULSE1 in
DC_COM_PIN_OUTPUT_SELECT(6) and DISP_CTRL_MODE_C_DISPLAY in
DC_CMD_DISPLAY_COMMAND before clearing DC_CMD_STATE_ACCESS back to 0, and
does not call tegra_dc_commit(dc).

When tegra_crtc_atomic_flush() runs immediately afterward during
drm_atomic_helper_commit_planes() and writes GENERAL_UPDATE and
GENERAL_ACT_REQ to DC_CMD_STATE_CONTROL, won't the stale assembly registers
(where DC_COM_PIN_OUTPUT_SELECT(6) lacks LDC_OUTPUT_SELECT_V_PULSE1 and
DC_CMD_DISPLAY_COMMAND still holds DISP_CTRL_MODE_STOP) be latched into the
active registers and stop the display?

> +
> +static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct tegra_dc *dc =3D priv->dc;
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(com_pin_output); i++)
> +		com_pin_output[i].value =3D tegra_dc_readl(dc, com_pin_output[i].offse=
t);
> +
> +	tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
> +
> +	if (priv->idx)
> +		tegra_dbi_init_secondary_interface(priv);
> +	else
> +		tegra_dbi_init_primary_interface(priv);
> +
> +	priv->active =3D true;
> +
> +	if (priv->output.panel)
> +		drm_panel_disable(priv->output.panel);
> +
> +	priv->active =3D false;
> +
> +	for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> +		tegra_dc_writel(dc, com_pin_output[i].value, com_pin_output[i].offset);
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +}

[Severity: High]
How does calling drm_panel_enable() and drm_panel_disable() directly here
interact with the panel_bridge attached in tegra_dbi_attach()?

In tegra_dbi_probe(), the panel is wrapped in a panel_bridge via
devm_drm_panel_bridge_add_typed() and stored in priv->output.bridge, while
the raw panel pointer is also saved in priv->output.panel. tegra_dbi_attach=
()
then attaches priv->output.bridge to encoder->bridge_chain after tegra_dbi.

During enable, drm_atomic_bridge_chain_enable() runs tegra_dbi_atomic_enabl=
e()
first, which sets priv->active =3D true, calls drm_panel_enable(priv->outpu=
t.panel)
(setting panel->enabled =3D true), and resets priv->active =3D false. Immed=
iately
afterward, panel_bridge_atomic_enable() runs for the attached panel_bridge
and calls drm_panel_enable() a second time, hitting:

    if (panel->enabled) {
        dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
        return;
    }

During disable, drm_atomic_bridge_chain_disable() walks the bridge chain in
reverse order, so panel_bridge_atomic_disable() runs before
tegra_dbi_atomic_disable(). At that point priv->active is still false and t=
he
DC COM pins are not configured for DBI bitbanging, so every MIPI DBI command
sent by panel->funcs->disable() fails in tegra_dbi_dbi_command():

    if (!priv->active)
        return -ENODEV;

drm_panel_disable() then sets panel->enabled =3D false. When
tegra_dbi_atomic_disable() subsequently runs with priv->active =3D true and
calls drm_panel_disable(priv->output.panel), it hits:

    if (!panel->enabled) {
        dev_warn(panel->dev, "Skipping disable of already disabled panel\n"=
);
        return;
    }

and returns without calling panel->funcs->disable(). Similarly, any DBI
commands sent from panel .prepare() or .unprepare() callbacks will also see
priv->active =3D=3D false and fail with -ENODEV.

[ ... ]

> +static int tegra_dbi_attach(struct drm_bridge *bridge,
> +			    struct drm_encoder *encoder,
> +			    enum drm_bridge_attach_flags flags)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct device *dev =3D priv->dev;
> +
> +	priv->dc =3D dev_get_drvdata(dev->parent);
> +	if (!priv->dc)
> +		return -ENODEV;
> +
> +	return drm_bridge_attach(bridge->encoder, priv->output.bridge, bridge,
> +				 flags);
> +}

[ ... ]

> +static int tegra_dbi_probe(struct platform_device *pdev)
> +{
> +	struct tegra_dbi_priv *priv;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct drm_bridge *bridge;
> +	struct drm_panel *panel;
> +	struct device_node *ep;
> +	int ret;
> +
> +	priv =3D devm_drm_bridge_alloc(dev, struct tegra_dbi_priv, bridge,
> +				     &tegra_dbi_funcs);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	priv->dev =3D dev;
> +
> +	/* Default to primaty */
> +	device_property_read_u32(dev, "nvidia,index", &priv->idx);
> +	if (priv->idx)
> +		priv->index =3D &tegra_dbi_idx[1];
> +	else
> +		priv->index =3D &tegra_dbi_idx[0];
> +
> +	/* Initialize MIPI DBI interface */
> +	mutex_init(&priv->dbi.cmdlock);
> +	priv->dbi.command =3D tegra_dbi_dbi_command;
> +
> +	ret =3D devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to probe children\n");
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
Does tegra_dbi_probe() leak the struct drm_panel reference acquired by
drm_of_find_panel_or_bridge()?

When drm_of_find_panel_or_bridge() finds a panel via of_drm_find_panel(), it
increments the panel reference count with drm_panel_get(panel).
devm_drm_panel_bridge_add_typed() then takes a second reference via
drm_panel_bridge_add_typed() -> drm_bridge_get(&panel->bridge) and only
releases that second reference on devres teardown.

Because tegra_dbi_probe() never calls drm_panel_put(panel) on error paths or
device unbind, isn't the reference from drm_of_find_panel_or_bridge() leake=
d?

> +
> +	priv->output.bridge =3D bridge;
> +	priv->output.panel =3D panel;
> +
> +	/* get input ep (port0/endpoint0) */
> +	ret =3D -EINVAL;
> +	ep =3D of_graph_get_endpoint_by_regs(np, 0, 0);
> +	if (ep) {
> +		ret =3D of_property_read_u32(ep, "bus-width", &priv->bus_width);
> +		of_node_put(ep);
> +	}
> +
> +	if (ret)
> +		priv->bus_width =3D 24;
> +
> +	priv->bridge.of_node =3D np;
> +	priv->bridge.timings =3D &default_tegra_dbi_timings;
> +
> +	ret =3D devm_drm_bridge_add(dev, &priv->bridge);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add bridge\n");
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}

[ ... ]

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
What happens here and in tegra_dbi_probe() when CONFIG_DRM_TEGRA_DBI=3Dm, or
when the child panel driver is a module or defers probe?

In tegra_dc_probe(), dc->dbi is registered with a devm cleanup action
(tegra_dc_release_dbi_pdev) right before calling tegra_dc_rgb_probe(dc).
tegra_dc_rgb_probe() -> tegra_output_probe() calls
drm_of_find_panel_or_bridge(), which returns -EPROBE_DEFER unless
tegra_dbi_probe() has already bound and called devm_drm_bridge_add().

Similarly, in tegra_dbi_probe(), devm_of_platform_populate(dev) creates the
child panel platform device and immediately calls
drm_of_find_panel_or_bridge(np, 1, 0, &panel, &bridge), which returns
-EPROBE_DEFER unless the panel driver has already synchronously bound and
registered its panel.

When either drm_of_find_panel_or_bridge() call returns -EPROBE_DEFER,
devres_release_all() runs on probe failure and unregisters the child panel
device and dc->dbi. With those child platform devices destroyed while
tegra-dc is deferred, how can udev autoload their modules or a later driver
registration bind to them and re-trigger deferred probing?

Also, in tegra_dbi_probe(), devm_of_platform_populate(dev) is called before
platform_set_drvdata(pdev, priv). If a child panel driver probes
synchronously during devm_of_platform_populate(dev) and calls
dev_get_drvdata(dev->parent) to obtain struct mipi_dbi, won't it get NULL?

Should platform_set_drvdata(pdev, priv) be called before populating childre=
n?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022132259.2407=
17-1-clamor95@gmail.com?part=3D7
