Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D030606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+if8mh9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CE910EB9E;
	Sun,  8 Nov 2026 05:38:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AFD10EB9E
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:38:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AEE443C38;
 Sun,  8 Nov 2026 05:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C821F0089F;
 Sun,  8 Nov 2026 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794116295;
 bh=1oiY3alnbO6VMYAPAlEPxykSQU4rqKCWz2fDmItW9rQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y+if8mh95HYQrBQsSJOY3rTolSbPW09pmlghwvU8G6GgIawo+qxaBK82ePi2fi79x
 rpkuM8LCNik91Jxa7/S6seHk4c24LPwY+jSmJxkeaKr7cu3X1xN/BbSGQRKTSpMAVd
 68fpO7BTw+CyzXhrVtPDMG1XGhOcE0CaqR8Asx/CWGF9ta9auy/V2LYfkCN/EzubzH
 czMo0jQmx3vzekXFp2AV5cTJXJIviUy0kiqLKHs4UbyST9X1GqKXFRZcVWxmOA9MH1
 PMLl6ROyHoXID86IwkYO8/0hfCN9gwlAiMtw+3F/M7T353JRjSIeMzSxEmLZBUQ1o6
 5NWSdTbSbiIAQ==
Message-ID: <sashiko-outbox-203589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] drm/imagination: Route map and unmap through
 pvr_vm_bind()
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261108-pvr-vm-bind-v2-3-730103d2cc9a@gmail.com>
References: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
 <20261108-pvr-vm-bind-v2-3-730103d2cc9a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 05:38:14 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/imagination: UAF and sync ordering bug in pvr_vm_bind()
--

commit 858616fa9e0f9c862d2be468e58d23d170048080
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Route map and unmap through pvr_vm_bind()

This commit consolidates map and unmap paths into a single pvr_vm_bind()
entry point taking an array of struct pvr_vm_bind_desc.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 12ebf0daf88db..2f959cd5e9047 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c

[ ... ]

> @@ -683,188 +692,191 @@ void pvr_destroy_vm_contexts_for_file(struct pvr_=
file *pvr_file)

[ ... ]

> -static int
> -pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
> -			struct pvr_gem_object *pvr_obj,
> -			u64 device_addr, u64 size)
> +static struct pvr_vm_bind_op *
> +pvr_vm_bind_ops_create(struct pvr_vm_context *vm_ctx,
> +		       const struct pvr_vm_bind_desc *descs, u32 desc_count)
>  {
> -	struct pvr_vm_bind_op bind_op =3D {0};
> -
> -	int err =3D pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, pvr_obj,
> -					    device_addr, size);
> -	if (err)
> -		return err;
> +	struct pvr_vm_bind_op *bind_ops;
> +	int err;
> =20
> -	pvr_gem_object_get(pvr_obj);
> +	bind_ops =3D kvzalloc_objs(*bind_ops, desc_count, GFP_KERNEL_ACCOUNT);
> +	if (!bind_ops)
> +		return ERR_PTR(-ENOMEM);
> =20
> -	err =3D pvr_vm_bind_op_exec(&bind_op);
> +	for (u32 prepared =3D 0; prepared < desc_count; prepared++) {
> +		err =3D pvr_vm_bind_op_init(&bind_ops[prepared], vm_ctx,
> +					  &descs[prepared]);
> +		if (err) {
> +			pvr_vm_bind_ops_free(bind_ops, prepared);
> +			/* Release the vm_bos that fini() deferred. */
> +			drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> +			return ERR_PTR(err);
> +		}
> =20
> -	pvr_vm_bind_op_fini(&bind_op);
> +		cond_resched();
> +	}
> =20
> -	return err;
> +	return bind_ops;
>  }
> =20
>  /**
> - * pvr_vm_unmap_obj() - Unmap an already mapped section of device-virtual
> - * memory.
> + * pvr_vm_bind() - Apply a batch of bind operations to a VM context.
>   * @vm_ctx: Target VM context.
> - * @pvr_obj: Target PowerVR memory object.
> - * @device_addr: Virtual device address at the start of the target mappi=
ng.
> - * @size: Size of the target mapping.
> + * @descs: Operations to apply, in array order.
> + * @desc_count: Number of entries in @descs.
> + *
> + * Not atomic: if an operation fails, the earlier ones stay applied.
>   *
>   * Return:
> - *  * 0 on success,
> - *  * Any error encountered by pvr_vm_unmap_obj_locked.
> + *  * 0 on success, or
> + *  * A negative error code on failure.
>   */
> -int
> -pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *p=
vr_obj,
> -		 u64 device_addr, u64 size)
> +int pvr_vm_bind(struct pvr_vm_context *vm_ctx,
> +		const struct pvr_vm_bind_desc *descs, u32 desc_count)
>  {
> -	int err;
> +	struct pvr_vm_bind_op *bind_ops;
> +	int err =3D 0;
> +
> +	bind_ops =3D pvr_vm_bind_ops_create(vm_ctx, descs, desc_count);
> +	if (IS_ERR(bind_ops))
> +		return PTR_ERR(bind_ops);
> =20
>  	mutex_lock(&vm_ctx->lock);
> -	err =3D pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, device_addr, size);
> +
> +	for (u32 i =3D 0; !err && i < desc_count; i++)
> +		err =3D pvr_vm_bind_op_exec(&bind_ops[i]);
> +
>  	mutex_unlock(&vm_ctx->lock);
> =20
> +	pvr_vm_bind_ops_free(bind_ops, desc_count);
>  	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> =20
>  	return err;
>  }

[ ... ]

> @@ -862,25 +862,21 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 dev=
ice_addr, u64 size)
>  void
>  pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
>  {
> -	u64 addr =3D vm_ctx->gpuvm_mgr.mm_start;
> -	u64 end =3D vm_ctx->gpuvm_mgr.mm_start + vm_ctx->gpuvm_mgr.mm_range;
> -	u64 va_addr, va_range;
> -
> -	mutex_lock(&vm_ctx->lock);
> -
> -	for (; addr < end; addr =3D va_addr + va_range) {
> -		struct pvr_gem_object *pvr_obj;
> -		struct drm_gpuva *va;
> -
> -		va =3D drm_gpuva_find_first(&vm_ctx->gpuvm_mgr, addr, end - addr);
> -		if (!va)
> -			break;
> -
> -		pvr_obj =3D gem_to_pvr_gem(va->gem.obj);
> -		va_addr =3D va->va.addr;
> -		va_range =3D va->va.range;
> +	const struct pvr_vm_bind_desc desc =3D {
> +		.type =3D PVR_VM_BIND_TYPE_UNMAP,
> +		.device_addr =3D vm_ctx->gpuvm_mgr.mm_start,
> +		.size =3D vm_ctx->gpuvm_mgr.mm_range,
> +	};
> +	struct pvr_vm_bind_op bind_op =3D {0};
> =20
> -		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, va_addr, va_range));
> -	}
> +	if (WARN_ON(pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, &desc)))
> +		return;
> =20
> +	mutex_lock(&vm_ctx->lock);
> +	WARN_ON(pvr_vm_bind_op_exec(&bind_op));
>  	mutex_unlock(&vm_ctx->lock);
> =20
> +	pvr_vm_bind_op_fini(&bind_op);
>  	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
>  }

[Severity: High]
Can calling pvr_vm_bind_ops_free() and pvr_vm_bind_op_fini() after dropping
vm_ctx->lock cause a use-after-free on op_ctx->curr_page.l0_table and
l1_table?

During pvr_vm_bind_op_exec(), pvr_mmu_map() and pvr_mmu_unmap() leave raw
pointers to the active page tables in op_ctx->curr_page.l0_table and
l1_table with pending syncs recorded in op_ctx->sync_level_required.
Previously, pvr_vm_unmap_obj_locked() ran pvr_vm_bind_op_fini() ->
pvr_mmu_op_context_destroy() -> pvr_mmu_op_context_sync() while holding
vm_ctx->lock.  With vm_ctx->lock dropped before pvr_vm_bind_ops_free(), a
second thread can unmap the remaining entries in the same L0 or L1 table
and free it before the first thread syncs:

CPU0                                  CPU1
pvr_vm_bind()
  mutex_lock(&vm_ctx->lock)
  pvr_vm_bind_op_exec(&bind_ops[0])
    /* leaves curr_page.l0_table =3D T0,
       T0->entry_count =3D=3D 1 */
  mutex_unlock(&vm_ctx->lock)
                                      pvr_vm_bind()
                                        mutex_lock(&vm_ctx->lock)
                                        pvr_vm_bind_op_exec(...)
                                          /* unmaps last entry in T0,
                                             queues T0 on l0_free_tables */
                                        mutex_unlock(&vm_ctx->lock)
                                        pvr_vm_bind_ops_free()
                                          ...
                                            pvr_page_table_l0_free(T0)
  pvr_vm_bind_ops_free()
    pvr_vm_bind_op_fini(&bind_ops[0])
      pvr_mmu_op_context_destroy()
        ...
          pvr_page_table_l0_sync(T0)  <-- use-after-free

In addition, when desc_count > 1 in pvr_vm_bind(), deferring
pvr_mmu_op_context_sync() until pvr_vm_bind_ops_free() runs after the loop
breaks the leaf-to-root (L0 -> L1 -> L2) DMA sync order across operations in
the same batch (and a later unmap in the batch can free a table still
referenced by an earlier op's curr_page).  For instance, if bind_ops[0]
allocates an L1 table T1 (requiring a level 2 sync) and bind_ops[1] attaches
a new L0 table T0_b to T1, freeing bind_ops[0] first syncs T1 and L2 before
freeing bind_ops[1] syncs T0_b.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-pvr-vm-bin=
d-v2-0-730103d2cc9a@gmail.com?part=3D3
