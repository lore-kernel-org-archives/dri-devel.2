Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCD606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOjPcTW/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F0C10E62C;
	Tue, 17 Nov 2026 14:41:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EAF010E5D8;
 Tue, 17 Nov 2026 14:40:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E06C6182B;
 Tue, 17 Nov 2026 14:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FF01F000C4;
 Tue, 17 Nov 2026 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794926457;
 bh=ydPzjoFvITA/Y7Eo/udikn0WQcYBPmRZR6h4MOx1E+c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nOjPcTW/r/OvJBgu1Rir/Dq58To5QdE8A5noYmYS9NunyIHUoLh0sXU4gerQLbkR/
 cwSwJeS2vYy1zqzfxKVouPkw6mK0POa0t2d4YzavIJ68XCdcMYp1TmerDlOFugvdZZ
 6Giw0P/TxbUstYW7gVzBP9XVQW8A5L2Qeq/hxRgCKnt9XXVbzkl0owwfq8TZMoZOlk
 gCYeStHPO30T9jguGAuDBCuRpLh61fwDUzTQIKuMzEd3JaKXpAlyk182QPC6yp7Noa
 bpzHbeuMiPOlMwPL0wCh/he1v/y6d9eu0OEXMaWIYLF56eVCbE3farJhgp7BUDEwG9
 F50rsX4BxxLLA==
Message-ID: <sashiko-outbox-218979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] drm/amdgpu: Add function to roll back a VM
 update ctx
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-prt-explicit-sync-v2-6-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-6-bb3851cb6a0c@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:40:56 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu: leak of ctx->new mappings in
  amdgpu_vm_update_ctx_rollback()
- [High] drm/amdgpu: missing ctx->cleared unlink in
  amdgpu_vm_update_ctx_rollback()
--

commit b40894c15667a95794d5db4dfea6f22963fb9ec5
Author: Natalie Vock <nat@pixelcluster.dev>

drm/amdgpu: Add function to roll back a VM update ctx

This commit introduces amdgpu_vm_update_ctx_rollback() to discard pending
mapping changes in a VM update context and calls it from
amdgpu_vm_update_ctx_fini().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 330c288053352..ac4a1ed9b1196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1874,37 +1874,48 @@ void amdgpu_vm_update_ctx_init(struct amdgpu_vm_u=
pdate_ctx *ctx,
>  }
> =20
>  /**
> - * amdgpu_vm_update_ctx_fini - finish a VM update operation
> - * @ctx: The context of the update
> + * amdgpu_vm_update_ctx_rollback - clear pending VM updates
> + * @ctx: The context to roll back
>   *
> - * Adds any leftover mappings needing to be cleared to the VM's delayed =
free list,
> - * then frees up resources used by the context.
> + * Cleans up any pending mapping changes, but does not reset
> + * anything else (like attached syncobjs).
>   */
> -void amdgpu_vm_update_ctx_fini(struct amdgpu_vm_update_ctx *ctx)
> +void amdgpu_vm_update_ctx_rollback(struct amdgpu_vm_update_ctx *ctx)
>  {
> +	struct amdgpu_bo_va_mapping *mapping, *next;
>  	struct interval_tree_node *node, *next_node;
>  	struct amdgpu_bo_va *bo_va, *next_bo_va;
> =20
> -	list_splice(&ctx->freed, &ctx->vm->delayed_freed);
> -	amdgpu_sync_free(&ctx->sync);
> +	list_for_each_entry_safe(mapping, next, &ctx->new, pending_list)
> +		list_del_init(&mapping->pending_list);

[Severity: High]
Does this leak each struct amdgpu_bo_va_mapping on ctx->new?

Unlike mappings on ctx->deleted, newly allocated mappings added by
amdgpu_vm_update_ctx_add_new_mapping() are not inserted into bo_va->invalids
or vm->va until amdgpu_vm_update_ctx_commit() runs.  If a rollback or an
error before commit hits this loop, unlinking mapping->pending_list without
calling kfree(mapping) drops the only reference to those allocations.

> +	list_for_each_entry_safe(mapping, next, &ctx->deleted, pending_list)
> +		list_del_init(&mapping->pending_list);

[Severity: High]
Should amdgpu_vm_update_ctx_rollback() also unlink mappings on
ctx->cleared?

amdgpu_vm_bo_clear_mappings() links overlapping live mappings from vm->va
onto ctx->cleared via mapping->pending_list.  If a replace or clear
operation rolls back or fails before amdgpu_vm_update_ctx_execute_replace()
drains ctx->cleared, those mappings stay linked to ctx->cleared while
ctx->cleared_ranges is reset.  If the context is then destroyed,
list_empty(&mapping->pending_list) remains false on the live mappings in
vm->va, causing later unmaps and amdgpu_vm_bo_del() to skip removing them
from vm->va before freeing bo_va, which leaves dangling pointers and leads
to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-prt-explic=
it-sync-v2-0-bb3851cb6a0c@pixelcluster.dev?part=3D6
