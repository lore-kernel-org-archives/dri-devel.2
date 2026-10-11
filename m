Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0250DCA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 12:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613CB10E2BA;
	Sun, 11 Oct 2026 12:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DtfUWMqu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE7210E2BA
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 12:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECA6560142;
 Sun, 11 Oct 2026 12:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5098C1F0089C;
 Sun, 11 Oct 2026 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791720353;
 bh=MNLCQspolKcCIMDjldD6RTX5OPFjK2nxySy34gwW64M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DtfUWMquR+3g/q4ImMXvEZ/PULdyI0pXrnY8XuQ2xzuKMbA/havMuGWc0GE/7OJQU
 BeXVDR7FuoXjLfMP3u3PfCz/0B7Jb+9vJBX0vTPgrn44wboc4kBmIzHMikxXXrtiLJ
 6fpNgz22jvYfQzl3j8RRlAg4dcBtXvBOEy2e3ZLCgIlUrOXMyhrEythlpyOX4yrIzV
 bBBe8UO3+8HYHEEFo+18C5eQdLYV9/zUskDDSTodvVhSCP7h+aFQiVl70BYVk9JeoO
 Etbbv19og/fbZD9daMIakvFHcipZ/q/cWmdRdAa6E1EXSZmpENDvkdEVkdvrFm1l7Q
 AQIglTJVsPLhA==
Message-ID: <sashiko-outbox-167214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] drm/panel: novatek-nt36672a: Add 3 panels used
 in Xiaomi phones
To: "Alexey Minnekhanov" <alexeymin@minlexx.ru>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-nt36672a-panels-v3-6-9ea238627f8a@minlexx.ru>
References: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
 <20261011-nt36672a-panels-v3-6-9ea238627f8a@minlexx.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 12:05:52 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm: panel: missing accum_err reset skips panel sleep on deinit =
error
- [Medium] drm/panel: nt36672a: regulator leak in prepare() error path
--

commit 219f9f92346f508583b813b9a7fbcd8b92f75a49
Author: Alexey Minnekhanov <alexeymin@minlexx.ru>

drm/panel: novatek-nt36672a: Add 3 panels used in Xiaomi phones

Add support for 3 panels used in 2 Xiaomi smartphones, all based on
Qualcomm SDM636/660 SoC:

* Shenchao panel used in Xiaomi Redmi Note 7 (xiaomi-lavender), the
  exact model string is unknown
* Tianma TL063FVMC43-02  for Xiaomi Redmi Note 6 Pro (xiaomi-tulip)
* Tianma TL063FVMCA01-00 for Xiaomi Redmi Note 7 (xiaomi-lavender)

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu=
/drm/panel/panel-novatek-nt36672a.c
> index a445c8067aa5f..d356348d39608 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c

[ ... ]

> +static void lavender_tulip_deinit_cmds(struct mipi_dsi_multi_context *ds=
i_ctx)
> +{
> +	dsi_ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 20);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);
> +}

[Severity: Medium]
If mipi_dsi_dcs_set_display_off_multi() fails, it sets dsi_ctx->accum_err t=
o a
negative error code. Since there is no dsi_ctx->accum_err =3D 0; after it, =
will
the subsequent mipi_dsi_msleep() and mipi_dsi_dcs_enter_sleep_mode_multi()
calls immediately exit as no-ops?

This seems like it would abort the deinitialization sequence prematurely,
skipping the panel sleep command and required delays before system regulato=
rs
disable power.

For comparison, tianma_fhd_video_send_deinit_cmds() explicitly resets accum=
_err
to continue with the power-down sequence even if prior commands fail.

While looking at how the new send_init_cmds() function interacts with the
preparation path:

drivers/gpu/drm/panel/panel-novatek-nt36672a.c:nt36672a_panel_prepare() {
	...
	dsi_ctx.accum_err =3D nt36672a_panel_power_on(pinfo);

	/* send init cmds */
	if (pinfo->desc->send_init_cmds)
		pinfo->desc->send_init_cmds(&dsi_ctx);

	if (dsi_ctx.accum_err < 0)
		gpiod_set_value(pinfo->reset_gpio, 0);

	return dsi_ctx.accum_err;
}

[Severity: Medium]
If send_init_cmds() fails (for example due to a MIPI DSI write timeout) and
returns a negative dsi_ctx.accum_err, does this leak the regulator reference
count?

It looks like the error path pulls the reset GPIO low and returns the error
code, but fails to call nt36672a_panel_power_off() or regulator_bulk_disabl=
e()
to clean up the regulators enabled earlier by nt36672a_panel_power_on().

Since the DRM core's drm_panel_prepare() does not set the panel's prepared
flag to true on error, drm_panel_unprepare() will skip the unprepared panel,
leaving the regulators permanently enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-nt36672a-p=
anels-v3-0-9ea238627f8a@minlexx.ru?part=3D6
