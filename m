Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AC7C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C265110F34D;
	Wed,  2 Sep 2026 20:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UKR0oxsE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0F610F34D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:35:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC516601EF;
 Wed,  2 Sep 2026 20:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3E11F000E9;
 Wed,  2 Sep 2026 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788381339;
 bh=PxHB2HwsqAP6BSC9LExwzxr7NZTZnEg/EtVrzdf3vAM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UKR0oxsEfSobYydxOT0ECQMywVY0PrfwzfAqL1RHpC8KXZcNLCnftMwgQCv8sGwzN
 vVbERzW5dDK75IuzXekK1IPvfP97sO/ImIemVN/MylfwsKVHBrGBEtNKoIBAmLAwxp
 SCcccY0ZgWbCbX1qzp86lxJG+azBLi/h5kVX6kXUCyNEaJaOkzeW8fPZ6vSoLr7ELI
 M3ssQCLvDUZsCv46zgN0/xsrQUZe5IdTzUIlEzvFXWefxl4BOB6Hx9p6mxIMfo5pB2
 6+Wz9YCb3UpY73ANdDv+l2tFYjWeZfDVsaZ9aWGqkAfnOXG9fPJq8imSWn652BokMG
 6fAg3sAttkIRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] drm: aspeed: Use
 devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260902201640.2024648-11-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-11-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:35:38 +0000
Message-Id: <20260902203539.6F3E11F000E9@smtp.kernel.org>
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
- [High] Using devm_of_reserved_mem_device_init ties the reserved memory re=
lease to the physical device unbind, which executes before DRM GEM objects =
are freed. This leads to a kernel panic in dma_free_wc() during driver unlo=
ad or when userspace closes the device.
--

commit af4228b344b701076f4bd88aa57c810ff4e26c48
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm: aspeed: Use devm_of_reserved_mem_device_init()

This commit replaces of_reserved_mem_device_init() with the devres-managed
devm_of_reserved_mem_device_init() to ensure the reserved memory region is
released on device removal.

> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/as=
peed/aspeed_gfx_drv.c
> index d4577663a1f0e..2c7e54fc35d93 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -168,7 +168,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
>  		}
>  	}
> =20
> -	ret =3D of_reserved_mem_device_init(drm->dev);
> +	ret =3D devm_of_reserved_mem_device_init(drm->dev);

[Severity: High]
Will tying the reserved memory release to the physical device unbind phase
cause a kernel panic if a user holds an open DRM file descriptor?

The devm_of_reserved_mem_device_init() cleanup runs when the platform device
unbinds, calling of_reserved_mem_device_release() which clears dev->dma_mem.

However, if userspace holds an open DRM file descriptor, the DRM device and
its GEM objects outlive the platform device's devres cleanup phase. When the
user eventually closes the file descriptor, the GEM objects are freed.

At that point, drm_gem_dma_free() calls dma_free_wc(), which relies on
dev->dma_mem to identify the reserved memory pool. Since dev->dma_mem was
already cleared during the unbind devres cleanup, it falls back to the syst=
em
page allocator, which results in a kernel panic.

>  	if (ret) {
>  		dev_err(&pdev->dev,
>  			"failed to initialize reserved mem: %d\n", ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902201640.2024=
648-1-mukesh.ojha@oss.qualcomm.com?part=3D10
