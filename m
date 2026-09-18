Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E72C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 03:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA59E10F14D;
	Fri, 18 Sep 2026 03:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A/Ued68j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180CB10F14D
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:12:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF1DB600AA;
 Fri, 18 Sep 2026 03:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7058F1F000FF;
 Fri, 18 Sep 2026 03:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789701122;
 bh=sgQfCkPRWWK+FybalF8pgOWHGJEjtz/k8VSRJa/Hg3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A/Ued68jfEmPUqBF1LjwjteqktCDZgnXZKOGFibt2nJ4srMm++i8zXkJUvfafsJRM
 Di5HpGxfCuFXelmCp/a40iD7lDPQpkga6P6YMujtyrBfV1Oe68ftLJYIj017x5XTI4
 eyxHsIo1PZd3+csDGM/cj09pqeWkgAE4MVwifyA95DBthO/Vwvs4uUoWYEfufWWere
 zyU4jLUWFjQxMkAjDezxgUmgAuRnuzFOECwgsicQO8lIWMKRO2eZ/QNxw5NCYigqvP
 nBZGsVGAA4UYQhnpQ6dPScGJMux44VEf52uaXyBupnV5CaDmN+NjvuctW3x0oXrF6m
 MKuSSuzB4p/yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/7] drm/verisilicon: introduce per-variant hardware
 ops table
To: "Joey Lu" <a0987203069@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260918030125.315978-4-a0987203069@gmail.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
 <20260918030125.315978-4-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:12:02 +0000
Message-Id: <20260918031202.7058F1F000FF@smtp.kernel.org>
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
- [High] drm: access after clock disable in vs_crtc_atomic_disable()
--

commit 4d2b1621cdee94c9390817d0548d0b254e003aa6
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: introduce per-variant hardware ops table

This commit introduces a per-variant hardware operations table (vs_dc_funcs)
for the Verisilicon display controller driver. It extracts DC8200-specific
hardware operations and updates shared code to dispatch through this vtable
to better support different hardware variants.

> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/veri=
silicon/vs_crtc.c
> index c24c1588cbe69..6033662dd9221 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c

[ ... ]

> @@ -30,6 +53,9 @@ static void vs_crtc_atomic_disable(struct drm_crtc *crt=
c,
>  	drm_crtc_vblank_off(crtc);
> =20
>  	clk_disable_unprepare(dc->pix_clk[output]);
> +
> +	if (dc->funcs->crtc_disable_ex)
> +		dc->funcs->crtc_disable_ex(dc, output);

[Severity: High]
Does this access hardware registers after their clock is gated?

In vs_crtc_atomic_disable(), the pixel clock is disabled via
clk_disable_unprepare() just before calling the hardware-specific disable
hook crtc_disable_ex(). If the hook accesses the hardware block after its
clock is already powered down, it typically leads to asynchronous external
aborts, system hangs, or MMIO bus faults.

Should the clock be kept enabled until after crtc_disable_ex() finishes,
similar to how vs_crtc_atomic_enable() properly enables the clock before
calling crtc_enable_ex()?

>  }
> =20
>  static void vs_crtc_atomic_enable(struct drm_crtc *crtc,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918030125.3159=
78-1-a0987203069@gmail.com?part=3D3
