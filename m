Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60B8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5558D10E5C6;
	Wed,  8 Jul 2026 12:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g4oreEBo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4201810E5C6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:02:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE8E04041D;
 Wed,  8 Jul 2026 12:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C6D1F000E9;
 Wed,  8 Jul 2026 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783512171;
 bh=Lxo8Kflpb/SV1Zp2TsX5UsCEFi+to1KfEkXqRADBu5s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g4oreEBozYUy33y0YKcSUykLnBIwApGDiz/X+8dTbH7AsE1WeMK2yNLSjwnGUkYzE
 ZdI+nIBpj426CRmVux3t/URPOJhx2u1tMN0+TQYNotuhSfNO90/nsnUzDrgrP4XVFa
 nhyQVQ0FmBEJzKlchF+uf2anni8lOEkYQcvreYfPYLg1/ZM7XgDqVqlO/TRaVuleWS
 Umzxkqs4kyvxUZhtIJqO5aEoyXdNq9J5AVoZhNevPzzn5gi6G+LahZbwDtm2WVud7D
 UReeVQSj4ZlDXTOcycXDVoUVtBcSgbw/S8h2t+wZdqBBMkhWUEuAr3R9SQF60iHNY4
 1v80vTr9PsYXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: put IOMMU domain on BO creation failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708114354.753817-1-lgs201920130244@gmail.com>
References: <20260708114354.753817-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 12:02:51 +0000
Message-Id: <20260708120251.87C6D1F000E9@smtp.kernel.org>
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
- [Critical] Integer overflow in `iommu_map_sgtable()` return value check c=
auses >=3D 2GB BO creations to fail and leak IOMMU mappings.
- [High] The `rocket_gem_bo_free` function accesses `bo->driver_priv`, lead=
ing to a Use-After-Free if the GEM object outlives the `drm_file`.
--

--- Patch [1]: [PATCH] accel/rocket: put IOMMU domain on BO creation failur=
e ---
commit cee2a8e5b9e315a984b6639a6737db57bbbb72ca
Author: Guangshuo Li <lgs201920130244@gmail.com>

accel/rocket: put IOMMU domain on BO creation failure

The BO creation error paths free the object with drm_gem_shmem_object_free(=
),=20
which bypasses the driver's GEM .free callback and releases the shmem objec=
t=20
without dropping the IOMMU domain reference. This commit drops the domain=20
reference explicitly on the BO creation error path.

> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index a5fffa51ff355..438694ba567b9 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -127,6 +127,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, vo=
id *data, struct drm_file *
>  	mutex_unlock(&rocket_priv->mm_lock);
> =20
>  err:

[Severity: Critical]
This is a pre-existing issue, but does the return value check for
iommu_map_sgtable() earlier in this function have an integer overflow?

Because iommu_map_sgtable() returns a ssize_t, and rocket_ioctl_create_bo()
stores this in a 32-bit signed int "ret", a mapping of 2GB or more would
result in a negative value.

When this happens, the check evaluates to true:

	ret =3D iommu_map_sgtable(rocket_priv->domain->domain, ...);
	if (ret < 0 || ret < args->size) {
		drm_err(dev, "failed to map buffer...");
		ret =3D -ENOMEM;
		goto err_remove_node;
	}

This incorrectly triggers the error path and bypasses the err_unmap label,
leaving the IOMMU mapping active while freeing the IOVA and physical pages.
Could this allow arbitrary physical memory access if the device is instruct=
ed
to perform DMA to the freed IOVA?

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk in
rocket_gem_bo_free()?

If a user exports the GEM object to a DMA-BUF using generic PRIME ioctls
and then closes the DRM file descriptor, the rocket_file_priv is freed.

When the DMA-BUF is later closed, the GEM object's refcount drops to zero,
invoking rocket_gem_bo_free(). This attempts to access the freed memory:

rocket_gem_bo_free() {
	...
	struct rocket_file_priv *rocket_priv =3D bo->driver_priv;
	...
}

Could this lead to accessing a freed lock when attempting to lock
rocket_priv->mm_lock?

> +	rocket_iommu_domain_put(rkt_obj->domain);
> +	rkt_obj->domain =3D NULL;
>  	drm_gem_shmem_object_free(gem_obj);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708114354.7538=
17-1-lgs201920130244@gmail.com?part=3D1
