Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5C0C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9192089DFF;
	Wed,  2 Sep 2026 20:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OIsmR0iT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80E510F350
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:35:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8231C41A0C;
 Wed,  2 Sep 2026 20:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304C21F000E9;
 Wed,  2 Sep 2026 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788381350;
 bh=9dG+CbzWCVcMgSvx9yQ3EHVPegU1kj1nZCrPwx+SEfY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OIsmR0iTM7oVclXMC3ha44K51G2lDPmK1g2UPXIUxQRG6DUE0VVcfdlN8PuN1H2DO
 Iu+ODOBuKD9TsleEi3Atr39IgwELALZOfQI3/9dxIZwXZUgtgJRXKRuNRFs52CaV/Y
 eiBCj7BdJNYUCg7xS84LdFStSLlYaiXOJHfe7WMwwWyXklQUIxXWxg2qziuX1Xeks6
 JsEvCXS8yvFgJj/mSNEArJPT4/Fq9HunpH70P2WFdLlxY89G3pdWRDGoRmTK2kEZSZ
 MXmIg/dKSldvTEGQHbRE4yQ8UwlWCZSNu1u+pNKMI/W2GpHz5D/zZcykesWh/Z1gOc
 s4AYH9P5pbvKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/11] drm: malidp: Use
 devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260902201640.2024648-6-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-6-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:35:49 +0000
Message-Id: <20260902203550.304C21F000E9@smtp.kernel.org>
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
- [High] Permanent CMA capacity leak due to clearing dev->cma_area before G=
EM objects are freed during device unbind.
--

commit a1f947cbe50ede0e9b650dcb9e31cc36cb85952d
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm: malidp: Use devm_of_reserved_mem_device_init()

This commit simplifies the driver by transitioning to the devres-managed
devm_of_reserved_mem_device_init(), removing manual cleanup calls during
bind failures and unbind.

> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malid=
p_drv.c
> index 23fa942ae4bbe..3e17513c31147 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -758,7 +758,7 @@ static int malidp_bind(struct device *dev)
>  		return PTR_ERR(hwdev->pxlclk);
> =20
>  	/* Get the optional framebuffer memory resource */
> -	ret =3D of_reserved_mem_device_init(dev);
> +	ret =3D devm_of_reserved_mem_device_init(dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this devres conversion
preserve a pre-existing CMA memory capacity leak during device unbind?

In malidp_bind(), devm_drm_dev_alloc() is called before this initialization
function. Because devres actions execute in reverse order of allocation, the
cleanup action registered here will execute before the drm_dev_put() action.

When malidp_unbind() returns, the component framework immediately releases
the component's devres group, clearing dev->cma_area. Later, when the DRM
device is freed (either immediately or when userspace eventually closes its
file descriptors), drm_gem_object_free() calls dma_free_contiguous().

Because dev->cma_area is already NULL at that point, it bypasses
cma_release() and falls back to the buddy allocator, permanently leaking
the CMA region's bitmap capacity.

The previous code suffered from this exact same ordering issue since the
manual of_reserved_mem_device_release() call happened before drm_dev_put()
ran. Is there a way to adjust the cleanup order so the CMA area outlives
the GEM objects?

>  	if (ret && ret !=3D -ENODEV)
>  		return ret;
> =20

[ ... ]
> @@ -913,7 +912,6 @@ static void malidp_unbind(struct device *dev)
>  	else
>  		malidp_runtime_pm_suspend(dev);
>  	dev_set_drvdata(dev, NULL);
> -	of_reserved_mem_device_release(dev);
>  }
> =20
>  static const struct component_master_ops malidp_master_ops =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902201640.2024=
648-1-mukesh.ojha@oss.qualcomm.com?part=3D5
