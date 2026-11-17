Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1523606A336
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOssXA88
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D7110F781;
	Tue, 17 Nov 2026 14:28:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE14710F781;
 Tue, 17 Nov 2026 14:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A0C240E58;
 Tue, 17 Nov 2026 14:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01811F000C4;
 Tue, 17 Nov 2026 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794925697;
 bh=MA0c4cOneuLD32OwZl6gBBL6dzZ926okDKSMQXY4r58=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZOssXA888MLYjaeNsORoNLErnOWOfwdXcJSpUOOWAK4mCYDPpUjCQeYd22zON1yo3
 Aou7QF9GFQhHr9hWZ/qdjKexyb/IOT6PD0sZKXdcaH3fL89vl7451yhDid1p5UoUQW
 JWpuTXHFai3v9W3OdfdD9fI5u3ytCouh/7eihXO6y0u5cQjVX359kabzTnOxt7CxtO
 bM5gSC0z0lVZdzBn5PUy6nSf9gCWLZfLaQXwjMQjnjJUw6CXkr1tI+upP4hBmekoSr
 pub95e1YyGhjwFiFDNZDs1F2nQ09FazDHAN7jfAy9pMez75aQ5CpH/IS90DrC+Ioy+
 MhN6bqy0TfH2g==
Message-ID: <sashiko-outbox-218965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] drm/amdgpu: Track dirty bo_va structures in
 update ctx
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-prt-explicit-sync-v2-5-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-5-bb3851cb6a0c@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:28:16 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdgpu: UAF on bo_va in amdgpu_vm_update_ctx_fini() after
  amdgpu_vm_bo_del()
- [High] drm/amdgpu: skipped delete in
  amdgpu_vm_update_ctx_add_freed_mapping()
- [Low] drm/amdgpu: update_link placed under wrong lock comment in
  amdgpu_bo_va
--

commit 3f1753904c640653510160bf642992a7a55fbc3d
Author: Natalie Vock <nat@pixelcluster.dev>

drm/amdgpu: Track dirty bo_va structures in update ctx

This commit adds an update_link list head to struct amdgpu_bo_va and tracks
modified bo_va structures in a dirty_bo_vas list on struct amdgpu_vm_update=
_ctx.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index e0090dc10682f..068c57ed537fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -80,6 +80,8 @@ struct amdgpu_bo_va {
>  	/* protected by bo being reserved */
>  	unsigned			ref_count;
> =20
> +	struct list_head		update_link;
> +
>  	/* all other members protected by the VM PD being reserved */
>  	struct dma_fence	        *last_pt_update;
> =20

[Severity: Low]
Should update_link be placed below the "all other members protected by the =
VM
PD being reserved" comment?  It is modified by the update_ctx helpers while
only the VM PD reservation lock is held, including when the individual BO is
NULL (such as fpriv->prt_va) or not reserved (when clearing overlapping
mappings of other BOs in the VM).

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 1e2d45979efdb..330c288053352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c

[ ... ]

> @@ -1733,8 +1735,10 @@ static void
>  amdgpu_vm_update_ctx_add_freed_mapping(struct amdgpu_vm_update_ctx *ctx,
>  				       struct amdgpu_bo_va_mapping *mapping)
>  {
> -	WARN_ON(!list_empty(&mapping->pending_list));
> -	list_add(&mapping->pending_list, &ctx->deleted);
> +	if (list_empty(&mapping->bo_va->update_link))
> +		list_add(&mapping->bo_va->update_link, &ctx->dirty_bo_vas);
> +	if (list_empty(&mapping->pending_list))
> +		list_add(&mapping->pending_list, &ctx->deleted);
>  }

[Severity: High]
Can skipping list_add(&mapping->pending_list, &ctx->deleted) when
mapping->pending_list is non-empty leave freed mappings in vm->va?

Within one update_ctx, amdgpu_vm_bo_clear_mappings() and
amdgpu_vm_bo_replace_map() put overlapping mappings onto ctx->cleared via
mapping->pending_list; if amdgpu_vm_bo_unmap() is then called on that mappi=
ng
in the same context, amdgpu_vm_update_ctx_add_freed_mapping() leaves it on
ctx->cleared instead of moving it to ctx->deleted, so
amdgpu_vm_update_ctx_execute_replace() re-inserts any non-cleared remainder.

Furthermore, if an update_ctx is aborted before
amdgpu_vm_update_ctx_execute_replace() finishes processing ctx->cleared (for
example, if amdgpu_vm_bo_replace_map() fails in
amdgpu_vm_update_ctx_add_new_mapping()), neither amdgpu_vm_update_ctx_fini()
here nor amdgpu_vm_update_ctx_rollback() in commit "drm/amdgpu: Add functio=
n to
roll back a VM update ctx" unlinks entries from ctx->cleared.  When the BO =
is
later removed in amdgpu_vm_bo_del(), amdgpu_vm_update_ctx_add_freed_mapping=
()
silently skips adding the mapping to update_ctx.deleted and kfree(bo_va) fr=
ees
bo_va while the mapping remains in vm->va with a dangling mapping->bo_va
pointer, causing a use-after-free on subsequent vm->va traversals.

>  int amdgpu_vm_update_ctx_execute_replace(struct amdgpu_vm_update_ctx *ct=
x)

[ ... ]

> @@ -1878,10 +1883,16 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_u=
pdate_ctx *ctx,
>  void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx)
>  {
>  	struct interval_tree_node *node, *next_node;
> +	struct amdgpu_bo_va *bo_va, *next_bo_va;
> =20
>  	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
>  	amdgpu_sync_free(&ctx->sync);
> =20
> +	list_for_each_entry_safe(bo_va, next_bo_va, &ctx->dirty_bo_vas,
> +				 update_link) {
> +		list_del_init(&bo_va->update_link);
> +	}

[Severity: High]
Does this cause a use-after-free on bo_va when a caller unmaps and deletes a
bo_va before finalizing update_ctx?

In amdgpu_unmap_static_csa(), amdgpu_vm_bo_unmap() adds bo_va->update_link =
to
update_ctx.dirty_bo_vas, and amdgpu_vm_bo_del() then frees bo_va before
amdgpu_vm_update_ctx_fini() runs:

drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c:amdgpu_unmap_static_csa() {
    ...
	r =3D amdgpu_vm_bo_unmap(&update_ctx, bo_va, csa_addr);
	if (r) {
		drm_err(adev_to_drm(adev),
			"failed to do bo_unmap on static CSA, err=3D%d\n", r);
		goto error_ctx;
	}
	amdgpu_vm_update_ctx_commit(&update_ctx);

	amdgpu_vm_bo_del(adev, bo_va);

error_ctx:
	amdgpu_vm_update_ctx_fini(&update_ctx);
    ...
}

Because amdgpu_vm_bo_del() calls kfree(bo_va) without unlinking
bo_va->update_link from the outer update_ctx.dirty_bo_vas,
amdgpu_vm_update_ctx_fini() executes list_del_init(&bo_va->update_link) on =
the
freed bo_va.  Unlinking bo_va->update_link in amdgpu_vm_bo_del() before
kfree(bo_va) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-prt-explic=
it-sync-v2-0-bb3851cb6a0c@pixelcluster.dev?part=3D5
