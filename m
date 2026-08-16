Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5C4C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA6610E351;
	Sun, 16 Aug 2026 19:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gNbX86M9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B9610E351
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:59:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55EAC4011C;
 Sun, 16 Aug 2026 19:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC431F000E9;
 Sun, 16 Aug 2026 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786910352;
 bh=+smZHeL6xiBG4VzXD9Hq0avAvKvZdhFa7BTeGdPWZyI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gNbX86M9WwIgyGS78xp914rMJ2R1jZlU3s2f/KlvE/PlA1gX3GJZdH8U0cJ6U7OYg
 rQGop79SH28Fpw0x+xudxvOsBAIP+kFIwnJ9OKaIK0t/PFT5l2xbuc8CJdHpPFEQGs
 K99IKoI2puh8ZevrlByaiiRexMS4c8M/vZGIpktbxK5rhUCZnCO5fv5Q1s9TuxcWtf
 SCoMEKtT9E4M0sc2S80fYfeDvlYcZjOUHA0C0edl8ZqYMpYiUpe9Zl3WYeCPSkrvbO
 7NnXPHW0CMv10FzU56Rvye4Baq/K2WBQWxXZBsaVJaLtISNpBz15przD5nCq1uHiuK
 BmebrVsmevsNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/imagination: Fix the vm_bo split mappings are
 linked to
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260817-pvr-vm-bind-v1-1-0a0f21be7d38@gmail.com>
References: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
 <20260817-pvr-vm-bind-v1-1-0a0f21be7d38@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 19:59:11 +0000
Message-Id: <20260816195912.0CC431F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced `pvr_gem_object_get()` in `pvr_vm_gpuva_remap()` causes=
 a permanent memory leak of GEM objects.
- [High] Missing `dma_resv` locking during `drm_gpuva_link()` and `drm_gpuv=
a_unlink()` causes data races and list corruption.
- [High] Missing `vm_ctx->lock` acquisition in `pvr_vm_map()` causes concur=
rent execution data races and potential RB tree corruption.
--

--- Patch [1]: [PATCH 1/4] drm/imagination: Fix the vm_bo split mappings ar=
e linked to ---
commit c145cb50bdcd3046dfd6222a4b0282d9524af76c
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Fix the vm_bo split mappings are linked to

A remap does not map anything new. It splits an existing mapping and
re-creates the parts the request did not cover, and that mapping is handed
to the callback in op->remap.unmap->va, carrying the &drm_gpuvm_bo those
parts belong to.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 396d349fb6ce4..608e8c0467dce 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -434,18 +436,18 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *o=
p_ctx)
> =20
>  	if (op->remap.prev) {
>  		pvr_gem_object_get(gem_to_pvr_gem(ctx->prev_va->base.gem.obj));
> -		drm_gpuva_link(&ctx->prev_va->base, ctx->gpuvm_bo);
> +		drm_gpuva_link(&ctx->prev_va->base, vm_bo);

[Severity: High]
This is a pre-existing issue, but does this code permanently leak GEM objec=
ts?

During a remap operation, this explicitly calls pvr_gem_object_get() to take
references on the backing GEM objects for the new split mappings (prev_va a=
nd
next_va).

However, the teardown paths like pvr_vm_gpuva_unmap() and the unmap phase
of pvr_vm_gpuva_remap() just call drm_gpuva_unlink() and kfree() without a
corresponding pvr_gem_object_put(). Since the DRM GPUVM framework internally
manages GEM object lifetimes through vm_bo structures, are these manual
references redundant and never released?

[Severity: High]
This is another pre-existing issue, but can this cause data races and list
corruption?

pvr_vm does not use DRM_GPUVM_IMMEDIATE_MODE, so it relies on the GEM objec=
t's
dma_resv lock to protect gpuva.list operations. When a new mapping overlaps=
 an
existing mapping belonging to a different GEM object, the core calls
pvr_vm_gpuva_remap() or pvr_vm_gpuva_unmap().

These callbacks then invoke drm_gpuva_link() and drm_gpuva_unlink() on the
mappings without holding their GEM object's dma_resv lock. Since pvr_vm_map=
()
only locks the new GEM object being mapped (via pvr_vm_lock_extra()) and
doesn't populate the GPUVM's extobj list, does this concurrent lockless
modification of gpuva.list result in list corruption?

>  		ctx->prev_va =3D NULL;
>  	}
> =20
>  	if (op->remap.next) {
>  		pvr_gem_object_get(gem_to_pvr_gem(ctx->next_va->base.gem.obj));
> -		drm_gpuva_link(&ctx->next_va->base, ctx->gpuvm_bo);
> +		drm_gpuva_link(&ctx->next_va->base, vm_bo);
>  		ctx->next_va =3D NULL;
>  	}
> =20
> -	drm_gpuva_unlink(op->remap.unmap->va);
> -	kfree(to_pvr_vm_gpuva(op->remap.unmap->va));
> +	drm_gpuva_unlink(unmap_va);
> +	kfree(to_pvr_vm_gpuva(unmap_va));
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue in this file outside of the diff, but does
pvr_vm_map() have a data race that could corrupt the GPUVM RB-tree?

In pvr_vm_unmap(), the driver acquires vm_ctx->lock before searching the
GPUVM's RB-tree via drm_gpuva_find(). However, pvr_vm_map() mutates the RB-=
tree
via pvr_vm_bind_op_exec() invoking drm_gpuvm_sm_map() but doesn't acquire
vm_ctx->lock:

drivers/gpu/drm/imagination/pvr_vm.c:pvr_vm_map() {
    ...
    err =3D pvr_vm_bind_op_exec(&bind_op);
    ...
}

While pvr_vm_map() acquires the VM's dma_resv lock, pvr_vm_unmap() does not
hold this lock during its traversal:

drivers/gpu/drm/imagination/pvr_vm.c:pvr_vm_unmap() {
    ...
    va =3D drm_gpuva_find(&vm_ctx->gpuvm_mgr, device_addr, size);
    ...
}

Since there is no shared lock between the reader and writer of the RB-tree,=
 can
a map operation modify the tree concurrently with an unmap operation's
traversal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-pvr-vm-bin=
d-v1-0-0a0f21be7d38@gmail.com?part=3D1
