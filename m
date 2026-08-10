Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690AAC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C816F10E8E7;
	Mon, 10 Aug 2026 15:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FXJL9lal";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF92110E231
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:02:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A89A8416C5;
 Mon, 10 Aug 2026 15:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F301F00A3D;
 Mon, 10 Aug 2026 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786374142;
 bh=lSUxke8DpL6AHLnr3xW6roBkc2fszgvn0DLFtdKHWIc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FXJL9lalsNgEcJMMtcXMZPbJ5s4U3jljvHuOJXiIalVU6drQIVyh2fkCQgo2tRJP4
 DBOD8q9JKzLIuBUQvHbfy9PdTP+XjyrZ5hcWOUYVgl+WpCRYh7Bf6UxTLgVyynrQYG
 QEOBSpqeqY7CihJ2yF1wXOayL4/xVgHNP0aEaUpCHnOJ6hcKNTXrAWuSzrAzT+wsj1
 PrLmHbocHoPs2tmAaMNPtqmvvofQBXck/qCWkmchdYr6YlEkBs0JVA0Lc+2dya8AaF
 3dNDPSjOzAeMEdm+3uyOYRmrzyrt+2bf6T3Iawi1b9lclq9OloX9qoOfyl05+OhPFv
 fCtS3IjAVss6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/imx: ipuv3-plane: add the pixel blend mode
 property
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260810-imx53-fix-hdmi-v1-2-fff9b1b17f25@oss.qualcomm.com>
References: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
 <20260810-imx53-fix-hdmi-v1-2-fff9b1b17f25@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:02:21 +0000
Message-Id: <20260810150222.54F301F00A3D@smtp.kernel.org>
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
- [High] Plane atomic update callback calls functions that acquire a sleepi=
ng lock (mutex).
--

--- Patch [2]: [PATCH 2/4] drm/imx: ipuv3-plane: add the pixel blend mode p=
roperty ---
commit 166d0e9ef492a9f6b268953776bb8c6c929a2acc
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/imx: ipuv3-plane: add the pixel blend mode property

This commit adds a pixel blend mode property to IPUv3 planes. It configures
the planes to support coverage or none based on whether they are part of a
DP flow, and uses this blend mode to decide between global and per-pixel
alpha during plane updates.

> diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/im=
x/ipuv3/ipuv3-plane.c
> index a0fd39eebbbc2..bde5892264f4a 100644
> --- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> +++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c

[ ... ]

> @@ -593,8 +621,8 @@ static void ipu_plane_atomic_update(struct drm_plane =
*plane,
>  	case IPU_DP_FLOW_SYNC_BG:
>  		if (new_state->normalized_zpos =3D=3D 1) {
>  			ipu_dp_set_global_alpha(ipu_plane->dp,
> -						!fb->format->has_alpha, 0xff,
> -						true);
> +						!ipu_plane_use_pixel_alpha(new_state),
> +						0xff, true);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
ipu_dp_set_global_alpha() from the atomic update callback?

The DRM core invokes ipu_plane_atomic_update() in an atomic context
where sleeping is forbidden. However, ipu_dp_set_global_alpha()
unconditionally acquires a sleeping lock:

drivers/gpu/ipu-v3/ipu-dp.c:ipu_dp_set_global_alpha() {
	...
	mutex_lock(&priv->mutex);
	...
}

Could this trigger kernel warnings or deadlocks if the thread is scheduled
out while executing in a non-blocking DRM atomic commit phase?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-imx53-fix-=
hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com?part=3D2
