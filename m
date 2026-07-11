Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2453C44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FE210E717;
	Sat, 11 Jul 2026 03:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FEmwQm1O";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4876410E716
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:21:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55F6560051;
 Sat, 11 Jul 2026 03:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04271F000E9;
 Sat, 11 Jul 2026 03:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783740063;
 bh=g9ETGHzCUDlFEptctSQkJPAYyyDSz5IxoYDFmzCkglE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FEmwQm1Or84YogvzBH1bvlF4yOsnrdm4D9RPCKQeORX4TG+otek+7t0InXJ0RWclo
 Xz9Pb41uC/LUSv9ycQp1sivE9GPeuqnzygBS0+eSxuMz//u+L2vy5BWgmLSyjzWtJO
 l0vWojQBWD4n7EtY/QlgJD9EDF/OI5/u2SZ1rk31clVva+H1kdE9qn67S3lwC94MTo
 /vIA3OMOMC9pgMCOG+mtkS0aC4wmgnOR5/yEVQ8tnpu4BDjpxJ0pewMcHjzVtJ+UfE
 fe+PJ89kB9v1JqikmY+mSuxV85CQ7hfOKUeWN736fJ2wB8Th/czq19YE2jr/T4RjiY
 1CqG6PQpDTkew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/33] drm/xe: Add debugfs stats for DMA-mapped pages
 per order
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-13-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-13-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:21:02 +0000
Message-Id: <20260711032102.E04271F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Missing decrement of DMA mapped pages counter in `xe_bo_dma_un=
map_pinned()` leads to leaked accounting and kernel assertion failure durin=
g device teardown.

Pre-existing issues:
- [High] `xe_bo_dev_fini()` is called before `xe->destroy_wq` is flushed, l=
eading to Use-After-Free of the TTM device and false positive assertion fai=
lures on device teardown.
--

--- Patch [12]: [PATCH v3 12/33] drm/xe: Add debugfs stats for DMA-mapped p=
ages per order ---
commit 670e42692f03a24b49683eec7ff3afb39e28a858
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Subject: drm/xe: Add debugfs stats for DMA-mapped pages per order

Expose per-page-order DMA mapping counts for the system memory that the
xe driver maps for GPU access, split into two categories: TTM buffer
objects, and the GPU SVM / userptr ranges.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 85e6d9a0f575b..60e0e568aa31f 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -404,6 +449,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, stru=
ct ttm_tt *tt)
>  	struct xe_ttm_tt *xe_tt =3D container_of(tt, struct xe_ttm_tt, ttm);
> =20
>  	if (xe_tt->sg) {
> +		xe_tt_account_dma_pages(xe, xe_tt, -1);
>  		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
>  				  DMA_BIDIRECTIONAL, 0);
>  		sg_free_table(xe_tt->sg);

[Severity: Critical]
Will this accounting leak if the scatter-gather table is unmapped elsewhere?

Looking at xe_bo_dma_unmap_pinned() in drivers/gpu/drm/xe/xe_bo.c, it unmaps
and frees the sg table without updating the accounting:

	} else if (xe_tt->sg) {
		dma_unmap_sgtable(ttm_to_xe_device(ttm_bo->bdev)->drm.dev,
				  xe_tt->sg,
				  DMA_BIDIRECTIONAL, 0);
		sg_free_table(xe_tt->sg);
		xe_tt->sg =3D NULL;
	}

Because xe_bo_dma_unmap_pinned() clears xe_tt->sg, a later call to
xe_tt_unmap_sg() will see xe_tt->sg as NULL and skip the decrement, leading=
 to
a permanent accounting leak and a guaranteed assertion failure on device
teardown.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index ad7f3e61d4579..97cc2d185e45d 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
[ ... ]
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe =3D to_xe_device(dev);
> =20
>  	xe_bo_dev_fini(&xe->bo_device);
> =20
> +	/*
> +	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
> +	 * has flushed the async BO-free worker: BOs pending async free still
> +	 * hold their DMA mappings (and counts) until the worker runs, so
> +	 * asserting before the flush could trip a false positive.
> +	 */
> +	xe_device_assert_dma_pages_zero(xe);
> +
>  	if (xe->preempt_fence_wq)
>  		destroy_workqueue(xe->preempt_fence_wq);

[Severity: High]
This is a pre-existing issue, but will this new assertion falsely trip due
to the teardown order?

Because xe->destroy_wq is destroyed after this assertion, and work items in
xe->destroy_wq might still hold final references to BOs, those BOs won't be
unmapped until the workqueue is drained.

Since the assertion now runs before the workqueues drop their BO references,
it will incorrectly trigger because those BOs still have active DMA mapping=
s.

Additionally, since xe_bo_dev_fini() flushes the async BO-free worker before
the workqueues drop BOs, the worker can run concurrently with or after
ttm_device_fini(), which is a pre-existing use-after-free risk exposed by
this change.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D12
