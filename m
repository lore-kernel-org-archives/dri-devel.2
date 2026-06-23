Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBA6CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D44910EBC3;
	Tue, 23 Jun 2026 20:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BeqZUh50";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375E610EBC3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:33:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00E6041AF1;
 Tue, 23 Jun 2026 20:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8C81F000E9;
 Tue, 23 Jun 2026 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246790;
 bh=TLk0sCP9g8Hb5W2660tfp4hE/wMoOUvU5+RyvkNByD8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BeqZUh50QfKXwW3gumbF3bCW3vnUf3X9/9get8ppLhKcZdaBVPwkYRIQPr+cuWAwB
 hwMApar/siqJU/dTc7Inzoo7NWy3Bfyxjr92prvEvDdh+Io583LFDIugtyt7YOwmZv
 FAjsZw5lih8hvOKTNXRxAto+FMVVodzyUItqSdcyGh3hVCmNJsZO23lgDl9vwVOiKZ
 4arM1dW/i3bwHVhWmhMA7noIzCGBYLGR/HL5oVgr9GuT7BUpk0LKSVY/RbXW+TA8R4
 hneJpiGEd5eVnAm0vAgcMKJ4KFW47ifL1vYQOCSwGzgQVz16yPp2pLk33wfTADYY1P
 uvSp2Xi343iGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] drm/rockchip: vop2: Avoid DCLK source switch for
 10-bit YUV422 output
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260617-dw-hdmi-qp-yuv-v1-3-a665cfd06d7d@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-3-a665cfd06d7d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:33:10 +0000
Message-Id: <20260623203310.9F8C81F000E9@smtp.kernel.org>
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
- [High] Division by zero in max_dclk calculation due to uninitialized outp=
ut_bpc.
- [High] Integer overflow in max_dclk calculation on 32-bit architectures.
- [High] Atomic context violation due to calling sleeping functions.
--

commit cdb8cbbc3fd201db3157d6704b3856b8565e10e2
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Avoid DCLK source switch for 10-bit YUV422 output
   =20
The commit modifies the DCLK source decision logic for HDMI output in VOP2.
It prevents unnecessary switching of the DCLK source to the system CRU for
10-bit YUV422 output by forcing the bandwidth check to 8 bpc.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 2833fb49ad81a..17d21e08ad977 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1922,8 +1922,17 @@ static void vop2_crtc_atomic_enable(struct drm_crt=
c *crtc,

[Severity: High]
This is a pre-existing issue, but does this function violate atomic context
rules?

According to the DRM subsystem guidelines, CRTC atomic enable callbacks exe=
cute
in atomic context where sleeping is forbidden. However, vop2_crtc_atomic_en=
able()
acquires a mutex via vop2_lock() and later calls clk_prepare_enable(), both=
 of
which can sleep.

Can this cause scheduling while atomic warnings or deadlocks during atomic
commits?

>  	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
>  	 */
>  	if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
> -		unsigned long max_dclk =3D DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * =
8,
> -							       vcstate->output_bpc);
> +		/*
> +		 * YUV422 always transmits two 12-bit components per clock
> +		 * cycle, regardless of the color depth, which from a rate
> +		 * perspective is equivalent to three 8-bit RGB components.
> +		 * Force 8 bpc here so the bandwidth check reflects the actual
> +		 * TMDS rate and avoids an unnecessary DCLK source switch.
> +		 */
> +		unsigned int bpc =3D vcstate->output_mode =3D=3D ROCKCHIP_OUT_MODE_YUV=
422 ?
> +					8 : vcstate->output_bpc;
> +		unsigned long max_dclk =3D DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * =
8, bpc);

[Severity: High]
This isn't a bug introduced by this patch, but can bpc be 0 here and cause a
division by zero?

If the VOP2 driver is used with a non-HDMI output like DSI or LVDS on a boa=
rd
that also has an HDMI PHY, vop2->pll_hdmiphy0 or vop2->pll_hdmiphy1 will be
non-NULL. Since DSI/LVDS encoders do not set vcstate->output_bpc, it defaul=
ts
to 0.

This would lead to DIV_ROUND_CLOSEST_ULL(..., 0) before the loop checks if
the endpoint is HDMI.

[Severity: High]
This is also a pre-existing issue, but does VOP2_MAX_DCLK_RATE * 8 overflow=
 on
32-bit architectures?

VOP2_MAX_DCLK_RATE is defined as 600000000UL. On architectures where
unsigned long is 32 bits, 600000000UL * 8 equals 4,800,000,000, which excee=
ds
ULONG_MAX.

This truncates to 505,032,704 before being promoted to unsigned long long i=
nside
DIV_ROUND_CLOSEST_ULL, improperly forcing higher resolutions to fall back t=
o the
system CRU.

Should this be cast to a 64-bit type first, such as VOP2_MAX_DCLK_RATE * 8U=
LL?

>  		if (clock <=3D max_dclk) {
>  			drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mas=
k) {
>  				struct rockchip_encoder *rkencoder =3D to_rockchip_encoder(encoder);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-dw-hdmi-qp=
-yuv-v1-0-a665cfd06d7d@collabora.com?part=3D3
