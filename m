Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659F606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osIFluT6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698BC10E3E1;
	Mon, 16 Nov 2026 15:50:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A0310E3E1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:50:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC0DF601E3;
 Mon, 16 Nov 2026 15:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6623D1F000C4;
 Mon, 16 Nov 2026 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794844200;
 bh=elVbEexr943DYVmadewPTe2CA+ALrWsjIGN8SAQyCm0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=osIFluT6MduMfgiuHhHf0gLJi36zfWejrgj9akPnp+pqTDhQ6+woXBSTMpzFUFjeA
 Liy+CkLOGKBoqMb+/6JKmUM22GyF/xcq9IkOw/eOfxqLhyeXp6fNoYtPW2IhELma/f
 SmoFne11V0aW9iF5GRdJip06Gs4J9gRIbyKRjNpsxGAPnL9exJgDHSAw0MBap9n4hP
 fn/o0eB8/rWkfU5KsJcJE9wIVK4/GlG10FCJaE9dhhDLi8R+rAo6/eMmVf3MEDpSku
 Y8J4rLmdfYqaQM7LVJKiQ/Qi+nE7ldygv1tHv+eE3CKdlFearF5CCG3Zddm/hBy5O8
 4sn2qxv+xzq7A==
Message-ID: <sashiko-outbox-217315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/12] drm/tegra: Add support for 8-bit CPU interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116151017.274764-13-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
 <20261116151017.274764-13-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:49:59 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/tegra: broken disable sequence and active state in
  tegra_dbi_atomic_disable()
- [High] drm/tegra: premature bridge add and NULL next_bridge in
  tegra_dbi_attach()
- [Medium] drm/tegra: duplicate next_bridge enable call in
  tegra_dbi_atomic_enable()
- [Medium] drm/tegra: dangling priv->next_bridge pointer in
  tegra_dbi_host_detach()
- [Medium] drm/tegra: device_node refcount leak on dbi_np in
  tegra_dc_dbi_probe()
- [Medium] drm/tegra: unbalanced of_node_put() on remote panel node in
  tegra_dc_dbi_probe()
- [Medium] drm/tegra: dbi: missing idle wait after stopping DC in
  tegra_dbi_atomic_enable()
- [Medium] drm/tegra: unconditional PIN_LDC muxing in
  tegra_dbi_atomic_enable()
--

commit c9bf1d91683f8b29d2b2a60164a0b606d5716c0d
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: Add support for 8-bit CPU interface

This commit adds a MIPI DBI host and DRM bridge driver for the 8-bit CPU
display controller interface on Tegra20 and Tegra30 SoCs, and hooks its pro=
be
into tegra_dc_probe().

> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..290e4c51dd3a7
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c
[ ... ]
> +static void tegra_dbi_host_detach(struct mipi_dbi_host *host, struct mip=
i_dbi_device *dbidev)
> +{
> +	struct tegra_dbi_priv *priv =3D dbi_host_to_tegra_dbi(host);
> +
> +	drm_bridge_put(priv->next_bridge);
> +}

[Severity: Medium]
Does tegra_dbi_host_detach() leave a dangling pointer in priv->next_bridge
after dropping its reference?  If the DBI peripheral driver is unbound,
later accesses in tegra_dbi_atomic_enable() or tegra_dbi_attach() will
dereference the freed bridge unless priv->next_bridge is cleared (for
example with drm_bridge_clear_and_put()).

[ ... ]

> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct drm_bridge *next_bridge =3D priv->next_bridge;
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

[Severity: Medium]
Should tegra_dbi_atomic_enable() wait for the display controller to become
idle after committing DISP_CTRL_MODE_STOP?

tegra_crtc_atomic_enable() has already started DISP_CTRL_MODE_C_DISPLAY and
tegra_rgb_encoder_enable() has committed rgb_enable, so GENERAL_ACT_REQ is
deferred until the next frame boundary rather than latching immediately.
Because panel enable callbacks sleep across multiple frames while
bit-banging DCS commands, the pending frame-boundary latch can overwrite
the active DC_COM_PIN_OUTPUT_* GPIO settings with the shadowed video-mode
values mid-transfer.

[ ... ]

> +	/* Set LDC pin to V Pulse 1 */
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LDC);
> +	value |=3D PIN_OUTPUT_SELECT_F4(PIN_OUTPUT_SELECT_LDC);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));

[Severity: Medium]
Does this unconditionally mux V_PULSE1 onto the primary interface D/C pin
(PIN_LDC) even when the secondary 8-bit CPU interface is used?

On the secondary interface (nvidia,interface =3D 1), the D/C signal is on
PIN_LVP0 in DC_COM_PIN_OUTPUT_SELECT(4), which tegra_rgb_encoder_enable()
leaves set to PIN_OUTPUT_SELECT_OUT (0x00210222).  Restoring com_pin_backup
therefore leaves PIN_LVP0 in fixed GPIO output mode during scanout instead
of driving per-frame MIPI_DCS_WRITE_MEMORY_START commands.

[ ... ]

> +	/* Unshadow to set up command and data pins */
> +	tegra_dc_writel(dc, WRITE_MUX | READ_MUX, DC_CMD_STATE_ACCESS);
> +
> +	priv->interface->init(priv);
> +
> +	priv->active =3D true;
> +
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
As reported by Mikko Perttunen on v5 [1], does calling
next_bridge->funcs->atomic_enable() here cause it to run twice on every
modeset?

Because tegra_dbi_attach() links priv->next_bridge into
encoder->bridge_chain after priv->bridge, drm_atomic_bridge_chain_enable()
immediately advances to priv->next_bridge and calls its atomic_enable
callback a second time while priv->active is false.  For panel_bridge, this
triggers the "Skipping enable of already enabled panel" warning in
drm_panel_enable(), and any downstream bridge that sends DBI commands in
the second call fails with -ENODEV.

> +
> +	tegra_dbi_pin_set(dc, &priv->interface->cs, 0);
> +
> +	priv->active =3D false;
[ ... ]
> +static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct tegra_dc *dc =3D priv->dc;
> +
> +	tegra_dc_writel(dc, WRITE_MUX | READ_MUX, DC_CMD_STATE_ACCESS);
> +
> +	priv->interface->init(priv);
> +	priv->active =3D true;
> +}

[Severity: High]
Does running this setup in atomic_disable prevent panel power-down commands
from working and leave the interface marked active after CRTC disable?

During disable_outputs(), drm_atomic_bridge_chain_disable() walks the chain
in reverse, so next_bridge->funcs->atomic_disable() runs before
tegra_dbi_atomic_disable() while priv->active is still false.  Immediately
after tegra_dbi_atomic_disable() configures the DBI pins with WRITE_MUX |
READ_MUX enabled, drm_atomic_helper_commit_encoder_bridge_disable() calls
tegra_rgb_encoder_disable(), which writes rgb_disable directly to the
active DC_COM_PIN_OUTPUT_SELECT and DC_COM_PIN_OUTPUT_ENABLE registers and
tristates the pins before drm_panel_unprepare() runs in post_disable.  In
addition, nothing clears priv->active or DC_CMD_STATE_ACCESS afterward, so
tegra_dbi_dbi_command() remains open for MMIO writes after the display
controller is suspended and unclocked.

[ ... ]

> +static int tegra_dbi_attach(struct drm_bridge *bridge,
> +			    struct drm_encoder *encoder,
> +			    enum drm_bridge_attach_flags flags)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +
> +	return drm_bridge_attach(bridge->encoder, priv->next_bridge, bridge,
> +				 flags);
> +}

[Severity: High]
What happens if tegra_dbi_attach() runs before the MIPI DBI panel driver
has bound and called tegra_dbi_host_attach()?

tegra_dc_dbi_probe() publishes priv->bridge via devm_drm_bridge_add()
before devm_mipi_dbi_device_register(), and device_add() succeeds even when
the panel driver has not probed yet or deferred probe (for instance,
drivers/gpu/drm/Makefile links tegra/ before panel/).  In that case
priv->next_bridge is still NULL when host1x_drm_probe() calls
tegra_dbi_attach(), so drm_bridge_attach() returns -EINVAL instead of
-EPROBE_DEFER and aborts DRM initialization permanently.

[ ... ]

> +	priv->bridge.of_node =3D of_node_get(dbi_np);
> +	priv->bridge.timings =3D &default_tegra_dbi_timings;
> +
> +	ret =3D devm_drm_bridge_add(dev, &priv->bridge);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Does of_node_get(dbi_np) leak a reference to the dbi device_node?

dbi_np is already managed with __free(device_node), and neither the DRM
bridge core nor a devm action releases the extra reference stored in
priv->bridge.of_node on error, probe deferral, or driver unbind.

> +
> +	np =3D of_graph_get_remote_node(dbi_np, 1, -1);
> +	if (!np)
> +		return -EINVAL;
> +
> +	dbidev =3D devm_mipi_dbi_device_register(dev, &priv->dbi_host, np);
> +	of_node_put(np);

[Severity: Medium]
Does calling of_node_put(np) here cause an of_node refcount underflow when
dbidev is released?

devm_mipi_dbi_device_register() attaches np to dbidev->dev via
device_set_node() without taking its own reference, and
mipi_dbi_device_release() calls of_node_put(dev->of_node) when the device
is freed:

drivers/gpu/drm/drm_mipi_dbi_bus.c:devm_mipi_dbi_device_register() {
    ...
	dbidev->dev.release =3D mipi_dbi_device_release;
	device_set_node(&dbidev->dev, of_fwnode_handle(np));
    ...
}

Dropping np's only reference right after registration leaves
dbidev->dev.of_node unreferenced and results in a double of_node_put() on
error unwind or device removal.

[1] https://lore.kernel.org/r/weWUeY3nRGCfNVcl2RuY5g@nvidia.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116151017.2747=
64-1-clamor95@gmail.com?part=3D12
