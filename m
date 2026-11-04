Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0D606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cv/lHsVD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233F810E224;
	Wed,  4 Nov 2026 07:47:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD36E10FA14
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:47:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 088F160DA2;
 Wed,  4 Nov 2026 07:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EC21F00919;
 Wed,  4 Nov 2026 07:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793778460;
 bh=5Ff3xs7Ao+bE4zMf+u5aTZxphjrWJJPWsrTaMsH5LKY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cv/lHsVDqcGHBZ4OuwkGjr/ORxB+xCPqpy8t3O3o0Lvc0tHOLIS1n8JS4XSHAAYFy
 2d6d5uZsdWN3AUfAU5Y8sQuGFw+CIwnlUrwy7zpSuia1x2rAlQT90tzSc3z9Xo37RQ
 gVkXMaFo+UfXQg29XX0eN/SRaXGGho7j98E2ugnbQRM2M1qz0HZgH3y9K6/bS4TDf5
 kyA5Fg3GyzkTUdVNyTDFBBDj4jDDZR+ZKjg/Yq2s3zpmS7X/57u07Q96Lm1Y1aYtYp
 089j1XgM3SjKy+J4h/zrb3PFAOFj9y27+m59UbDRBPw9soV57YjT/zHjDayyb5LPkG
 zFXlMTB5Xie5A==
Message-ID: <sashiko-outbox-196821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: Replace deprecated DCS display-on calls
To: amit <amittibi123@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104073813.42429-1-amittibi123@gmail.com>
References: <20261104073813.42429-1-amittibi123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:47:40 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/panel: uninitialized return value in k101_im2ba02_enable() on =
DSI error
- [Low] drm/panel: single-call mipi_dsi_multi_context misuse and duplicate =
dev_err()
--

commit 98ea9fe2e57e340101561581a07219ed561f36d0
Author: amit <amittibi123@gmail.com>

drm/panel: Replace deprecated DCS display-on calls

This commit replaces calls to mipi_dsi_dcs_set_display_on() across 14 DRM
panel drivers with mipi_dsi_dcs_set_display_on_multi() using a local
mipi_dsi_multi_context structure.

> diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/d=
rm/panel/panel-boe-himax8279d.c
> index 4a8560b4b899a..a4b35e042f315 100644
> --- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> +++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> @@ -155,7 +155,12 @@ static int boe_panel_prepare(struct drm_panel *panel)
>  	/* T6: 120ms - 121ms */
>  	usleep_range(120000, 121000);
> =20
> -	err =3D mipi_dsi_dcs_set_display_on(pinfo->link);
> +	struct mipi_dsi_multi_context dsi_ctx =3D {
> +		.dsi =3D pinfo->link,
> +	};
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	err =3D dsi_ctx.accum_err;
>  	if (err < 0) {
>  		dev_err(panel->dev, "failed to set display on: %d\n", err);
>  		goto poweroff;

[Severity: Low]
This isn't a bug, but is it intended to instantiate struct
mipi_dsi_multi_context mid-function for just a single
mipi_dsi_dcs_set_display_on_multi() call while leaving the surrounding DSI
calls (such as mipi_dsi_dcs_exit_sleep_mode(), mipi_dsi_dcs_set_tear_on(),
mipi_dsi_dcs_set_pixel_format(), and mipi_dsi_dcs_write_buffer()) unconvert=
ed?

In addition, mipi_dsi_dcs_set_display_on_multi() in
drivers/gpu/drm/drm_mipi_dsi.c already logs an error on failure:

	ret =3D mipi_dsi_dcs_set_display_on(dsi);
	if (ret < 0) {
		ctx->accum_err =3D ret;
		dev_err(dev, "sending DCS SET_DISPLAY_ON failed: %d\n",
			ctx->accum_err);
	}

Keeping the caller's dev_err() here in boe_panel_prepare() (as well as in
boe_panel_enable(), innolux_panel_prepare(), khadas_ts050_panel_prepare(),
kingdisplay_panel_prepare(), ltk500hd1829_prepare(), panel_nv3051d_prepare(=
),
nt35510_prepare(), rad_panel_enable(), and sharp_panel_prepare()) will print
duplicate error messages when setting the display on fails. Declaring
dsi_ctx in the middle of the function after executable statements also
introduces mixed declarations across 12 of the modified drivers (including
dsicm_power_on(), rm68200_prepare(), and s6e63j0x03_enable()).

Should the full DSI command sequences in these functions be converted to use
a single mipi_dsi_multi_context declared at the top of each function with t=
he
redundant dev_err() calls removed?

[ ... ]

> diff --git a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c b/drivers/=
gpu/drm/panel/panel-feixin-k101-im2ba02.c
> index 8c3a231c147d5..baa64b7aeb0bd 100644
> --- a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
> +++ b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
> @@ -344,12 +344,15 @@ static int k101_im2ba02_enable(struct drm_panel *pa=
nel)
>  {
>  	struct k101_im2ba02 *ctx =3D panel_to_k101_im2ba02(panel);
>  	const struct k101_im2ba02_init_cmd *cmd =3D &timed_cmds[1];
> +	struct mipi_dsi_multi_context dsi_ctx =3D {
> +		.dsi =3D ctx->dsi,
> +	};
>  	int ret;
> =20
>  	msleep(150);
> =20
> -	ret =3D mipi_dsi_dcs_set_display_on(ctx->dsi);
> -	if (ret < 0)
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err)
>  		return ret;

[Severity: High]
In k101_im2ba02_enable(), doesn't this return the uninitialized local
variable ret when mipi_dsi_dcs_set_display_on_multi() fails and sets
dsi_ctx.accum_err?

Since ret is never initialized or assigned, returning ret on error triggers
an uninitialized variable warning and can return a non-negative garbage val=
ue
to drm_panel_enable(), causing it to treat a failed panel enable as
successful while skipping the final mipi_dsi_dcs_write_buffer() command.

Should ret be removed and dsi_ctx.accum_err returned directly instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104073813.4242=
9-1-amittibi123@gmail.com?part=3D1
