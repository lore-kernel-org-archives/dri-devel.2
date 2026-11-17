Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgn0KcS7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EFF10E431;
	Tue, 17 Nov 2026 15:06:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAB910E19B;
 Tue, 17 Nov 2026 15:06:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65022635BF;
 Tue, 17 Nov 2026 15:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74771F000C7;
 Tue, 17 Nov 2026 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927990;
 bh=w/mdGnCHRu6CoYOAy/uAzQ0WBxxu5KKBMGLflrKoquo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kgn0KcS7fY2nTGLNpYj9mMDHSBNr2tJ2TkMcLGrmDpswXevXJW5mnYTTyaZ4rwuNY
 JTriOirv/ZpFsMaCfpc4REKfven7k4k/l7dN9q8SPyrUkreZt7VgLij+ijrNVIgje9
 TmbQh6Xc7HGcmvDMrjF0oSR+vOAKpW+pXbIGW0hk2dnvCgT6VL41OnmCV34yRGC6wo
 4iJf1IfqDx+lihFB6PsZNekU+zrnKwM7S1c2qZ2FWXBfIQCs+cqzXWwkO3BNRJWotO
 g3kmxTYakJ+I4P7XKbgFKS9nedSxkHbNDUAOw59r1wn6WUZFk55swy9tYqVYQ4x24d
 fMsmxalTzCxCg==
Message-ID: <sashiko-outbox-219018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] drm/amdgpu: Only reject conflicting mappings
 if they are not cleared
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-prt-explicit-sync-v2-8-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-8-bb3851cb6a0c@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:06:29 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Critical] drm/amdgpu: amdgpu_vm_update_ctx_rollback() fails to unlink
  ctx->cleared
- [High] drm/amdgpu: missing interval tree iteration in
  amdgpu_vm_bo_map()
- [High] drm/amdgpu: amdgpu_vm_bo_map() ignores conflicts on partially
  cleared ranges
- [High] drm/amdgpu: amdgpu_vm_update_ctx_rollback() leaks ctx->new
  mappings
- [High] drm/amdgpu: missing amdgpu_vm_update_ctx_commit() in
  unmap_bo_from_gpuvm()
--

commit 4bdb539ca2c3dc59efa5a70eaf09b4e87c351cb1
Author: Natalie Vock <nat@pixelcluster.dev>

drm/amdgpu: Only reject conflicting mappings if they are not cleared

This commit updates amdgpu_vm_bo_map() to only reject an overlapping
mapping in the VM interval tree when its pending_list is empty.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index ac4a1ed9b1196..491f4b50f7602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2241,7 +2241,7 @@ int amdgpu_vm_bo_map(struct amdgpu_vm_update_ctx *c=
tx,
>  	eaddr =3D saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
> =20
>  	tmp =3D amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
> -	if (tmp) {
> +	if (tmp && list_empty(&tmp->pending_list)) {
>  		/* bo and tmp overlap, invalid addr */
>  		dev_err(ctx->adev->dev,
>  			"bo %p va 0x%010Lx-0x%010Lx conflict with "

[Severity: High]
Can amdgpu_vm_bo_map() miss a conflict when [saddr, eaddr] overlaps more
than one mapping in vm->va?

If the first node returned by amdgpu_vm_it_iter_first() has a non-empty
pending_list (because it was unmapped or cleared earlier in the same
update context) and a subsequent overlapping node in [saddr, eaddr] is
still active with an empty pending_list, amdgpu_vm_bo_map() never walks
the remaining nodes via amdgpu_vm_it_iter_next().
amdgpu_vm_update_ctx_commit() then inserts the new mapping into vm->va on
top of the active mapping.

Should this loop with amdgpu_vm_it_iter_next(tmp, saddr, eaddr) over all
overlapping nodes in [saddr, eaddr] and reject the map if any node has an
empty pending_list?

[Severity: High]
Does checking list_empty(&tmp->pending_list) also allow mapping over the
uncleared portion of a partially cleared mapping?

When amdgpu_vm_bo_clear_mappings() partially clears an existing mapping
tmp, it adds the entire unsplit mapping to ctx->cleared via
tmp->pending_list while recording only the cleared sub-range in
ctx->cleared_ranges:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_bo_clear_mappings() {
	...
	tmp =3D amdgpu_vm_it_iter_first(&ctx->vm->va, saddr, eaddr);
	while (tmp) {
		amdgpu_vm_update_ctx_add_replaced_mapping(ctx, tmp);
		tmp =3D amdgpu_vm_it_iter_next(tmp, saddr, eaddr);
	}

	cleared_range->start =3D saddr;
	cleared_range->last =3D eaddr;
	interval_tree_insert(cleared_range, &ctx->cleared_ranges);
	...
}

Because list_empty(&tmp->pending_list) is false across all of
[tmp->start, tmp->last], a subsequent amdgpu_vm_bo_map() overlapping the
still-active part of tmp is not rejected here.  If a later clear in the
same update context covers that remaining range,
amdgpu_vm_update_ctx_execute_replace() produces no gap mapping to collide
with ctx->pending_maps, so the invalid map succeeds without ever reporting
a conflict.

[Severity: Critical]
What happens to tmp->pending_list when an update context is rolled back
after staging cleared mappings on ctx->cleared?

In commit "drm/amdgpu: Add function to roll back a VM update ctx",
amdgpu_vm_update_ctx_rollback() unlinks ctx->new and ctx->deleted, but
does not unlink ctx->cleared:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_update_ctx_rollback() {
	...
	list_for_each_entry_safe(mapping, next, &ctx->new, pending_list)
		list_del_init(&mapping->pending_list);
	list_for_each_entry_safe(mapping, next, &ctx->deleted, pending_list)
		list_del_init(&mapping->pending_list);
	...
}

If an operation rolls back after amdgpu_vm_bo_clear_mappings() or
amdgpu_vm_bo_replace_map() has placed a live mapping onto ctx->cleared,
that mapping stays in vm->va with mapping->pending_list pointing into the
expired stack-allocated update_ctx.cleared head.  Because
list_empty(&mapping->pending_list) then remains false, this check in
amdgpu_vm_bo_map() treats the live mapping as cleared and allows
conflicting mappings over it.  In addition,
amdgpu_vm_update_ctx_add_freed_mapping() skips any mapping whose
pending_list is not empty, so amdgpu_vm_bo_del() frees bo_va while leaving
its mapping in vm->va with a dangling bo_va pointer, leading to a
use-after-free on later VM interval tree walks.

[Severity: High]
Does rolling back a context after amdgpu_vm_bo_map() queues a new mapping
leak the mapping allocation?

amdgpu_vm_bo_map() allocates mapping with kmalloc_obj(*mapping) and
queues it on ctx->new via amdgpu_vm_update_ctx_add_new_mapping(), only
inserting it into vm->va and bo_va->invalids when
amdgpu_vm_update_ctx_commit() runs.  When a later step fails (such as
amdgpu_vm_update_ctx_execute_replace() after mapping over a partially
cleared range) or hits lock contention, amdgpu_vm_update_ctx_rollback()
calls list_del_init(&mapping->pending_list) on each entry in ctx->new
without freeing mapping.

[Severity: High]
In commit "drm/amdgpu: Make removed/cleared mappings pending per update
context", does unmap_bo_from_gpuvm() also miss a call to
amdgpu_vm_update_ctx_commit() before clearing freed mappings?

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:unmap_bo_from_gpuvm() {
	...
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

Because amdgpu_vm_bo_unmap() only stages the mapping on
update_ctx.deleted until amdgpu_vm_update_ctx_commit() moves it to
update_ctx.freed and removes it from vm->va, amdgpu_vm_clear_freed() sees
an empty freed list and amdgpu_vm_update_ctx_fini() rolls the unmap back,
leaving the mapping active in vm->va.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-prt-explic=
it-sync-v2-0-bb3851cb6a0c@pixelcluster.dev?part=3D8
