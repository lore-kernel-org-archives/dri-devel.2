Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015CCC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5314B10E2F5;
	Wed, 22 Jul 2026 19:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F3w02s7u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D4D10E2F5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 19:10:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4591600B0;
 Wed, 22 Jul 2026 19:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5341F000E9;
 Wed, 22 Jul 2026 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784747451;
 bh=G6bYgMrZ+/w+bjhtab2LPeI6X5NWO+BBWmuFa1yQVfc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F3w02s7uT1SvaFDuwbsJ+zKk0a/RNdC1mloa+b9Mr8p3uZZZjvfHVXv2H/N6Qe5+H
 pGQrNSFvWRH2R1vYRdmT2LkuInt1Ah9TsATQsa5OOMplK1DVI/AWVgMpRXhX8YoFgQ
 Iw6NVDMBFaGYZkpUzubgnDWh43RGNszrPfMf5I6R0rIvV2/sfdoQZ8YC6pYkW5Y2+W
 N1fzjo9yFvgMHGPYYWCM+MA6zmBnCcgpTItHcJ6yFaCp4Ph4QdHlZJVzwo4ZN4wAQb
 RS5FkdkNF/2UR5XBrkeJbQz0yYpXpRL3cAn7sYHAYVoIhy9aP/xFu51ZBhgwSPnz9B
 bzmqK3zYs+TBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS for
 Exynos 7870 DSIM
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-exynos-dsim-fixes-v3-1-0c31ae1dbecc@disroot.org>
References: <20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org>
 <20260723-exynos-dsim-fixes-v3-1-0c31ae1dbecc@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 19:10:50 +0000
Message-Id: <20260722191051.6E5341F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The macro `samsung_dsim_hw_is_exynos()` incorrectly evaluates to f=
alse for `DSIM_TYPE_EXYNOS7870`, causing Exynos 7870 to be treated as non-E=
xynos hardware.
--

--- Patch [1]: [PATCH v3 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS fo=
r Exynos 7870 DSIM ---
commit fb46175bd3153fc02fa44c4333e69d1b1ac4e3b4
Author: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM

This commit enables FIFO flushing at v-sync pulse by setting the MFLUSH_VS
bit for Exynos 7870. The bit is active-high for this hardware variant.

Link: https://github.com/samsungexynos7870/android_kernel_samsung_exynos787=
0/blob/a3762bb1761ae/drivers/video/fbdev/exynos/decon_7870/dsim_reg_7870.c#=
L699 [1]

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 25ab475309e87..da753ff6eed4d 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1089,6 +1089,13 @@ static int samsung_dsim_init_link(struct samsung_d=
sim *dsi)
>  			reg |=3D DSIM_HBP_DISABLE_MODE;
>  		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_NO_HSA)
>  			reg |=3D DSIM_HSA_DISABLE_MODE;
> +
> +		/*
> +		 * For some hardware types, DSIM_MFLUSH_VS bit needs to be
> +		 * enabled explicitly.
> +		 */
> +		if (dsi->plat_data->hw_type =3D=3D DSIM_TYPE_EXYNOS7870)
> +			reg |=3D DSIM_MFLUSH_VS;

[Severity: High]
This is a pre-existing issue, but does the DSIM_TYPE_EXYNOS7870 hardware ty=
pe
need to be included in the samsung_dsim_hw_is_exynos() macro?

Currently, the macro in include/drm/bridge/samsung-dsim.h is defined as:

#define samsung_dsim_hw_is_exynos(hw) \
	((hw) >=3D DSIM_TYPE_EXYNOS3250 && (hw) <=3D DSIM_TYPE_EXYNOS5433)

Because Exynos 7870 falls outside this range, the macro evaluates to false
for it, causing the driver to treat it as non-Exynos hardware.

This causes incorrect configurations later in samsung_dsim_init_link():

	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
		reg |=3D DSIM_NON_CONTINUOUS_CLKLANE;

And in samsung_dsim_atomic_pre_enable(), it causes the wrong initialization
path to be taken:

	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
		ret =3D samsung_dsim_init(dsi);
		if (ret)
			return;
	}

Could this cause initialization ordering issues or incorrect hardware
configuration for Exynos 7870?

>  	}
> =20
>  	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-exynos-dsi=
m-fixes-v3-0-0c31ae1dbecc@disroot.org?part=3D1
