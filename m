Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068C606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOqcAxsp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E701C10F725;
	Tue, 17 Nov 2026 13:26:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8D010F718;
 Tue, 17 Nov 2026 13:26:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3C076110A;
 Tue, 17 Nov 2026 13:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A961F000C7;
 Tue, 17 Nov 2026 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794921981;
 bh=fSoSdA9fLovj1gv0VS8BuMXouKRjFPqn12tY4z7tqsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HOqcAxsp/7LACdEC3dai3YkEltttno66xRPIF6zPGmM0o8gCy5r5sJkvcG2SLD7q/
 XEhPvgmlR8Tas/poxTMG1fG3sz5EtsfFgfaIZUCJV9AtOFexQuNTdEsVEshoNKGzCW
 gwiMvw+RWvCM1Lk2i6t+RTMZHHJFVnluITV2Rys+EaCL7NMJffrKWOKFMKeibg82wG
 uXpud+Mm9VKbKhSPseCZKrhUIadQLbXU/LSHv4DVxcOGLMyiKJZNJEfZLdimNm6/mg
 P/DM2ItJnlzX+dKjjFvxzh5Oj0Rlx063p2XF1A7fNAyvJtqahJHHMW3dbGysYG+gru
 vMDxuicwsIhjw==
Message-ID: <sashiko-outbox-218873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] drm/amdgpu: Add and use vm_update_ctx struct
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-prt-explicit-sync-v2-2-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-2-bb3851cb6a0c@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:26:20 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/amdgpu: fence and sync leaks in
  amdgpu_gem_add_input_fence() error paths
- [High] drm/amdgpu: stale vm->delayed_freed entries overwrite new PTEs
  in amdgpu_gem_va_update_vm()
- [Medium] drm/amdgpu: swallowed error and sync leak in
  amdgpu_vm_handle_moved()
- [Medium] drm/amdgpu: update_ctx.sync leak on seq64_va error in
  amdgpu_cs_vm_handling()
- [Medium] drm/amdgpu: input fences dropped in amdgpu_gem_va_ioctl()
  without PT range update
- [Medium] drm/amdgpu: cross-BO fence accumulation in
  amdgpu_vm_bo_update()
- [Low] drm/amdgpu: outdated kernel-doc comments for
  amdgpu_vm_bo_update() and vm_update_ctx
--

commit 613a377be8b434a7253a6f919cefd9f59fe0c3de
Author: Natalie Vock <nat@pixelcluster.dev>

drm/amdgpu: Add and use vm_update_ctx struct

This commit introduces struct amdgpu_vm_update_ctx to track freed mappings
and synchronization state across VM mapping and page table update
operations, and moves deferred unmaps onto vm->delayed_freed.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 71e2b83faa12b..d1f5ec9a3ef0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1126,6 +1126,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>  	struct amdgpu_vm *vm =3D &fpriv->vm;
>  	struct amdgpu_bo_list_entry *e;
>  	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_vm_update_ctx update_ctx;
>  	unsigned int i;
>  	int r;
> =20
> @@ -1147,34 +1148,36 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs=
_parser *p)
>  	if (!amdgpu_vm_ready(vm))
>  		return -EINVAL;
> =20
> -	r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
> +	r =3D amdgpu_vm_delayed_free(adev, vm, NULL);
>  	if (r)
>  		return r;
> =20
> -	r =3D amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
> +	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
> +
> +	r =3D amdgpu_vm_bo_update(&update_ctx, fpriv->prt_va, false);
>  	if (r)
> -		return r;
> +		goto err_fini_ctx;
> =20
>  	r =3D amdgpu_sync_fence(&p->sync, fpriv->prt_va->last_pt_update,
>  			      GFP_KERNEL);
>  	if (r)
> -		return r;
> +		goto err_fini_ctx;
> =20
>  	if (fpriv->csa_va) {
>  		bo_va =3D fpriv->csa_va;
> -		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
> +		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
>  		if (r)
> -			return r;
> +			goto err_fini_ctx;
> =20
>  		r =3D amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
>  				      GFP_KERNEL);
>  		if (r)
> -			return r;
> +			goto err_fini_ctx;
>  	}
> =20
>  	if (fpriv->seq64_va) {
>  		bo_va =3D fpriv->seq64_va;
> -		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
> +		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
>  		if (r) {
>  			DRM_ERROR("failed to do vm_bo_update on userq sem\n");
>  			return r;
>  		}
> =20
>  		r =3D amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
>  				      GFP_KERNEL);
>  		if (r)
>  			return r;
>  	}

[Severity: Medium]
Do the two error returns in the fpriv->seq64_va block leak
update_ctx.sync?  Both paths return r directly instead of jumping to
err_fini_ctx to call amdgpu_vm_update_ctx_fini(&update_ctx), leaking any
amdgpu_sync_entry allocations and dma_fence references added during the
earlier csa_va or seq64_va updates.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index c29df93790c53..e4492c44ce1cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -51,6 +51,7 @@
> =20
>  static int
>  amdgpu_gem_add_input_fence(struct drm_file *filp,
> +			   struct amdgpu_vm_update_ctx *update_ctx,
>  			   uint64_t syncobj_handles_array,
>  			   uint32_t num_syncobj_handles)
>  {
> @@ -77,9 +78,10 @@ amdgpu_gem_add_input_fence(struct drm_file *filp,
>  		if (ret)
>  			goto free_memdup;
> =20
> -		dma_fence_wait(fence, false);
> +		ret =3D amdgpu_sync_fence(&update_ctx->sync, fence, GFP_KERNEL);
> +		if (ret)
> +			goto free_memdup;
> =20
> -		/* TODO: optimize async handling */
>  		dma_fence_put(fence);
>  	}

[Severity: High]
Does jumping to free_memdup when amdgpu_sync_fence() fails leak the fence
reference acquired by drm_syncobj_find_fence()?

[ ... ]

> @@ -808,8 +811,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev,=
 void *data,
>   * otherwise stub fence in case of error.
>   */
>  static struct dma_fence *
> -amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
> -			struct amdgpu_vm *vm,
> +amdgpu_gem_va_update_vm(struct amdgpu_vm_update_ctx *ctx,
>  			struct amdgpu_bo_va *bo_va,
>  			uint32_t operation)
>  {
> @@ -817,10 +819,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	int r =3D 0;
> =20
>  	/* If the VM is not ready return only a stub. */
> -	if (!amdgpu_vm_ready(vm))
> +	if (!amdgpu_vm_ready(ctx->vm))
>  		return dma_fence_get_stub();
> =20
> -
>  	/*
>  	 * First clean up any freed mappings in the VM.
>  	 *
> @@ -828,20 +829,20 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	 * schedules GPU work. If nothing needs clearing, @fence can remain as
>  	 * the original vm->last_update.
>  	 */
> -	r =3D amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
> +	r =3D amdgpu_vm_clear_freed(ctx, &ctx->vm->last_update);
>  	if (r)
>  		goto error;
> =20
>  	/* For MAP/REPLACE we also need to update the BO mappings. */
>  	if (operation =3D=3D AMDGPU_VA_OP_MAP ||
>  	    operation =3D=3D AMDGPU_VA_OP_REPLACE) {
> -		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
> +		r =3D amdgpu_vm_bo_update(ctx, bo_va, false);
>  		if (r)
>  			goto error;
>  	}

[Severity: High]
Can stale entries on ctx->vm->delayed_freed overwrite newly mapped PTEs?

When an unmap is deferred (for example via AMDGPU_VM_DELAY_UPDATE),
amdgpu_vm_bo_unmap() removes the mapping from vm->va and
amdgpu_vm_update_ctx_fini() splices it onto vm->delayed_freed.  If
userspace then maps a BO at the same VA without AMDGPU_VM_DELAY_UPDATE,
amdgpu_gem_va_update_vm() only clears ctx->freed from the current ioctl and
writes the new BO's valid PTEs while the old unmap remains on
vm->delayed_freed.  A later amdgpu_vm_delayed_free() in
amdgpu_cs_vm_handling() or amdgpu_gem_object_close() will then zero those
active PTEs and cause GPU page faults.

In addition, amdgpu_userq_vm_validate_and_restore_queue() and KFD VM
updates never call amdgpu_vm_delayed_free(), leaving mappings on
vm->delayed_freed uncleared in those paths.

[ ... ]

> @@ -967,8 +969,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void=
 *data,
>  	if (r)
>  		goto error_put_gobj;
> =20
> +	amdgpu_vm_update_ctx_init(&update_ctx, adev, &fpriv->vm);
> +
>  	/* Add input syncobj fences (if any) for synchronization. */
> -	r =3D amdgpu_gem_add_input_fence(filp,
> +	r =3D amdgpu_gem_add_input_fence(filp, &update_ctx,
>  				       args->input_fence_syncobj_handles,
>  				       args->num_syncobj_handles);
>  	if (r)
>  		goto error_put_gobj;

[ ... ]

> @@ -1049,7 +1053,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, voi=
d *data,
>  	    (!adev->debug_vm || timeline_syncobj)) {
>  		struct dma_fence *fence;
> =20
> -		fence =3D amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> +		fence =3D amdgpu_gem_va_update_vm(&update_ctx, bo_va,
>  						args->operation);
>  		if (timeline_syncobj) {
>  			if (!args->vm_timeline_point) {
> @@ -1070,6 +1074,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, voi=
d *data,
>  	}
> =20
>  error:
> +	amdgpu_vm_update_ctx_fini(&update_ctx);
>  	dma_fence_chain_free(timeline_chain);
>  	if (timeline_syncobj)
>  		drm_syncobj_put(timeline_syncobj);
>  	drm_exec_fini(&exec);
>  error_put_gobj:
>  	drm_gem_object_put(gobj);
>  	return r;
>  }

[Severity: High]
Does jumping to error_put_gobj when amdgpu_gem_add_input_fence() fails
leak update_ctx.sync?  If amdgpu_gem_add_input_fence() adds a fence to
update_ctx.sync on the first handle and then fails on a later handle,
error_put_gobj skips amdgpu_vm_update_ctx_fini(&update_ctx) and leaks the
accumulated amdgpu_sync_entry allocations and dma_fence references.

[Severity: Medium]
Are input fences in update_ctx.sync silently dropped when
amdgpu_vm_update_range() does not run?

Previously, amdgpu_gem_add_input_fence() waited on each input fence with
dma_fence_wait().  Now the fences are queued in update_ctx.sync, which is
only consumed by amdgpu_vm_update_range().  When AMDGPU_VM_DELAY_UPDATE is
set, or when an operation such as AMDGPU_VA_OP_CLEAR on an unmapped range
does not emit a PT range update, amdgpu_vm_update_ctx_fini() frees
update_ctx.sync without waiting on the input fences or chaining them into
timeline_syncobj.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e0..90f27feb84257 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1319,37 +1319,31 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   * Returns:
>   * 0 for success, -EINVAL for failure.
>   */
> -int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va =
*bo_va,
> -			bool clear)
> +int amdgpu_vm_bo_update(struct amdgpu_vm_update_ctx *ctx,
> +			struct amdgpu_bo_va *bo_va, bool clear)
>  {
>  	struct amdgpu_bo *bo =3D bo_va->base.bo;
> -	struct amdgpu_vm *vm =3D bo_va->base.vm;
> +	struct amdgpu_vm *vm =3D ctx->vm;
>  	struct amdgpu_bo_va_mapping *mapping;
>  	struct dma_fence **last_update;
>  	dma_addr_t *pages_addr =3D NULL;
>  	struct ttm_resource *mem;
> -	struct amdgpu_sync sync;
>  	bool flush_tlb =3D clear;
>  	uint64_t vram_base;
>  	uint64_t flags;
>  	bool uncached;
>  	int r;
> =20
> -	amdgpu_sync_create(&sync);
>  	if (clear) {
>  		mem =3D NULL;
> =20
> -		/* Implicitly sync to command submissions in the same VM before
> -		 * unmapping.
> -		 */
> -		r =3D amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
> -				     AMDGPU_SYNC_EQ_OWNER, vm);
> +		r =3D amdgpu_vm_update_ctx_ensure_unmap_synced(ctx);
>  		if (r)
> -			goto error_free;
> +			goto error;
>  		if (bo) {
> -			r =3D amdgpu_sync_kfd(&sync, bo->tbo.base.resv);
> +			r =3D amdgpu_sync_kfd(&ctx->sync, bo->tbo.base.resv);
>  			if (r)
> -				goto error_free;
> +				goto error;
>  		}
>  	} else if (!bo) {
>  		mem =3D NULL;
> @@ -1374,16 +1368,16 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v, struct amdgpu_bo_va *bo_va,
>  			pages_addr =3D bo->tbo.ttm->dma_address;
> =20
>  		/* Implicitly sync to moving fences before mapping anything */
> -		r =3D amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
> +		r =3D amdgpu_sync_resv(ctx->adev, &ctx->sync, bo->tbo.base.resv,
>  				     AMDGPU_SYNC_EXPLICIT, vm);
>  		if (r)
> -			goto error_free;
> +			goto error;
>  	}

[Severity: Medium]
Does sharing ctx->sync across multiple amdgpu_vm_bo_update() calls cause
later BO updates to wait on unrelated fences?

amdgpu_vm_bo_update() adds per-BO moving fences, VM-wide
AMDGPU_SYNC_EQ_OWNER fences, and KFD eviction fences to ctx->sync before
checking whether bo_va->invalids is empty, and never clears per-BO fences
between calls.  When amdgpu_cs_vm_handling() or amdgpu_vm_handle_moved()
reuses one update_ctx across a loop of BOs, every subsequent PT update
waits on all earlier BOs' moving fences (even for BOs whose bo_va->invalids
was empty), and an earlier clear=3Dtrue BO forces later clear=3Dfalse updat=
es
in amdgpu_vm_handle_moved() to wait on prior VM submissions and enable
signaling on KFD eviction fences.

[ ... ]

> @@ -1679,18 +1748,22 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *=
adev,
>  			   struct amdgpu_vm *vm,
>  			   struct ww_acquire_ctx *ticket)
>  {
> +	struct amdgpu_vm_update_ctx update_ctx;
>  	struct amdgpu_bo_va *bo_va, *tmp;
>  	struct dma_resv *resv;
>  	struct amdgpu_bo *bo;
>  	bool clear, unlock;
>  	int r;
> =20
> +	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);
> +
>  	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.needs_update,
>  				 base.vm_status) {
>  		/* Per VM BOs never need to bo cleared in the page tables */
> -		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
> +		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
> +
>  		if (r)
> -			return r;
> +			goto error;
>  	}
> =20
>  	spin_lock(&vm->individual_lock);
> @@ -1716,7 +1789,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ad=
ev,
>  			unlock =3D false;
>  		}
> =20
> -		r =3D amdgpu_vm_bo_update(adev, bo_va, clear);
> +		r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, clear);
> =20
>  		if (unlock)
>  			dma_resv_unlock(resv);
>  		if (r)
>  			return r;
> =20
> @@ -1736,6 +1809,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ad=
ev,
>  	}
>  	spin_unlock(&vm->individual_lock);
> =20
> +error:
> +	amdgpu_vm_update_ctx_fini(&update_ctx);
> +
>  	return 0;
>  }

[Severity: Medium]
Does amdgpu_vm_handle_moved() swallow errors from the always_valid loop and
leak update_ctx.sync on errors in the individual loop?

When amdgpu_vm_bo_update() fails on an entry in
vm->always_valid.needs_update, jumping to error returns 0 instead of r, so
callers such as amdgpu_cs_vm_handling() proceed with stale page tables.
Conversely, when amdgpu_vm_bo_update() fails in the
vm->individual.needs_update loop, returning r directly skips
amdgpu_vm_update_ctx_fini(&update_ctx) and leaks update_ctx.sync.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index f6285a9d9e989..8445599d9539a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -264,6 +264,39 @@ struct amdgpu_task_info {
>  	struct kref	refcount;
>  };
> =20
> +/**
> + * struct amdgpu_vm_update_ctx
> + *
> + * Encapsulates various state that is carried around during VM updates.
> + */

[Severity: Low]
This isn't a bug, but scripts/kernel-doc expects a short description on the
struct amdgpu_vm_update_ctx line, and the kernel-doc comments on
amdgpu_vm_bo_update() and amdgpu_gem_va_update_vm() still list @adev and
@vm instead of @ctx.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-prt-explic=
it-sync-v2-0-bb3851cb6a0c@pixelcluster.dev?part=3D2
