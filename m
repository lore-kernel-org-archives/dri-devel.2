Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D33606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YS+Aa0fj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0591E10E7BF;
	Wed, 18 Nov 2026 10:01:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C0010FA76
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:01:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 239F96205F;
 Wed, 18 Nov 2026 10:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD711F000C4;
 Wed, 18 Nov 2026 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794996088;
 bh=74w79Zw/FUDp7uhiM29PNQis4A6RNC87nG2KEIOV2J8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YS+Aa0fj6eHx7RaeePRuKsOe1qdEvfzKuN/DHLxnbxY1ZWwbdTbitK8I8emLsM3vI
 WErvJIOYOtNXUBuQp81zTUckJKLYgse1a42Y2r+93+xKqJX9y3qDOVW2iCodq95I7A
 1u1qeVtRoJ4Ol+TwHd78pqrho4d/NMGJQDaQFcClZdusXT997o0DoFSGsQzZQ5sq1J
 fM+I9pGM6MIMnQ3nbBeyidGG6EeVGRit1BglvYVboR93WbIys+6lBgx0UMXl9wkpRa
 j0km6B0Ek8X12p7aXTNHBHF22Tww656LdXoAxWmehocQ3eYLWWCLJWjuwc+OlUMUqz
 LHIGFnCNGzR+Q==
Message-ID: <sashiko-outbox-220650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/panel: Replace deprecated DCS display-on calls
To: amit <amittibi123@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118094800.54292-1-amittibi123@gmail.com>
References: <1794145178-999776-mlmmj-06e01102@vger.kernel.org>
 <20261118094800.54292-1-amittibi123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:01:28 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/panel: missing Signed-off-by trailer in commit message
- [Medium] drm/panel: boe_panel_unprepare() skips sleep mode on
  display-off error
- [Low] drm/panel: incomplete mipi_dsi_multi_context conversion and
  duplicate logs
--

commit 7771574db163ac443f13d706bebea54afbd4c7d9
Author: amit <amittibi123@gmail.com>

> drm/panel: Replace deprecated DCS display-on calls
>
> Replace deprecated mipi_dsi_dcs_set_display_on() calls with their multi-c=
ontext equivalents across DRM panel drivers.
>
> Use the MIPI DSI multi-context API to handle errors returned by the new h=
elpers.

[Severity: High]
This commit is missing a Signed-off-by trailer.  In addition, the commit
message only mentions replacing mipi_dsi_dcs_set_display_on(), while the
diff also converts mipi_dsi_dcs_write_buffer(),
mipi_dsi_dcs_set_display_off(), mipi_dsi_dcs_enter_sleep_mode(),
mipi_dsi_dcs_exit_sleep_mode(), mipi_dsi_dcs_set_column_address(),
mipi_dsi_dcs_set_page_address(), mipi_dsi_dcs_set_pixel_format() and
mipi_dsi_dcs_set_tear_on() in panel-boe-himax8279d.c, panel-dsi-cm.c and
panel-feixin-k101-im2ba02.c.

> diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/d=
rm/panel/panel-boe-himax8279d.c
> index 4a8560b4b899a..322f6801e52bd 100644
> --- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> +++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
[ ... ]
> @@ -95,15 +99,17 @@ static int boe_panel_disable(struct drm_panel *panel)
>  static int boe_panel_unprepare(struct drm_panel *panel)
>  {
>  	struct panel_info *pinfo =3D to_panel_info(panel);
> -	int err;
> +	struct mipi_dsi_multi_context dsi_ctx =3D {
> +		.dsi =3D pinfo->link,
> +	};
> =20
> -	err =3D mipi_dsi_dcs_set_display_off(pinfo->link);
> -	if (err < 0)
> -		dev_err(panel->dev, "failed to set display off: %d\n", err);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err < 0)
> +		dev_err(panel->dev, "failed to set display off: %d\n", dsi_ctx.accum_e=
rr);
> =20
> -	err =3D mipi_dsi_dcs_enter_sleep_mode(pinfo->link);
> -	if (err < 0)
> -		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err < 0)
> +		dev_err(panel->dev, "failed to enter sleep mode: %d\n", dsi_ctx.accum_=
err);

[Severity: Medium]
Does sharing dsi_ctx here skip entering sleep mode when
mipi_dsi_dcs_set_display_off_multi() fails?

Previously, boe_panel_unprepare() still sent the enter-sleep-mode command
even if display-off failed before disable_gpios() cut power.  Because
mipi_dsi_dcs_enter_sleep_mode_multi() returns early when dsi_ctx.accum_err
is non-zero, a display-off error now skips the sleep command and triggers
a false "failed to enter sleep mode" message from the stale accum_err.

> =20
>  	/* sleep_mode_delay: 1ms - 2ms */
>  	usleep_range(1000, 2000);
[ ... ]
> @@ -178,7 +191,12 @@ static int boe_panel_enable(struct drm_panel *panel)
> =20
>  	usleep_range(120000, 121000);
> =20
> -	ret =3D mipi_dsi_dcs_set_display_on(pinfo->link);
> +	struct mipi_dsi_multi_context dsi_ctx =3D {
> +		.dsi =3D pinfo->link,
> +	};
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	ret =3D dsi_ctx.accum_err;
>  	if (ret < 0) {
>  		dev_err(panel->dev, "failed to set display on: %d\n", ret);
>  		return ret;

[Severity: Low]
Could these conversions declare dsi_ctx at the top of each function, drop
the redundant dev_err() calls, and convert the remaining DSI helpers in
the same functions?

The mipi_dsi_dcs_*_multi() helpers already log an error via dev_err() on
failure, so keeping the caller dev_err() blocks here and in the other
touched drivers logs every failure twice.  In addition, declaring dsi_ctx
mid-function after statements to wrap a single call leaves adjacent
deprecated DSI calls in the same functions (such as in
k101_im2ba02_enable(), innolux_panel_prepare(),
khadas_ts050_panel_prepare(), kingdisplay_panel_prepare(),
ltk500hd1829_prepare(), panel_nv3051d_prepare(), nt35510_prepare(),
rad_panel_enable(), rm68200_prepare(), s6e63j0x03_enable() and
sharp_panel_prepare()) unconverted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118094800.5429=
2-1-amittibi123@gmail.com?part=3D1
