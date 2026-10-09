Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0492CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BBC10FFE9;
	Fri,  9 Oct 2026 09:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j26r26Hv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADEAF10FFE9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 09:36:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B4BE434CC;
 Fri,  9 Oct 2026 09:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130C01F000FF;
 Fri,  9 Oct 2026 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791538606;
 bh=FcO83K+cA1YUFGbg0dOdm/F/8IAOHrRT94o0zI+v8X4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j26r26HvJRel+J5kw8AnDSIS7X60ZaAg3FQoxRnK6xN4GZdM7pWAO0zrnsK4vWtFW
 +82/sALPEI+oOcx0q8L14AMaPPP5cEx3iEduki6/cJaozlyHBo/Tfhj1fRVuzIteAJ
 9MpV6F77Ey2pf7cXzLX6COyjRjynBKVcoqLcNLzTtNVlt2l+5MvrrhjUf6x0kYSXK3
 2W6PWi8mmN//b1kGm9Rn2f3fp09RDuxc+h/F0MdTI2s2w+uT74WLmOm3XfbhJctkZA
 GEP7iPSSAm+RdNzu9rBFO5uSLdAEKvrsRzVdBEJXto3LG06Aa2kJ8IWHq5kWcI0Bh9
 qS19RIIIL83IA==
Message-ID: <sashiko-outbox-165175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/nouveau/uvmm: reject replace across page sizes
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-nouveau-fixes-v2-1-a0b71bf8df1b@outlook.com>
References: <20261009-nouveau-fixes-v2-1-a0b71bf8df1b@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 09:36:45 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/nouveau: UAF in select_page_shift() due to lockless resource a=
ccess
--

commit 96b9704295117874e5545da9ce1209804365ab06
Author: Junrui Luo <moonafterrain@outlook.com>

drm/nouveau/uvmm: reject replace across page sizes

This commit fixes an issue where rebinding mappings across different page
sizes leaves split remainders with incorrect page tables. It rejects binds
with mismatched page sizes and ensures split remainders inherit their
parent's page size.

Link: https://lore.kernel.org/r/20260817-nouveau-fixes-v1-0-f518d0c735f3@ou=
tlook.com

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index f5e4756b4de4a..aa5b93808f41c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -684,8 +686,20 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>  	struct drm_gpuva_op *op;
>  	u64 vmm_get_start =3D args ? args->addr : 0;
>  	u64 vmm_get_end =3D args ? args->addr + args->range : 0;
> +	u8 map_page_shift =3D 0;
>  	int ret;
> =20
> +	/* A new mapping takes over the page tables of the mappings it replaces,
> +	 * so every one of them has to be using its page size. The new mapping
> +	 * is the last op drm_gpuvm_sm_map_ops_create() emits.
> +	 */
> +	if (args) {
> +		struct drm_gpuva_op *last =3D drm_gpuva_last_op(ops);
> +
> +		if (last->op =3D=3D DRM_GPUVA_OP_MAP)
> +			map_page_shift =3D select_page_shift(uvmm, &last->map);

[Severity: High]
Does this call to select_page_shift() introduce a Use-After-Free (UAF) due =
to
lockless resource access?

In nouveau_uvmm_bind_job_submit(), the map prepare sequence is called before
drm_exec_until_all_locked() acquires the GEM objects' dma_resv locks:

drivers/gpu/drm/nouveau/nouveau_uvmm.c:nouveau_uvmm_bind_job_submit() {
    ...
    ret =3D nouveau_uvmm_sm_map_prepare(uvmm, &op->new,
                                      reg, op->ops,
                                      op->va.addr,
                                      op->va.range,
                                      op->flags & 0xff);
    ...
}

Inside select_page_shift(), the code accesses nvbo->bo.resource and derefer=
ences
its properties without the dma_resv_lock held:

drivers/gpu/drm/nouveau/nouveau_uvmm.c:select_page_shift() {
    ...
    struct nouveau_mem *mem =3D nouveau_mem(nvbo->bo.resource);
    struct nvif_vmm *vmm =3D &uvmm->vmm.vmm;
    ...
        /* Skip incompatible domains. */
        if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
            continue;
    ...
}

Because the dma_resv lock is not held during this preparation phase, TTM can
concurrently evict or move the BO, freeing the old ttm_resource (and its
wrapping nouveau_mem structure).

This could leave a dangling pointer and cause a UAF when accessing
mem->mem.type, potentially leading to a kernel panic or privilege escalatio=
n.

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-nouveau-fi=
xes-v2-1-a0b71bf8df1b@outlook.com?part=3D1
