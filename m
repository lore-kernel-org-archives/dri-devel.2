Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA807C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06D610F418;
	Fri, 28 Aug 2026 16:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NC8XcJbR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0B810F418
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 16:05:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 919204381A;
 Fri, 28 Aug 2026 16:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A171F000E9;
 Fri, 28 Aug 2026 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787933115;
 bh=PV62CvgK0YRvRNi3zJrwnIzDYqn+siVy54jqUkXp0ww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NC8XcJbRk8js7TjwHtDog2XqUqdo9wGCggY3RcyM7je9Y2Og92n0/me4YEGTKkjtZ
 rroBj5U+stO4sDQGWqqYYVvn0A5malqL0neVBwYXXqZEG0OuvDQcbFyPvSgZJBP1fi
 8AR8fnHmAcT+I0rAi5kR8xO9FqeFcKKE72GLA9KlxovHyy/edI3pFJirEg6e/hBAjC
 CrQ4CZEsYRHhsz1sNRfsGAgWvRZeeyvOXNTMYY6ji8+/AKSFOCQQUx7Ar8FgKdhXri
 rhWuG6vxQJ+A9zVWhrxLqRgKMwXVBVhcY/Rsgei1aWWdGpYDtWafzcV6yx/7Yr3pe6
 iM5D8lm730Qvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] ARM: dts: microchip: sam9x60: Add GFX2D GPU
To: "Cyrille Pitchen" <cyrille.pitchen@microchip.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-cpitchen-mainline_gfx2d-v8-3-378374559738@microchip.com>
References: <20260828-cpitchen-mainline_gfx2d-v8-0-378374559738@microchip.com>
 <20260828-cpitchen-mainline_gfx2d-v8-3-378374559738@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:05:14 +0000
Message-Id: <20260828160515.30A171F000E9@smtp.kernel.org>
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
- [High] Potential Use-After-Free of GEM object in mchp_gfx2d_ioctl_alloc_b=
uffer().
- [High] mchp_gfx2d_ioctl_sync_for_gpu() improperly uses flush_cache_range(=
) with a detached, memcpy'd VMA.
- [High] The driver fails to restore essential hardware registers upon retu=
rning from system sleep.
- [Medium] mchp_gfx2d_ioctl_sync_for_cpu() fails to invalidate the CPU cach=
e for non-coherent buffers.
--

commit 9a29a32449f034a19c84420d0dbfd7fc866315ff
Author: Cyrille Pitchen <cyrille.pitchen@microchip.com>

drm/microchip: add a driver for the Microchip GFX2D GPU

This commit introduces a new DRM driver for the Microchip GFX2D GPU,
supporting basic 2D graphics instructions like FILL, COPY, BLEND, and ROP.
It implements a ring buffer for command queuing and a mailbox-based
completion tracking mechanism.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_drv.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c
[ ... ]
> +static int __maybe_unused mchp_gfx2d_runtime_resume(struct device *dev)
> +{
> +	struct mchp_gfx2d_device *priv =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D clk_enable(priv->pclk);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&priv->cmdlist_mutex);
> +	priv->is_suspended =3D false;
> +	pm_runtime_mark_last_busy(dev);
> +	mutex_unlock(&priv->cmdlist_mutex);
> +
> +	(void)mchp_gfx2d_progress(priv);

[Severity: High]
Does this resume hook fail to restore essential hardware registers?

mchp_gfx2d_init_command_queue() configures vital hardware parameters during
probe, such as the ring buffer DMA address, length, graphics engine enable,
and the mailbox DMA address.

When the SoC enters system sleep, peripheral power can be shut off entirely
on AT91 platforms, causing these registers to reset to zero.

The resume function only re-enables the clock and calls mchp_gfx2d_progress=
()
which immediately triggers the hardware. Because the base addresses and
configuration registers were never restored, the GPU may interpret
uninitialized registers and fetch rendering instructions from physical addr=
ess
0, which could trigger IOMMU faults or memory corruption.

> +
> +	return 0;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_gem.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_gem.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_gem.c
[ ... ]
> +static int mchp_gfx2d_gem_object_mmap(struct drm_gem_object *obj,
> +				      struct vm_area_struct *vma)
> +{
> +	struct mchp_gfx2d_gem_object *gfx2d_obj =3D to_mchp_gfx2d_bo(obj);
> +	int ret;
> +
[ ... ]
> +	if (ret)
> +		drm_gem_vm_close(vma);
> +	else
> +		memcpy(&gfx2d_obj->vma, vma, sizeof(gfx2d_obj->vma));

[Severity: High]
Is it safe to save a raw snapshot of the VMA using memcpy()?

VMAs are dynamically managed by the memory management subsystem. Saving a r=
aw
snapshot is generally not permitted because its fields (including vm_mm) can
become invalid if the region is unmapped or split.

> +
> +	return ret;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c b/drivers/gpu/d=
rm/microchip/mchp_gfx2d_ioctl.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c
[ ... ]
> +static int mchp_gfx2d_ioctl_alloc_buffer(struct drm_device *dev, void *d=
ata,
> +					 struct drm_file *file_priv)
> +{
> +	struct drm_mchp_gfx2d_alloc_buffer *args =3D data;
> +	struct mchp_gfx2d_gem_object *gfx2d_obj;
> +	enum dma_data_direction dir;
> +	struct drm_gem_object *obj;
> +	int ret;
[ ... ]
> +	gfx2d_obj =3D mchp_gfx2d_gem_create_with_handle(file_priv, dev,
> +						      args->size, dir,
> +						      &args->handle);
> +	if (IS_ERR(gfx2d_obj))
> +		return PTR_ERR(gfx2d_obj);
> +
> +	gfx2d_obj->width =3D args->width;
> +	gfx2d_obj->height =3D args->height;
> +	gfx2d_obj->stride =3D args->stride;
> +	gfx2d_obj->format =3D args->format;

[Severity: High]
Can this code dereference gfx2d_obj after it might have been freed?

mchp_gfx2d_gem_create_with_handle() calls drm_gem_handle_create() which mak=
es
the GEM object visible to userspace via its handle, and then immediately dr=
ops
the driver's internal creation reference via drm_gem_object_put(). The obje=
ct's
lifetime is now tied entirely to the userspace handle.

If a concurrent userspace thread immediately calls DRM_IOCTL_GEM_CLOSE on t=
his
handle, the object reference count can reach 0, freeing it.

Back in mchp_gfx2d_ioctl_alloc_buffer(), the driver then dereferences the
potentially freed gfx2d_obj to assign width, height, stride, and format,
which could cause a Use-After-Free.

> +
> +	obj =3D &gfx2d_obj->base;
[ ... ]
> +static int mchp_gfx2d_ioctl_sync_for_cpu(struct drm_device *dev, void *d=
ata,
> +					 struct drm_file *file_priv)
> +{
> +	struct mchp_gfx2d_device *priv =3D drm_to_dev(dev);
> +	struct drm_mchp_gfx2d_sync_for_cpu *args =3D data;
> +	const struct drm_mchp_timespec *timeout =3D &args->timeout;
> +	struct mchp_gfx2d_gem_object *gfx2d_obj;
> +	struct drm_gem_object *obj;
> +	int ret;
[ ... ]
> +	ret =3D mchp_gfx2d_wait(priv, gfx2d_obj, timeout);
> +
> +	drm_gem_object_put(obj);
> +
> +	return ret;

[Severity: Medium]
Does this code fail to invalidate the CPU cache for non-coherent buffers?

mchp_gfx2d_ioctl_sync_for_cpu() waits until the GPU finishes executing comm=
ands
using mchp_gfx2d_wait() so that the CPU can safely read the results.

If the buffer is non-coherent (allocated via dma_alloc_noncoherent), the
CPU's cache lines must be invalidated so the CPU can actually see the
modifications written by the device to physical memory.

By not calling dma_sync_single_for_cpu(), userspace applications may read
stale cached data instead of the newly rendered content.

> +}
> +
> +static int mchp_gfx2d_ioctl_sync_for_gpu(struct drm_device *dev, void *d=
ata,
> +					 struct drm_file *file_priv)
> +{
> +	struct drm_mchp_gfx2d_sync_for_gpu *args =3D data;
> +	struct mchp_gfx2d_gem_object *gfx2d_obj;
> +	enum dma_data_direction dir;
> +	struct drm_gem_object *obj;
[ ... ]
> +	dir =3D gfx2d_obj->direction;
> +	if (valid_dma_direction(dir)) {
> +		struct vm_area_struct *vma =3D &gfx2d_obj->vma;
> +
> +		flush_cache_range(vma, vma->vm_start, vma->vm_end);

[Severity: High]
Is it safe to pass a detached VMA to flush_cache_range() here?

In mchp_gfx2d_ioctl_sync_for_gpu(), the driver passes the potentially stale
VMA copy (saved earlier via memcpy) directly to flush_cache_range().

flush_cache_range() is an architecture-specific API that relies on the VMA's
vm_mm context. Providing a detached VMA could result in a kernel panic if t=
he
mm has been destroyed, or silently corrupt memory. The DMA API
dma_sync_single_for_device() should be used instead.

> +	}
> +
> +	drm_gem_object_put(obj);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-cpitchen-m=
ainline_gfx2d-v8-0-378374559738@microchip.com?part=3D3
