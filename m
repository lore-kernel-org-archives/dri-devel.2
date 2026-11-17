Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4B606A331
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgFlMFaF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2935110EBFB;
	Tue, 17 Nov 2026 13:43:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF36B10E5B6;
 Tue, 17 Nov 2026 13:43:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A1C346811;
 Tue, 17 Nov 2026 13:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550A61F000C5;
 Tue, 17 Nov 2026 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794922998;
 bh=Q8HVAFodqnoc4W3+zuB9Ach0UcpvmHqmtA2jQcoShiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hgFlMFaFb/rN+ckkChfU0e3H9a3gcj0KXKYg1Ev5kWMLlWYf7I90TO5Uo73UktNqM
 TeM0O0Vec3Kyhg1li22uMlBi8oDthT69JCD36MrvZiDH8e4Thg5dNypTVfS/0qr29O
 lduQyomho5Fmc50AkV/TooVDLdvvEJfPt3TpJJ0bG02M5fViBfrVMgNGovlO2V5ph/
 OpSVMeIarVGPaf8SO3M+3bZGUC/5v2t8itzAwnFXKRGnnMvgEos0iyklROxzNwlWlL
 ZxLXMFzpzpZdsAp26Mi23QKUewBxn4knhi/BaWrFF0m9nHLohYNtcG8aDujIUySOnm
 FqIHvEkof9UZQ==
Message-ID: <sashiko-outbox-218895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] drm/amdgpu: Make VM maps pending per update
 context
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-prt-explicit-sync-v2-3-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-3-bb3851cb6a0c@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:43:17 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/amdgpu: 64-bit PFN truncation in
  amdgpu_vm_update_ctx_add_new_mapping()
- [Low] drm/amdgpu: duplicate interval check in
  amdgpu_vm_update_ctx_add_new_mapping()
- [Low] drm/amdgpu: fix pending_maps kernel-doc in struct
  amdgpu_vm_update_ctx
--

commit 471887082bbdcd3f5636c1bb4feae875d96ebdb8
Author: Natalie Vock <nat@pixelcluster.dev>

drm/amdgpu: Make VM maps pending per update context

This commit stages new VM mappings in struct amdgpu_vm_update_ctx and
inserts them into the VM bookkeeping structures when
amdgpu_vm_update_ctx_commit() is called.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 90f27feb84257..97cf04da6a025 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1589,6 +1589,73 @@ static void amdgpu_vm_prt_fini(struct amdgpu_devic=
e *adev, struct amdgpu_vm *vm)

[ ... ]

> +static int
> +amdgpu_vm_update_ctx_add_new_mapping(struct amdgpu_vm_update_ctx *ctx,
> +				     struct amdgpu_bo_va *bo_va,
> +				     struct amdgpu_bo_va_mapping *mapping)
> +{
> +	struct interval_tree_node *pending;
> +
> +	if (interval_tree_iter_first(&ctx->pending_maps, mapping->start,
> +				     mapping->last))
> +		return -EINVAL;
> +
> +	pending =3D kzalloc_obj(*pending);
> +	if (!pending)
> +		return -ENOMEM;
> +
> +	if (interval_tree_iter_first(&ctx->pending_maps, mapping->start,
> +				     mapping->last))
> +		return -EINVAL;

[Severity: Low]
Is this second interval_tree_iter_first() check redundant, and would it
leak pending if ever taken?  ctx->pending_maps is not modified since the
identical check before kzalloc_obj(), and returning -EINVAL here skips
kfree(pending).

> +
> +	pending->start =3D mapping->start;
> +	pending->last =3D mapping->last;
> +	interval_tree_insert(pending, &ctx->pending_maps);

[Severity: Medium]
Can using struct interval_tree_node here truncate 64-bit GPU page frame
numbers on 32-bit architectures?

mapping->start and mapping->last are uint64_t PFNs (which is why amdgpu_vm.c
defines amdgpu_vm_it with uint64_t via INTERVAL_TREE_DEFINE), whereas
struct interval_tree_node and interval_tree_iter_first() use unsigned long.
On 32-bit builds, GPU virtual addresses at or above 16 TiB (PFN >=3D 1ULL <=
< 32)
have their upper 32 bits truncated when querying and inserting into
ctx->pending_maps, which can cause false -EINVAL conflicts, missed overlaps,
or inverted intervals where pending->start > pending->last.

While a mapping is pending on ctx->new prior to amdgpu_vm_bo_commit_insert(=
),
its embedded rb and uint64_t start/last/__subtree_last fields are unused, so
inserting mapping directly into ctx->pending_maps via the amdgpu_vm_it
helpers would also avoid allocating pending.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 8445599d9539a..d35494440cb5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -279,6 +279,16 @@ struct amdgpu_vm_update_ctx {
>  	 */
>  	struct amdgpu_vm *vm;
> =20
> +	/**
> +	 * @mapped_intervals: Interval tree of VA ranges mapped by this update =
operation.
> +	 */
> +	struct rb_root_cached pending_maps;

[Severity: Low]
The kernel-doc tag @mapped_intervals does not match the struct member name
pending_maps, which triggers a scripts/kernel-doc warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-prt-explic=
it-sync-v2-0-bb3851cb6a0c@pixelcluster.dev?part=3D3
