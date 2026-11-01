Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A3606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQWwi30S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648B610EAD2;
	Sun,  1 Nov 2026 22:51:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFE710EAD2
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:51:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFD5C4194B;
 Sun,  1 Nov 2026 22:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8551F000C1;
 Sun,  1 Nov 2026 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573496;
 bh=x5CLYZKfDh4XOi/Zw5DHgTzeCCLrO5Sq/l7IPnE/u3k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jQWwi30S9WQ/bkn6tMGStBlZ82WYVcPU7VUx4ba+Qb3jQRpAOUmnFmZAUuqRpMa2E
 fLPwyyIqEUe6968mkHwjirpY7aPh0yZZnHYNBY1GvoydVBKi1UThb3EU9ADtN3wDN/
 lgIskCoIFuyI48yGCNzaUoX3YaoEr1DcLFZKpPOP4u1uIOOjoZ7Cd1WwhRbQl+jdzi
 oIue7+b5aubSpXDLhew6j9UNUyzcirHUc2P74Lb/1jtcdptKm9DQv51aqG3noyVd5S
 8Q8l2xrY8IwV/5NzZeUiiPi5tCwtgoRW4xUSvvuEC8/Sgfivv3+LfKGvmgFz2EPXqp
 FJc6bGMYwxhNQ==
Message-ID: <sashiko-outbox-192739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/25] accel/qda: Add buffer allocation for the DSP
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-6-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-6-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:51:36 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] accel/qda: UAF and context bank reuse when qda_gem_obj outlive=
s qda_session
- [High] accel/qda: missing vm_ops in qda_gem_object_funcs leaks GEM buffer=
s on mmap
- [High] accel/qda: UAF on iommu_dev->dev in qda_dma_free() after qda_cb_un=
populate()
- [High] accel/qda: missing drm_dev_enter() in qda_ioctl_gem_create() races=
 with unplug
- [Medium] accel/qda: 32-bit dma_addr_t in qda_gem_obj truncates stream ID =
bits
- [Medium] accel/qda: 32-bit size_t truncation of args->size in qda_ioctl_g=
em_create()
- [Medium] accel/qda: coherent_dma_mask left at 32 bits in qda_create_cb_de=
vice()
--

commit 28e778f1e5490a2de285e597396980427ca74098
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add buffer allocation for the DSP

This commit adds GEM buffer allocation and mmap offset ioctls for the QDA
DSP accelerator driver, backing buffers with coherent DMA allocations from
per-session IOMMU context banks and folding the context bank stream ID into
DSP-visible addresses.

> diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
> new file mode 100644
> index 0000000000000..864bac914e48d
> --- /dev/null
> +++ b/drivers/accel/qda/qda_gem.c
> @@ -0,0 +1,108 @@
[ ... ]
> +static int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_ar=
ea_struct *vma)
> +{
> +	struct qda_gem_obj *qda_gem_obj =3D to_qda_gem_obj(gem_obj);
> +	int ret;
> +
> +	/* The fake offset only identifies the object, it does not index into i=
t */
> +	vma->vm_pgoff =3D 0;
> +
> +	ret =3D qda_dma_mmap(qda_gem_obj, vma);
> +	if (ret)
> +		return ret;
> +
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> +
> +	return 0;
> +}
> +
> +static const struct drm_gem_object_funcs qda_gem_object_funcs =3D {
> +	.free =3D qda_gem_free_object,
> +	.mmap =3D qda_gem_mmap_obj,
> +};

[Severity: High]
Does qda_gem_object_funcs leak every mmap()ed qda_gem_obj and its coherent
DMA buffer?

When user space maps a buffer on the accel fd, the call chain is:

  drm_gem_mmap()
    drm_gem_mmap_obj()
      drm_gem_object_get(obj);
      vma->vm_ops =3D obj->funcs->vm_ops;
      obj->funcs->mmap(obj, vma); -> qda_gem_mmap_obj()

drm_gem_mmap_obj() takes a reference on the GEM object for the VMA and
relies on vma->vm_ops->close (normally drm_gem_vm_close) to drop that
reference when the VMA is unmapped, as well as vma->vm_ops->open
(drm_gem_vm_open) to take additional references when the VMA is forked or
split.

Because qda_gem_object_funcs leaves .vm_ops unset and neither
qda_gem_mmap_obj() nor qda_dma_mmap() initializes vma->vm_ops,
drm_gem_vm_close() is never called on munmap() or process exit, so the GEM
object reference count never drops to zero and qda_gem_free_object() never
runs.

Should qda_gem_object_funcs set .vm_ops to a vm_operations_struct wired to
drm_gem_vm_open and drm_gem_vm_close?

> diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
> new file mode 100644
> index 0000000000000..af3b9dfc75099
> --- /dev/null
> +++ b/drivers/accel/qda/qda_gem.h
> @@ -0,0 +1,44 @@
[ ... ]
> +struct qda_gem_obj {
> +	/** @base: DRM GEM object base; must be first member */
> +	struct drm_gem_object base;
> +	/** @iommu_dev: Context bank this buffer is mapped into */
> +	struct qda_iommu_device *iommu_dev;
> +	/** @virt: Kernel virtual address of the buffer */
> +	void *virt;
> +	/** @dma_addr: Address of the buffer as the DSP sees it */
> +	dma_addr_t dma_addr;

[Severity: Medium]
Can storing the DSP-visible address in dma_addr_t truncate the folded
stream ID bits when dma_addr_t is 32 bits wide?

In drivers/accel/qda/qda_soc.h, qda_soc_sid_offset() returns a u64 with the
stream ID shifted to soc_data->sid_pos (32 on default_soc_data and 56 on
kaanapali_soc_data), and qda_soc_dma_addr() takes a u64 iova.

However, struct qda_gem_obj declares dma_addr as dma_addr_t. On 32-bit
builds without CONFIG_ARCH_DMA_ADDR_T_64BIT (which are permitted since
DRM_ACCEL_QDA depends on ARCH_QCOM || COMPILE_TEST), assigning:

  gem_obj->dma_addr =3D dma_addr +
                      qda_soc_sid_offset(iommu_dev->qdev->soc_data,
                                         iommu_dev->sid);

in qda_dma_alloc() truncates the upper 32 bits and discards the stream ID.
Should struct qda_gem_obj::dma_addr be u64 instead of dma_addr_t?

> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index 380c2526d9d2c..b11743ab791e7 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
[ ... ]
> +int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_=
file *file_priv)
> +{
> +	struct qda_dev *qdev =3D qda_dev_from_drm(dev);
> +	struct drm_qda_gem_create *args =3D data;
> +	struct drm_gem_object *gem_obj;
> +
> +	if (args->pad)
> +		return -EINVAL;
> +
> +	gem_obj =3D qda_gem_create_object(dev, qdev->iommu_mgr, args->size,
> +					file_priv->driver_priv);

[Severity: High]
Can qda_ioctl_gem_create() race with qda_rpmsg_remove() because it does not
guard hardware/manager access with drm_dev_enter() and drm_dev_exit()?

In drivers/accel/qda/qda_rpmsg.c, qda_rpmsg_remove() runs:

  drm_dev_unplug(&qdev->drm_dev);
  qda_cb_unpopulate(qdev);
  qda_deinit_device(qdev);
    qda_memory_manager_exit(qdev->iommu_mgr);

drm_ioctl() only performs a point-in-time drm_dev_is_unplugged() check
before invoking the driver ioctl callback; drm_dev_unplug() only waits for
readers inside a drm_dev_enter() / drm_dev_exit() section.

If qda_rpmsg_remove() runs right after a thread enters
qda_ioctl_gem_create(), drm_dev_unplug() returns immediately and
qda_cb_unpopulate() and qda_memory_manager_exit() can destroy the context
bank devices and free qdev->iommu_mgr->devices concurrently with
qda_gem_create_object() -> qda_memory_manager_alloc() -> qda_dma_alloc().

[Severity: Medium]
Also in qda_ioctl_gem_create(), can passing args->size (__u64) to
qda_gem_create_object() (which takes size_t) silently truncate sizes >=3D 4=
 GiB
on 32-bit builds?

When args->size exceeds SIZE_MAX on a 32-bit kernel (for example
0x100001000ULL), the implicit conversion to size_t narrows the value to its
lower 32 bits before PAGE_ALIGN(size) is checked in qda_gem_create_object(),
allocating a smaller buffer than requested instead of returning -EINVAL.

> diff --git a/drivers/accel/qda/qda_memory_dma.c b/drivers/accel/qda/qda_m=
emory_dma.c
> new file mode 100644
> index 0000000000000..0f4715a55b9de
> --- /dev/null
> +++ b/drivers/accel/qda/qda_memory_dma.c
> @@ -0,0 +1,72 @@
[ ... ]
> +int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
> +		  struct qda_gem_obj *gem_obj, size_t size)
> +{
> +	dma_addr_t dma_addr;
> +	void *virt;
> +
> +	virt =3D dma_alloc_coherent(iommu_dev->dev, size, &dma_addr, GFP_KERNEL=
);
> +	if (!virt)
> +		return -ENOMEM;

[Severity: Medium]
Are coherent allocations in qda_dma_alloc() restricted to a 32-bit DMA mask
even on 34-bit CDSP context banks such as kaanapali_soc_data?

In drivers/accel/qda/qda_cb.c, qda_create_cb_device() configures the
context bank platform device with:

  dma_bits =3D qda_soc_dma_addr_bits(qdev);
  ret =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(dma_bits));

Because of_platform_device_create() initializes pdev->dev.dma_mask to
&pdev->platform_dma_mask and pdev->dev.coherent_dma_mask to
DMA_BIT_MASK(32), calling dma_set_mask() only updates
*pdev->dev.dma_mask and leaves pdev->dev.coherent_dma_mask at 32 bits.

When qda_dma_alloc() calls dma_alloc_coherent(), the IOMMU DMA allocator
bounds the IOVA using iommu_dev->dev->coherent_dma_mask rather than
*iommu_dev->dev->dma_mask, so 34-bit CDSP context banks on Kaanapali
(where dma_addr_bits_cdsp is 34) remain limited to 32-bit IOVAs. Should
qda_create_cb_device() call dma_set_mask_and_coherent() instead?

> +	gem_obj->virt =3D virt;
> +	gem_obj->dma_addr =3D dma_addr +
> +			    qda_soc_sid_offset(iommu_dev->qdev->soc_data, iommu_dev->sid);
> +	gem_obj->iommu_dev =3D iommu_dev;
> +
> +	return 0;
> +}
> +
> +/**
> + * qda_dma_free() - Release a buffer back to its context bank
> + * @gem_obj: GEM object to free
> + */
> +void qda_dma_free(struct qda_gem_obj *gem_obj)
> +{
> +	dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
> +			  gem_obj->virt, qda_gem_dma_addr(gem_obj));

[Severity: Critical]
What happens if a qda_gem_obj outlives the drm_file session that created it?

A GEM object can stay alive after its drm_file is closed, for example if
user space exports it to a dma-buf fd via DRM_IOCTL_PRIME_HANDLE_TO_FD
(enabled by DRIVER_GEM) or keeps a VMA mapped after closing the accel fd.

When the drm_file closes, the teardown path runs:

  qda_postclose()
    qda_session_free()
      qda_memory_manager_release_device(session->assigned_iommu_dev)
        iommu_dev->assigned_session =3D NULL;
        kref_put(&iommu_dev->ref, iommu_device_free);

Because qda_dma_alloc() stores gem_obj->iommu_dev without holding a
reference on iommu_dev or keeping the context bank reserved while buffers
are still allocated from it:

1. Setting iommu_dev->assigned_session =3D NULL allows
   qda_memory_manager_assign_device() to hand the same context bank to a new
   session while the previous session's DMA buffer is still mapped into that
   context bank's IOMMU domain.

2. If the context bank is also unregistered via qda_cb_teardown_device() ->
   qda_memory_manager_unregister_device(), iommu_dev->ref drops to zero and
   iommu_device_free() frees iommu_dev, causing a use-after-free in
   qda_dma_free() (and qda_dma_mmap()) when it later dereferences
   gem_obj->iommu_dev->dev and gem_obj->iommu_dev->qdev->soc_data.

[Severity: High]
Similarly, in qda_dma_free(), can gem_obj->iommu_dev->dev be a dangling
pointer if the RPMsg device is removed while a user process still holds an
open session or GEM buffer?

In drivers/accel/qda/qda_cb.c, qda_cb_unpopulate() runs during
qda_rpmsg_remove():

  qda_cb_teardown_device(&entry->pdev->dev);
  of_platform_device_destroy(&entry->pdev->dev, NULL);

While struct qda_iommu_device itself is refcounted via iommu_dev->ref so
that it can survive qda_cb_teardown_device(), of_platform_device_destroy()
immediately unregisters and frees entry->pdev (which is iommu_dev->dev).
When the user process later closes its fd or frees the GEM handle,
qda_gem_free_object() -> qda_memory_manager_free() -> qda_dma_free() passes
the freed gem_obj->iommu_dev->dev to dma_free_coherent().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D6
