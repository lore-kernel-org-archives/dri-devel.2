Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE29C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065B010E24F;
	Fri, 14 Aug 2026 02:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TarucEJN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFB710E24F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:57:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4130E402F3;
 Fri, 14 Aug 2026 02:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA481F00A3D;
 Fri, 14 Aug 2026 02:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786676240;
 bh=w1o9ejSufhAvkHKQy2NsqEli+eF6Y1fVNR66fYFqlI8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TarucEJN8TqUOgjuJ1TpITAdss9aqM0L60z6Nlav+tFEa2KjbKprL5o0fsekzod5w
 44gSxxyMTgATLKmH4SicTi1yGJZ30aHbtA1/cmbRk7sLuyB1V5Y0eVNTYe+5L4QkTA
 NjPlFsvk5gfmEG0syby+yTBdDdvPwRfAaQ2/RS67ZsybAxnOEQKzNqCSTdRxeCC4k+
 Inz6jbwQ+4pKrgsZwg8iMBdfluhhixb/zrt+O/DTtJJDEif4mnQ3S0i309+XnGgZKl
 /mZ63FWjpGMnlW8dRqiOwzmIDZWVeJKAcMgrT/TNd+XQ27oKizA+4L/lYFA1bRypBv
 8kI0BDjOR/DOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] accel/rocket: Fix the IOMMU domain leak in
 rocket_ioctl_create_bo
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814022453.437-2-kernel@airkyi.com>
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:57:19 +0000
Message-Id: <20260814025720.0FA481F00A3D@smtp.kernel.org>
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
- [Critical] The return value of `iommu_map_sgtable` (`ssize_t`) is stored =
in an `int`, causing an overflow to a negative value for BOs of 2GB or larg=
er, leading to a massive IOMMU mapping leak.
- [High] In `rocket_ioctl_prep_bo`, `dma_sync_sgtable_for_cpu` is called un=
conditionally even if `dma_resv_wait_timeout` fails with a timeout or error.
- [High] The per-file `rocket_priv` context is freed on file close, but GEM=
 objects can outlive the file descriptor, causing a Use-After-Free when the=
y are eventually destroyed.
--

--- Patch [1]: [PATCH 1/4] accel/rocket: Fix the IOMMU domain leak in rocke=
t_ioctl_create_bo ---
commit ea4421559353add8c0bf8f5cce3e937cd76171d8
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

accel/rocket: Fix the IOMMU domain leak in rocket_ioctl_create_bo
   =20
When rocket_ioctl_create_bo fails, rocket_iommu_domain_put should be
called to avoid an IOMMU domain leak.

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
> +	rocket_iommu_domain_put(rkt_obj->domain);
> +	rkt_obj->domain =3D NULL;
>  	drm_gem_shmem_object_free(gem_obj);
> =20
>  	return ret;

[Severity: Critical]
This is a pre-existing issue, but does rocket_ioctl_create_bo() in=20
drivers/accel/rocket/rocket_gem.c truncate the return value of
iommu_map_sgtable() to a signed integer?

	ret =3D iommu_map_sgtable(rocket_priv->domain->domain,
				rkt_obj->mm.start,
				shmem_obj->sgt,
				IOMMU_READ | IOMMU_WRITE);
	if (ret < 0 || ret < args->size) {

If a user requests a buffer size of 2 GiB, iommu_map_sgtable() successfully
maps it and returns 2147483648 (0x80000000) as ssize_t. Is this truncated
into the local int ret, becoming -2147483648, which triggers the ret < 0
check? This would wrongly treat success as failure, bypass the IOMMU unmap
logic, and leak the IOMMU mappings for the freed backing pages.

[Severity: High]
This isn't a bug introduced by this patch, but can the per-file
rocket_priv context be freed while exported GEM objects still exist?

When a userspace client creates a GEM object, exports it, and then closes
its DRM file descriptor, rocket_postclose() in
drivers/accel/rocket/rocket_drv.c destructs rocket_priv:

	mutex_destroy(&rocket_priv->mm_lock);
	drm_mm_takedown(&rocket_priv->mm);
	rocket_iommu_domain_put(rocket_priv->domain);
	kfree(rocket_priv);

Later, when the final reference to the exported GEM object is dropped, would
rocket_gem_bo_free() in drivers/accel/rocket/rocket_gem.c dereference the
freed rocket_priv?

	mutex_lock(&rocket_priv->mm_lock);
	drm_mm_remove_node(&bo->mm);
	mutex_unlock(&rocket_priv->mm_lock);

This could lead to a use-after-free since the GEM object outlives the file
descriptor.

[Severity: High]
This is a pre-existing issue, but does rocket_ioctl_prep_bo() in
drivers/accel/rocket/rocket_gem.c unconditionally sync the buffer even if
the wait fails?

	ret =3D dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_WRITE, true, t=
imeout);
	if (!ret)
		ret =3D timeout ? -ETIMEDOUT : -EBUSY;
	else if (ret > 0)
		ret =3D 0;

	shmem_obj =3D &to_rocket_bo(gem_obj)->base;

	dma_sync_sgtable_for_cpu(dev->dev, shmem_obj->sgt, DMA_BIDIRECTIONAL);

If dma_resv_wait_timeout() fails due to a timeout or interrupted wait
and returns a negative error code, the code continues executing without
an early return. Could this lead to data corruption since
dma_sync_sgtable_for_cpu() is invoked while the GPU may still be actively
writing to the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814022453.437-=
1-kernel@airkyi.com?part=3D1
