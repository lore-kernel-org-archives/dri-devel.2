Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF5CC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D2010F349;
	Wed,  2 Sep 2026 20:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VNhGG7qb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D22910F349
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 669BF40BAC;
 Wed,  2 Sep 2026 20:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474A1F000E9;
 Wed,  2 Sep 2026 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788381097;
 bh=WLyR6ChNOMlRe+CSsEvu6PNv1+KHt/AG1uqBK9WJ1Y4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VNhGG7qb2VfwP7KqJKOKYvkCXGWwB8M/OakO8b44IVTe5FTf2PNmwfe0vTI0D04xg
 h1EJrBSMv/g5c8Mzz3ct7aJBS0oBWhzAB+vo5RVidF7/D0PaRJ1JYV0vLS/mEsA/2d
 6lxagA3JM4vbATasiBVMxzj7NTqTf0p6W2swIqsOOgVnunYOfVUl7NanxOtC75RYqw
 MBMm/ntD31mv/PAuifRogEi1v92dsk74qyPB+qhjb2zdWPE+ymc6fMO2JfvJHSnnTE
 ZcF0ZJftYhPjEBg+TocOM/17MPd+H8ZOhGqC/xPqYBUO2XD7PNZuNnuq0mds0pQ8MZ
 Z7NaHPmyOcYNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/11] drm: kmb: Use devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260902201640.2024648-8-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-8-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:31:36 +0000
Message-Id: <20260902203137.1474A1F000E9@smtp.kernel.org>
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
- [High] The return value of kmb_initialize_clocks() is ignored in kmb_hw_i=
nit(), leading to potential hardware hangs.
- [High] Calling drm_atomic_helper_shutdown() after disabling clocks and PM=
 runtime leads to hardware access on a powered-down device and a system han=
g.
- [High] Dereferencing an ERR_PTR during error handling of DSI initializati=
on causes a kernel panic.
--

commit ce6024d25a2085ae8c8a68d80d92293c0cb8ad15
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm: kmb: Use devm_of_reserved_mem_device_init()

This commit updates the driver to use the devres-managed variant of
of_reserved_mem_device_init(), simplifying the error and removal paths by
removing manual cleanup calls.

> diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
> index 7c2eb1152fc2f..88fe377940f30 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.c
> +++ b/drivers/gpu/drm/kmb/kmb_drv.c
> @@ -140,13 +140,12 @@ static int kmb_hw_init(struct drm_device *drm, unsi=
gned long flags)
>  	/* Allocate LCD interrupt resources */
>  	irq_lcd =3D platform_get_irq(pdev, 0);

[Severity: High]
This is a pre-existing issue, but I noticed that just before this hunk in
kmb_hw_init(), the return value of kmb_initialize_clocks() is discarded:

	/* Enable display clocks */
	kmb_initialize_clocks(kmb, &pdev->dev);

	/* Register irqs here - section 17.3 in databook

If kmb_initialize_clocks() fails, the driver proceeds with probe and will
eventually access unclocked MMIO registers during modeset. Can this lead to
synchronous external aborts and system hangs?

[ ... ]

> @@ -465,8 +459,6 @@ static void kmb_remove(struct platform_device *pdev)
>  	pm_runtime_put_sync(drm->dev);
>  	pm_runtime_disable(drm->dev);
> =20
> -	of_reserved_mem_device_release(drm->dev);
> -
>  	/* Release clks */
>  	kmb_display_clk_disable(kmb);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the shutdown sequence
in kmb_remove() cause hardware access on a powered-down device?

Right after this hunk, the function completes with:

	/* Unregister DSI host */
	kmb_dsi_host_unregister(kmb->kmb_dsi);
	drm_atomic_helper_shutdown(drm);
}

Since pm_runtime_disable() and kmb_display_clk_disable() are called prior to
drm_atomic_helper_shutdown(), atomic_disable callbacks will read and write
hardware registers while clocks are disabled. Will this cause a bus fault or
system hang during driver unbind?

[Severity: High]
This is also a pre-existing issue, but outside the diff in kmb_probe(), does
the error handling for kmb_dsi_init() cause an invalid pointer dereference?

If kmb_dsi_init() fails, it returns an ERR_PTR:

	kmb->kmb_dsi =3D kmb_dsi_init(dsi_pdev);
	if (IS_ERR(kmb->kmb_dsi)) {
		drm_err(&kmb->drm, "failed to initialize DSI\n");
		ret =3D PTR_ERR(kmb->kmb_dsi);
		goto err_free1;
	}

The error handling path unconditionally passes this ERR_PTR to
kmb_dsi_host_unregister(), which passes it to kmb_dsi_clk_disable(). This
dereferences the pointer when attempting to access kmb_dsi->clk_mipi:

drivers/gpu/drm/kmb/kmb_dsi.c:kmb_dsi_clk_disable() {
	clk_disable_unprepare(kmb_dsi->clk_mipi);

Will this result in a kernel panic due to dereferencing the ERR_PTR on memo=
ry
allocation failure during initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902201640.2024=
648-1-mukesh.ojha@oss.qualcomm.com?part=3D7
