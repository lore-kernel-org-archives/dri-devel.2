Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3EDC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1B210EA9C;
	Mon,  6 Jul 2026 19:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ODmWzvEO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E64810EA9C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:41:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50648600C3;
 Mon,  6 Jul 2026 19:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DD51F000E9;
 Mon,  6 Jul 2026 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783366873;
 bh=ql1BTd+R8iFjcDbKq4QObGCOG8trG6gfPLTyqY6GNFw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ODmWzvEO4cyA8TLoxfAus2NNW3uweu/35BapcKk609i+UQZjP/nbJULqoF6ynV4hJ
 O6MRphWRdxLy7mGlcOADibnnptNEiBLxUcJNGf8JxUiEnYdiQ+MsB9I4dRXyDrfm0Y
 pQIKAArokSKsDMFWZLFcH6QjLmREAZSQPH3VbCmL3cfpOtLVBpYC5ixEH8BDIkXxS2
 FpjUUwTeBqMenWsRcqd2p0Iws0GE2pQVHeMtHJiOtt/gr3QWuvq4g+0YR2X//TuGs7
 YJX3QhqJiq4Ewn1GGWIPcsvZ02EwTnp+2eL6SHbVQbKxwII74Txrg/kIHSdln4S2T7
 nYYlDAvTataeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] drm/rockchip: vop2: Avoid division by zero
 when computing max_dclk
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260706-dw-hdmi-qp-yuv-v2-4-b91beb33dedf@collabora.com>
References: <20260706-dw-hdmi-qp-yuv-v2-0-b91beb33dedf@collabora.com>
 <20260706-dw-hdmi-qp-yuv-v2-4-b91beb33dedf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 19:41:12 +0000
Message-Id: <20260706194112.A9DD51F000E9@smtp.kernel.org>
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
- [High] The function `vop2_crtc_atomic_enable` calls sleeping functions, v=
iolating the DRM subsystem guideline that CRTC atomic enable callbacks exec=
ute in atomic context.
--

commit d9247f0e6928075b3e607f5959fafadc7413c070
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Avoid division by zero when computing max_dclk

This commit avoids a division by zero in vop2_crtc_atomic_enable() by
defaulting bpc to 8 if vcstate->output_bpc is 0, which happens for
non-HDMI outputs.

Closes: https://lore.kernel.org/all/20260623203310.9F8C81F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index c2328b35466de..e966c0a0266ea 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1920,8 +1920,9 @@ static void vop2_crtc_atomic_enable(struct drm_crtc=
 *crtc,
>  	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
>  	 */
>  	if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
> -		unsigned long max_dclk =3D DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * =
8,
> -							       vcstate->output_bpc);
> +		unsigned int bpc =3D vcstate->output_bpc ?: 8;
> +		unsigned long max_dclk =3D DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * =
8, bpc);
> +
>  		if (clock <=3D max_dclk) {
>  			drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mas=
k) {
>  				struct rockchip_encoder *rkencoder =3D to_rockchip_encoder(encoder);

[Severity: High]
This is a pre-existing issue, but does vop2_crtc_atomic_enable() safely
execute in an atomic context?

CRTC atomic enable callbacks can execute in an atomic context during
non-blocking commits, where sleeping is forbidden.

However, vop2_crtc_atomic_enable() invokes sleeping functions. It starts
with vop2_lock() (which wraps mutex_lock) and clk_prepare_enable():

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_crtc_atomic_enable() {
    ...
	vop2_lock(vop2);

	ret =3D clk_prepare_enable(vp->dclk);
    ...
}

Additionally, further down in the function, clk_set_parent() is called,
which also acquires the clock framework's sleeping mutex:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_crtc_atomic_enable() {
    ...
		if (pll_hdmiphy) {
			if (!vp->dclk_src)
				vp->dclk_src =3D clk_get_parent(vp->dclk);

			ret =3D clk_set_parent(vp->dclk, pll_hdmiphy);
    ...
}

Calling sleeping functions from an atomic context can cause kernel warnings,
potential deadlocks, and system instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-dw-hdmi-qp=
-yuv-v2-0-b91beb33dedf@collabora.com?part=3D4
