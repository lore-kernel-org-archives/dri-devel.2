Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C172ECDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C29A10E061;
	Wed, 24 Jun 2026 09:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UqyO2Vop";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624A410E061
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:15:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B35460138;
 Wed, 24 Jun 2026 09:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399AC1F00A3A;
 Wed, 24 Jun 2026 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782292546;
 bh=jnDWOhZaOD0rbEad5COU0E1pZqkGq3hp66Pmfb7QUuA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UqyO2Vopm8MOpXiMoe3Bc2M7EEvnfk9MIvL8QE39dJZ4foKinHTUkHrIiRVWB37bJ
 U5TE7q8fSomnWdQ4z2Cd0RFY20pmg9XbzPNZ2ddwlalL92EffDNvXlEg6PG9n64kwa
 jC3n74n81ya1FVA6DxaAbQ36YRmgMMVsLL3+0ACXlKvoQ68QqaevHuuaqddXii9FW4
 WeTcrWycT2LsukBy3ICKOsWwxP0ue/5Gv90UQdCfE6B5UKAK6L1WRsYmH6/FCV/lAW
 w9qf562hHyUgDcqa+X34aO3i352Lg0N5Bm0fF7sBL8/rG0XMulfUo+f7UduYnmxTZQ
 t9jidQPfHes8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/adp: Free FE IRQ on bind failure
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624090050.87051-1-mhun512@gmail.com>
References: <20260624090050.87051-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:15:45 +0000
Message-Id: <20260624091546.399AC1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling drmm_* initializations inside the component bind callback =
leads to memory leaks and DRM structure corruption if bind fails and is ret=
ried.
- [High] Calling dma_alloc_coherent() with GFP_KERNEL in an atomic context.
- [High] Missing NULL check for the return value of dma_alloc_coherent().
- [High] adp_drm_gem_dumb_create modifies height after validation, causing =
a 32-bit integer overflow and undersized buffer allocation.
--

commit 8a1bec26bfe0bb63ece93f656fc4dc72b509f897
Author: Myeonghun Pak <mhun512@gmail.com>

drm/adp: Free FE IRQ on bind failure

adp_drm_bind() requests the front-end IRQ before registering the DRM
device. If drm_dev_register() fails, the function returns immediately
and leaves the IRQ handler registered.

> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
> index ce9dd6222634d..b7fc456043f34 100644
> --- a/drivers/gpu/drm/adp/adp_drv.c
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -533,9 +533,13 @@ static int adp_drm_bind(struct device *dev)
> =20
>  	err =3D drm_dev_register(&adp->drm, 0);
>  	if (err)
> -		return err;
> +		goto err_free_irq;
> =20
>  	return 0;
> +
> +err_free_irq:
> +	free_irq(adp->fe_irq, adp);
> +	return err;
>  }

[Severity: High]
This is a pre-existing issue, but does calling drmm_ initializations inside
the component bind callback lead to memory leaks if bind fails here?

The drm_device is allocated in probe with devm_, so it persists across bind
retries:

drivers/gpu/drm/adp/adp_drv.c:adp_probe() {
    ...
	adp =3D devm_drm_dev_alloc(&pdev->dev, &adp_driver, struct adp_drv_private=
, drm);
    ...
}

But adp_drm_bind() calls adp_setup_mode_config(), which initializes drmm_
resources:

drivers/gpu/drm/adp/adp_drv.c:adp_drm_bind() {
    ...
	err =3D adp_setup_mode_config(adp);
    ...
}

If a later step in bind fails (such as drm_dev_register()) and bind is
retried, will re-running drmm_mode_config_init() on the same drm_device
re-initialize dev->mode_config mutexes and IDRs without destroying the old
ones, leading to memory leaks and corruption?

[Severity: High]
This is a pre-existing issue, but is it safe to use GFP_KERNEL in the atomic
commit tail path?

drivers/gpu/drm/adp/adp_drv.c:adp_crtc_atomic_flush() {
    ...
		if (new_size !=3D 0) {
			adp->mask_buf =3D dma_alloc_coherent(crtc->dev->dev, new_size,
							   &adp->mask_iova, GFP_KERNEL);
			memset(adp->mask_buf, 0xFF, new_size);
			writel(adp->mask_iova, adp->be + ADBE_MASK_BUF);
		}
    ...
}

Since adp_crtc_atomic_flush() is part of the atomic commit pipeline, it runs
in an atomic context where sleeping is forbidden.

Does calling dma_alloc_coherent() with GFP_KERNEL here allow the function to
sleep, causing kernel warnings or deadlocks?

[Severity: High]
This is a pre-existing issue, but is there a missing NULL check for the
return value of dma_alloc_coherent() here?

drivers/gpu/drm/adp/adp_drv.c:adp_crtc_atomic_flush() {
    ...
			adp->mask_buf =3D dma_alloc_coherent(crtc->dev->dev, new_size,
							   &adp->mask_iova, GFP_KERNEL);
			memset(adp->mask_buf, 0xFF, new_size);
    ...
}

If memory is exhausted and dma_alloc_coherent() returns NULL, will the
immediate memset() cause a NULL pointer dereference?

[Severity: High]
This is a pre-existing issue, but does aligning args->height after validati=
on
cause an integer overflow?

drivers/gpu/drm/adp/adp_drv.c:adp_drm_gem_dumb_create() {
    ...
	args->height =3D ALIGN(args->height, 64);
	args->size =3D args->pitch * args->height;

	return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
}

If userspace requests dimensions that pass the core drm_mode_create_dumb()
checks but overflow when args->height is increased, will the 32-bit
multiplication in drm_gem_dma_dumb_create_internal() wrap around?

Could this result in an undersized DMA buffer allocation that allows
out-of-bounds memory accesses when userspace maps and writes to it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624090050.8705=
1-1-mhun512@gmail.com?part=3D1
