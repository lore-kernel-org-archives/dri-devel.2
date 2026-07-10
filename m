Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26491C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8584B10F96C;
	Fri, 10 Jul 2026 22:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nEgjhWgI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23D110F96C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:18:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 888414149E;
 Fri, 10 Jul 2026 22:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397601F000E9;
 Fri, 10 Jul 2026 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721896;
 bh=WPbUrLVNUz6t9GtukwZKok6HF5juKRk0PHTrKqsxOEY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nEgjhWgIDPWRfZv4SugEocq3lodAc8xnlWhoVLufSMzSlZZu2u8DULcQeMgk2CaI/
 dpIIz6iR0wxRO7R7Sq364IGFoUORRRAdK4KEccZMclUmoLHW3DT1SpoUuXl1HLJPKZ
 WZsGCuiV0ee6uVT0ERJOe6kkxzJSa91KwZ5s0QSRLCwDO3tFMh397rbSdSpw9bGHYI
 1utR8QVIRJA3uQg7QsRzs1P7Zs3iWSi95ZzJM55ouKdxx4bDq9sG006lhzQcgqNGmr
 qdnrHoBZKRCvs8g6RZnDqIbo9iqvF4wZEGB3Lx0mKZBwCEh1Ig0y2TKlZsxIaB9YAq
 b4x7y79GmmdPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/33] drm/xe: Flush L2 asynchronously in
 xe_bo_trigger_rebind()
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-14-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-14-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:18:15 +0000
Message-Id: <20260710221816.397601F000E9@smtp.kernel.org>
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
- [High] GFP_KERNEL allocation in shrinker and dma-resv critical section ca=
uses deadlocks and lockdep splats
--

--- Patch [13]: [PATCH v2 13/33] drm/xe: Flush L2 asynchronously in xe_bo_t=
rigger_rebind() ---
commit 985db7b22213ce9503872b19a27fddeba9fe24ff
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Flush L2 asynchronously in xe_bo_trigger_rebind()

This commit replaces synchronous TLB invalidations during buffer object
eviction with asynchronous flushes on L2-flush-optimized hardware. It
queues a TLB invalidation job per VMA, which waits on the buffer's
in-flight GPU work before flushing.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -732,6 +732,13 @@ static int xe_bo_trigger_rebind(struct xe_device *xe=
, struct xe_bo *bo,
>  			 */
>  			if (!xe_device_is_l2_flush_optimized(xe))
>  				continue;
> +
> +			/*
> +			 * Attempt to flush L2 async, fallback to sync flush on
> +			 * failure
> +			 */
> +			if (!xe_vm_flush_vm_bo_tlb_async(vm, bo, vm_bo))
> +				continue;

[Severity: High]
Does this create a deadlock regression when reached from the shrinker path?

The memory shrinker can call into this path through xe_shrinker_scan() ->
xe_bo_shrink() -> xe_bo_move_notify() -> xe_bo_trigger_rebind().

In this path, the shrinker operates under the fs_reclaim pseudo-lock and
holds the buffer object's dma-resv lock.

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
[ ... ]
> +static int xe_vma_tlb_flush_client(struct xe_vm *vm, struct xe_vma *vma,
> +				   struct xe_tile *tile, struct xe_gt *gt,
> +				   struct dma_resv *resv, struct dma_fence *dep,
> +				   int type)
> +{
> +	struct xe_exec_queue *q =3D xe_migrate_exec_queue(tile->migrate);
> +	struct xe_tlb_inval_job *job;
> +	struct dma_fence *fence;
> +	int err;
> +
> +	job =3D xe_tlb_inval_job_create(q, &gt->tlb_inval,
> +				      q->tlb_inval[type].dep_scheduler, vm,
> +				      xe_vma_start(vma), xe_vma_end(vma), type);

[Severity: High]
Could this allocation recurse into memory reclaim and attempt to acquire the
same dma-resv lock, or trigger a lockdep splat for context violations?

The xe_tlb_inval_job_create() function allocates the job using a default
GFP_KERNEL allocation. Furthermore, the subsequent call to
xe_tlb_inval_job_alloc_dep() explicitly calls might_alloc(GFP_KERNEL).

Since this can be reached while holding the dma-resv lock or while in the
shrinker reclaim path, these GFP_KERNEL allocations appear to violate the
context constraints.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D13
