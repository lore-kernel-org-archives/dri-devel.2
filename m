Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C33C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6E110E5A7;
	Mon, 13 Jul 2026 08:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F/x4fXrZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C30910E5A7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:30:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5548660018;
 Mon, 13 Jul 2026 08:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51951F000E9;
 Mon, 13 Jul 2026 08:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783931411;
 bh=F9CNNKvYwBXnlZRTZBvyJFrNt40eYKWPXShSgljFkhQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F/x4fXrZus7y/MAzoZMqcuLKpo7U6y6/NeZ6FZddq7qpHo7yxd8umE+ujkMHCs/e8
 7J6mQPhsTxi1HzH+qWQ8mHzgLh4bxlZFqkiStwnK5ZkQwbHuE86sXMYwzNgOyJvMch
 dWl12D8y5JbD+2KT8NrwLqAlyRkuX2ukScYmUAeOodVb2gSiJgBk1I5v+ce+FFj8RI
 71SJbbh9WO1w3zLRzWMhC4K6U6bjPj7cjl1wJzvYtQWI95eWnOOHokkjTz+5EY2+Rj
 dTtXY2zOsPluC6JG3IcoBcZMQo4q9+n+ZtEKJ+KBrU88quqeWvStSq73GgkiJjC+0L
 tGWH89oLH2oNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: ilitek-ili9881c: do not fail probe if iovcc
 is absent
To: "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713082213.75759-1-david.oberhollenzer@sigma-star.at>
References: <20260713082213.75759-1-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:30:10 +0000
Message-Id: <20260713083010.D51951F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing `drm_panel_remove()` cleanup on the error path of `mipi_ds=
i_attach()` in probe leads to Use-After-Free.
- [High] The reset GPIO is asserted after regulators are disabled in the un=
prepare sequence, risking back-powering the display controller.
--

--- Patch [1]: [PATCH] drm/panel: ilitek-ili9881c: do not fail probe if iov=
cc is absent ---
commit 20684573ac473e40824b8b3fb7de5a67cbfc4efa
Author: David Oberhollenzer <david.oberhollenzer@sigma-star.at>

drm/panel: ilitek-ili9881c: do not fail probe if iovcc is absent

Commit 4c95b2b7d49e ("drm/panel: ilitek-ili9881c: support Waveshare
7.0" DSI panel") adds an additional iovcc regulator that other
Ilitek ili9881c based panels apparently do not have or need.

The commit goes out of its way to make usage of this new regulator
optional, dutifully testing if the field in struct ili9881c is NULL
before touching the new regulator. However, in the probe function,
it unconditionally fails if devm_regulator_get_optional returns an
error.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
> index 3abdd0870e831..c3d5ab67121d9 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2563,9 +2563,12 @@ static int ili9881c_dsi_probe(struct mipi_dsi_devi=
ce *dsi)
>  				     "Couldn't get our power regulator\n");
> =20
>  	ctx->iovcc =3D devm_regulator_get_optional(&dsi->dev, "iovcc");
> -	if (IS_ERR(ctx->iovcc))
> -		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
> +	if (IS_ERR(ctx->iovcc)) {
> +		if (PTR_ERR(ctx->iovcc) !=3D -ENODEV)
> +			return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
>  				     "Couldn't get our iovcc regulator\n");
> +		ctx->iovcc =3D NULL;
> +	}
> =20
>  	ctx->reset =3D devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LO=
W);
>  	if (IS_ERR(ctx->reset))

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
ili9881c_dsi_probe(), it appears there is a missing cleanup if mipi_dsi_att=
ach()
fails later in the function:

	drm_panel_add(&ctx->panel);

	dsi->mode_flags =3D ctx->desc->mode_flags;
	dsi->format =3D MIPI_DSI_FMT_RGB888;
	dsi->lanes =3D ctx->desc->lanes;

	return mipi_dsi_attach(dsi);
}

If mipi_dsi_attach() returns an error, the ctx memory (allocated via
devm_drm_panel_alloc()) is automatically freed upon probe failure.

However, since drm_panel_remove() isn't called, does the freed memory remain
linked in the global panel_list?

Could this lead to a use-after-free crash if another driver traverses
panel_list by calling of_drm_find_panel()?


[Severity: High]
This is another pre-existing issue, but I noticed a potential power sequenc=
ing
problem in ili9881c_unprepare():

drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:ili9881c_unprepare() {
    ...
	regulator_disable(ctx->power);
	if (ctx->iovcc)
		regulator_disable(ctx->iovcc);
	gpiod_set_value_cansleep(ctx->reset, 1);
    ...
}

Is it safe to disable the regulators before asserting the reset GPIO?

If the regulators are disabled while the reset GPIO is still driving a high
voltage, could the unpowered display panel be back-powered through the reset
pin's ESD protection diodes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713082213.7575=
9-1-david.oberhollenzer@sigma-star.at?part=3D1
