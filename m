Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693A6C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17FB10F997;
	Fri, 10 Jul 2026 22:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aPPSU+rL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C05D410F997
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:23:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1719C60052;
 Fri, 10 Jul 2026 22:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F7F1F000E9;
 Fri, 10 Jul 2026 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722227;
 bh=27YHdKxSfynPlDYIQLE0sYsVLE2UyO2gbBcP4CeFzRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aPPSU+rLwpYie1xeuaaU81AQ/SgoOyHEqnj2pLR5COB/JpOw6zCXsLA3SMwibaZdo
 jj0HWzk3i3Hftb1/4MQLJtiA6fgYz0b4XmF7HwpFGL4fDjfumBTPIPwn4lVNU00Y8j
 pGJ3yCHM+rS8b+iLUn1miA5reO6Im2Bnfx74gpPfgS8Qp1YBjVbAHam+ZUatbt8XMP
 R7iAuA6HqmTwf7wuVJVEJUeK2v4Tec2ACI8KEVZDNK2bLhSXO4F6YtQ8wNbcSJfNgq
 p+dDzqG1VZvhxFXu4US7itIi9PvW5+yhAm25XPVMsV4tdW+lwyt/JLiOPebD1mR32P
 ja1WnFUY5XXMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/33] drm/xe: Add debugfs stats for DMA-mapped pages
 per order
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-13-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-13-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:23:46 +0000
Message-Id: <20260710222347.97F7F1F000E9@smtp.kernel.org>
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

New issues:
- [High] xe_device_assert_dma_pages_zero() is called too early in xe_device=
_destroy(), leading to spurious kernel assertion failures.
- [High] Uncapped `addr->order` in SVM and userptr DMA accounting leads to =
out-of-bounds array writes.
- [Low] Too many arguments to `drm_gpusvm_init` in `xe_svm.h` causes a comp=
ilation error when `CONFIG_DRM_GPUSVM` is enabled but `CONFIG_DRM_XE_GPUSVM=
` is disabled.

Pre-existing issues:
- [Critical] Asynchronous execution of `vm_destroy_work_func` can cause a U=
se-After-Free of the `xe` device structure.
--

--- Patch [12]: [PATCH v2 12/33] drm/xe: Add debugfs stats for DMA-mapped p=
ages per order ---
commit 808c14d37a18acfee1cc7559a4568116c9d63f8b
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Subject: drm/xe: Add debugfs stats for DMA-mapped pages per order

This commit adds per-page-order DMA mapping counters for system memory
accessible by the GPU. The stats cover both TTM buffer objects and SVM/user=
ptr
ranges, exposing them through debugfs.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index ad7f3e61d4579..0c4ee874a56d7 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
[ ... ]
> @@ -475,8 +499,10 @@ static void xe_device_destroy(struct drm_device *dev=
, void *dummy)
>  {
>  	struct xe_device *xe =3D to_xe_device(dev);
> =20
> +	xe_device_assert_dma_pages_zero(xe);
> +
>  	xe_bo_dev_fini(&xe->bo_device);

[Severity: High]
Does this assertion trigger prematurely if the asynchronous BO destruction
worker has pending buffers to free?

In xe_device_destroy(), xe_device_assert_dma_pages_zero() is called
before xe_bo_dev_fini() flushes the async_free worker. If there are
delayed destructions, wouldn't the DMA mappings still be active, causing
the counters to be non-zero and triggering a kernel warning?

> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index b228a737cfd6d..2f639fc0cac4e 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
[ ... ]
> +static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
> +				   const struct drm_pagemap_addr *addr,
> +				   int sign)
> +{
> +	struct xe_device *xe =3D gpusvm_to_vm(gpusvm)->xe;
> +	unsigned int order =3D addr->order;
> +
> +	if (addr->proto !=3D DRM_INTERCONNECT_SYSTEM)
> +		return;
> +
> +	atomic_long_add((long)(1UL << order) * sign,
> +			&xe->mem.dma_mapped_pages_svm[order]);

[Severity: High]
Can this cause an out-of-bounds write if addr->order exceeds the array
bounds of dma_mapped_pages_svm?

In xe_svm_dma_map_account(), addr->order is used directly as an array
index. If an unprivileged user maps a large huge page (such as a 1GB page
with an order of 18) and faults it into the GPU, wouldn't this exceed the
NR_PAGE_ORDERS limit and corrupt adjacent kernel memory?

> +}
> +#endif

> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index a921556d34662..edd668c415512 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
[ ... ]
> @@ -236,7 +236,8 @@ int xe_svm_init(struct xe_vm *vm)
>  {
>  #if IS_ENABLED(CONFIG_DRM_GPUSVM)
>  	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
> -			       NULL, 0, 0, 0, NULL, NULL, 0);
> +			       NULL, 0, 0, 0, NULL, NULL,
> +			       xe_userptr_gpusvm_ops_get(), 0);

[Severity: Low]
Does this function call pass too many arguments to drm_gpusvm_init()?

In the xe_svm_init() inline stub, the xe_userptr_gpusvm_ops_get() argument
was added without removing one of the NULL placeholders. Since
drm_gpusvm_init() expects 9 arguments and this now provides 10, won't this
cause a compilation error when CONFIG_DRM_GPUSVM is enabled but
CONFIG_DRM_XE_GPUSVM is disabled?

>  #else
>  	return 0;
>  #endif

> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_user=
ptr.c
> index 8b2d461ea0b28..79c2a81001f2e 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
[ ... ]
> +static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
> +				       const struct drm_pagemap_addr *addr,
> +				       int sign)
> +{
> +	struct xe_vm *vm =3D container_of(gpusvm, struct xe_vm, svm.gpusvm);
> +	unsigned int order =3D addr->order;
> +
> +	if (addr->proto !=3D DRM_INTERCONNECT_SYSTEM)
> +		return;
> +
> +	atomic_long_add((long)(1UL << order) * sign,
> +			&vm->xe->mem.dma_mapped_pages_svm[order]);

[Severity: High]
Similarly to xe_svm_dma_map_account(), can this cause an out-of-bounds
write if addr->order is larger than NR_PAGE_ORDERS?

Using addr->order directly as an array index without capping it could allow
unprivileged user-space applications mapping large huge pages to corrupt
memory when invoking xe_userptr_dma_map_account().

> +}


While reviewing the VM lifecycle code related to this patch, I noticed a
separate pre-existing issue in drivers/gpu/drm/xe/xe_vm.c.

[Severity: Critical]
This is a pre-existing issue, but does queueing the destroy work
asynchronously lead to a use-after-free if the last reference to the DRM
device is dropped before the worker executes?

In xe_vm_free(), the destruction work is queued to system_dfl_wq:

	queue_work(system_dfl_wq, &vm->destroy_work);

If this drops the last device reference, the xe device could be freed via
RCU before vm_destroy_work_func() runs. Since vm_destroy_work_func()
dereferences the xe pointer (for example, when calling
xe_pm_runtime_put()), wouldn't this result in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D12
