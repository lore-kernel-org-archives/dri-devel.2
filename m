Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8541DCA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A8010E729;
	Tue, 13 Oct 2026 04:43:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8725710E737
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:43:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49A6A43B0D;
 Tue, 13 Oct 2026 04:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0387D1F000FF;
 Tue, 13 Oct 2026 04:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791866616;
 bh=Ra8LK0alyL/dmxK24eW8Xn18xDRiIvE/sNnfAcpzRMQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BjrhIJGLsmXeOBAq/EBNEdHXnT7cfrBwDXcDX2DbCCcxBJmeaOdFXWetwZ/zX++Ff
 Z7f0k89JkpcOwCafnzo2StRJknUNsBt+FliGzg8GAUHkm3/mM7Vi2O+WatnYG6Iugz
 QwQ0+eTbyd0Otlcyxf7fdU2EtU9q0PEf61zwAwCdKrJanAXeoTPfZFMzN28VT2YLq/
 neHZs6NsyxS93Ad9qWaWdnMwlTpl4GIUQ7WoAbcJRAs0YlXpiRXgSSX6cGARpEmUWG
 Ov5CL9JL8lKNfbb+qZnXRKxNRggIqqAmAyUcZr5dy6vfVKn93nkiRGEB3qUl7v1Afb
 ksHesO1RsDgIg==
Message-ID: <sashiko-outbox-168984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/panel: newvision-nv3051d: Use
 mipi_dsi_*_multi(); fix minor bugs
To: "Akash Sukhavasi" <akash.sukhavasi@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-mipi-multi-series-v1-4-6a29add1ec92@gmail.com>
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
 <20261012-mipi-multi-series-v1-4-6a29add1ec92@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 04:43:35 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/panel: ignored error in panel_nv3051d_init_sequence()
--

commit aa26fcd3815b87a0163ded60d82dde5bf60bbecd
Author: Akash Sukhavasi <akash.sukhavasi@gmail.com>
drm/panel: newvision-nv3051d: Use mipi_dsi_*_multi(); fix minor bugs

This commit converts the newvision-nv3051d panel driver to use the _multi()
variants of the mipi_dsi_dcs_* functions. It uses mipi_dsi_msleep() and
mipi_dsi_usleep_range() for delays so they are skipped on prior errors. It
also fixes a bug where an enter_sleep_mode failure would skip the post-sleep
delay and leave the panel in a stuck state.

> diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c b/drivers/gp=
u/drm/panel/panel-newvision-nv3051d.c
> index 22560384e48e3..7dc25102a7735 100644
> --- a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
> +++ b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
[ ... ]
> @@ -295,22 +291,16 @@ static int panel_nv3051d_prepare(struct drm_panel *=
panel)
>  		goto disable_vdd;
>  	}
> =20
> -	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
> -		goto disable_vdd;
> -	}
> -
> -	msleep(200);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);

[Severity: Medium]
Does panel_nv3051d_init_sequence() mask initialization failures?

In panel_nv3051d_init_sequence(), the function uses a local dsi_ctx to
accumulate errors, but always returns 0:

static int panel_nv3051d_init_sequence(struct panel_nv3051d *ctx)
{
        ...
        struct mipi_dsi_multi_context dsi_ctx =3D {.dsi =3D dsi};

        mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x30);
        ...
        return 0;
}

If any DCS write fails, the error is stored in the local dsi_ctx.accum_err,
but the function unconditionally returns 0 instead of the accumulated error.

This causes the caller panel_nv3051d_prepare() to falsely assume the
initialization succeeded.

Will this proceed to exit sleep mode and turn on the display rather than
aborting and safely disabling the regulator when DSI communication fails?

> +	mipi_dsi_msleep(&dsi_ctx, 200);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 10000, 15000);
> =20
> -	ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
> +	if (dsi_ctx.accum_err) {
> +		ret =3D dsi_ctx.accum_err;
>  		goto disable_vdd;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-mipi-multi=
-series-v1-0-6a29add1ec92@gmail.com?part=3D4
