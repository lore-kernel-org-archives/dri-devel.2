Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A77606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE2rhqG2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01A11123F5;
	Thu, 29 Oct 2026 15:55:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA4D1123F5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:55:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D27243928;
 Thu, 29 Oct 2026 15:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2BF1F01824;
 Thu, 29 Oct 2026 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793289310;
 bh=1VwWsE71pD16ba6yYPb9TUUw7t3vs5NYGRM4gF9nz68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aE2rhqG2R1Y6DeJ95AQAXaJKts97X+vNB2GErfpogbe6IjSOgFU9CbRdEXIrR8bVL
 5A6QPC2whK4EyAjVJ0hZYNFLmkOJUG9OgPGERzrXRkRijXE+Fsr7j1Hl27VmeaihO+
 npizenWU7LNtbA58A7XqtEtwxchvt8tfR2l/0zDntbVADhaVQefvT6OztwrcQN6Nro
 ZL2UL5cHDvzfYrRjYvgyM2nTIip7zEyaO2Z5R6D1DRMMe+tuFnAeIyb92uAyU3Ks8S
 y5PA1y//CBrAE631D418adpN+JTXDwskhuI9XoTRxcmc17ykC0YYKLq2quUI8L27oW
 k2W4Y8jVczbPw==
Message-ID: <sashiko-outbox-189642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/11] drm/tegra: Add support for 8-bit CPU interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029152909.234584-12-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-12-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:55:09 +0000
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
- [High] drm/tegra: manual next_bridge calls in tegra_dbi_atomic_enable() b=
reak disable
- [High] drm/tegra: double drm_bridge_remove() and leak in tegra_dbi_host_a=
ttach()
- [High] drm/tegra: driver conflict and deferral deadlock in devm_tegra_dc_=
dbi_init()
- [Medium] drm/tegra: misconfigured pin select and mux in tegra_dbi_atomic_=
enable()
- [Low] drm/tegra: missing select DRM_MIPI_DBI causes link error in tegra_d=
bi_probe()
--

commit 38b0aba6a8c5c45d84b4bce85bd75f2063d5eedc
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: Add support for 8-bit CPU interface

This commit adds a MIPI DBI Type B host and DRM bridge driver to support the
8-bit CPU interface on Tegra20/30 display controllers.

> diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Makef=
ile
> index e399b40d64a1d..ae7fccb3d6421 100644
> --- a/drivers/gpu/drm/tegra/Makefile
> +++ b/drivers/gpu/drm/tegra/Makefile
> @@ -18,6 +18,7 @@ tegra-drm-y :=3D \
>  	hdmi.o \
>  	mipi-phy.o \
>  	dsi.o \
> +	dbi.o \
>  	sor.o \
>  	dpaux.o \
>  	gr2d.o \

[Severity: Low]
Can building tegra-drm fail with an undefined reference to
devm_mipi_dbi_device_register() when CONFIG_DRM_MIPI_DBI is disabled or bui=
lt
as a module while CONFIG_DRM_TEGRA is built-in?

Here dbi.o is unconditionally added to tegra-drm-y whenever CONFIG_DRM_TEGRA
is enabled, and tegra_dbi_probe() in drivers/gpu/drm/tegra/dbi.c calls
devm_mipi_dbi_device_register():

	dbidev =3D devm_mipi_dbi_device_register(dev, &priv->dbi_host, np);

However, devm_mipi_dbi_device_register() is defined in
drivers/gpu/drm/drm_mipi_dbi_bus.c, which is only compiled when
CONFIG_DRM_MIPI_DBI is enabled:

	obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o drm_mipi_dbi_bus.o

and include/drm/drm_mipi_dbi_bus.h does not provide fallback stubs.

Should config DRM_TEGRA in drivers/gpu/drm/tegra/Kconfig select
DRM_MIPI_DBI alongside DRM_MIPI_DSI and DRM_PANEL?

> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..e129be0f21da5
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c

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
> +
> +static int tegra_dbi_host_attach(struct mipi_dbi_host *host, struct mipi=
_dbi_device *dbidev)
> +{
> +	struct tegra_dbi_priv *priv =3D dbi_host_to_tegra_dbi(host);
> +	struct device *dev =3D priv->dev;
> +	struct drm_bridge *bridge;
> +	struct device_node *ep;
> +	int ret;
> +
> +	bridge =3D of_drm_get_bridge_by_endpoint(dev_of_node(dev), 1, -1);
> +	if (IS_ERR(bridge))
> +		return PTR_ERR(bridge);
> +
> +	bridge->type =3D DRM_MODE_CONNECTOR_DPI;
> +	priv->next_bridge =3D bridge;
> +
> +	/* get input ep (port0/endpoint0) */
> +	ret =3D -EINVAL;
> +	ep =3D of_graph_get_endpoint_by_regs(dev_of_node(dev), 0, 0);
> +	if (ep) {
> +		ret =3D of_property_read_u32(ep, "bus-width", &priv->bus_width);
> +		of_node_put(ep);
> +	}
> +
> +	if (ret)
> +		priv->bus_width =3D 24;
> +
> +	return devm_drm_bridge_add(dev, &priv->bridge);
> +}
> +
> +static void tegra_dbi_host_detach(struct mipi_dbi_host *host, struct mip=
i_dbi_device *dbidev)
> +{
> +	struct tegra_dbi_priv *priv =3D dbi_host_to_tegra_dbi(host);
> +
> +	drm_bridge_remove(&priv->bridge);
> +	drm_bridge_put(priv->next_bridge);
> +}

[Severity: High]
Won't using devm_drm_bridge_add() in tegra_dbi_host_attach() alongside an
explicit drm_bridge_remove() in tegra_dbi_host_detach() cause
drm_bridge_remove() to run twice on priv->bridge during unbind, as well as
leak priv->next_bridge if devm_drm_bridge_add() fails?

In tegra_dbi_probe(), priv is allocated with devm_drm_bridge_alloc(), which
initializes priv->bridge.refcount to 1 and registers a devres action on
priv->dev to call drm_bridge_put_void(&priv->bridge).

When tegra_dbi_host_attach() calls devm_drm_bridge_add(dev, &priv->bridge),
it increments priv->bridge.refcount to 2 and registers a devres action on
priv->dev to call drm_bridge_remove_void(&priv->bridge).

When the DBI device or tegra-dbi unbinds, mipi_dbi_device_unregister()
invokes:

mipi_dbi_device_unregister()
  mipi_dbi_detach()
    tegra_dbi_host_detach()
      drm_bridge_remove(&priv->bridge)

which destroys bridge->hpd_mutex and bridge->hpd_state_mutex and drops
priv->bridge.refcount from 2 to 1.

When priv->dev's devres then runs drm_bridge_remove_void(&priv->bridge), it
calls drm_bridge_remove(&priv->bridge) a second time, destroying both mutex=
es
again and dropping priv->bridge.refcount from 1 to 0, which frees priv via
__drm_bridge_free(). Immediately afterward, the drm_bridge_put_void() devres
action from devm_drm_bridge_alloc() runs on the already-freed priv->bridge.

Also, if devm_drm_bridge_add() fails in tegra_dbi_host_attach(), the
reference on priv->next_bridge acquired by of_drm_get_bridge_by_endpoint() =
is
never released with drm_bridge_put(). Should tegra_dbi_host_attach() use
drm_bridge_add() instead of devm_drm_bridge_add()?

[ ... ]

> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct drm_bridge *next_bridge =3D priv->next_bridge;
> +	struct tegra_dc *dc =3D priv->dc;
> +	u32 value;

[ ... ]

> +	/* Unshadow to set up command and data pins */
> +	tegra_dc_writel(dc, WRITE_MUX | READ_MUX, DC_CMD_STATE_ACCESS);
> +
> +	if (priv->reg)
> +		tegra_dbi_init_secondary_interface(priv);
> +	else
> +		tegra_dbi_init_primary_interface(priv);
> +
> +	priv->active =3D true;
> +
> +	/*
> +	 * DBI requires that the next bridge be enabled here in order to
> +	 * send DCS commands, since the interface pins will subsequently be
> +	 * reconfigured for video data.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_enable)
> +		next_bridge->funcs->atomic_enable(next_bridge, state);
> +
> +	tegra_dbi_pin_set(dc, &priv->index->cs, 0);
> +
> +	priv->active =3D false;
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +
> +	for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> +		tegra_dc_writel(dc, priv->com_pin_backup[i].value,
> +				priv->com_pin_backup[i].offset);
> +
> +	tegra_dc_commit(dc);
> +
> +	/* Set LDC pin to V Pulse 1 */
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> +	value |=3D PIN_OUTPUT_SELECT_F4(PIN_OUTPUT_SELECT_LDC);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
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
> +	for (int i =3D 0; i < ARRAY_SIZE(com_pin_output); i++)
> +		priv->com_pin_backup[i].value =3D tegra_dc_readl(dc,
> +			priv->com_pin_backup[i].offset);
> +
> +	tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
> +
> +	if (priv->reg)
> +		tegra_dbi_init_secondary_interface(priv);
> +	else
> +		tegra_dbi_init_primary_interface(priv);
> +
> +	priv->active =3D true;
> +
> +	/*
> +	 * DBI requires that the next bridge be disabled here in order to
> +	 * send DCS commands, since the interface pins will subsequently be
> +	 * reconfigured for video data.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_disable)
> +		next_bridge->funcs->atomic_disable(next_bridge, state);
> +
> +	priv->active =3D false;
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +
> +	for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> +		tegra_dc_writel(dc, priv->com_pin_backup[i].value,
> +				priv->com_pin_backup[i].offset);
> +
> +	tegra_dc_commit(dc);
> +}

[Severity: High]
Because tegra_dbi_attach() attaches priv->next_bridge to the encoder's
bridge_chain via drm_bridge_attach(), won't the DRM bridge chain helpers
already invoke next_bridge->funcs->atomic_enable() and atomic_disable(),
causing panel DCS commands during disable to fail with -ENODEV?

When disabling the display, drm_atomic_bridge_chain_disable() iterates
encoder->bridge_chain in reverse order, so it calls
priv->next_bridge->funcs->atomic_disable() (for example,
panel_bridge_atomic_disable() -> drm_panel_disable()) before
tegra_dbi_atomic_disable() runs. At that point priv->active is still false
and the DC pins are still in video mode, so every MIPI DCS command issued by
the panel's disable callback is rejected by tegra_dbi_dbi_command() with
-ENODEV, while drm_panel_disable() still marks panel->enabled =3D false.

When drm_atomic_bridge_chain_disable() subsequently calls
tegra_dbi_atomic_disable(), it sets priv->active =3D true and manually calls
next_bridge->funcs->atomic_disable(next_bridge, state) a second time, which
sees panel->enabled =3D=3D false, logs "Skipping disable of already disabled
panel", and returns without sending the panel's DCS disable sequence.

Similarly, during enable, drm_atomic_bridge_chain_enable() calls
tegra_dbi_atomic_enable(), which manually calls
next_bridge->funcs->atomic_enable(next_bridge, state), and then
drm_atomic_bridge_chain_enable() advances to priv->next_bridge in
encoder->bridge_chain and calls next_bridge->funcs->atomic_enable() a second
time while priv->active is false.

[Severity: Medium]
In tegra_dbi_atomic_enable() and tegra_dbi_atomic_disable(), there also
appear to be a couple of register configuration issues:

First, at the end of tegra_dbi_atomic_enable():

	/* Set LDC pin to V Pulse 1 */
	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
	value |=3D PIN_OUTPUT_SELECT_F4(PIN_OUTPUT_SELECT_LDC);
	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));

This unconditionally modifies PIN_LDC in DC_COM_PIN_OUTPUT_SELECT(6) without
clearing PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LDC) first, and without
checking priv->reg. When the secondary interface (priv->reg =3D=3D 1) is us=
ed,
tegra_dbi_idx[1] uses PIN_LVP0 in DC_COM_PIN_OUTPUT_SELECT(4) as the D/C
pin rather than PIN_LDC. Does the secondary interface need V_PULSE1 routed =
to
its own D/C pin instead of PIN_LDC?

Second, tegra_dbi_atomic_disable() writes only WRITE_MUX to
DC_CMD_STATE_ACCESS:

	tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);

whereas tegra_dbi_atomic_enable() writes WRITE_MUX | READ_MUX before calling
tegra_dbi_init_primary_interface() or tegra_dbi_init_secondary_interface().
Without READ_MUX set, won't the tegra_dc_readl() calls in those init
functions read from the shadowed assembly registers while tegra_dc_writel()
writes to the active registers?

[ ... ]

> +static struct platform_driver tegra_dbi_driver =3D {
> +	.driver.name =3D "tegra-dbi",
> +	.probe =3D tegra_dbi_probe,
> +};
> +
> +static void tegra_dbi_release(void *pdev)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&tegra_dbi_driver);
> +}
> +
> +int devm_tegra_dc_dbi_init(struct device *dev)
> +{
> +	struct device_node *dbi_np __free(device_node) =3D
> +		of_get_available_child_by_name(dev_of_node(dev), "dbi");
> +	struct platform_device_info dbi_info =3D { 0 };
> +	struct platform_device *dbi;
> +	int ret;
> +
> +	/* Missing node means that DBI is not used, continue */
> +	if (!dbi_np)
> +		return 0;
> +
> +	ret =3D platform_driver_register(&tegra_dbi_driver);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register DBI driver\n");
> +
> +	dbi_info.parent =3D dev;
> +	dbi_info.name =3D "tegra-dbi";
> +	dbi_info.id =3D PLATFORM_DEVID_AUTO;
> +	dbi_info.fwnode =3D of_fwnode_handle(dbi_np);
> +	dbi_info.of_node_reused =3D true;
> +
> +	dbi =3D platform_device_register_full(&dbi_info);
> +	if (IS_ERR(dbi)) {
> +		platform_driver_unregister(&tegra_dbi_driver);
> +		return dev_err_probe(dev, PTR_ERR(dbi),
> +				     "Failed to create DBI device\n");
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, tegra_dbi_release, dbi);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 5bbf2c028edd8..768cf82776632 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -3382,6 +3382,10 @@ static int tegra_dc_probe(struct platform_device *=
pdev)
>  		}
>  	}
> =20
> +	err =3D devm_tegra_dc_dbi_init(&pdev->dev);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err, "failed to init DBI\n");
> +
>  	err =3D tegra_dc_rgb_probe(dc);
>  	if (err < 0 && err !=3D -ENODEV)
>  		return dev_err_probe(&pdev->dev, err,

[Severity: High]
Can devm_tegra_dc_dbi_init() deadlock on probe deferral if the child MIPI D=
BI
panel driver is not yet bound when tegra_dc_rgb_probe() runs, and also fail
with -EBUSY if both display controllers have an available "dbi" child node?

In tegra_dc_probe(), devm_tegra_dc_dbi_init() is called immediately before
tegra_dc_rgb_probe(dc). In tegra_dbi_probe(), devm_mipi_dbi_device_register=
()
creates the child mipi_dbi_device, but priv->bridge is only registered later
in tegra_dbi_host_attach() when the panel driver binds to that DBI device a=
nd
calls devm_mipi_dbi_attach().

If the panel driver is built as a module, has not registered yet, or defers
its own probe (for example waiting on a regulator, GPIO, or backlight),
devm_tegra_dc_dbi_init() still returns 0, and then tegra_dc_rgb_probe(dc) ->
tegra_output_probe() -> drm_of_find_panel_or_bridge() returns -EPROBE_DEFER
because priv->bridge has not been added yet. When tegra_dc_probe() fails wi=
th
-EPROBE_DEFER, devres on &pdev->dev runs tegra_dbi_release(), which
unregisters the tegra-dbi platform device and destroys the child
mipi_dbi_device. With the mipi_dbi_device removed, how can the panel driver
ever bind to it and call tegra_dbi_host_attach() to resolve the deferral?

Additionally, tegra_dbi_driver is a single static platform_driver registered
inside devm_tegra_dc_dbi_init(). If both display controllers on Tegra20/30
have an available "dbi" child node, won't the second DC's call to
platform_driver_register(&tegra_dbi_driver) fail with -EBUSY, and unbinding
one DC unregister tegra_dbi_driver while the other DC is still using it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029152909.2345=
84-1-clamor95@gmail.com?part=3D11
