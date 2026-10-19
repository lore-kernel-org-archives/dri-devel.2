Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF3CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A01110E978;
	Mon, 19 Oct 2026 10:09:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701ED10E14F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:09:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B75A600CB;
 Mon, 19 Oct 2026 10:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7011F000C5;
 Mon, 19 Oct 2026 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792404559;
 bh=nxn/92jjwQUMArB247A1WBK30C3YVW/dTQViUzms37g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UlpvlC7dAYUEeE92YqCfKs/ya9S7b3U7HXMyBPqwJCtgEE/M6HFo9FaQMbhbtmxYc
 yIo149iFFxgCh9M+O17oEVdg9WWjCkJ3OkR1gAt/cMAUkpTA9d2pOJusKGfUVT2ZFg
 bDTwfc/rPCL6V5ZEF5fhabGlIfgg3QS2v3KlagB8zxvbQmXvo0NiE0JBzOm2KSJ5Di
 uc9fg1S3GXETFqJ99ZLLFtS/o43tuHWGUDc358aaiGG4u7j5vswAmKnRCwOfOpb1wS
 h3B4REjrliCTlFFdTuS+5a0YU4emFZyS2h03aYP33wOYa+qz7u0Pjsth4Tkqo1wHua
 RRR4dPtPHfMqA==
Message-ID: <sashiko-outbox-176953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI
 Type B panel driver
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019095705.91062-7-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
 <20261019095705.91062-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:09:18 +0000
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
- [High] drm/panel: tx10d07vm0baa: DBI commands in disable() use freed tegr=
a-dbi GPIOs
- [High] drm/panel: unchecked priv->dbi in hitachi_tx10d07vm0baa_enable()
- [Medium] drm/panel: hitachi-tx10d07vm0baa: swapped width_mm and height_mm=
 in mode
--

commit a653f9af8d9f186ab20cfe9e9245165b2be8f4e3
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver

This commit adds a DRM panel driver for the Hitachi TX10D07VM0BAA 4" WVGA M=
IPI
DBI Type B panel used in the LG Optimus 2X P990 smartphone.

> diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driver=
s/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> new file mode 100644
> index 0000000000000..c3434cb96c86c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> @@ -0,0 +1,297 @@
[ ... ]
> +static int hitachi_tx10d07vm0baa_prepare(struct drm_panel *panel)
> +{
> +	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> +	struct device *dev =3D panel->dev;
> +	int ret;
> +
> +	priv->dbi =3D dev_get_drvdata(dev->parent);
> +	if (!priv->dbi)
> +		return -ENODEV;
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies=
), priv->supplies);
> +	if (ret) {
> +		dev_err(dev, "failed to enable power supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(1000, 2000);
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +
> +	usleep_range(10000, 11000);
> +
> +	return 0;
> +};
> +
> +static int hitachi_tx10d07vm0baa_enable(struct drm_panel *panel)
> +{
> +	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> +
> +	panel_dbi_command(priv, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x=
1f);

[Severity: High]
Can priv->dbi be NULL when hitachi_tx10d07vm0baa_enable() (and later
hitachi_tx10d07vm0baa_disable()) calls panel_dbi_command()?

In hitachi_tx10d07vm0baa_probe(), priv->dbi is not initialized. Instead,
hitachi_tx10d07vm0baa_prepare() looks up dev_get_drvdata(dev->parent) and
returns -ENODEV if priv->dbi is NULL (for instance, if the panel device tree
node is not a child of a bound DBI parent device, or if the parent has no
drvdata set).

During an atomic modeset commit, the prepare path runs:

  drm_atomic_helper_commit_modeset_enables()
    drm_atomic_bridge_chain_pre_enable()
      panel_bridge_atomic_pre_enable()
        drm_panel_prepare()
          hitachi_tx10d07vm0baa_prepare() -> returns -ENODEV

When hitachi_tx10d07vm0baa_prepare() returns an error, drm_panel_prepare()
logs the error and skips setting panel->prepared =3D true, but does not abo=
rt
the atomic commit. Next in the same commit:

  drm_atomic_helper_commit_modeset_enables()
    drm_atomic_bridge_chain_enable()
      panel_bridge_atomic_enable()
        drm_panel_enable()
          hitachi_tx10d07vm0baa_enable()

Because drm_panel_enable() only checks panel and panel->enabled without
checking panel->prepared, it unconditionally calls
hitachi_tx10d07vm0baa_enable(). That passes a NULL priv->dbi to
panel_dbi_command() -> mipi_dbi_command_stackbuf() -> mipi_dbi_command_buf(=
),
which dereferences dbi at mutex_lock(&dbi->cmdlock).

> +	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03, 0x2=
0,
> +			  0x00, 0x00);
[ ... ]
> +static int hitachi_tx10d07vm0baa_disable(struct drm_panel *panel)
> +{
> +	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> +
> +	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
> +	msleep(35);
> +
> +	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
> +	msleep(50);
> +
> +	return 0;
> +}

[Severity: High]
When this panel is paired with its parent tegra-dbi bridge, does
hitachi_tx10d07vm0baa_disable() end up using freed GPIO descriptors when
sending MIPI_DCS_SET_DISPLAY_OFF and MIPI_DCS_ENTER_SLEEP_MODE?

In drivers/gpu/drm/tegra/dbi.c, tegra_dbi_probe() wraps the panel in a panel
bridge via devm_drm_panel_bridge_add_typed() and attaches it downstream of
tegra_dbi->bridge in tegra_dbi_attach(). At the end of
tegra_dbi_atomic_enable(), tegra-dbi releases its shared DBI GPIOs with
gpiod_put() and gpiod_put_array(priv->data_gpios) without clearing the
pointers.

When the display pipeline is disabled, drm_atomic_bridge_chain_disable()
iterates encoder->bridge_chain in reverse order:

  drm_atomic_bridge_chain_disable()
    panel_bridge_atomic_disable()
      drm_panel_disable()
        hitachi_tx10d07vm0baa_disable()
          panel_dbi_command()
            mipi_dbi_command_stackbuf()
              tegra_dbi_dbi_command()
                tegra_dbi_write()

Because panel_bridge_atomic_disable() runs before tegra_dbi_atomic_disable(=
),
tegra_dbi_write() sees the non-NULL dangling priv->data_gpios pointer and
dereferences the freed struct gpio_descs memory and freed GPIO descriptors
before tegra_dbi_atomic_disable() has a chance to call
tegra_dbi_prepare_gpios():

drivers/gpu/drm/tegra/dbi.c:tegra_dbi_atomic_disable() {
	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
	int ret;

	ret =3D tegra_dbi_prepare_gpios(priv);
	if (ret)
		return;

	if (priv->output.panel)
		drm_panel_disable(priv->output.panel);
    ...
}

When tegra_dbi_atomic_disable() subsequently runs, its call to
drm_panel_disable() becomes a no-op because panel->enabled is already false.

> +
> +static int hitachi_tx10d07vm0baa_unprepare(struct drm_panel *panel)
> +{
[ ... ]
> +static const struct drm_display_mode hitachi_tx10d07vm0baa_mode =3D {
> +	.clock =3D (480 + 10 + 10 + 10) * (800 + 4 + 4 + 4) * 60 / 1000,
> +	.hdisplay =3D 480,
> +	.hsync_start =3D 480 + 10,
> +	.hsync_end =3D 480 + 10 + 10,
> +	.htotal =3D 480 + 10 + 10 + 10,
> +	.vdisplay =3D 800,
> +	.vsync_start =3D 800 + 4,
> +	.vsync_end =3D 800 + 4 + 4,
> +	.vtotal =3D 800 + 4 + 4 + 4,
> +	.width_mm =3D 86,
> +	.height_mm =3D 52,
> +	.type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};

[Severity: Medium]
Are width_mm and height_mm swapped in hitachi_tx10d07vm0baa_mode?

The active mode resolution is portrait (hdisplay =3D 480, vdisplay =3D 800,
matching MIPI_DCS_SET_PARTIAL_ROWS 0..799 and MIPI_DCS_SET_SCROLL_AREA 800 =
in
hitachi_tx10d07vm0baa_enable()), whereas width_mm =3D 86 and height_mm =3D =
52 are
landscape dimensions. When hitachi_tx10d07vm0baa_get_modes() calls
drm_connector_helper_get_modes_fixed(), those values are copied to
connector->display_info, resulting in non-square DPI calculations in
userspace. Should width_mm be 52 and height_mm be 86?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019095705.9106=
2-1-clamor95@gmail.com?part=3D6
