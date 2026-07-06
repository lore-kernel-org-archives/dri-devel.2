Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDBBC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FAC10E274;
	Mon,  6 Jul 2026 19:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W6lPCCJM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD7410E274
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:47:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 640BC6138D;
 Mon,  6 Jul 2026 19:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1DB1F000E9;
 Mon,  6 Jul 2026 19:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783367277;
 bh=9h1dkj/a801+juvT6n1q1xdaTjaRLzkZOCHODrSF9LI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W6lPCCJM0quK7a59pG0/cFrCk0OTm+X1DK28ZwwocIWi4YeeUNnE6djztR/Fox6lf
 /kYG2GEalz3u/VTrM6dKCWM1TV3my+8BBIoIYbAVvNlWF6PlmQzMhTJ2Dc7/6WReX9
 Il342AzwrmUkV129GxtHv5//VGhU/ErcPJ0cmCwvUUXskEhbKVLHZUmItx+KQ0ST8k
 vaItVjLFWb0sJ9kanqirJYqtLvlkT76HAWs1t2P9Tw14ZBDCTQLRxbmWU7nujFvxBN
 VlEINuAHOwsJmPh9ie4NusC3VYvTKyfiVbRh7hsk2qOGGCi6mpO2mn9yDVE+6KB36/
 2EPUmZrRflFvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE
 overflow on 32-bit
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260706-dw-hdmi-qp-yuv-v2-5-b91beb33dedf@collabora.com>
References: <20260706-dw-hdmi-qp-yuv-v2-0-b91beb33dedf@collabora.com>
 <20260706-dw-hdmi-qp-yuv-v2-5-b91beb33dedf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 19:47:55 +0000
Message-Id: <20260706194756.BA1DB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sleeping functions are called from CRTC atomic enable and disable =
callbacks, which execute in atomic context.
- [High] 32-bit integer overflow in MIPI D-PHY target clock calculation bef=
ore 64-bit promotion.
- [High] 32-bit integer overflow in HDMI PHY link rate calculation.
--

commit 5fecee5ab858bfe428aa0c5173e40c8dd13919cc
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE overflow on 32-bit

This commit fixes a 32-bit integer overflow when calculating the maximum
DCLK for the HDMI PHY PLL by redefining VOP2_MAX_DCLK_RATE as an
unsigned long long. This ensures the value is evaluated in 64-bit
arithmetic, preventing high-resolution modes from being wrongly rejected.

Closes: https://lore.kernel.org/all/20260623203310.9F8C81F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index e966c0a0266ea..0799eb0dd29fc 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -102,7 +102,7 @@ enum vop2_afbc_format {
>  	VOP2_AFBC_FMT_INVALID =3D -1,
>  };
> =20
> -#define VOP2_MAX_DCLK_RATE		600000000UL
> +#define VOP2_MAX_DCLK_RATE		600000000ULL
> =20
>  /*
>   * bus-format types.

[Severity: High]
This is a pre-existing issue, but do vop2_crtc_atomic_enable() and
vop2_crtc_atomic_disable() call sleeping functions from atomic context?

Looking at drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:

vop2_crtc_atomic_enable() {
    ...
    vop2_lock(vop2);
    ...
}

And:

vop2_crtc_atomic_disable() {
    ...
    vop2_lock(vop2);
    ...
}

According to the DRM display hardware programming guidelines, CRTC atomic
enable and disable callbacks run in atomic context during non-blocking comm=
its,
where sleeping is strictly forbidden.

However, vop2_crtc_atomic_enable() calls vop2_lock() (which takes a mutex),
clk_prepare_enable(), and vop2_enable(). Similarly, vop2_crtc_atomic_disabl=
e()
calls vop2_lock(), wait_for_completion_timeout(), clk_disable_unprepare(), =
and
vop2_disable().

Can this cause kernel warnings, system instability, and potential deadlocks?

[Severity: High]
This isn't a bug introduced by this patch, but does the MIPI D-PHY target c=
lock
calculation in dw_mipi_dsi2_get_lane_mbps() overflow on 32-bit architecture=
s?

Looking at drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c:

dw_mipi_dsi2_get_lane_mbps() {
    ...
    target_phyclk =3D DIV_ROUND_CLOSEST_ULL(lane_rate_kbps * lanes * 1000, =
bpp);
    ...
}

The multiplication lane_rate_kbps * lanes * 1000 is evaluated in 32-bit
arithmetic before DIV_ROUND_CLOSEST_ULL() can promote it to 64-bit. For
high-resolution outputs, this could exceed the 32-bit unsigned maximum and =
wrap
around.

Does this result in an incorrectly configured PHY clock?

[Severity: High]
This is a pre-existing issue, but does the HDMI PHY link rate calculation in
rk_hdptx_phy_clk_set_rate() also suffer from a 32-bit integer overflow?

Looking at drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:

rk_hdptx_phy_clk_set_rate() {
    ...
    link_rate =3D DIV_ROUND_CLOSEST_ULL(rate * hdptx->hdmi_cfg.bpc, 8);
    ...
}

The expression rate * hdptx->hdmi_cfg.bpc is evaluated as an unsigned long.
On 32-bit architectures, this is a 32-bit operation. When rate is large (e.=
g.,
594,000,000 for 4K@60Hz) and bpc is 8, the product exceeds the 32-bit unsig=
ned
limit, causing an overflow before promotion to 64-bit.

Could this yield an invalid HDMI PHY link rate and break display output on
32-bit architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-dw-hdmi-qp=
-yuv-v2-0-b91beb33dedf@collabora.com?part=3D5
