Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2278606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WK/QILxD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D045D10E681;
	Mon,  9 Nov 2026 06:47:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2230B10E681
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:47:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CFF260D65;
 Mon,  9 Nov 2026 06:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A4E1F008A1;
 Mon,  9 Nov 2026 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794206831;
 bh=NUAI/7ZFiKdiHTlAqMQnrh/mmc7g8QGK9DZo8y8QpOc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WK/QILxDPxmBJZzQFWrhWJtQd4FDQIkhjCqtGPhEoXpwouMmWcQ7Ha3TT9Z++VoEe
 xdFsle0vXY728U3Jp/AHsnD+t4yibukESTEXEdadOTfZlHaFUnW5KVIQa2y0sH8PaQ
 pXiRS73ghXK31ON9Xz/Mv72Nv0JpBUP5z1YYQ2oupuxUsRatmmXwvPk5Yo//cn8Dck
 gAWj0rQjJKKdu6zlLp5PF5/iX/P90R6lfsH6ld7Hp9zS4sS7IoUE4DlID42SRIIKQ7
 q90v1ov7B+t3D8z+Hoq/yxnsd+A5ZefGHWEL3BNi3XI7gd/v5to9rSV2S+JqMs8mka
 GoukLfkpVxDug==
Message-ID: <sashiko-outbox-204504@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Novatek NT37802
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261109-jshekhar-nt37802-v2-2-a8e9efdcabd7@oss.qualcomm.com>
References: <20261109-jshekhar-nt37802-v2-0-a8e9efdcabd7@oss.qualcomm.com>
 <20261109-jshekhar-nt37802-v2-2-a8e9efdcabd7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 06:47:10 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] drm/panel: nt37802: state desync on DSI errors in disable and
  unprepare
- [Medium] drm/panel: nt37802: asymmetric display-on/off across prepare
  and disable
- [Medium] drm/panel: bogus voltage ranges in
  novatek_nt37802_set_supply_voltages()
- [Low] drm/panel: nt37802: use mipi_dsi_dcs_write_seq_multi() for init
  commands
--

commit a18941fccd5aa85d21c8730be5323c1f810aa7e5
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/panel: Add driver for Novatek NT37802

This commit adds a DRM panel driver for the Novatek NT37802 1440x3200@120Hz
AMOLED DSI command-mode panel with DSC 1.2 compression and DCS brightness
control.

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

[Severity: Low]
This isn't a bug, but could novatek_nt37802_write_init() use
mipi_dsi_dcs_write_seq_multi() and the standard DCS helpers (such as
mipi_dsi_dcs_set_column_address_multi(),
mipi_dsi_dcs_set_page_address_multi(), and mipi_dsi_dcs_set_tear_on_multi())
instead of a custom struct nt37802_cmd table?  Because data[32] is fixed-si=
ze,
even 2-byte commands in nt37802_init_cmds[] take 33 bytes each in .rodata.

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
Should the supply voltages be left to the board Device Tree constraints
instead of calling regulator_set_voltage() with wide ranges here?

regulator_set_voltage() picks the lowest voltage >=3D min_uV allowed by the
regulator's constraints, so requesting (1100000, 1950000) on vdd will drive
the rail down to 1.1V on any board whose PMIC LDO constraints permit 1.1V e=
ven
if the panel expects 1.2V.  In addition, calling regulator_set_voltage() on=
 a
fixed or dummy regulator without voltage readback returns -EINVAL and aborts
novatek_nt37802_probe().

[ ... ]

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
Does sending mipi_dsi_dcs_set_display_on_multi() in novatek_nt37802_prepare=
()
but mipi_dsi_dcs_set_display_off_multi() in novatek_nt37802_disable() leave
the display off across a disable/enable cycle?

novatek_nt37802_enable() sends no DSI commands, so if drm_panel_disable() is
followed by drm_panel_enable() without an intervening unprepare/prepare cyc=
le,
nothing sends MIPI_DCS_SET_DISPLAY_ON and the panel stays blank while the
backlight turns on.  Conversely, if drm_panel_prepare() is followed directly
by drm_panel_unprepare() without enable/disable, the panel enters sleep mode
without sending MIPI_DCS_SET_DISPLAY_OFF.

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
desynchronize ctx->prepared and ctx->enabled from the drm_panel core?

If mipi_dsi_dcs_enter_sleep_mode_multi() fails, novatek_nt37802_unprepare()
still asserts reset, sets ctx->prepared =3D false, disables all four suppli=
es,
and returns the negative error code.  In drm_panel_unprepare(), a negative
return skips clearing panel->prepared:

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

On the next resume or modeset, drm_panel_prepare() sees panel->prepared =3D=
=3D
true and returns early without calling novatek_nt37802_prepare() to re-enab=
le
the regulators, and novatek_nt37802_enable() then fails with -EPERM because
ctx->prepared is false.  Similarly, if mipi_dsi_dcs_set_display_off_multi()
fails in novatek_nt37802_disable() after drm_panel_disable() has already
disabled the backlight, returning dsi_ctx.accum_err leaves panel->enabled =
=3D=3D
true so subsequent drm_panel_enable() calls return early without re-enabling
the backlight.

Dropping the driver's duplicate ctx->prepared and ctx->enabled flags (since
drm_panel already guards transitions with panel->prepared and panel->enable=
d)
and returning 0 from novatek_nt37802_unprepare() and
novatek_nt37802_disable() once teardown has completed would avoid wedging t=
he
panel state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-jshekhar-n=
t37802-v2-0-a8e9efdcabd7@oss.qualcomm.com?part=3D2
