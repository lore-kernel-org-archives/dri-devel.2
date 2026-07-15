Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0C4C4450A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 04:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5546B10E0BB;
	Wed, 15 Jul 2026 04:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OO0Hu2ti";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1484410E0BB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 04:51:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75BCE4046C;
 Wed, 15 Jul 2026 04:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4021F000E9;
 Wed, 15 Jul 2026 04:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784091112;
 bh=Qqv6BQPJo7p3+MzzLekV12NrMj8NuGe+UbeVf/F3Yv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OO0Hu2tiQduCDQmLSsY6U9PQiFq5PLA/1aCHD8VjjxGLgdrLulrH2FqjlmChHiGer
 UUpZm9ogsMD4fKOMBSHgTUQ4exlLjNrMIf8q5rsjbDiBPJvDOo4Ga9icY0aOPcfXlN
 72eAOpWe7r+Hf1Rzec2YRxURcYeEYxjbBKtCDQ7Xb5LTigpMTH5Anzxl8/Zef0xSom
 l0uHkvFLZtOfhIO51yJjUrmZodCVVwSTz29TXToPotY93Yr6zwFUwu7LyYQ5U4Mxxz
 ZPJyG1jjLC1vK9uqMqlIlu/c9n36YKkRPTRZ5i9VoPTszk7oOQnAemCCrOM3qzZ/GT
 sKiwHpK91lcWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/xe: Fix up BO TTM priority for late VM binds
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715042832.3625096-4-matthew.brost@intel.com>
References: <20260715042832.3625096-1-matthew.brost@intel.com>
 <20260715042832.3625096-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 04:51:51 +0000
Message-Id: <20260715045152.2E4021F000E9@smtp.kernel.org>
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
- [High] Data race and TTM LRU corruption due to missing invariant check fo=
r cross-VM binds of private BOs.

Pre-existing issues:
- [Medium] Meaningful code and commit message mismatch (Incomplete Implemen=
tation of extobj priority lowering).
--

--- Patch [3]: [PATCH v2 3/4] drm/xe: Fix up BO TTM priority for late VM bi=
nds ---
commit b5439d40abd0e7b0ac5ecc4fc4045178d3dcfcb7
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Fix up BO TTM priority for late VM binds

This patch updates the BO TTM priority when a BO is (re)mapped into a VM.
It recalculates the priority band based on the VM's current exec queues or
sets it to the highest priority for external objects.

>     A BO's TTM priority is only ever set once, at creation time, based on
>     the priority band of exec queues attached to its VM at that moment
>     (xe_vm_bo_priority()), or XE_BO_PRIORITY_HIGHEST for an extobj not
>     tied to any single VM. This misses the common flow of VM create -> BO
>     create -> exec queue create -> VM bind: the BO is created before any
>     exec queue exists on the VM (so it gets XE_BO_PRIORITY_HIGH, the "no
>     exec queues yet" default), the exec queue is added afterwards
>     (xe_vm_add_exec_queue() only re-prioritizes BOs already bound to the
>     VM at that time), and only then is the BO bound into the VM via
>     VM_BIND, leaving it stuck at a stale priority that no longer reflects
>     the VM's exec queues.
>    =20
>     It also misses a second flow specific to extobjs: create BO with no
>     vm_id (bo->vm =3D=3D NULL) -> bind -> unbind -> rebind. The unbind can
>     lower the BO's priority to XE_BO_PRIORITY_LOW once it has no VMA
>     mappings left anywhere (see xe_vma_destroy()), but on rebind nothing

[Severity: Medium]
This is a pre-existing issue, but I don't see any logic in xe_vma_destroy()
or elsewhere in the codebase that actually lowers an extobj's priority to
XE_BO_PRIORITY_LOW.

Because extobjs appear to permanently retain XE_BO_PRIORITY_HIGHEST, won't
the fix in op_update_bo_priority() always hit the early return for extobjs,
missing the intended working set eviction optimization entirely?

>     brought it back up, leaving a still-useful, freshly rebound extobj
>     stuck at the lowest priority, an easy target for eviction/shrinking.
>    =20
>     Add op_update_bo_priority(), called from vm_bind_ioctl_ops_fini() for

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 0f2b8ffefb8ec..dd64a46b554ed 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c

[ ... ]

> @@ -3538,6 +3538,38 @@ static void op_add_ufence(struct xe_vm *vm, struct=
 xe_vma_op *op,
>  	}
>  }
> =20
> +/*
> + * A BO's TTM priority is set when it is created, based on the priority =
band
> + * of @vm's exec queues at that time (for a private BO), or to the highe=
st
> + * level (for an extobj, bo->vm =3D=3D NULL). If a BO is (re)mapped into=
 @vm
> + * afterwards, its priority may be stale: a private BO's VM may have gai=
ned
> + * or lost exec queues since, and an extobj may have been lowered to
> + * XE_BO_PRIORITY_LOW by xe_vma_destroy() after losing all of its VMA
> + * mappings. Bring it in line with the current priority band here.
> + */
> +static void op_update_bo_priority(struct xe_vm *vm, struct xe_vma_op *op)
> +{
> +	struct xe_bo *bo;
> +	int priority;
> +
> +	if (op->base.op !=3D DRM_GPUVA_OP_MAP)
> +		return;
> +
> +	bo =3D xe_vma_bo(op->map.vma);
> +	if (!bo)
> +		return;
> +
> +	/* Private BOs are only ever bound to the VM they were created for. */
> +	xe_assert(vm->xe, !bo->vm || bo->vm =3D=3D vm);

[Severity: High]
Could this regression allow a data race and TTM LRU list corruption if
userspace binds a private BO associated with another VM?

If userspace binds a private BO associated with VM_A to VM_B, the xe_assert=
()
doesn't prevent execution from continuing (and may compile out in non-debug
builds).

During the bind operation, vma_lock_and_validate() skips acquiring the BO's
resv lock because it assumes any BO with a non-NULL bo->vm shares the target
VM's lock:

drivers/gpu/drm/xe/xe_vm.c:vma_lock_and_validate() {
    ...
	if (bo) {
		if (!bo->vm)
			err =3D drm_exec_lock_obj(exec, &bo->ttm.base);
    ...
}

This means op_update_bo_priority() will call xe_bo_update_ttm_priority() to
mutate bo->ttm.priority and TTM LRU structures without holding the required
bo->ttm.base.resv lock. Can an unprivileged userspace application trigger t=
his
by passing a mismatched BO handle to the bind IOCTL?

> +
> +	priority =3D bo->vm ? xe_vm_bo_priority(vm) : XE_BO_PRIORITY_HIGHEST;
> +	if (bo->ttm.priority =3D=3D priority)
> +		return;
> +
> +	xe_vm_assert_held(vm);
> +	xe_bo_update_ttm_priority(bo, priority);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715042832.3625=
096-1-matthew.brost@intel.com?part=3D3
