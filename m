Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE42C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1E910F306;
	Wed,  8 Jul 2026 22:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DqM1Ion3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ECE710F306
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:07:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7BFF6001A;
 Wed,  8 Jul 2026 22:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF3D1F000E9;
 Wed,  8 Jul 2026 22:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783548433;
 bh=cx7sCC72Rb5ZKhm5QhYr0VJzve760uPVVRldcv4QzG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DqM1Ion30QKok/H+f7ErmpqQwYmnlAntEvmRhnSWOLpIL6bdHBkWGucLXTK52Jakf
 vOXrT96Ws0uzmCWVgOhRvQ+UAJ7oxV+LJf/RqxNCWi06EZSX+MCSb224lCeXxwkBhY
 XJyHV81sCdy9tVW783oEOzTNXpk6WaEAV55OJGVF1OStVAyAKFwdHpLPnzuphfYUmN
 22KfEhEy7+cOhSnyr8AvVQp+S9kK6DW/CC9qOPiXvY7J7QU+oZXJuVMpjkC/tLOXx7
 vMLpWPdii4N2TZ7+nkQF9ADTSeiGOg7j3pAM5AbXA7j6Fqa0Sqo97e7a+O3CQ80X2s
 YSy7+wrIFRy6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/14] drm/rockchip: vop2: Fix resource leak on
 vop2_enable() error path
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-2-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
 <20260709-dw-hdmi-qp-yuv-v3-2-a4a982a9f2e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:07:12 +0000
Message-Id: <20260708220713.3CF3D1F000E9@smtp.kernel.org>
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
- [High] The patch modifies `vop2_enable()` to return an error code and cle=
anly unwind resources on failure, but fails to update its caller `vop2_crtc=
_atomic_enable()` to check this return value. This converts a resource leak=
 into a critical double-free and system crash.
--

--- Patch [2]: [PATCH v3 02/14] drm/rockchip: vop2: Fix resource leak on vo=
p2_enable() error path ---
commit d8725e1d1e43785d7a93679c9bc6634b3ebd7fab
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Fix resource leak on vop2_enable() error path

vop2_enable() returns void, so callers cannot tell whether powering up
the VOP2 succeeded.

Additionally, if rockchip_drm_dma_attach_device() fails, vop2_enable()
returns without disabling the core clocks or dropping the runtime PM
reference taken earlier, leaking both.

Make vop2_enable() return int and unwind all resources on every failure
path.  As disabling the core clocks is also needed in vop2_disable(),
factor it out into a local helper used by both.

Link: https://lore.kernel.org/all/20260623202043.8BFE21F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 4cce3e336f5b3..e11dc8c7f78ba 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -871,7 +878,7 @@ static void rk3588_vop2_power_domain_enable_all(struc=
t vop2 *vop2)
>  	vop2_writel(vop2, RK3588_SYS_PD_CTRL, pd);
>  }
> =20
> -static void vop2_enable(struct vop2 *vop2)
> +static int vop2_enable(struct vop2 *vop2)
>  {
>  	int ret;
>  	u32 version;

[ ... ]

> @@ -932,6 +938,17 @@ static void vop2_enable(struct vop2 *vop2)
>  		    VOP2_INT_BUS_ERRPR << 16 | VOP2_INT_BUS_ERRPR);
>  	vop2_writel(vop2, RK3568_SYS1_INT_EN,
>  		    VOP2_INT_BUS_ERRPR << 16 | VOP2_INT_BUS_ERRPR);
> +
> +	return 0;
> +
> +err_detach_dma:
> +	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
> +err_disable_clks:
> +	vop2_core_clks_disable_unprepare(vop2);
> +err_put_pm:
> +	pm_runtime_put_sync(vop2->dev);
> +
> +	return ret;
>  }

[Severity: High]
Does this code leave vop2_crtc_atomic_enable() vulnerable to a crash if
vop2_enable() fails?

The newly added error path in vop2_enable() unwinds resources (power and
clocks), invalidating the assumption that the hardware is active.

However, the caller vop2_crtc_atomic_enable() still ignores the return
value:

	if (!vop2->enable_count)
		vop2_enable(vop2);

	vop2->enable_count++;

If vop2_enable() fails (e.g., due to DMA attach failure), it disables the
core clocks and puts the PM runtime.

Because vop2_crtc_atomic_enable() ignores the error, it unconditionally
increments enable_count and proceeds to access VOP2 MMIO registers.

Can this result in a system crash (Synchronous External Abort) due to MMIO
access to unpowered/unclocked hardware, followed by a double-free of PM
runtime and clock resources on teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-dw-hdmi-qp=
-yuv-v3-0-a4a982a9f2e7@collabora.com?part=3D2
