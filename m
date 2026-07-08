Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9780AC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA71810E552;
	Wed,  8 Jul 2026 22:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JOVleI/Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E4710E552
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:06:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BA376001A;
 Wed,  8 Jul 2026 22:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B323E1F000E9;
 Wed,  8 Jul 2026 22:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783548416;
 bh=WwwQNL4FDTzLpQnrRMiXnMvqOgpuNzzaDKuvB3TpRKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JOVleI/QhrbOPXzWWzQ3q8yKPPonhsIIZCaWZlBJ32UoSSFICbqpq4EEhk9e7oxNi
 5jUf+TUJjEPUr5AlJIuu5ZY46M3PDLvv6eM0aEzXzU2xOHjNLaggN2thq3CPt3PaRB
 Z8JgBBf9qBaSuwkTZyPeFjLBsNY88KRCYoDaqIK1tZ50SdKi76Zm7E90a6Jid/lYBR
 A6hGb74qxIlp97SXKv395UXuAMj5SGMI0gqMNlGiE+BT+WhwhhW3XSPZXBk/Ob4P56
 KuiOe0oPTmGY9MFnl0yumRV8RBxw99WSPqDErB5Z4W/DNJOickm46CP/SrEP9H+HYe
 MOMeGTX3bpQRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/14] drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE
 overflow on 32-bit
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-6-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
 <20260709-dw-hdmi-qp-yuv-v3-6-a4a982a9f2e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:06:55 +0000
Message-Id: <20260708220655.B323E1F000E9@smtp.kernel.org>
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
- [High] The driver calls multiple sleeping functions from CRTC atomic enab=
le, disable, and flush callbacks, violating DRM atomic context rules.
--

--- Patch [6]: [PATCH v3 06/14] drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE =
overflow on 32-bit ---
commit 4edf4257240708c6864fcd134b29f53d0456d685
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE overflow on 32-bit

VOP2_MAX_DCLK_RATE is defined as an unsigned long and is used scaled by
the color-depth ratio. On 32-bit architectures, this can overflow when
multiplied. This patch changes the constant to unsigned long long to ensure
64-bit arithmetic is used.

Link: https://lore.kernel.org/all/20260623203310.9F8C81F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index e9f5d015b6458..2cd04bedaa2c0 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -102,7 +102,7 @@ enum vop2_afbc_format {
>  	VOP2_AFBC_FMT_INVALID =3D -1,
>  };
> =20
> -#define VOP2_MAX_DCLK_RATE		600000000UL
> +#define VOP2_MAX_DCLK_RATE		600000000ULL

[Severity: High]
This is a pre-existing issue, but I noticed some potential atomic context
violations in this file.

During non-blocking commits, the DRM core invokes CRTC callbacks like
vop2_crtc_atomic_enable(), vop2_crtc_atomic_disable(), and
vop2_crtc_atomic_flush(). These run in an atomic context where sleeping is
strictly forbidden.

However, the driver appears to invoke sleeping functions on these paths.
For example, in vop2_crtc_atomic_enable():

    vop2_lock(vop2);
   =20
    ...
   =20
    ret =3D clk_prepare_enable(vp->dclk);

Similarly, in vop2_crtc_atomic_disable():

    vop2_lock(vop2);

And in the flush path via vop2_crtc_atomic_try_set_gamma_locked():

    vop2_lock(vop2);

Because vop2_lock() acquires a mutex and clk_prepare_enable() can sleep,
does this violate the atomic context requirement and potentially cause syst=
em
instability or deadlocks during display state updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-dw-hdmi-qp=
-yuv-v3-0-a4a982a9f2e7@collabora.com?part=3D6
