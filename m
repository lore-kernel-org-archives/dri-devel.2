Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB3C88E67
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 14:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84BD10E927;
	Sun, 13 Sep 2026 14:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d7FfBa1n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559CB10E7BE
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:56:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D2B860E50;
 Sun, 13 Sep 2026 14:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EB71F000FF;
 Sun, 13 Sep 2026 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789311418;
 bh=qwT6SRGrWU5ixZrRtK9qFiINLnWC1+kF+GUOsHUyW3s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d7FfBa1nDgoFFRzBucfNuX0dXjf7XCoNg/ZwnoOpuN/AqmJ+ioHfPF4bWqGKqFDjU
 Uwj2Gmc74kkdpsEPGKzVlogYtoqqbAZuJ+48c4Z65oMcVH11StVG9Vz2YchCVEOCmU
 EIRjkYYwuKqrHNXjgcmGbHb8VFMMmLKNjjzo/m6UtLTgf6zD6LKYuW21DR/ur6O2AJ
 6G6ywaVPzPR+VNVnXaIvScuoc6d4vClgwwe0Hndgms18Mw0aYDlW+ZgnydS74y7bTV
 o/5MoGVErgJRCfUI05E/UboWnyEd8fCEKYTz1R1X3yGtm6OX/XAgMJFrjVTzZslEti
 LLaCoMyXPQ2Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: "Nickolay Goppen" <setotau@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260913-qcom-novatek-nt51021-panels-v3-2-266bc5d7e8c9@mainlining.org>
References: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
 <20260913-qcom-novatek-nt51021-panels-v3-2-266bc5d7e8c9@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 14:56:57 +0000
Message-Id: <20260913145657.B9EB71F000FF@smtp.kernel.org>
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
- [Medium] Unconditional execution of CABC off sequence overwrites untouche=
d state for boe_tv101wum_nm0 variant.
--

commit 80218d28f8a5f485ff9423dca654f2257664a78b
Author: Nickolay Goppen <setotau@mainlining.org>

drivers: gpu: drm: panel: Add BOE NT51021 driver

Add driver for BOE NT51021-based 8-inch and 10-inch DSI video mode
panels used in Xiaomi Mi Pad 4, Mi Pad 4 Plus and Amazon Fire HD 10 tablets.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt51021.c b/drivers/gpu/=
drm/panel/panel-novatek-nt51021.c
> new file mode 100644
> index 0000000000000..fc99908917868
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt51021.c

[ ... ]

> +static int nt51021_novatek_off(struct novatek_nt51021_desc *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	nt51021_cabc_off(&dsi_ctx);

[Severity: Medium]
The commit message mentions that for the boe_tv101wum_nm0 variant, CABC is
untouched because the vendor drives it over I2C from the backlight path. Wh=
ile
the initialization sequence for the nm0 variant correctly omits turning CABC
on, this teardown sequence appears to unconditionally call nt51021_cabc_off=
()
for all variants.

When nt51021_cabc_off() is called, it executes:

    mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x90, 0xc0);

Could this unconditional write cause unexpected hardware states or DSI/I2C
collisions during the display teardown for the nm0 variant, since the regis=
ter
was intended to be left alone?

> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0xa5);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 130);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 70);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0x00);
> +	mipi_dsi_usleep_range(&dsi_ctx, 4000, 5000);
> +
> +	return dsi_ctx.accum_err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-qcom-novat=
ek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org?part=3D2
