Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29F606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmNqf1Q0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B1610F47F;
	Mon,  9 Nov 2026 17:25:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CAA10F468
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:25:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48F65634BC;
 Mon,  9 Nov 2026 17:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7251F008A2;
 Mon,  9 Nov 2026 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794245148;
 bh=dSYl6TxLdgW/G8UJPzXO2BgovbFJ22Tp7a6zmnpXxWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TmNqf1Q09q2FsyWXEgdEfrnMoIKBJd/9PH5k/TJwmJOv1M2IZFILYJzmKchettP01
 v9WAyhli4wahIsRUhL8i2ZdmdgFCu+ArrEAHFwpafrUfHe5f2Ds9DoclukH7k0QNwW
 X8GxSn3cYYjHrOUfFYzsb2pqETKzQGopiOTeBfjyBJTyIrs3gw+b5R/zUlCHxV+WZD
 aeLImh7TBzOEn8stiREm430JMlyQV4yI7lnDmFcnvwa0lUDeMLIFDb9qqMP7gTVlte
 iAr4za5faWLcs0s6eLazT3OXmEuKgQ6gfuwKHiowuLs46Fks3kKGX0XWZDoADTpVHc
 JPy+SJ76O2tiQ==
Message-ID: <sashiko-outbox-205296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm: avoid an unmatched fbdev IOVA pin
To: "Michael McAllister" <me@michaelmcallister.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
References: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:25:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/msm: VMA close and vma_ref underflow in
  msm_fbdev_driver_fbdev_probe()
--

commit a1a08825c16a09f8d3eedf5784d21f5c50d25613
Author: Michael McAllister <me@michaelmcallister.org>

drm/msm: avoid an unmatched fbdev IOVA pin

This commit replaces msm_gem_get_and_pin_iova() with msm_gem_get_iova() in
msm_fbdev_driver_fbdev_probe() and removes the corresponding
msm_gem_unpin_iova() call from the error path.

> diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fb=
dev.c
> index dd6d6c507d77e..c3bec6719ca04 100644
> --- a/drivers/gpu/drm/msm/msm_fbdev.c
> +++ b/drivers/gpu/drm/msm/msm_fbdev.c
> @@ -137,12 +137,8 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helpe=
r *helper,
>  		goto err_drm_gem_handle_delete;
>  	}
> =20
> -	/*
> -	 * NOTE: if we can be guaranteed to be able to map buffer
> -	 * in panic (ie. lock-safe, etc) we could avoid pinning the
> -	 * buffer now:
> -	 */
> -	ret =3D msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
> +	/* Scanout pins the buffer; only reserve its address here. */
> +	ret =3D msm_gem_get_iova(bo, priv->kms->vm, &paddr);
>  	if (ret) {
>  		drm_err(dev, "failed to get buffer obj iova: %d\n", ret);
>  		goto err_drm_client_buffer_delete;
> @@ -162,7 +158,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper=
 *helper,
>  	fbi->screen_buffer =3D msm_gem_get_vaddr(bo);
>  	if (IS_ERR(fbi->screen_buffer)) {
>  		ret =3D PTR_ERR(fbi->screen_buffer);
> -		goto err_msm_gem_unpin;
> +		goto err_msm_gem_vma_put;
>  	}
>  	fbi->screen_size =3D bo->size;
>  	fbi->fix.smem_start =3D paddr;
> @@ -179,8 +175,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper=
 *helper,
> =20
>  	return 0;
> =20
> -err_msm_gem_unpin:
> -	msm_gem_unpin_iova(bo, priv->kms->vm);
> +err_msm_gem_vma_put:
>  	msm_gem_vma_put(bo);
>  err_drm_client_buffer_delete:
>  	drm_client_buffer_delete(buffer);

[Severity: Medium]
Does calling msm_gem_get_iova() without a matching msm_gem_vma_get() cause
the IOVA reservation to be closed immediately and underflow vma_ref on the
error path?

drm_gem_handle_create() takes the only vma_ref on bo via msm_gem_open(),
and neither drm_client_buffer_create() nor msm_gem_get_iova() increments
vma_ref.  On the normal path, drm_gem_handle_delete() at the end of
msm_fbdev_driver_fbdev_probe() calls msm_gem_close() -> msm_gem_vma_put(),
which drops vma_ref to 0 and calls put_iova_spaces(..., true, "vma_put") to
close the VMA and release the IOVA range stored in fbi->fix.smem_start.

On the error path when msm_gem_get_vaddr() fails, err_msm_gem_vma_put calls
msm_gem_vma_put(bo) and then falls through to drm_gem_handle_delete(),
which calls msm_gem_vma_put(bo) a second time and underflows vma_ref to -1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179424371125.96483.=
2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org?part=3D1
