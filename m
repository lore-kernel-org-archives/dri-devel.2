Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD0606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3RK3RlM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186D110E4F5;
	Mon, 16 Nov 2026 07:22:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E03410E126
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:22:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67E92613F3;
 Mon, 16 Nov 2026 07:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27651F000C4;
 Mon, 16 Nov 2026 07:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794813751;
 bh=Mc9EBMDCDJ9VNqZ83ASIkMZqJSi46IHtmvxnjNrJYjc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H3RK3RlMOAifvHq2lW3NydkjTNlfzMyWMGcqPczk3eKsmUzwgv1cgOOwcxzYMl3L8
 Vv7bo3MptivgwBnjJ/ZZKjezESvgiVDyKsZl0fITI3NI+IU1yKnFI25HHjwCLRTJgj
 7O5VPS3sJHOOxwnRgDTweWV5kkVxzH5g/vXVbvwbbDa7o+tyjzBOhtdLdMk8RMl8Mj
 IswKwP9+b/0s7P/DFg4nTN/5zzxzzQBJLJ6G2zf4i9UMw7qfi7pQcYm32Jfhr1tcPd
 KlEmxzkMgVQ5nyDR0cbqNF8nGNYAwVBcbXkD0WaV2hw4EILtapLfDkiPr6KP98OfIw
 t5VAMFLFDSeWw==
Message-ID: <sashiko-outbox-216407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] drm/panel: add Novatek NT36525 panel driver
To: =?utf-8?b?QWRpbCBIw7xzcmV2IFRlcGU=?= <tadilhusrev@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116070212.314228-3-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261116070212.314228-3-tadilhusrev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:22:30 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/panel: missing prepare_prev_first =3D true in nt36525_probe()
- [Medium] drm/panel: vpos, vneg, and backlight in nt36525_probe()
  mismatch DT binding
- [Medium] drm/panel: inverted gpiod logical polarity for reset_gpio in
  nt36525
- [Low] drm/panel: negative return and open-coded helper in
  nt36525_get_modes()
--

commit bba87e5acae9fff577a4366212e7273dead1f8e4
Author: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>

drm/panel: add Novatek NT36525 panel driver

This commit adds a DRM panel driver for Novatek NT36525-based MIPI-DSI
video-mode panels used in the Samsung Galaxy XCover5.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36525.c b/drivers/gpu/=
drm/panel/panel-novatek-nt36525.c
> new file mode 100644
> index 0000000000000..246476af49b15
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36525.c
[ ... ]
> +static int nt36525_prepare(struct drm_panel *panel)
> +{
> +	struct nt36525 *p =3D panel_to_nt36525(panel);
> +	int ret;
> +
> +	/* Power-up sequence from Samsung decon_board_nt36525 panel_power_enabl=
e */
> +	ret =3D regulator_enable(p->vdd);
> +	if (ret)
> +		return ret;
> +	usleep_range(1000, 1500);
> +	ret =3D regulator_enable(p->vpos);
> +	if (ret)
> +		goto disable_vdd;
> +	usleep_range(1000, 1500);
> +	ret =3D regulator_enable(p->vneg);
> +	if (ret)
> +		goto disable_vpos;
> +	usleep_range(1000, 1500);
> +
> +	/* Reset pulse, Samsung sequence from panel_reset */
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(p->reset_gpio, 1);
> +	usleep_range(1000, 1500);
> +	gpiod_set_value_cansleep(p->reset_gpio, 0);
> +	usleep_range(3500, 4000);
> +	gpiod_set_value_cansleep(p->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +
> +	ret =3D nt36525_on(p);
> +	if (ret)
> +		goto fail;
> +
> +	return 0;
> +
> +fail:
> +	gpiod_set_value_cansleep(p->reset_gpio, 0);
> +	regulator_disable(p->vneg);
> +	usleep_range(1000, 1500);
> +disable_vpos:
> +	regulator_disable(p->vpos);
> +	usleep_range(5000, 5500);
> +disable_vdd:
> +	regulator_disable(p->vdd);
> +	return ret;
> +}
> +
> +static int nt36525_unprepare(struct drm_panel *panel)
> +{
> +	struct nt36525 *p =3D panel_to_nt36525(panel);
> +	struct mipi_dsi_multi_context ctx =3D { .dsi =3D p->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 20);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 60);
> +
> +	usleep_range(3000, 3500);
> +	regulator_disable(p->vneg);
> +	usleep_range(1000, 1500);
> +	regulator_disable(p->vpos);
> +	usleep_range(5000, 5500);
> +	regulator_disable(p->vdd);
> +	msleep(30);
> +	gpiod_set_value_cansleep(p->reset_gpio, 0);
> +	return 0;
> +}

[Severity: Medium]
Are the gpiod logical states for p->reset_gpio inverted across
nt36525_prepare(), nt36525_unprepare(), and nt36525_probe()?

As noted in the comment in nt36525_probe() ("Request RESX released (high)
rather than asserting it here"), the hardware RESX pin is active-low
(physical 0 asserts reset, physical 1 releases it).  Under the gpiod API
and panel-common.yaml, logical 1 (GPIOD_OUT_HIGH) means reset asserted and
logical 0 (GPIOD_OUT_LOW) means reset deasserted, with the physical
inversion described via GPIO_ACTIVE_LOW in Device Tree.

Passing physical levels directly means a Device Tree using standard
GPIO_ACTIVE_LOW polarity holds the panel in reset during nt36525_on() and
releases reset when powering off, or else has to misdeclare the active-low
pin as GPIO_ACTIVE_HIGH.

> +static int nt36525_get_modes(struct drm_panel *panel, struct drm_connect=
or *conn)
> +{
> +	struct drm_display_mode *m;
> +
> +	m =3D drm_mode_duplicate(conn->dev, &nt36525_xcover5_mode);
> +	if (!m)
> +		return -ENOMEM;
> +	drm_mode_set_name(m);
> +	drm_mode_probed_add(conn, m);
> +	conn->display_info.width_mm =3D m->width_mm;
> +	conn->display_info.height_mm =3D m->height_mm;
> +	return 1;
> +}

[Severity: Low]
Can nt36525_get_modes() use drm_connector_helper_get_modes_fixed(conn,
&nt36525_xcover5_mode) instead of open-coding mode duplication?

drm_helper_probe_get_modes() expects .get_modes() callbacks to return the
number of modes (0 on failure) and logs a drm_err() if a negative error
code such as -ENOMEM is returned.  drm_connector_helper_get_modes_fixed()
handles duplicating the mode, setting its name, updating display_info
dimensions, and returning 0 on failure.

[ ... ]
> +static int nt36525_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct nt36525 *p;
> +	int ret;
> +
> +	p =3D devm_drm_panel_alloc(dev, struct nt36525, panel, &nt36525_funcs,
> +				 DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(p))
> +		return PTR_ERR(p);
> +
> +	p->dsi =3D dsi;
> +	ret =3D drm_panel_of_backlight(&p->panel);
> +	if (ret)
> +		return ret;
> +
> +	p->vdd =3D devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(p->vdd))
> +		return dev_err_probe(dev, PTR_ERR(p->vdd), "vdd supply\n");
> +
> +	p->vpos =3D devm_regulator_get(dev, "vpos");
> +	if (IS_ERR(p->vpos))
> +		return dev_err_probe(dev, PTR_ERR(p->vpos), "vpos supply\n");
> +
> +	p->vneg =3D devm_regulator_get(dev, "vneg");
> +	if (IS_ERR(p->vneg))
> +		return dev_err_probe(dev, PTR_ERR(p->vneg), "vneg supply\n");

[Severity: Medium]
Do the vpos, vneg, and backlight properties requested here match the DT
binding in Documentation/devicetree/bindings/display/panel/novatek,nt36525.=
yaml?

The binding schema only defines compatible, reg, reset-gpios, vdd-supply,
and port with additionalProperties: false.  A Device Tree conforming to
that schema will lack vpos-supply, vneg-supply, and backlight, causing
devm_regulator_get() to fall back to dummy regulators with a warning
(leaving the positive and negative LCD bias supplies unswitched) and
drm_panel_of_backlight() to find no backlight, while a Device Tree that
includes them will fail dtbs_check.

[ ... ]
> +	dsi->mode_flags	 =3D MIPI_DSI_MODE_VIDEO		/* video (non-burst) */
> +			 | MIPI_DSI_MODE_VIDEO_SYNC_PULSE
> +			 | MIPI_DSI_MODE_LPM		/* force LP for all transfers */
> +			 | MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +	drm_panel_add(&p->panel);

[Severity: High]
Should p->panel.prepare_prev_first =3D true be set before calling
drm_panel_add(&p->panel)?

drm_panel_add() copies panel->prepare_prev_first into
panel->bridge.pre_enable_prev_first.  Because it is left false,
drm_atomic_bridge_chain_pre_enable() calls nt36525_prepare() ->
nt36525_on() before the upstream DSI host bridge's atomic_pre_enable()
callback, and drm_atomic_bridge_chain_post_disable() disables the upstream
DSI host bridge before nt36525_unprepare() sends display-off and sleep-in
commands.  On bridge-based DSI hosts such as samsung-dsim, transfers sent
while DSIM_STATE_ENABLED is cleared are rejected by
samsung_dsim_host_transfer() with -EINVAL, causing panel bring-up and
power-down to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070212.3142=
28-1-tadilhusrev@gmail.com?part=3D2
