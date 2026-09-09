Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B58C79FBB
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9847C10F29B;
	Wed,  9 Sep 2026 21:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PPzmB6R7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F63010F29B
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 21:14:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5929A40DB2;
 Wed,  9 Sep 2026 21:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAF21F00893;
 Wed,  9 Sep 2026 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788988496;
 bh=ASjALnlFNmENHxUj62/PYXs6J8TCqZKdXDOELEbvsVk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PPzmB6R7vU+GSI33AKU2fGqrqc4urs87QFJZZMAlOew6nhddTW2xKIeL1Ifko0AcN
 QU6LijlA6I8QJ0oufCrv+b49nN4qgY3RL1o3Ug/ZKBlAw83BblVR9d99fTaCuz+VAL
 uabK9gUVWdNktW6H8+c/l7f+X0RVCr6hzMoME2RXh6DIeSk5BieQRwU+vMTen6nBWK
 a3B2Ob1CLGcWNJc6uH2CXF90o21PeOdaborQ974mWqyN2sAHM+LB/Cv86uu+7QK772
 PyxVCGUvWDnuyE9P2nUcvcjeimQAp3TMEHmVaFpln7QBxI7qGIfShpfvSBRY+EVFzy
 6k5RERuzeHHIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mxsfb: lcdif: Fix use-after-free on unbind
To: "Fabio Estevam" <festevam@gmail.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260909210213.946159-1-festevam@gmail.com>
References: <20260909210213.946159-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 21:14:55 +0000
Message-Id: <20260909211456.0DAF21F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmapped MMIO Access (Hot-unplug protection)
- [High] Missing Error Handling for pm_runtime_get_sync
--

commit 66de576415540b0c76cf173d95116edc4c840ef4
Author: Fabio Estevam <festevam@gmail.com>

drm/mxsfb: lcdif: Fix use-after-free on unbind
   =20
This patch fixes a use-after-free issue during LCDIF unbind by allocating
the DRM private data and encoders using drmm APIs instead of devres. This
ensures the DRM objects remain alive until mode config cleanup completes.

> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index e2173c4d6fc28..7e9f3b205a458 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c

[ ... ]

While reviewing this patch, I noticed a couple of related pre-existing issu=
es
in drivers/gpu/drm/mxsfb/lcdif_kms.c:

> drivers/gpu/drm/mxsfb/lcdif_kms.c:lcdif_crtc_atomic_enable() {
> 	...
> 	clk_set_rate(lcdif->clk, m->clock * 1000);
>=20
> 	pm_runtime_get_sync(drm->dev);
>=20
> 	lcdif_crtc_mode_set_nofb(new_cstate, new_pstate);
> 	...
> }

[Severity: High]
This is a pre-existing issue, but the return value of pm_runtime_get_sync()
is ignored here.

If this call fails (due to a hardware fault or intermediate PM state), the
driver unconditionally proceeds to execute lcdif_crtc_mode_set_nofb(), which
writes to hardware registers. Can this lead to a kernel panic (Synchronous
External Abort) by accessing unpowered hardware registers?


> drivers/gpu/drm/mxsfb/lcdif_kms.c:lcdif_plane_primary_atomic_update() {
> 	...
> 	paddr =3D drm_fb_dma_get_gem_addr(new_pstate->fb, new_pstate, 0);
> 	if (paddr) {
> 		writel(lower_32_bits(paddr),
> 		       lcdif->base + LCDC_V8_CTRLDESCL_LOW0_4);
> 		writel(CTRLDESCL_HIGH0_4_ADDR_HIGH(upper_32_bits(paddr)),
> 		       lcdif->base + LCDC_V8_CTRLDESCL_HIGH0_4);
> 	}
> }

[Severity: High]
This is a pre-existing issue, but could this access the lcdif->base MMIO
region after it has been unmapped by devres?

If a privileged user unbinds the driver via sysfs but a userspace process
keeps the DRM device open, drm_dev_unregister() is called but
drm_dev_unplug() is not. Because drm_dev_is_unplugged() would return false,
an ioctl like DRM_IOCTL_MODE_ATOMIC could still execute and trigger
lcdif_plane_primary_atomic_update(). Would this result in a synchronous
abort/kernel panic when accessing the unmapped memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909210213.9461=
59-1-festevam@gmail.com?part=3D1
