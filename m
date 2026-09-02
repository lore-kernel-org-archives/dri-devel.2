Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C91C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 23:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D895510EFFE;
	Wed,  2 Sep 2026 23:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYIzjrlR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A708C10EFFE
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 23:01:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D6B540AF7;
 Wed,  2 Sep 2026 23:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D61F00A3D;
 Wed,  2 Sep 2026 23:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788390096;
 bh=tR6mwiMSkS5vBeij9jZpHKCQX6tqW69OwpHzizbKZNM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eYIzjrlRCPhDcnSEW5EhY5guhJy/9cCl9dxx/xfqInk/0Q/MJA8y/gTEM0skLZCbJ
 U5d8d572BfguQwdoCGdKl3Um0iGBFmrRTvCyGqCV7svOFF7soDAJ9iWqM9Nj5qPgon
 y0eYrtiv6jt/OHyV8LhvyD46zeCM6pcXZeoSFzuVuGL6LMfeJtAQZl2U3zL6WhFPZf
 FrGRsoVO2xIC65QGERMZ1aJmVEtxllXM0ag+XUUGnZCLCzLYFsNWXYbNocKv4CzfRQ
 8ieUbHIXA5drCADfN46Dh/l19rCIZ/SYQ1Q/D9Wh1lG+vZ75Kzs1K7nqaF8bIWysH6
 WbXa72pALGYUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/14] drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE
 overflow on 32-bit
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260903-dw-hdmi-qp-yuv-v4-6-fb45bf4147eb@collabora.com>
References: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
 <20260903-dw-hdmi-qp-yuv-v4-6-fb45bf4147eb@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:01:35 +0000
Message-Id: <20260902230135.E54D61F00A3D@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the DRM subsyste=
m guidelines explicitly designate CRTC atomic enable and disable callbacks =
as executing in atomic context where sleeping is forbidden. However, `vop2_=
crtc_atomic_enable` and `vop2_crtc_atomic_disable` invoke multiple sleeping=
 functions. For example, both callbacks invoke `vop2_lock()` (which acquire=
s a mutex). `vop2_crtc_atomic_enable` calls `clk_prepare_enable()`, and `vo=
p2_crtc_atomic_disable` calls `wait_for_completion_timeout()`.
--

commit 42f6f5bd762f8191ecc03127da51288c0ad3ea76
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE overflow on 32-bit

This commit modifies the VOP2_MAX_DCLK_RATE macro to use an unsigned long=20
long suffix. This ensures 64-bit arithmetic is used during clock rate=20
calculations, preventing integer overflows on architectures where unsigned=
=20
long is 32-bit.

Link: https://lore.kernel.org/all/20260623203310.9F8C81F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 12a6341e3c988..c3f72cac63690 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -102,7 +102,7 @@ enum vop2_afbc_format {
>  	VOP2_AFBC_FMT_INVALID =3D -1,
>  };
> =20
> -#define VOP2_MAX_DCLK_RATE		600000000UL
> +#define VOP2_MAX_DCLK_RATE		600000000ULL

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file, I
noticed that the CRTC atomic callbacks appear to invoke sleeping functions.

In vop2_crtc_atomic_enable():

    vop2_lock(vop2);

    ret =3D clk_prepare_enable(vp->dclk);

And in vop2_crtc_atomic_disable():

    ret =3D wait_for_completion_timeout(&vp->dsp_hold_completion,
                                      msecs_to_jiffies(50));

Does this code risk system instability or deadlocks? The DRM subsystem=20
guidelines designate CRTC atomic enable and disable callbacks as executing=
=20
in an atomic context where sleeping is forbidden, yet these paths acquire a
mutex, enable clocks, and wait for completion timeouts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-dw-hdmi-qp=
-yuv-v4-0-fb45bf4147eb@collabora.com?part=3D6
