Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CDF606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LP3spdmD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3256310EB7D;
	Tue, 17 Nov 2026 14:05:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0585E10EB7D;
 Tue, 17 Nov 2026 14:05:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BAD843607;
 Tue, 17 Nov 2026 14:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E711F000C6;
 Tue, 17 Nov 2026 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794924313;
 bh=bgHMfMeSa64s0EVHg+tX7qzUtCyYpj5CGBXVrH+t6n0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LP3spdmDbu9NIZTVsRO9t04RCXOUyuvSr1HXDaYnV9CYHAkaseN5u4dQ+0awC2Pdl
 M2P0k5B2Tc01oJIClS4e+8jjtJWSmwFd9wwr6jmPNE/BsnOuysslEAoRslsUzhM+mm
 xpS1DwN7YdoajcSzqmMgZJZQJIK0IcOfdDvHRfnjYVeGS4/DIzypD1fok914g7VvbR
 RiAhSbXKX9Ho+ujceo0TQiHE0pTj9xPsxVhtKcCm5gkiah44zNP5GavycLxWpgkHLC
 4pPI9qCqPFvIjskyzsMZTJ7eBSS4gDvpB80EzDvVzlG1VRzl2R2/PXudyHR5pZFDQV
 TUNhoRADtlu+g==
Message-ID: <sashiko-outbox-218921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] drm/amdgpu: Make removed/cleared mappings
 pending per update context
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-prt-explicit-sync-v2-4-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-4-bb3851cb6a0c@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:05:12 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/amdgpu: missing amdgpu_vm_update_ctx_commit() in
  unmap_bo_from_gpuvm()
- [High] drm/amdgpu: unclamped cleared mapping unmaps surviving gaps in
  clear_freed()
- [Medium] drm/amdgpu: uncleaned pending lists in
  amdgpu_vm_update_ctx_fini() on error
- [Medium] drm/amdgpu: cur_end moves backward on nested ranges in
  execute_replace()
- [Medium] drm/amdgpu: 32-bit PFN truncation in cleared_ranges
  interval_tree_node
- [Low] drm/amdgpu: mismatched @replaced kernel-doc tag for cleared
  list_head
--

commit 2c940ee3e7377ed3b2aa248bd851e7573259f51f
Author: Natalie Vock <nat@pixelcluster.dev>

drm/amdgpu: Make removed/cleared mappings pending per update context

This commit defers VM mapping removals and range clears into lists and
interval trees on struct amdgpu_vm_update_ctx until the context is
committed, and allows explicit synchronization when unmapping always-valid
BOs or PRT mappings.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 97cf04da6a025..1e2d45979efdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c

[ ... ]

> @@ -1652,10 +1716,103 @@ amdgpu_vm_update_ctx_add_new_mapping(struct amdg=
pu_vm_update_ctx *ctx,
>  	interval_tree_insert(pending, &ctx->pending_maps);
> =20
>  	mapping->bo_va =3D bo_va;
> +	WARN_ON(!list_empty(&mapping->pending_list));
>  	list_add(&mapping->pending_list, &ctx->new);
>  	return 0;
>  }
> =20
> +static void
> +amdgpu_vm_update_ctx_add_replaced_mapping(struct amdgpu_vm_update_ctx *c=
tx,
> +					  struct amdgpu_bo_va_mapping *mapping)
> +{
> +	if (list_empty(&mapping->pending_list))
> +		list_add(&mapping->pending_list, &ctx->cleared);
> +}
> +
> +static void
> +amdgpu_vm_update_ctx_add_freed_mapping(struct amdgpu_vm_update_ctx *ctx,
> +				       struct amdgpu_bo_va_mapping *mapping)
> +{
> +	WARN_ON(!list_empty(&mapping->pending_list));
> +	list_add(&mapping->pending_list, &ctx->deleted);
> +}
> +
> +int amdgpu_vm_update_ctx_execute_replace(struct amdgpu_vm_update_ctx *ct=
x)
> +{
> +	LIST_HEAD(new_maps);
> +	struct interval_tree_node *map;
> +	struct amdgpu_bo_va_mapping *cleared, *next, *gap;
> +	uint64_t cur_end;
> +	int r;
> +
> +	list_for_each_entry_safe(cleared, next, &ctx->cleared, pending_list) {
> +		cur_end =3D cleared->start;
> +
> +		map =3D interval_tree_iter_first(&ctx->cleared_ranges, cleared->start,=
 cleared->last);
> +		while (map && map->start <=3D cleared->last) {
> +			if (map->start <=3D cur_end) {
> +				cur_end =3D map->last + 1;
> +				map =3D interval_tree_iter_next(map, cleared->start, cleared->last);
> +				continue;
> +			}

[Severity: Medium]
Can cur_end move backward here when ctx->cleared_ranges contains nested or
overlapping intervals?  interval_tree_iter_first() and
interval_tree_iter_next() walk intervals in ascending order of map->start,
so if an earlier interval extends past a later one (for example, [0x10,
0x20] followed by [0x12, 0x15]), the second iteration sees map->start <=3D
cur_end and rewinds cur_end from 0x21 back to 0x16, causing the already
cleared subrange [0x16, 0x20] to be treated as an uncleared gap and
re-mapped (or rejected as a duplicate in
amdgpu_vm_update_ctx_add_new_mapping()).  Using max(cur_end, map->last + 1)
would prevent cur_end from decreasing.

> +
> +			gap =3D kmalloc_obj(*gap);
> +			if (!gap) {
> +				r =3D -ENOMEM;
> +				goto error;
> +			}
> +
> +			gap->bo_va =3D cleared->bo_va;
> +			gap->start =3D cur_end;
> +			gap->last =3D map->start - 1;
> +			gap->offset =3D cleared->offset;
> +			gap->offset +=3D (gap->start - cleared->start) << AMDGPU_GPU_PAGE_SHI=
FT;
> +			gap->flags =3D cleared->flags;
> +			list_add(&gap->pending_list, &new_maps);
> +
> +			cur_end =3D map->last + 1;
> +			map =3D interval_tree_iter_next(map, cleared->start, cleared->last);
> +		}
> +
> +		if (cur_end <=3D cleared->last) {
> +			gap =3D kmalloc_obj(*gap);
> +			if (!gap) {
> +				r =3D -ENOMEM;
> +				goto error;
> +			}
> +
> +			gap->bo_va =3D cleared->bo_va;
> +			gap->start =3D cur_end;
> +			gap->last =3D cleared->last;
> +			gap->offset =3D cleared->offset;
> +			gap->offset +=3D (gap->start - cleared->start) << AMDGPU_GPU_PAGE_SHI=
FT;
> +			gap->flags =3D cleared->flags;
> +			list_add(&gap->pending_list, &new_maps);
> +		}
> +
> +		list_del_init(&cleared->pending_list);
> +		amdgpu_vm_update_ctx_add_freed_mapping(ctx, cleared);
> +	}

[Severity: High]
Does queueing the unclamped cleared mapping onto ctx->deleted cause
amdgpu_vm_clear_freed() to wipe the hardware PTEs for the surviving gap
subranges too?

Previously, amdgpu_vm_bo_clear_mappings() clamped tmp->start and tmp->last
to [saddr, eaddr] before adding tmp to ctx->freed, so
amdgpu_vm_clear_freed() only cleared PTEs in the unmapped range.  With this
change, cleared keeps its full [cleared->start, cleared->last] span when
amdgpu_vm_bo_commit_remove() moves it to ctx->freed, while the surviving
gap mappings are added to cleared->bo_va->invalids.  In
amdgpu_gem_va_update_vm(), amdgpu_vm_clear_freed() then zeroes the hardware
PTEs across the entire original mapping, and the surviving gaps are never
re-populated in the page tables for AMDGPU_VA_OP_CLEAR (which never calls
amdgpu_vm_bo_update()) or for AMDGPU_VA_OP_REPLACE when the split mapping
belongs to another BO or fpriv->prt_va:

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:amdgpu_gem_va_update_vm() {
    ...
	r =3D amdgpu_vm_clear_freed(ctx, &ctx->vm->last_update);
	if (r)
		goto error;

	/* For MAP/REPLACE we also need to update the BO mappings. */
	if (operation =3D=3D AMDGPU_VA_OP_MAP ||
	    operation =3D=3D AMDGPU_VA_OP_REPLACE) {
		r =3D amdgpu_vm_bo_update(ctx, bo_va, false);
		if (r)
			goto error;
	}
    ...
}

Even when replacing a subrange with the same bo_va, amdgpu_vm_clear_freed()
clears the full original range and flushes the TLB before
amdgpu_vm_bo_update() restores the surviving subranges, which can fault
concurrent GPU work accessing the unmodified parts of the mapping.

[ ... ]

> @@ -1715,17 +1877,23 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_u=
pdate_ctx *ctx,
>   */
>  void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx)
>  {
> -	struct interval_tree_node *pending, *next_pending;
> +	struct interval_tree_node *node, *next_node;
> =20
>  	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
>  	amdgpu_sync_free(&ctx->sync);
> =20
> -	rbtree_postorder_for_each_entry_safe(pending, next_pending, &ctx->pendi=
ng_maps.rb_root, rb)
> -		kfree(pending);
> +	rbtree_postorder_for_each_entry_safe(node, next_node, &ctx->pending_map=
s.rb_root, rb) {
> +		kfree(node);
> +	}
> +	rbtree_postorder_for_each_entry_safe(node, next_node, &ctx->cleared_ran=
ges.rb_root, rb) {
> +		kfree(node);
> +	}
> =20
>  	ctx->pending_maps =3D RB_ROOT_CACHED;
> +	ctx->cleared_ranges =3D RB_ROOT_CACHED;
> =20
>  	WARN_ON(!list_empty(&ctx->new));
> +	WARN_ON(!list_empty(&ctx->deleted));
>  }

[Severity: Medium]
If an error occurs before amdgpu_vm_update_ctx_commit() is called=E2=80=94f=
or
example, when amdgpu_vm_update_ctx_add_new_mapping() fails in
amdgpu_vm_bo_replace_map() after amdgpu_vm_bo_clear_mappings() has already
populated ctx->cleared, or when an allocation or mapping insertion fails
midway through amdgpu_vm_update_ctx_execute_replace()=E2=80=94does
amdgpu_vm_update_ctx_fini() leak ctx->new mappings and leave live mappings
linked into the stack-allocated ctx->deleted and ctx->cleared lists?

In this commit, jumping to error in amdgpu_gem_va_ioctl() hits the WARN_ON()
checks, leaks any struct amdgpu_bo_va_mapping objects already moved to
ctx->new, and leaves existing mappings with mapping->pending_list pointing
into the popped update_ctx stack frame.  Note that commit "drm/amdgpu: Add
function to roll back a VM update ctx" later in the series adds
amdgpu_vm_update_ctx_rollback(), but that helper still only unlinks
ctx->new entries without calling kfree(mapping) and does not unlink entries
on ctx->cleared at all.

[ ... ]

> @@ -2178,24 +2345,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_vm_update_ctx=
 *ctx,
>  			return -ENOENT;
>  	}
> =20
> -	/* It's unlikely to happen that the mapping userq hasn't been idled
> -	 * during user requests GEM unmap IOCTL except for forcing the unmap
> -	 * from user space.
> -	 */
> -	if (unlikely(bo_va->userq_va_mapped))
> -		amdgpu_userq_gem_va_unmap_validate(ctx->adev, mapping);
> -
> -	list_del(&mapping->list);
> -	amdgpu_vm_it_remove(mapping, &vm->va);
> -	mapping->bo_va =3D NULL;
> -	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
> -
> -	if (valid)
> -		list_add(&mapping->list, &ctx->freed);
> -	else
> -		amdgpu_vm_free_mapping(ctx->adev, vm, mapping,
> -				       bo_va->last_pt_update);
> -
> +	amdgpu_vm_update_ctx_add_freed_mapping(ctx, mapping);
>  	return 0;
>  }

[Severity: High]
Does unmap_bo_from_gpuvm() also need to call amdgpu_vm_update_ctx_commit()
after amdgpu_vm_bo_unmap()?

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:unmap_bo_from_gpuvm() {
	struct amdgpu_bo_va *bo_va =3D entry->bo_va;
	struct amdgpu_vm *vm =3D peer_vm;
	struct amdgpu_vm_update_ctx update_ctx;

	amdgpu_vm_update_ctx_init(&update_ctx, adev, vm);

	(void)amdgpu_vm_bo_unmap(&update_ctx, bo_va, entry->va);

	/* VM entity stopped if process killed, don't clear freed pt bo */
	if (!amdgpu_vm_ready(vm))
		goto out;

	(void)amdgpu_vm_clear_freed(&update_ctx, &bo_va->last_pt_update);

	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);

out:
	amdgpu_vm_update_ctx_fini(&update_ctx);

	return 0;
}

Because amdgpu_vm_bo_unmap() now only queues the mapping onto
update_ctx.deleted until amdgpu_vm_update_ctx_commit() runs,
unmap_bo_from_gpuvm() passes an empty update_ctx.freed list to
amdgpu_vm_clear_freed() and never removes the mapping from bo_va or vm->va.
Every KFD unmap leaves the GPU page tables mapped, triggers
WARN_ON(!list_empty(&ctx->deleted)) in amdgpu_vm_update_ctx_fini(), and
leaves mapping->pending_list pointing at the stack-allocated update_ctx (or
rolls the unmap back once commit "drm/amdgpu: Add function to roll back a
VM update ctx" is applied).

> =20
> @@ -2214,8 +2364,8 @@ int amdgpu_vm_bo_unmap(struct amdgpu_vm_update_ctx =
*ctx,
>  int amdgpu_vm_bo_clear_mappings(struct amdgpu_vm_update_ctx *ctx,
>  				uint64_t saddr, uint64_t size)
>  {
> -	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
> -	LIST_HEAD(removed);
> +	struct interval_tree_node *cleared_range;
> +	struct amdgpu_bo_va_mapping *tmp;
>  	uint64_t eaddr;
>  	int r;
> =20
> @@ -2223,96 +2373,23 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_vm_=
update_ctx *ctx,
>  	if (r)
>  		return r;
> =20
> -	saddr /=3D AMDGPU_GPU_PAGE_SIZE;
> -	eaddr =3D saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
> -
> -	/* Allocate all the needed memory */
> -	before =3D kzalloc_obj(*before);
> -	if (!before)
> +	cleared_range =3D kmalloc_obj(*cleared_range);
> +	if (!cleared_range)
>  		return -ENOMEM;
> -	INIT_LIST_HEAD(&before->list);
> =20
> -	after =3D kzalloc_obj(*after);
> -	if (!after) {
> -		kfree(before);
> -		return -ENOMEM;
> -	}
> -	INIT_LIST_HEAD(&after->list);
> +	saddr /=3D AMDGPU_GPU_PAGE_SIZE;
> +	eaddr =3D saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
> =20
>  	/* Now gather all removed mappings */
>  	tmp =3D amdgpu_vm_it_iter_first(&ctx->vm->va, saddr, eaddr);
>  	while (tmp) {
> -		/* Remember mapping split at the start */
> -		if (tmp->start < saddr) {
> -			before->start =3D tmp->start;
> -			before->last =3D saddr - 1;
> -			before->offset =3D tmp->offset;
> -			before->flags =3D tmp->flags;
> -			before->bo_va =3D tmp->bo_va;
> -			list_add(&before->list, &tmp->bo_va->invalids);
> -		}
> -
> -		/* Remember mapping split at the end */
> -		if (tmp->last > eaddr) {
> -			after->start =3D eaddr + 1;
> -			after->last =3D tmp->last;
> -			after->offset =3D tmp->offset;
> -			after->offset +=3D (after->start - tmp->start) << AMDGPU_GPU_PAGE_SHI=
FT;
> -			after->flags =3D tmp->flags;
> -			after->bo_va =3D tmp->bo_va;
> -			list_add(&after->list, &tmp->bo_va->invalids);
> -		}
> -
> -		list_del(&tmp->list);
> -		list_add(&tmp->list, &removed);
> -
> +		amdgpu_vm_update_ctx_add_replaced_mapping(ctx, tmp);
>  		tmp =3D amdgpu_vm_it_iter_next(tmp, saddr, eaddr);
>  	}
> =20
> -	/* And free them up */
> -	list_for_each_entry_safe(tmp, next, &removed, list) {
> -		amdgpu_vm_it_remove(tmp, &ctx->vm->va);
> -		list_del(&tmp->list);
> -
> -		if (tmp->start < saddr)
> -		    tmp->start =3D saddr;
> -		if (tmp->last > eaddr)
> -		    tmp->last =3D eaddr;
> -
> -		tmp->bo_va =3D NULL;
> -		list_add(&tmp->list, &ctx->freed);
> -		trace_amdgpu_vm_bo_unmap(NULL, tmp);
> -	}
> -
> -	/* Insert partial mapping before the range */
> -	if (!list_empty(&before->list)) {
> -		struct amdgpu_bo *bo =3D before->bo_va->base.bo;
> -
> -		amdgpu_vm_it_insert(before, &ctx->vm->va);
> -		if (before->flags & AMDGPU_VM_PAGE_PRT)
> -			amdgpu_vm_prt_get(ctx->adev);
> -
> -		if (amdgpu_vm_is_bo_always_valid(ctx->vm, bo) &&
> -		    !before->bo_va->base.moved)
> -			amdgpu_vm_bo_needs_update(&before->bo_va->base);
> -	} else {
> -		kfree(before);
> -	}
> -
> -	/* Insert partial mapping after the range */
> -	if (!list_empty(&after->list)) {
> -		struct amdgpu_bo *bo =3D after->bo_va->base.bo;
> -
> -		amdgpu_vm_it_insert(after, &ctx->vm->va);
> -		if (after->flags & AMDGPU_VM_PAGE_PRT)
> -			amdgpu_vm_prt_get(ctx->adev);
> -
> -		if (amdgpu_vm_is_bo_always_valid(ctx->vm, bo) &&
> -		    !after->bo_va->base.moved)
> -			amdgpu_vm_bo_needs_update(&after->bo_va->base);
> -	} else {
> -		kfree(after);
> -	}
> +	cleared_range->start =3D saddr;
> +	cleared_range->last =3D eaddr;
> +	interval_tree_insert(cleared_range, &ctx->cleared_ranges);

[Severity: Medium]
On 32-bit architectures, does storing 64-bit GPU page frame numbers into
struct interval_tree_node truncate saddr and eaddr?

struct interval_tree_node uses unsigned long for start and last, whereas GPU
PFNs are uint64_t (up to 36 bits on 48-bit GPU VA spaces, which is why
amdgpu_vm.c defines its own uint64_t amdgpu_vm_it interval tree).  When a
mapping at or above 16 TiB (PFN >=3D 1ULL << 32) is cleared on a 32-bit bui=
ld,
cleared_range->start and cleared_range->last are truncated to 32 bits; in
amdgpu_vm_update_ctx_execute_replace(), cur_end =3D map->last + 1 then drops
below the 64-bit cleared->start, causing (gap->start - cleared->start) <<
AMDGPU_GPU_PAGE_SHIFT to underflow and produce an out-of-bounds gap->offset.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index d35494440cb5a..5657aa63e9491 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -284,11 +284,27 @@ struct amdgpu_vm_update_ctx {
>  	 */
>  	struct rb_root_cached pending_maps;
> =20
> +	/**
> +	 * @cleared_ranges: Interval tree of VA ranges cleared by this update o=
peration.
> +	 */
> +	struct rb_root_cached cleared_ranges;
> +
>  	/**
>  	 * @new: Pending new mappings not yet applied to bookkeeping structures.
>  	 */
>  	struct list_head new;
> =20
> +	/**
> +	 * @deleted: Pending freed mappings not yet applied to bookkeeping stru=
ctures.
> +	 */
> +	struct list_head deleted;
> +
> +	/**
> +	 * @replaced: Pending mappings that have been cleared, potentially part=
ially,
> +	 * and are not yet applied to bookkeeping structures.
> +	 */
> +	struct list_head cleared;

[Severity: Low]
This kernel-doc comment uses @replaced instead of @cleared to document
struct list_head cleared, which triggers a kernel-doc warning on W=3D1 buil=
ds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-prt-explic=
it-sync-v2-0-bb3851cb6a0c@pixelcluster.dev?part=3D4
