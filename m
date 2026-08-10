Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6EFC5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4C210E213;
	Mon, 10 Aug 2026 16:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F4nm/wZb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F70A10E213
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:33:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 636E860052;
 Mon, 10 Aug 2026 16:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E479A1F000E9;
 Mon, 10 Aug 2026 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786379621;
 bh=uxq+5dTM6MxMAoKCgOQMBzy5eRarUA878rQ3zKgfQFs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F4nm/wZbq3+EQhN14f3loQNrkJ83zV0lC2h7ZxCtkgtrG2d2L8pknGEq1bX+U7zgW
 IoHWbOhnfuYX8vTYu0XzqieDoh/W/0FFcPwJDS7iKDGmMgCPXg9ZoaCJmW6eQwTyHv
 zwBFSTonKJsXCWeK/+24CRAGunbI3fLny3AawSuwbp+RvJl3HOpY4fVsW59aXB0+io
 zpyAj/jpJv+IlHd/VGoUeU8hvIQsbxfgucltKVVwGoooDDH4nzxoSXMRN6Tgm2qPdn
 ghzNtki4n5J2VLf6EhIr+vdZo43PU1C2MeEVcpditPXmq2njl2xQogxWAw77EQiuFp
 IVXAgjps92ZIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] drm/amdgpu: reject PRT mappings as user queue
 buffer VAs
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260811-amdgpu-fixes-v1-2-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
 <20260811-amdgpu-fixes-v1-2-4954a417b8ff@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:33:40 +0000
Message-Id: <20260810163340.E479A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents PRT mappings from being validated as user queue=
 VAs to avoid NULL pointer dereferences, but userspace can bypass this rest=
riction via a Time-Of-Check to Time-Of-Use (TOCTOU) race, leading to the ex=
act same NULL pointer dereferences.
- [High] GPU coredump crashes with a NULL pointer dereference if an Indirec=
t Buffer (IB) resides in a PRT mapping.
- [High] Providing a PRT mapping during KFD queue creation permanently leak=
s `queue_refcount`, leading to a denial of service.
- [High] Userspace can completely bypass the user queue eviction synchroniz=
ation by using `AMDGPU_VA_OP_CLEAR` or `AMDGPU_VA_OP_REPLACE`.
--

--- Patch [2]: [PATCH 2/5] drm/amdgpu: reject PRT mappings as user queue bu=
ffer VAs ---
commit 2673e3bf87d8321b443028125d445c8f3dba144c
Author: Junrui Luo <moonafterrain@outlook.com>

drm/amdgpu: reject PRT mappings as user queue buffer VAs

This commit fixes a NULL pointer dereference by rejecting PRT mappings duri=
ng
user queue VA validation. It ensures that only mappings with backing BOs can
be used as ring, rptr, or wptr buffers.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 6d3ed55e9ab4b..bec107216811c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c

[ ... ]

> @@ -259,6 +259,14 @@ int amdgpu_userq_input_va_validate(struct amdgpu_dev=
ice *adev,
>  	if (!va_map)
>  		return -EINVAL;
> =20
> +	/*
> +	 * A PRT mapping has no backing BO and so can't carry the eviction
> +	 * fence which amdgpu_userq_gem_va_unmap_validate() waits on. Reject it
> +	 * here, otherwise that helper dereferences a NULL bo on GEM unmap.
> +	 */
> +	if (!va_map->bo_va->base.bo)
> +		return -EINVAL;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this validation fully
prevent the NULL pointer dereference?

Userspace might bypass this restriction via a Time-Of-Check to Time-Of-Use
(TOCTOU) race. After amdgpu_userq_input_va_validate() completes, the VM root
PD is temporarily unreserved before mes_userq_mqd_create() is called. A
concurrent thread could call AMDGPU_GEM_VA_IOCTL to unmap the wptr_va and
remap it as a PRT mapping.

When mes_userq_create_wptr_mapping() or amdgpu_userq_fence_read_wptr()=20
executes:

drivers/gpu/drm/amd/amdgpu/mes_userqueue.c:mes_userq_create_wptr_mapping() {
    wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
    ...
    obj =3D wptr_mapping->bo_va->base.bo;
    ret =3D drm_exec_lock_obj(&exec, &obj->tbo.base);
}

Could the mapping now be a PRT mapping, causing obj to be NULL and triggeri=
ng
a kernel panic when drm_exec_lock_obj() dereferences it?

[Severity: High]
This is also a pre-existing issue, but does the synchronization mechanism t=
his
patch aims to protect actually cover all unmap paths?

Userspace can submit an AMDGPU_GEM_VA_IOCTL with AMDGPU_VA_OP_CLEAR or
AMDGPU_VA_OP_REPLACE instead of AMDGPU_VA_OP_UNMAP. This routes to
amdgpu_vm_bo_clear_mappings(), which removes the mappings without checking
userq_va_mapped:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_bo_clear_mappings() {
    list_for_each_entry_safe(tmp, next, &removed, list) {
        amdgpu_vm_it_remove(tmp, &vm->va);
        ...
        tmp->bo_va =3D NULL;
        list_add(&tmp->list, &vm->freed);
        trace_amdgpu_vm_bo_unmap(NULL, tmp);
    }
}

Does this bypass the amdgpu_userq_gem_va_unmap_validate() wait entirely,
allowing userspace to unmap active hardware queues while the GPU is still
accessing them?

[Severity: High]
This is a pre-existing issue, but there appears to be another unhandled edge
case with PRT mappings causing a similar NULL pointer dereference elsewhere.

If userspace submits an Indirect Buffer (IB) pointing to a PRT mapping and
triggers a GPU reset, the GPU coredump handler iterates over the IBs to dump
them. In amdgpu_devcoredump_print_ibs():

drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c:amdgpu_devcoredump_print_i=
bs() {
    mapping =3D amdgpu_vm_bo_lookup_mapping(vm, pfn);
    if (!mapping)
        continue;

    abo =3D mapping->bo_va->base.bo;
    r =3D drm_exec_lock_obj(&exec, &abo->tbo.base);
}

Since abo is NULL for PRT mappings, will this unconditionally crash the sys=
tem
during the coredump?

[Severity: High]
This is a pre-existing issue, but there seems to be one more unhandled PRT
mapping flaw in the KFD subsystem.

If userspace calls a KFD queue creation IOCTL providing a PRT mapping for
one of the queue buffers, kfd_queue_buffer_get() successfully increments the
refcount:

drivers/gpu/drm/amd/amdkfd/kfd_queue.c:kfd_queue_buffer_get() {
    mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
    ...
    *pbo =3D amdgpu_bo_ref(mapping->bo_va->base.bo);
    mapping->bo_va->queue_refcount++;
}

Because *pbo is set to NULL, kfd_queue_unref_bo_va() skips the decrement
during queue destruction:

drivers/gpu/drm/amd/amdkfd/kfd_queue.c:kfd_queue_unref_bo_va() {
    if (*bo) {
        struct amdgpu_bo_va *bo_va;
        ...
        if (bo_va && bo_va->queue_refcount)
            bo_va->queue_refcount--;
    }
}

Does this permanently leak the queue_refcount and prevent the mapping from
ever being unmapped?

>  	/* Lookup guarantees start_page is mapped; ensure full span is covered.=
 */
>  	if ((end_addr >> AMDGPU_GPU_PAGE_SHIFT) <=3D va_map->last) {
>  		va_map->bo_va->userq_va_mapped =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-amdgpu-fix=
es-v1-0-4954a417b8ff@outlook.com?part=3D2
