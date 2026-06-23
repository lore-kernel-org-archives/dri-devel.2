Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6628CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0438010EB04;
	Tue, 23 Jun 2026 20:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZbxA+xvn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC3D10EB04
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:20:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1ED0E60008;
 Tue, 23 Jun 2026 20:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE21F000E9;
 Tue, 23 Jun 2026 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246043;
 bh=VpHUaNWePYf2H4z+8r7fDXexwC6n6eCmfj8CaUM1zCk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZbxA+xvnL/GsYgdQhoGfbVsKWJtRAY2IBg3SztszAodhg/8rvKroZiFVuwvjYWdYT
 B08wRUwGMPG/ML9ADN6n3kT6qrHtMSSo7NywTljltnhtxWgjymH0CSvZsET3b2FSoL
 dEOGV6+g9jFGi4IU1v4HYeQua5BwsdVj2N/AjQM/BE6uBPUjQPBcXQFz92MI4Wweqs
 WrU6X3vxXq9I4MQ9F+3dn3EbPSjUN9mybra/9g0gD/Xq7/u5oiUb2gQWtuuUUaFYao
 cmHwI3cC+CrmTE0BZANCf60Vv6gPmAY7/3xpBoLKxVtZOb3BVj6JuaYqb+/elOhXtx
 iWVWUuiqVYLHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] drm/rockchip: vop2: Reset AXI and DCLK to improve
 robustness
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260617-dw-hdmi-qp-yuv-v1-2-a665cfd06d7d@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-2-a665cfd06d7d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:20:43 +0000
Message-Id: <20260623202043.8BFE21F000E9@smtp.kernel.org>
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

New issues:
- [High] AXI reset is performed after detaching the IOMMU domain, risking m=
emory corruption.

Pre-existing issues:
- [High] Unpowered hardware access and unbalanced PM runtime usage due to i=
gnored error in vop2_enable().
- [High] Clock enable count underflow and resource tracking mismatch on ear=
ly return in vop2_crtc_atomic_enable().
--

commit 13864800def8231541cc3847f090a3ab6ab365c2
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: drm/rockchip: vop2: Reset AXI and DCLK to improve robustness

Assert the AXI reset in the CRTC disable path, and the VP DCLK reset in
the enable path. These resets are intended to leave the hardware in a clean
state for the next use, helping recover from exceptions such as IOMMU page
faults.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 4cce3e336f5b3..2833fb49ad81a 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -938,6 +959,8 @@ static void vop2_disable(struct vop2 *vop2)
>  {
>  	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
> =20
> +	vop2_clk_reset(vop2, vop2->axi_rst);
> +

[Severity: High]
Does asserting the AXI reset here risk memory corruption?

If the AXI master is recovering from an exception and still issuing DMA
requests, detaching the IOMMU domain first leaves a window where the master
could access physical memory without translation.=20

Could this lead to memory corruption or spurious page faults? Should the AXI
master be explicitly reset before the IOMMU is detached?

>  	pm_runtime_put_sync(vop2->dev);
> =20
>  	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);

[ ... ]

> @@ -1948,6 +1971,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc=
 *crtc,
> =20
>  	vop2_crtc_atomic_try_set_gamma(vop2, vp, crtc, crtc_state);
> =20
> +	vop2_clk_reset(vop2, vp->dclk_rst);
> +

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for unpowered
hardware access to cause a crash if vop2_enable() fails?

In vop2_enable(), if pm_runtime_resume_and_get() or clock preparation fails,
it logs an error and returns void. However, vop2_crtc_atomic_enable()
unconditionally increments vop2->enable_count and continues configuring
hardware:

	if (!vop2->enable_count)
		vop2_enable(vop2);

	vop2->enable_count++;

Since the power domain and core clocks would remain off on failure, could t=
he
subsequent writes to VOP2 hardware registers trigger a synchronous external
abort and crash the system?

[Severity: High]
This is a pre-existing issue, but can an early return in
vop2_crtc_atomic_enable() cause severe state mismatches?

If clk_prepare_enable(vp->dclk) fails earlier in this function:

	ret =3D clk_prepare_enable(vp->dclk);
	if (ret < 0) {
		drm_err(vop2->drm, "failed to enable dclk for video port%d - %d\n",
			vp->id, ret);
		vop2_unlock(vop2);
		return;
	}

The function returns early without updating state properly. During disable,
vop2_crtc_atomic_disable() blindly decrements the tracking state:

	clk_disable_unprepare(vp->dclk);

	vop2->enable_count--;

	if (!vop2->enable_count)
		vop2_disable(vop2);

If another CRTC is active, couldn't this underflow or prematurely drop the
count to 0, unintentionally shutting off core clocks and PM runtime for the
actively running CRTC?

>  	drm_crtc_vblank_on(crtc);
> =20
>  	vop2_unlock(vop2);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-dw-hdmi-qp=
-yuv-v1-0-a665cfd06d7d@collabora.com?part=3D2
