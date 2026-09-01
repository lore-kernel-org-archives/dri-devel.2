Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB86AC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A63710E3A6;
	Tue,  1 Sep 2026 06:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="msXwwd+K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CDD10E981
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 06:49:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F6FC600D1;
 Tue,  1 Sep 2026 06:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95BE1F000E9;
 Tue,  1 Sep 2026 06:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788245346;
 bh=FBVrjV/aUp2uHi9W1gw1nAWkxD7Yo3zW+zLPItPqNP8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=msXwwd+KsIxpeR8JbJL4H9I7yh8J+Er2GNR8/qyDPnjN6fexXKp5hp7Fs3/c93kSW
 ATRULy+Omeqzmq4wEHz8tGQLwlxLp+rUAkA+pSM94M0ro3x2ODFOIcsDqutifIFiC5
 LO6xbOSALFWDsgGmJ03ik1mfGE6feb4S8liZMGUFXXJo1qnALQJKwQf4El/HKDHYrW
 easIYU/cEzcbZkZAOIogw4czR7wcBhPO4VC23+pzkUsBXivi8ZArf38a5Enh5peuvt
 QFIf/oRFySA/MUCSt3e0fctSp+J/r4Bkv++SzZFbYhO9fWDciyo64xoK/ODjOyNC26
 Pt1K8YU2ryoUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/uvmm: fix UAF in bind job cleanup
To: "Peiyang He" <peiyang_he@smail.nju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <7F26D29D0BD60619+20260901063255.661503-1-peiyang_he@smail.nju.edu.cn>
References: <7F26D29D0BD60619+20260901063255.661503-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:49:06 +0000
Message-Id: <20260901064906.A95BE1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unwinding a successfully prepared OP_MAP_SPARSE operation in nouve=
au_uvmm_bind_job_submit() causes a guaranteed NULL pointer dereference.
- [High] Unwinding a successfully prepared OP_UNMAP_SPARSE operation leaves=
 the region permanently dirty, causing uninterruptible hangs for future ope=
rations.
--

commit 203035037bce29ea5a47c8cbbdd0cff202e6dbea
Author: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: drm/nouveau/uvmm: fix UAF in bind job cleanup

This patch clears op->reg on the unwind_continue paths for OP_UNMAP_SPARSE.
This prevents a stale region pointer from being passed to cleanup after an
async sparse unmap fails, avoiding a use-after-free.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index f5e4756b4de4a..aad14316cbefd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1318,6 +1318,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *jo=
b,
>  			op->reg =3D nouveau_uvma_region_find(uvmm, op->va.addr,
>  							   op->va.range);
>  			if (!op->reg || op->reg->dirty) {
> +				op->reg =3D NULL;
>  				ret =3D -ENOENT;
>  				goto unwind_continue;
>  			}
> @@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *jo=
b,
>  								op->va.range);
>  			if (IS_ERR(op->ops)) {
>  				ret =3D PTR_ERR(op->ops);
> +				op->reg =3D NULL;
>  				goto unwind_continue;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the unwind path
triggered by goto unwind_continue, does the unwind loop cause a null pointer
dereference for OP_MAP_SPARSE operations?

When unwinding a successfully prepared OP_MAP_SPARSE operation, the code
unconditionally calls drm_gpuva_ops_free(&uvmm->base, op->ops). However,
op->ops is never allocated for OP_MAP_SPARSE and remains NULL.

The drm_gpuva_ops_free() function does not check for NULL and evaluates
&(ops)->list inside the drm_gpuva_for_each_op_safe() iterator:

drm_gpuvm.c:drm_gpuva_ops_free() {
    struct drm_gpuva_op *op, *next;

    drm_gpuva_for_each_op_safe(op, next, ops) {
        list_del(&op->entry);
        ...

Could this crash if a VM_BIND job submits an OP_MAP_SPARSE operation
followed by a malformed operation that fails?

[Severity: High]
This is also a pre-existing issue in the same unwind path, but does
unwinding a successfully prepared OP_UNMAP_SPARSE operation leave the region
permanently dirty?

The prepare phase for OP_UNMAP_SPARSE calls nouveau_uvma_region_dirty(op->r=
eg).
If a subsequent operation fails, the unwind loop restores the region to the
maple tree and unconditionally clears op->reg =3D NULL without clearing the
dirty flag or signaling the completion:

nouveau_uvmm.c:nouveau_uvmm_bind_job_submit() unwind path {
    ...
    case OP_UNMAP_SPARSE:
        __nouveau_uvma_region_insert(uvmm, op->reg);
        nouveau_uvmm_sm_unmap_prepare_unwind(uvmm, &op->new, op->ops);
        break;
    ...
    drm_gpuva_ops_free(&uvmm->base, op->ops);
    op->ops =3D NULL;
    op->reg =3D NULL;
    ...

Because op->reg is cleared here, the nouveau_uvmm_bind_job_cleanup() functi=
on
skips it, meaning nouveau_uvma_region_complete(op->reg) is never called.

Will future tasks attempting to map over this leaked region hang forever
waiting on &reg->complete in bind_validate_map_common()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7F26D29D0BD60619+20=
260901063255.661503-1-peiyang_he@smail.nju.edu.cn?part=3D1
