Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958F606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieMt/5Gc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2FA10E85F;
	Wed,  4 Nov 2026 09:35:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E2010FA80
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:35:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C10E460213;
 Wed,  4 Nov 2026 09:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403AF1F000C1;
 Wed,  4 Nov 2026 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793784912;
 bh=/9UwIzdIAMbX7ysUUVFgkx4wDbhFfnUMKlcNU4rUfN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ieMt/5GcJxY+rLDUOx3U73hpOW30tgrLNU0CvKTJjOrKd1mGuFLdir5p1cTvQnFGW
 LHqVkN6O+GVROBtmWj05VXDR8mxSXPlsOobuNiRja0WHYC0LrtT57PbM/bcEV0/EbY
 VjbSdPvamLg377b3GMST3GOFD9RXW+MROa6MaOPI2uKyh9B0G78rA1v9wF+S4ODZ4o
 GxIEkDkVAPcWlKsNUdvVz7lHWQKdoJCz6EeSFsrMwflsdWw8zRXCmhQNCsuU2Urg7q
 9Xdq+Pd5ArCFMhPeIm+rt9TTNNTXdIvmj2cCJBsTK6UChTjFAofcXrKxQtWXjx/ode
 RuDCsIyWWg8ew==
Message-ID: <sashiko-outbox-196968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Novatek NT37802
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104-jshekhar-nt37802-v1-2-58e5e7fb2556@oss.qualcomm.com>
References: <20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com>
 <20261104-jshekhar-nt37802-v1-2-58e5e7fb2556@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:35:11 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] drm/panel: nt37802: state desync on DSI errors in disable and un=
prepare
- [Medium] drm/panel: nt37802: asymmetric display-on/off across prepare and=
 disable
- [Medium] drm/panel: bogus voltage ranges in novatek_nt37802_set_supply_vo=
ltages()
- [Low] drm/panel: nt37802: use mipi_dsi_dcs_write_seq_multi() for init com=
mands
--

commit a4454941919dc768e5c78cce0316ea1f0954d638
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/panel: Add driver for Novatek NT37802

This commit adds a DRM panel driver for the Novatek NT37802 AMOLED DSI
command-mode panel running at 1440x3200@120Hz with DSC 1.2 compression
and enables it as a module in the arm64 defconfig.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37802.c b/drivers/gpu/=
drm/panel/panel-novatek-nt37802.c
> new file mode 100644
> index 0000000000000..632520f04ffad
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37802.c
> @@ -0,0 +1,544 @@

[ ... ]

> +struct nt37802_cmd {
> +	u8 len;
> +	u8 data[32];
> +};
> +
> +#define NT37802_CMD(...) \
> +	{ .len =3D sizeof((u8[]){ __VA_ARGS__ }), .data =3D { __VA_ARGS__ } }

[ ... ]

> +static int novatek_nt37802_set_supply_voltages(struct novatek_nt37802 *c=
tx)
> +{
> +	int ret;
> +
> +	ret =3D regulator_set_voltage(ctx->supplies[NT37802_SUPPLY_VDDIO].consu=
mer,
> +				    1800000, 2000000);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regulator_set_voltage(ctx->supplies[NT37802_SUPPLY_VDD].consume=
r,
> +				    1100000, 1950000);
> +	if (ret)
> +		return ret;
> +
> +	return regulator_set_voltage(ctx->supplies[NT37802_SUPPLY_VCI].consumer,
> +				     3000000, 3544000);
> +}

[Severity: Medium]
Should the voltage constraints be defined in the board Device Tree via
regulator-min-microvolt and regulator-max-microvolt rather than calling
regulator_set_voltage() with wide ranges in
novatek_nt37802_set_supply_voltages()?

The upper bounds (2000000 uV, 1950000 uV, and 3544000 uV) appear to be
Qualcomm PMIC5 LDO hardware maximums from downstream
qcom,panel-supply-entries rather than exact panel requirements.

In drivers/regulator/core.c, regulator_set_voltage() selects the lowest
voltage permitted by the intersection of the consumer request and the
regulator's constraints:

regulator_set_voltage_unlocked()
  regulator_balance_voltage()
    regulator_get_optimal_voltage()
    _regulator_do_set_voltage()

If a board's PMIC LDO constraints allow a voltage down to 1.1V while the
panel expects 1.2V on vdd, requesting (1100000, 1950000) will lower the
rail to 1.1V, and novatek_nt37802_probe() will also fail with -EINVAL on
boards using fixed regulators without voltage adjustment constraints.

[ ... ]

> +static int novatek_nt37802_write_init(struct novatek_nt37802 *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(nt37802_init_cmds); i++)
> +		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx,
> +						nt37802_init_cmds[i].data,
> +						nt37802_init_cmds[i].len);
> +
> +	return dsi_ctx.accum_err;
> +}

[Severity: Low]
This isn't a bug, but could novatek_nt37802_write_init() use
mipi_dsi_dcs_write_seq_multi() and standard DCS helpers (such as
mipi_dsi_dcs_set_column_address_multi(),
mipi_dsi_dcs_set_page_address_multi(), and mipi_dsi_dcs_set_tear_on_multi())
with the caller's struct mipi_dsi_multi_context instead of defining the
custom struct nt37802_cmd with a fixed 32-byte array for every entry in
nt37802_init_cmds?

> +
> +static int novatek_nt37802_prepare(struct drm_panel *panel)
> +{
> +	struct novatek_nt37802 *ctx =3D to_novatek_nt37802(panel);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +	struct drm_dsc_picture_parameter_set pps;
> +	int ret;
> +
> +	if (ctx->prepared)
> +		return 0;
> +
> +	ret =3D novatek_nt37802_enable_supplies(ctx);
> +	if (ret)
> +		return ret;
> +
> +	novatek_nt37802_reset(ctx);
> +	ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	ret =3D novatek_nt37802_write_init(ctx);
> +	if (ret) {
> +		novatek_nt37802_set_reset(ctx, 1);
> +		novatek_nt37802_disable_supplies(ctx);
> +		return ret;
> +	}
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +	mipi_dsi_compression_mode_multi(&dsi_ctx, true);
> +	if (dsi_ctx.accum_err) {
> +		novatek_nt37802_set_reset(ctx, 1);
> +		novatek_nt37802_disable_supplies(ctx);
> +		return dsi_ctx.accum_err;
> +	}
> +
> +	ctx->prepared =3D true;
> +	return 0;
> +}
> +
> +static int novatek_nt37802_enable(struct drm_panel *panel)
> +{
> +	struct novatek_nt37802 *ctx =3D to_novatek_nt37802(panel);
> +
> +	if (!ctx->prepared)
> +		return -EPERM;
> +
> +	if (ctx->enabled)
> +		return 0;
> +
> +	ctx->enabled =3D true;
> +	return 0;
> +}
> +
> +static int novatek_nt37802_disable(struct drm_panel *panel)
> +{
> +	struct novatek_nt37802 *ctx =3D to_novatek_nt37802(panel);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	if (!ctx->enabled)
> +		return 0;
> +
> +	/* The off sequence sends display-off in HS mode, then waits 10 ms. */
> +	ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 10);
> +
> +	ctx->enabled =3D false;
> +	return dsi_ctx.accum_err;
> +}

[Severity: Medium]
What happens if drm_panel_disable() is followed by drm_panel_enable()
without an intervening unprepare and prepare cycle?

novatek_nt37802_prepare() sends both mipi_dsi_dcs_exit_sleep_mode_multi()
and mipi_dsi_dcs_set_display_on_multi(), while novatek_nt37802_enable()
does not send any DSI commands. On the teardown side,
novatek_nt37802_disable() sends mipi_dsi_dcs_set_display_off_multi() and
novatek_nt37802_unprepare() only sends
mipi_dsi_dcs_enter_sleep_mode_multi().

If a disable/enable cycle occurs without unprepare/prepare, the panel will
be left with the display turned off while the backlight is enabled;
conversely, if prepare is followed by unprepare without enable/disable,
the panel enters sleep mode without sending display-off.

Should mipi_dsi_dcs_set_display_off_multi() and
mipi_dsi_dcs_enter_sleep_mode_multi() both be handled in
novatek_nt37802_unprepare() (dropping the enable and disable callbacks,
similar to panel-novatek-nt37801.c), or should display-on be paired in
novatek_nt37802_enable() with display-off in novatek_nt37802_disable()?

> +
> +static int novatek_nt37802_unprepare(struct drm_panel *panel)
> +{
> +	struct novatek_nt37802 *ctx =3D to_novatek_nt37802(panel);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	if (!ctx->prepared)
> +		return 0;
> +
> +	ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	/* Assert the active-low reset after the downstream sleep delay. */
> +	novatek_nt37802_set_reset(ctx, 1);
> +	ctx->prepared =3D false;
> +	novatek_nt37802_disable_supplies(ctx);
> +
> +	return dsi_ctx.accum_err;
> +}

[Severity: Medium]
Can a DSI error in novatek_nt37802_unprepare() or novatek_nt37802_disable()
permanently desynchronize ctx->prepared and ctx->enabled from the core
panel->prepared and panel->enabled state?

In drivers/gpu/drm/drm_panel.c, drm_panel_unprepare() and
drm_panel_disable() already track panel->prepared and panel->enabled, and
skip clearing them when the driver callback returns a negative error:

drivers/gpu/drm/drm_panel.c:drm_panel_unprepare() {
	...
	if (panel->funcs && panel->funcs->unprepare) {
		ret =3D panel->funcs->unprepare(panel);
		if (ret < 0)
			goto exit;
	}
	panel->prepared =3D false;
	...
}

If mipi_dsi_dcs_enter_sleep_mode_multi() fails in
novatek_nt37802_unprepare(), the driver still asserts reset, sets
ctx->prepared =3D false, disables all four regulators, and returns the
negative dsi_ctx.accum_err. Because drm_panel_unprepare() then leaves
panel->prepared set to true, the next drm_panel_prepare() call returns
early without calling novatek_nt37802_prepare() to re-enable the
regulators, and novatek_nt37802_enable() then fails with -EPERM because
ctx->prepared is false.

Similarly, in drm_panel_disable(), backlight_disable() runs before
panel->funcs->disable(). If mipi_dsi_dcs_set_display_off_multi() fails in
novatek_nt37802_disable(), ctx->enabled is cleared and the negative error
is returned, leaving panel->enabled set to true so subsequent
drm_panel_enable() calls return early without re-enabling the backlight.

Since struct drm_panel already maintains prepared and enabled state in the
core, can ctx->prepared and ctx->enabled be dropped, and should
novatek_nt37802_unprepare() return 0 after powering down the hardware (with
mipi_dsi_dcs_enter_sleep_mode_multi() already logging the DSI error)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-jshekhar-n=
t37802-v1-0-58e5e7fb2556@oss.qualcomm.com?part=3D2
