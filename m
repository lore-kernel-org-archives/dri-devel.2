Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74690C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 05:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EC310E105;
	Wed, 15 Jul 2026 05:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jEzCN6m9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC66E10E105
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:02:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76E4342B6B;
 Wed, 15 Jul 2026 05:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD961F000E9;
 Wed, 15 Jul 2026 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784091747;
 bh=XU41lxDZD+Uu40zeEQFipNzSLA8NCV6FdrSGpu/fbCw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jEzCN6m9PFX6DSvVihF5ftTMcvETgrVukDzvILgmd5aCszOi4XVUd6HdYqQHY7tkU
 Tmde572VrEn4MZP9btM5P/soSrM+AL+qXE18ztweSpmCbt9uUkzxGjpqkf09Ww8aKb
 Jf4Lb4bqjJn7FKK9POVS16ESfNMmER4B6UW9Ilx3msnODcysgZ5G5XtsxRo+/8poN+
 FmBSDNHjgeKWDPh4LanvfjXNi9rIxLk5bY9R8bHiWtUIojQ8wPD2vfjA9sm6qK1cnr
 pkLzavBPNSpMdP5sYFCwDxLHTW3CKh0d7V1YixOF74VHYhs32MKMHbqwAbVsvkcWLk
 Tie3Eu4tYEgbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/xe: Re-prioritize VM's private BOs when
 adding an exec queue
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715042832.3625096-3-matthew.brost@intel.com>
References: <20260715042832.3625096-1-matthew.brost@intel.com>
 <20260715042832.3625096-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 05:02:26 +0000
Message-Id: <20260715050227.2DD961F000E9@smtp.kernel.org>
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
- [Medium] Concurrent exec queue additions and removals create a Time-of-Ch=
eck to Time-of-Use (TOCTOU) race, leaving BOs with stale TTM priorities.
- [Medium] The BO priority evaluation incorrectly prioritizes LOW priority =
exec queues over NORMAL priority ones, causing unintended priority downgrad=
es.
- [Medium] Unbound private BOs miss dynamic priority updates and permanentl=
y retain stale priorities.
- [Medium] The patch omits the intended logic to downgrade completely unmap=
ped BOs to `XE_BO_PRIORITY_LOW` in `xe_vma_destroy()`.
--

--- Patch [2]: [PATCH v2 2/4] drm/xe: Re-prioritize VM's private BOs when a=
dding an exec queue ---
commit 45971462729146ee32e2c293b500a521f745e5fe
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Re-prioritize VM's private BOs when adding an exec queue

This commit updates the TTM LRU eviction priority of a VM's private BOs when
exec queues are added or removed. It iterates over the VM's active VMAs to
apply the new priority based on the highest priority band among the VM's
attached exec queues.

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 0b315d6120aae..0f2b8ffefb8ec 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
[ ... ]
> @@ -4912,6 +4944,87 @@ int xe_vm_alloc_cpu_addr_mirror_vma(struct xe_vm *=
vm, uint64_t start, uint64_t r
>  	return xe_vm_alloc_vma(vm, &map_req, false);
>  }
> =20
> +/*
> + * Determine the TTM LRU priority to use for BOs private to @vm, based o=
n the
> + * highest priority band among exec queues currently attached to @vm.
> + *
> + * A VM with a HIGH priority exec queue gets XE_BO_PRIORITY_HIGHEST, sam=
e as
> + * BOs that are never subject to this heuristic at all (kernel or shared
> + * BOs) -- userspace has indicated its most important work lives here, so
> + * treat these BOs as equally important. Every other band is then shifte=
d up
> + * one level from its "intuitive" mapping: a NORMAL priority exec queue =
(or no
> + * exec queues at all yet) yields XE_BO_PRIORITY_HIGH, and a LOW priorit=
y exec
> + * queue yields XE_BO_PRIORITY_NORMAL. XE_BO_PRIORITY_LOW is intentional=
ly
> + * never returned here -- it is reserved for xe_vma_destroy() to apply o=
nce a
> + * BO has no VMAs left, letting userspace signal "drop this from my work=
ing
> + * set" via unbind while still retaining the backing store, without this
> + * heuristic immediately promoting it back up on the next bind.

[Severity: Medium]
Is the logic to downgrade completely unmapped BOs to XE_BO_PRIORITY_LOW
missing from this patch? The comment states it is reserved for
xe_vma_destroy() to apply once a BO has no VMAs left, but the implementation
to actually apply it does not seem to be included in this changeset.

> + *
> + * Must be called with @vm's exec_queues.lock held, in either read or wr=
ite
> + * mode.
> + */
> +static int xe_vm_bo_priority_locked(struct xe_vm *vm)
> +{
> +	lockdep_assert_held(&vm->exec_queues.lock);
> +
> +	if (vm->exec_queues.priority_count[XE_EXEC_QUEUE_PRIORITY_HIGH])
> +		return XE_BO_PRIORITY_HIGHEST;
> +	if (vm->exec_queues.priority_count[XE_EXEC_QUEUE_PRIORITY_LOW])
> +		return XE_BO_PRIORITY_NORMAL;
> +
> +	return XE_BO_PRIORITY_HIGH;
> +}

[Severity: Medium]
Does this logic incorrectly prioritize LOW priority exec queues over NORMAL
priority ones? If a VM has both a NORMAL and a LOW priority queue, it appea=
rs
this will return XE_BO_PRIORITY_NORMAL instead of checking for the presence=
 of
a NORMAL queue first, which might unfairly downgrade the VM's priority band.

> +
> +/**
> + * xe_vm_bo_priority() - Determine TTM LRU priority for a VM's private B=
Os
[ ... ]
> +/*
> + * Update the TTM LRU priority of all BOs private to @vm to @priority, m=
oving
> + * each to the tail of its new priority level's LRU list. BOs shared with
> + * other VMs (extobjs) are left untouched.
> + */
> +static void xe_vm_update_bo_priority(struct xe_vm *vm, int priority)
> +{
> +	struct drm_gpuva *gpuva;
> +
> +	/*
> +	 * vm->lock is the outer most lock and serializes against concurrent
> +	 * VMA insertion/removal (bind/unbind), so it must be held to safely
> +	 * walk vm->gpuvm here. xe_vm_lock() (the VM's dma-resv) is taken
> +	 * inside it, as it protects each private BO's bo->ttm.priority.
> +	 */
> +	down_read(&vm->lock);
> +	xe_vm_lock(vm, false);
> +	drm_gpuvm_for_each_va(gpuva, &vm->gpuvm) {

[Severity: Medium]
Can unbound private BOs miss dynamic priority updates here? Since this
loop iterates over mapped VMAs using drm_gpuvm_for_each_va(), any allocated
but not yet bound BOs would be skipped and might permanently retain their
stale creation priorities.

> +		struct xe_vma *vma =3D gpuva_to_vma(gpuva);
> +		struct xe_bo *bo =3D xe_vma_bo(vma);
> +
> +		if (!bo || bo->vm !=3D vm || bo->ttm.priority =3D=3D priority)
> +			continue;
> +
> +		xe_bo_update_ttm_priority(bo, priority);
> +	}
> +	xe_vm_unlock(vm);
> +	up_read(&vm->lock);
> +}
[ ... ]
> @@ -4941,7 +5055,10 @@ void xe_vm_add_exec_queue(struct xe_vm *vm, struct=
 xe_exec_queue *q)
>  	if (q->sched_props.priority >=3D XE_EXEC_QUEUE_PRIORITY_LOW &&
>  	    q->sched_props.priority <=3D XE_EXEC_QUEUE_PRIORITY_HIGH)
>  		++vm->exec_queues.priority_count[q->sched_props.priority];
> +	priority =3D xe_vm_bo_priority_locked(vm);
>  	up_write(&vm->exec_queues.lock);
> +
> +	xe_vm_update_bo_priority(vm, priority);
>  }

[Severity: Medium]
Is there a race condition between taking the priority snapshot and applying=
 it?

If multiple threads are concurrently adding and removing exec queues, their
execution could interleave between dropping exec_queues.lock and acquiring
vm->lock inside xe_vm_update_bo_priority().

Could the last thread to acquire vm->lock apply a stale priority snapshot
that no longer reflects the current queue state?

> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715042832.3625=
096-1-matthew.brost@intel.com?part=3D2
