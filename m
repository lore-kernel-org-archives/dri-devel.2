Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86628C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 09:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E95B10E115;
	Sun,  9 Aug 2026 09:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kHWGwyNx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811A510E115
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:09:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FB9F438DF;
 Sun,  9 Aug 2026 09:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A1F1F000E9;
 Sun,  9 Aug 2026 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786266561;
 bh=OAxx3kJLY3bHaf2gK1XAtKnLGmanKqZ8lck6hjA4OG4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kHWGwyNx/cSumu2VjB6Qazjl1m8v5GayE7pHO3l1fu7hHw3yGETWCGhlt0eE3w6Yn
 h2rxqgbimJN9/rTDn+ljZ5TVbMkSfaZ7bRIMW9wt0W5Q/8aTB/w1IdUA0mFjj8f0u6
 skHdtGmzKUKhf+OHYE5zGNCsvGs+xXfqp6s6V2e5HgQDI39aGuY4KJMlqrjmi/k0TA
 M1+forERJeaPjCDTdFSPoiHx4w6IChfval7UmFE4Agum+cWjVaeESIjPEoQudUxlGy
 tHqc2V/mYPB5kshNK+opy9AyzSpVBOPByZIkVB+gwriziditHmCJ/ZvlhHhw97V2GA
 HLBxS+xf33UAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS for
 Exynos 7870 DSIM
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809-exynos-dsim-fixes-v5-1-6e63dc6c238f@disroot.org>
References: <20260809-exynos-dsim-fixes-v5-0-6e63dc6c238f@disroot.org>
 <20260809-exynos-dsim-fixes-v5-1-6e63dc6c238f@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:09:20 +0000
Message-Id: <20260809090921.45A1F1F000E9@smtp.kernel.org>
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
- [High] Hardware misidentification of Exynos 7870 causing incorrect displa=
y initialization sequence.
--

--- Patch [1]: [PATCH v5 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS fo=
r Exynos 7870 DSIM ---
commit 4604aa815a722cdb66f92b628f8218c57c5a77bb
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM

This commit enables the active-high MFLUSH_VS bit for the Exynos 7870 DSIM
hardware to properly flush the display FIFO at v-sync pulse. It fixes an
issue introduced by a previous commit that assumed MFLUSH_VS was active-low
across all hardware.

Link: https://github.com/samsungexynos7870/android_kernel_samsung_exynos787=
0/blob/a3762bb1761ae/drivers/video/fbdev/exynos/decon_7870/dsim_reg_7870.c#=
L699 [1]

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index e2fc69fc51b60..6260c091c3df8 100644
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
> +		 * enabled as its active-high.
> +		 */
> +		if (dsi->plat_data->hw_type =3D=3D DSIM_TYPE_EXYNOS7870)
> +			reg |=3D DSIM_MFLUSH_VS;

[Severity: High]
This is a pre-existing issue, but since this patch adds specific support for
DSIM_TYPE_EXYNOS7870, does the samsung_dsim_hw_is_exynos() macro also need
to be updated to include it?

Currently, that macro is defined as:

include/drm/bridge/samsung-dsim.h:
#define samsung_dsim_hw_is_exynos(hw) \
	((hw) >=3D DSIM_TYPE_EXYNOS3250 && (hw) <=3D DSIM_TYPE_EXYNOS5433)

Because DSIM_TYPE_EXYNOS7870 falls outside this range, the macro evaluates
to false for the Exynos 7870. This causes the driver to incorrectly treat
it as an i.MX device in several places.

For example, further down in this same samsung_dsim_init_link() function,
it will incorrectly apply the i.MX-specific non-continuous clock lane
configuration:

	if (driver_data->has_clklane_stop &&
	    dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
		if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
			reg |=3D DSIM_NON_CONTINUOUS_CLKLANE;

It also causes samsung_dsim_atomic_pre_enable() to call samsung_dsim_init()
early:

	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
		ret =3D samsung_dsim_init(dsi);

which breaks the expected Exynos DSI host initialization order.

Will this hardware misidentification cause display initialization failures
on Exynos 7870 hardware?

>  	}
> =20
>  	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-exynos-dsi=
m-fixes-v5-0-6e63dc6c238f@disroot.org?part=3D1
