Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7C606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQnWu69L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D4A10EA36;
	Tue, 17 Nov 2026 15:34:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A86110EB49;
 Tue, 17 Nov 2026 15:34:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F20B445565;
 Tue, 17 Nov 2026 15:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC81F000C4;
 Tue, 17 Nov 2026 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794929647;
 bh=mLz6qf8hFOuGaQy2piZECzhFN4a9YeKCoGb56tOqUTg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VQnWu69LtQwQ8/nmCG30hDdFGM2EkRR7cmS50VNzVtopF1LBPWBowsSkMuhrg6T2w
 /LIYMv6g03JFtCCIJp6HxiFE5ozjNDxWb/NMIOXcm2p0nA7TVYjVNd4H3pFDABTZCO
 2vw4hVcMU6iLN+6Jgktv+IM1gm4ysns+31E/dSTyZqyZmAGt7gAmAlPprWQkR89jWi
 J4f3e+9x/NooL8obiw1snVSYecPp1Pn4KUNeiyl3bhFPyQ/oMFqx+1KA55GfJjpKpD
 GHTraYXc7Pz1bfD29U+E29ZIBq4IOGmoOcIlneUB8p/3YJVn1tctKEsmKsiZEAF4hp
 PVQ5vz8YFKF7A==
Message-ID: <sashiko-outbox-219088@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] drm/amdgpu: Add new AMDGPU_GEM_VA2 ioctl
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-prt-explicit-sync-v2-9-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-9-bb3851cb6a0c@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:34:07 +0000
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

Thank you for your contribution! Sashiko AI review found 15 potential
issues to consider:
- [High] drm/amdgpu: wrong argument to amdgpu_vm_bo_unmap() in
  amdgpu_gem_va2_ioctl()
- [High] drm/amdgpu: syncobj_handles leak in
  amdgpu_gem_prepare_timeline_nodes()
- [High] drm/amdgpu: uninitialized fence pointer in
  amdgpu_gem_va2_ioctl() error path
- [High] drm/amdgpu: lost bo_va->last_pt_update and TLB fences in
  amdgpu_gem_va2_ioctl()
- [High] drm/amdgpu: wrong struct in DRM_IOCTL_AMDGPU_GEM_VA2 macro
  definition
- [High] drm/amdgpu: missing runtime PM acquisition in
  amdgpu_gem_va2_ioctl()
- [High] drm/amdgpu: unlocked BO update on CLEAR/REPLACE in
  amdgpu_gem_va2_ioctl()
- [High] drm/amdgpu: unlocked amdgpu_vm_bo_find() call in
  amdgpu_gem_va2_ioctl()
- [High] drm/amdgpu: gobj ref leak on lock contention/error in
  amdgpu_gem_va2_ioctl()
- [High] drm/amdgpu: memory leak and list corruption in
  amdgpu_vm_update_ctx_rollback()
- [High] drm/amdgpu: fence ref leak when merging fences in
  amdgpu_gem_va2_ioctl()
- [Medium] drm/amdgpu: delay never set to true in amdgpu_gem_va2_ioctl()
- [Medium] drm/amdgpu: wrong pointer in PTR_ERR() in
  amdgpu_gem_add_input_fence()
- [Medium] drm/amdgpu: gobj ref leak on drm_exec_lock_obj() contention
  or error
- [Medium] drm/amdgpu: in-place VA masking in amdgpu_gem_va2_ioctl()
  breaks retry
--

commit dddcd1a96bab3eebca95b4fd6d51bf06141d06e1
Author: Natalie Vock <nat@pixelcluster.dev>

drm/amdgpu: Add new AMDGPU_GEM_VA2 ioctl

This commit adds the DRM_IOCTL_AMDGPU_GEM_VA2 ioctl to batch multiple VM
mapping operations in a single call with multiple input and output binary or
timeline syncobjs.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 7eed5c360be20..6d6a6017d4787 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -53,10 +53,13 @@ static int
>  amdgpu_gem_add_input_fence(struct drm_file *filp,
>  			   struct amdgpu_vm_update_ctx *update_ctx,
>  			   uint64_t syncobj_handles_array,
> +			   uint64_t syncobj_points_array,
>  			   uint32_t num_syncobj_handles)
>  {
>  	struct dma_fence *fence;
>  	uint32_t *syncobj_handles;
> +	uint64_t *syncobj_points;
> +	uint64_t point;
>  	int ret, i;
> =20
>  	if (!num_syncobj_handles)
> @@ -67,6 +70,17 @@ amdgpu_gem_add_input_fence(struct drm_file *filp,
>  	if (IS_ERR(syncobj_handles))
>  		return PTR_ERR(syncobj_handles);
> =20
> +	if (syncobj_points_array) {
> +		syncobj_points =3D memdup_user(u64_to_user_ptr(syncobj_points_array),
> +					      size_mul(sizeof(uint64_t), num_syncobj_handles));
> +		if (IS_ERR(syncobj_points)) {
> +			kfree(syncobj_handles);
> +			return PTR_ERR(syncobj_handles);
> +		}

[Severity: Medium]
Should this return PTR_ERR(syncobj_points) instead of
PTR_ERR(syncobj_handles)?  syncobj_handles is a valid kernel heap pointer
here, so returning PTR_ERR(syncobj_handles) leaks its lower 32 bits as the
ioctl return value (or returns 0 if 4 GiB-aligned).

[ ... ]

> +static int amdgpu_gem_prepare_timeline_nodes(
> +	struct drm_file *filp, uint64_t syncobj_handles_array,
> +	uint64_t syncobj_points_array, uint32_t num_syncobjs,
> +	struct amdgpu_gem_timeline_out *out)
> +{
> +	uint32_t *syncobj_handles;
> +	uint32_t i;
> +	int r;
> +
> +	syncobj_handles =3D memdup_user(u64_to_user_ptr(syncobj_handles_array),
> +				      size_mul(sizeof(uint32_t), num_syncobjs));
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);

[ ... ]

> +	for (i =3D 0; i < num_syncobjs; i++) {
> +		out->syncobjs[i] =3D drm_syncobj_find(filp, syncobj_handles[i]);
> +		if (!out->syncobjs[i]) {
> +			r =3D -ENOENT;
> +			goto err_loop_rollback;
> +		}
> +
> +		if (!out->timeline_points[i])
> +			continue;
> +
> +		out->chains[i] =3D dma_fence_chain_alloc();
> +		if (!out->chains[i]) {
> +			r =3D -ENOMEM;
> +			goto err_loop_rollback;
> +		}
> +
> +		continue;
> +err_loop_rollback:
> +		for (;;) {
> +			if (out->syncobjs[i])
> +				drm_syncobj_put(out->syncobjs[i]);
> +			if (out->chains[i])
> +				dma_fence_chain_free(out->chains[i]);
> +			if (i-- =3D=3D 0)
> +				goto err_free_sync;
> +		}
> +	}
> +
> +	return 0;

[Severity: High]
Does the success path here leak syncobj_handles?  kfree(syncobj_handles) is
only called on the error path at err_free_handles, so every call with
num_syncobjs > 0 leaks the memdup_user() buffer.

[ ... ]

> @@ -1100,6 +1218,232 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, v=
oid *data,
>  	return r;
>  }
> =20
> +int amdgpu_gem_va2_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_va2 *args =3D data;
> +	struct amdgpu_device *adev =3D drm_to_adev(dev);
> +	struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +	struct drm_amdgpu_gem_va_mapping *mappings;
> +	struct amdgpu_gem_timeline_out tl_out;
> +	struct amdgpu_vm_update_ctx update_ctx;
> +	struct drm_gem_object *gobj;
> +	struct amdgpu_bo_va *bo_va;
> +	struct drm_exec exec;
> +	bool delay =3D false;
> +	u32 i;
> +	int r;
> +
> +	mappings =3D vmemdup_array_user(u64_to_user_ptr(args->mappings),
> +				      args->num_mappings,
> +				      sizeof(struct drm_amdgpu_gem_va_mapping));
> +	if (IS_ERR(mappings))
> +		return PTR_ERR(mappings);
> +
> +	r =3D amdgpu_gem_prepare_timeline_nodes(filp, args->syncobjs_out,
> +					      args->timeline_points_out,
> +					      args->num_syncobjs_out, &tl_out);
> +	if (r)
> +		goto out_free_mappings;
> +
> +	drm_exec_init(&exec,
> +		      DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES,
> +		      0);
> +	amdgpu_vm_update_ctx_init(&update_ctx, adev, &fpriv->vm);

[Severity: High]
Does amdgpu_gem_va2_ioctl() need to acquire a runtime PM reference via
PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(), like amdgpu_gem_va_ioctl() doe=
s?
Without it, non-delayed VM updates can write to VRAM, flush HDP via MMIO, or
submit SDMA jobs while the GPU is runtime-suspended.

> +	update_ctx.explicit_sync_unmap =3D true;
> +
> +	r =3D amdgpu_gem_add_input_fence(filp, &update_ctx, args->syncobjs_in,
> +				       args->timeline_points_in,
> +				       args->num_syncobjs_in);
> +	if (r)
> +		goto out;
> +
> +	drm_exec_until_all_locked(&exec)
> +	{
> +		r =3D amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto out;
> +
> +		for (i =3D 0; i < args->num_mappings; ++i) {
> +			r =3D amdgpu_gem_va_validate_args(adev, mappings[i].va,
> +							mappings[i].map_size,
> +							mappings[i].flags);
> +			if (r)
> +				goto out;
> +
> +			mappings[i].va &=3D AMDGPU_GMC_HOLE_MASK;

[Severity: Medium]
Can masking mappings[i].va in place break retries on lock contention?  For
an address in the upper canonical range (>=3D AMDGPU_GMC_HOLE_END), masking=
 it
with AMDGPU_GMC_HOLE_MASK places it inside [AMDGPU_GMC_HOLE_START,
AMDGPU_GMC_HOLE_END), so if drm_exec_until_all_locked() retries the loop,
amdgpu_gem_va_validate_args() will reject mappings[i].va with -EINVAL.

> +
> +			if (mappings[i].flags & AMDGPU_VM_DELAY_UPDATE) {
> +				/* Can't delay if we're supposed to signal fences */
> +				if (args->num_syncobjs_out) {
> +					r =3D -EINVAL;
> +					goto out;
> +				}
> +				/* If one mapping is delayed, all mappings must be delayed */
> +				if (i && !delay) {
> +					r =3D -EINVAL;
> +					goto out;
> +				}
> +			} else if (delay) {
> +				/* If one mapping is not delayed, no mappings may be delayed */
> +				r =3D -EINVAL;
> +				goto out;
> +			}

[Severity: Medium]
Is delay ever set to true when AMDGPU_VM_DELAY_UPDATE is set?  Because delay
stays false, any batch with two or more delayed mappings fails with -EINVAL
at if (i && !delay), a batch where only mappings[0] is delayed is not
rejected, and page table updates are still executed immediately.

> +
> +			if ((mappings[i].operation !=3D AMDGPU_VA_OP_CLEAR) &&
> +			    !(mappings[i].flags & AMDGPU_VM_PAGE_PRT)) {
> +				gobj =3D drm_gem_object_lookup(
> +					filp, mappings[i].handle);
> +				if (gobj =3D=3D NULL) {
> +					r =3D -ENOENT;
> +					goto out;
> +				}
> +				bo_va =3D amdgpu_vm_bo_find(
> +					&fpriv->vm, gem_to_amdgpu_bo(gobj));
> +				if (!bo_va) {
> +					drm_gem_object_put(gobj);
> +					r =3D -ENOENT;
> +					goto out;
> +				}

[Severity: High]
Is it safe to call amdgpu_vm_bo_find() before locking gobj with
drm_exec_lock_obj()?  amdgpu_vm_bo_find() walks bo->vm_bo, which is
protected by bo->tbo.base.resv; on a shared BO, another DRM file can
concurrently modify bo->vm_bo and free its amdgpu_bo_va in
amdgpu_vm_bo_del().

> +			} else {
> +				gobj =3D NULL;
> +				bo_va =3D mappings[i].operation !=3D
> +							AMDGPU_VA_OP_CLEAR ?
> +						fpriv->prt_va :
> +						NULL;
> +			}
> +
> +			if (gobj) {
> +				r =3D drm_exec_lock_obj(&exec, gobj);
> +				if (drm_exec_is_contended(&exec))
> +					amdgpu_vm_update_ctx_rollback(
> +						&update_ctx);

[Severity: High]
When amdgpu_vm_update_ctx_rollback() runs here on lock contention (or via
amdgpu_vm_update_ctx_fini() on error), does it leak ctx->new mappings and
corrupt ctx->cleared?

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_update_ctx_rollback() {
    ...
	list_for_each_entry_safe(mapping, next, &ctx->new, pending_list)
		list_del_init(&mapping->pending_list);
	list_for_each_entry_safe(mapping, next, &ctx->deleted, pending_list)
		list_del_init(&mapping->pending_list);
    ...
}

Entries on ctx->new were allocated by amdgpu_vm_bo_map() or
amdgpu_vm_bo_replace_map() and are unlinked without kfree(mapping).
In addition, ctx->cleared is never unlinked at all, leaving live mappings in
fpriv->vm.va with mapping->pending_list pointing into update_ctx.cleared on
the stack.

> +				drm_exec_retry_on_contention(&exec);

[Severity: Medium]
Does drm_exec_retry_on_contention(&exec) leak the gobj reference from
drm_gem_object_lookup()?  drm_exec_lock_obj() takes its own reference for
exec->contended on -EDEADLK, and jumping back to the start of the loop
skips drm_gem_object_put(gobj) below.

> +				if (unlikely(r))
> +					goto out;
> +			}

[Severity: High]
Does jumping to out when drm_exec_lock_obj() returns a non-contention error
(such as -EINTR or -ENOMEM) also leak the gobj lookup reference?
drm_exec_lock_obj() does not record gobj in exec->objects on failure, and
goto out bypasses drm_gem_object_put(gobj).

> +
> +			switch (mappings[i].operation) {
> +			case AMDGPU_VA_OP_MAP:
> +				r =3D amdgpu_vm_bo_map(&update_ctx, bo_va,
> +						     mappings[i].va,
> +						     mappings[i].offset_in_bo,
> +						     mappings[i].map_size,
> +						     mappings[i].flags);
> +				break;
> +			case AMDGPU_VA_OP_UNMAP:
> +				r =3D amdgpu_vm_bo_unmap(&update_ctx, bo_va,
> +						       mappings[i].flags);
> +				break;

[Severity: High]
Should amdgpu_vm_bo_unmap() be passed mappings[i].va instead of
mappings[i].flags?  Passing flags as the virtual address makes
AMDGPU_VA_OP_UNMAP look up page 0 and fail with -ENOENT.

[ ... ]

> +	if (!delay && (!adev->debug_vm || args->num_syncobjs_out)) {
> +		struct dma_fence *fence, *merged;
> +
> +		if (!amdgpu_vm_ready(&fpriv->vm)) {
> +			fence =3D dma_fence_get_stub();
> +			goto insert_fence;
> +		}
> +
> +		r =3D amdgpu_vm_clear_freed(&update_ctx, &fpriv->vm.last_update);
> +		if (r) {
> +			drm_err(adev_to_drm(adev),
> +				"Could not clear freed PT entries: %d\n", r);
> +			goto insert_fence;
> +		}

[Severity: High]
If amdgpu_vm_clear_freed() fails, does goto insert_fence use an
uninitialized fence pointer?  fence is only initialized afterwards, so
insert_fence will pass stack garbage to drm_syncobj_replace_fence(),
drm_syncobj_add_point(), and dma_fence_put().

> +
> +		fence =3D dma_fence_get(fpriv->vm.last_update);
> +
> +		list_for_each_entry(bo_va, &update_ctx.dirty_bo_vas,
> +				    update_link) {
> +			r =3D amdgpu_vm_bo_update(&update_ctx, bo_va, false);
> +			if (r) {
> +				drm_err(adev_to_drm(adev),
> +					"Could not update BO PT entries: %d\n", r);
> +				goto insert_fence;
> +			}
> +		}

[Severity: High]
Can this loop call amdgpu_vm_bo_update() on BOs whose dma_resv is not
locked?

AMDGPU_VA_OP_CLEAR locks no BO, and AMDGPU_VA_OP_REPLACE only locks the new
BO from mappings[i].handle.  However, amdgpu_vm_update_ctx_execute_replace()
adds the bo_va of every existing mapping that was cleared or split to
update_ctx.dirty_bo_vas, so amdgpu_vm_bo_update() then accesses
bo->tbo.resource and calls amdgpu_sync_resv() on those affected BOs without
holding their reservation locks.

> +
> +		list_for_each_entry(bo_va, &update_ctx.dirty_bo_vas,
> +				    update_link) {
> +			if (!amdgpu_vm_is_bo_always_valid(&fpriv->vm,
> +							  bo_va->base.bo)) {
> +				dma_fence_put(bo_va->last_pt_update);
> +				bo_va->last_pt_update =3D dma_fence_get(fence);
> +			}
> +		}

[Severity: High]
Does this discard the page table update fences just generated by
amdgpu_vm_bo_update()?

For non-always-valid BOs (and PRT mappings where bo is NULL),
amdgpu_vm_bo_update() stores the new PT update fence in
bo_va->last_pt_update rather than fpriv->vm.last_update.  Overwriting
bo_va->last_pt_update with the pre-update fence without merging
bo_va->last_pt_update (or fpriv->vm.last_tlb_inv) into fence drops those PT
update and TLB invalidation fences from both bo_va->last_pt_update and the
signaled output syncobjs.

> +
> +		/* Always update PDEs after we touched the mappings. */
> +		r =3D amdgpu_vm_update_pdes(adev, &fpriv->vm, false);
> +		if (r)
> +			goto insert_fence;
> +
> +		merged =3D dma_fence_unwrap_merge(fence, fpriv->vm.last_update);
> +		if (!merged) {
> +			/* As fallback in OOM situations */
> +			dma_fence_wait(fpriv->vm.last_update, false);
> +			dma_fence_wait(fence, false);
> +			merged =3D dma_fence_get_stub();
> +		}
> +		fence =3D merged;

[Severity: High]
Does assigning fence =3D merged without calling dma_fence_put(fence) leak t=
he
fence reference acquired before the amdgpu_vm_bo_update() loop?

> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 29009f6aabde9..c9e52bfa7d028 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -83,6 +84,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AM=
DGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>  #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
> +#define DRM_IOCTL_AMDGPU_GEM_VA2	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_G=
EM_VA2, struct drm_amdgpu_gem_va)

[Severity: High]
Should DRM_IOCTL_AMDGPU_GEM_VA2 use struct drm_amdgpu_gem_va2 instead of
struct drm_amdgpu_gem_va?  struct drm_amdgpu_gem_va is 64 bytes whereas
struct drm_amdgpu_gem_va2 is 56 bytes, so drm_ioctl() will copy 8 bytes past
the end of the user struct.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-prt-explic=
it-sync-v2-0-bb3851cb6a0c@pixelcluster.dev?part=3D9
