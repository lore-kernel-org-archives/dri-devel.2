Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF951C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 23:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D8D10F365;
	Wed,  2 Sep 2026 23:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GxBoe/D7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B0410F365
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 23:01:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D8D46022E;
 Wed,  2 Sep 2026 23:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29E61F000E9;
 Wed,  2 Sep 2026 23:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788390107;
 bh=2xxJ3vXyS2cx7QfAvvt1AgbxxFY+sQkBBJ+l79+1XpM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GxBoe/D71YkQcoe7v+oSvbiJ6Wa9KB2aaxZ6x3KJSGldBmXP359FJw9aGrqw1UUAv
 FD37s64fNPjJC+hNbdLLCAeiKvfWXh0qb8L0sPGpJfhFmKpmAnGm+xURnetdMlTr4A
 fV/YF8UNPt1Dg/6saLaHxJb1uhMdmNtlBcnBngZBl922WPyPa0zompDaSdgkn4iivH
 Tzw4qqPr8X9Qvo0t74iB7TJNzLTlNkuR9mlIorbaVtD64e0ZQyRXR0oKoeD/7PrrBt
 Z7t8i14wMaYaS4sDLhtw7f709SX3A8+P5S3B5Sn4r0syoHwaQquxtSsRZIzDTm3kJS
 +CMNyHSuu0mVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/14] drm/rockchip: vop2: Consolidate HDMI PHY PLL
 clock parent switch
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260903-dw-hdmi-qp-yuv-v4-9-fb45bf4147eb@collabora.com>
References: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
 <20260903-dw-hdmi-qp-yuv-v4-9-fb45bf4147eb@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:01:46 +0000
Message-Id: <20260902230146.C29E61F000E9@smtp.kernel.org>
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
- [High] Sleeping functions clk_set_parent() and mutex_lock() called from C=
RTC atomic enable callback.
--

commit afbd808f729085c5fb27d8d2795c3ac8b9bd1609
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Consolidate HDMI PHY PLL clock parent switch

This commit refactors the DCLK parent switch logic for HDMI0 and HDMI1
PHY PLLs into a single shared code path instead of repeating the parent
selection and clock switch for each endpoint.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1964,42 +1964,34 @@ static void vop2_crtc_atomic_enable(struct drm_cr=
tc *crtc,
[ ... ]
> +		if (pll_hdmiphy) {
> +			if (!vp->dclk_src)
> +				vp->dclk_src =3D clk_get_parent(vp->dclk);
> +
> +			ret =3D clk_set_parent(vp->dclk, pll_hdmiphy);

[Severity: High]
This is a pre-existing issue, but does calling clk_set_parent() in this
function violate atomic context rules?

The vop2_crtc_atomic_enable() callback runs in an atomic context during a
display modeset, where sleeping is strictly forbidden by DRM subsystem
guidelines.=20

Because clk_set_parent() might sleep, could this lead to system instability,
potential deadlocks, or kernel warnings when reconfiguring the display?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-dw-hdmi-qp=
-yuv-v4-0-fb45bf4147eb@collabora.com?part=3D9
