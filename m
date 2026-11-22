Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B2606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PA0+kofj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE66210E4F6;
	Sun, 22 Nov 2026 08:43:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88CED10E4F4
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:43:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 954E760092;
 Sun, 22 Nov 2026 08:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196F11F000C4;
 Sun, 22 Nov 2026 08:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795336987;
 bh=nzENoBqEP38YaFTitLU/VuQrsi/ucjE7nP4aqpSUunU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PA0+kofj8enDiM2l6Pax7ql/ru1G7wn6UqaNWTQvarY3Ai1hYzUEky0J5gHPgn+gd
 SU4p97ldclD+7nl+JHZEvcOzE1bKJVMOfO61utC9ZLpeCumvxzo19uysPdFBG2ZZOL
 db6yomzHCgzLOuLJXib9U9e7Ie1v7/5KH+pMKxv1/ezISvwHn8X9ius7ZKq/zoRgX6
 LbzN3MQYerHVQXi0MAlOhOHA//4xpcEriYFt/T6ndQPrKkzKz6TUwR8Ux1jrf7u8OJ
 TdbNRXJv7FJMOiMzwz0NOdLQjphFSx0LSfZGyDzJ31i99lfVvmnG2Nb8kM0nnnO49Z
 +/yS3CWwmQ0UQ==
Message-ID: <sashiko-outbox-227839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/12] drm/tegra: Add support for 8-bit CPU interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261122081820.53199-13-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-13-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 08:43:06 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/tegra: duplicate and out-of-order next_bridge
  enable/disable calls
- [Medium] drm/tegra: missing DC stop and idle wait in
  tegra_dbi_atomic_disable()
- [Medium] drm/tegra: premature of_node_put() on dbi_np in
  tegra_dc_dbi_probe()
- [Medium] drm/tegra: NULL next_bridge dereference in DBI atomic
  enable/disable
- [Medium] drm/tegra: unconditional PIN_LDC muxing in
  tegra_dbi_atomic_enable()
--

commit 12a7641d08ff0efca036e7255db62622fe7d77c9
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: Add support for 8-bit CPU interface

This commit adds a DRM bridge and MIPI DBI host driver for the 8-bit CPU
interface on Tegra20 and Tegra30 display controllers, allowing MIPI DCS
commands to be sent to panels that receive video data over RGB.

> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..8929f0013462a
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c
> @@ -0,0 +1,592 @@

[ ... ]

> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct drm_bridge *next_bridge =3D priv->next_bridge;
> +	struct tegra_dc *dc =3D priv->dc;
> +	void __iomem *disp_cmd =3D dc->regs + (DC_CMD_DISPLAY_COMMAND << 2);
> +	u32 value;
> +	int ret;
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
> +
> +	/* Ensure the DC is fully idle before reconfiguring pins */
> +	tegra_dc_writel(dc, READ_MUX, DC_CMD_STATE_ACCESS);
> +
> +	ret =3D readl_relaxed_poll_timeout(disp_cmd, value,
> +					 !(value & DISP_CTRL_MODE_MASK), 1000,
> +					 100000);
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +	if (ret) {
> +		dev_err(priv->dev, "timeout waiting for DC to become idle\n");
> +		return;
> +	}
> +
> +	tegra_dc_writel(dc, V_PULSE1_ENABLE, DC_DISP_DISP_SIGNAL_OPTIONS0);
> +	tegra_dc_writel(dc, PULSE_POLARITY_LOW, DC_DISP_V_PULSE1_CONTROL);
> +
> +	tegra_dc_writel(dc, PULSE_END(1), DC_DISP_V_PULSE1_POSITION_A);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_B);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_C);
> +
> +	value =3D 1 << FRAME_INIT_SEQ_CYCLES_SHIFT |
> +		DC_SIGNAL_VPULSE1 << INIT_SEQ_DC_SIGNAL_SHIFT |
> +		INIT_SEQUENCE_MODE_PLCD | SEND_INIT_SEQUENCE;
> +	tegra_dc_writel(dc, value, DC_DISP_INIT_SEQ_CONTROL);
> +
> +	/* Init cycle 1: WRITE_MEMORY_START, set LCD_PCLK and COMMAND */
> +	tegra_dc_writel(dc, MIPI_DCS_WRITE_MEMORY_START, DC_DISP_SPI_INIT_SEQ_D=
ATA_A);
> +	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_B);
> +	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_C);
> +	tegra_dc_writel(dc, BIT(12) | BIT(14), DC_DISP_SPI_INIT_SEQ_DATA_D);
> +
> +	/* Set LDC pin to V Pulse 1 */
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LDC);
> +	value |=3D PIN_OUTPUT_SELECT_F4(PIN_OUTPUT_SELECT_LDC);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));

[Severity: Medium]
Does this unconditionally mux V_PULSE1 onto PIN_LDC even when the secondary
8-bit CPU interface (nvidia,interface =3D 1) is selected?

In tegra_dbi_idx[], the secondary interface uses PIN_LVP0 in
DC_COM_PIN_OUTPUT_SELECT(4) as its D/C signal rather than PIN_LDC.  Because
tegra_rgb_encoder_enable() programs PIN_OUTPUT_SELECT_LVP0 to
PIN_OUTPUT_SELECT_OUT before tegra_dbi_atomic_enable() backs up the pin
registers into com_pin_backup[], restoring com_pin_backup[] leaves PIN_LVP0
in fixed GPIO output mode during scanout instead of driving the per-frame
MIPI_DCS_WRITE_MEMORY_START D/C pulse on the secondary interface.

[ ... ]

> +	/*
> +	 * DBI requires that the next bridge be enabled here in order to
> +	 * send DCS commands, since the interface pins will subsequently be
> +	 * reconfigured for video data.
> +	 *
> +	 * Using the prepare_prev_first flag in the panel will not work,
> +	 * because the DBI bridge requires the panel to be enabled beforehand
> +	 * for proper configuration.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_enable)
> +		next_bridge->funcs->atomic_enable(next_bridge, state);

[Severity: Medium]
Can next_bridge be NULL here and in tegra_dbi_atomic_disable() if the MIPI
DBI peripheral driver has been unbound?

tegra_dbi_host_detach() calls drm_bridge_clear_and_put(&priv->next_bridge),
setting priv->next_bridge to NULL.  A subsequent modeset or shutdown will
then hit a NULL pointer dereference when evaluating next_bridge->funcs.

> +
> +	tegra_dbi_pin_set(dc, &priv->interface->cs, 0);
> +
> +	priv->active =3D false;
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +
> +	for (int i =3D 0; i <  ARRAY_SIZE(tegra_dbi_pin_regs); i++)
> +		tegra_dc_writel(dc, priv->com_pin_backup[i],
> +				tegra_dbi_pin_regs[i]);
> +
> +	tegra_dc_commit(dc);
> +
> +	value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> +	value &=3D ~DISP_CTRL_MODE_MASK;
> +	value |=3D DISP_CTRL_MODE_C_DISPLAY;
> +	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> +}
> +
> +static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct drm_bridge *next_bridge =3D priv->next_bridge;
> +	struct tegra_dc *dc =3D priv->dc;
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(tegra_dbi_pin_regs); i++)
> +		priv->com_pin_backup[i] =3D tegra_dc_readl(dc, tegra_dbi_pin_regs[i]);
> +
> +	tegra_dc_writel(dc, WRITE_MUX | READ_MUX, DC_CMD_STATE_ACCESS);
> +
> +	priv->interface->init(priv);
> +	priv->active =3D true;

[Severity: Medium]
Should tegra_dbi_atomic_disable() stop the DC and wait for it to become idle
before unshadowing DC_CMD_STATE_ACCESS and reconfiguring pins, just as
tegra_dbi_atomic_enable() does?

During modeset disable, drm_atomic_helper_commit_encoder_bridge_disable()
runs before drm_atomic_helper_commit_crtc_disable(), so the DC is still
actively scanning out in DISP_CTRL_MODE_C_DISPLAY with V_PULSE1 frame init
sequences enabled while the pins are switched to GPIO output mode and bit-
banged for DBI commands.

> +
> +	/*
> +	 * DBI requires that the next bridge be disabled here in order to
> +	 * send DCS commands, since the interface pins will subsequently be
> +	 * reconfigured for video data and tegra_rgb_encoder_disable() will
> +	 * be called before drm_panel_unprepare() runs in post_disable.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_disable)
> +		next_bridge->funcs->atomic_disable(next_bridge, state);

[Severity: High]
As reported by Mikko Perttunen on v5 [1], since tegra_dbi_attach() attaches
priv->next_bridge to encoder->bridge_chain, won't manually calling
next_bridge->funcs->atomic_enable() and atomic_disable() cause both
callbacks to run twice and in the wrong order on disable?

On enable, drm_atomic_bridge_chain_enable() calls tegra_dbi_atomic_enable(),
which invokes next_bridge->funcs->atomic_enable() while priv->active is tru=
e,
and then drm_atomic_bridge_chain_enable() advances to priv->next_bridge and
calls next_bridge->funcs->atomic_enable() a second time while priv->active =
is
false.

On disable, drm_atomic_bridge_chain_disable() walks encoder->bridge_chain in
reverse order and calls next_bridge->funcs->atomic_disable() before
tegra_dbi_atomic_disable() runs.  At that point priv->active is still false
and the pins are in RGB video mode, so tegra_dbi_dbi_command() rejects all
panel disable DCS commands with -ENODEV.  If the panel's disable callback
still returns 0, drm_panel_disable() marks panel->enabled =3D false on that
failed first call and skips the second call inside tegra_dbi_atomic_disable=
()
so the panel never receives its disable commands; if it propagates -ENODEV,
the panel disable sequence and its msleep() delays run twice.

[ ... ]

> +int tegra_dc_dbi_probe(struct tegra_dc *dc)
> +{
> +	struct device *dev =3D dc->dev;
> +	struct device_node *dbi_np __free(device_node) =3D
> +		of_get_available_child_by_name(dev_of_node(dev), "dbi");
> +	struct mipi_dbi_device *dbidev;
> +	struct tegra_dbi_priv *priv;
> +	struct device_node *np;
> +	u32 interface =3D 0;
> +	int ret;
> +
> +	/* Missing node means that DBI is not used, continue DC probe */
> +	if (!dbi_np)
> +		return 0;
> +
> +	of_property_read_u32(dbi_np, "nvidia,interface", &interface);
> +	if (interface !=3D 0 && interface !=3D 1)
> +		return dev_err_probe(dev, -EINVAL, "Wrong interface value: %d\n", inte=
rface);
> +
> +	priv =3D devm_drm_bridge_alloc(dev, struct tegra_dbi_priv, bridge,
> +				     &tegra_dbi_funcs);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	priv->dc =3D dc;
> +	priv->dev =3D dev;
> +	priv->interface =3D &tegra_dbi_idx[interface];
> +
> +	/* Initialize MIPI DBI interface */
> +	mutex_init(&priv->dbi.cmdlock);
> +	priv->dbi.command =3D tegra_dbi_dbi_command;
> +
> +	priv->dbi_host.dev =3D dev;
> +	priv->dbi_host.dbi =3D &priv->dbi;
> +	priv->dbi_host.ops =3D &tegra_dbi_host_ops;
> +
> +	priv->bridge.of_node =3D dbi_np;

[Severity: Medium]
Does declaring dbi_np with __free(device_node) drop the OF node reference as
soon as tegra_dc_dbi_probe() returns while priv->bridge.of_node keeps using
the pointer?

Neither devm_drm_bridge_alloc() nor devm_drm_bridge_add() takes a reference
on bridge->of_node, so when tegra_dc_dbi_probe() exits, of_node_put(dbi_np)
releases the reference obtained from of_get_available_child_by_name() before
tegra_dbi_host_attach() and bridge lookup helpers dereference
priv->bridge.of_node.

[1] https://lore.kernel.org/r/weWUeY3nRGCfNVcl2RuY5g@nvidia.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122081820.5319=
9-1-clamor95@gmail.com?part=3D12
