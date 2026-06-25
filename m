Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E2ECDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE0310E20D;
	Thu, 25 Jun 2026 11:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nSlebkbi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2075B10E20D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:26:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E3E5600FC;
 Thu, 25 Jun 2026 11:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA321F00A3E;
 Thu, 25 Jun 2026 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782386781;
 bh=loIiHtrFunkmDyzLyxoCZ2phvbI1tmgeJoZzVFFSmCU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nSlebkbiraj04zFB8JujNK2/m+cZrsPeaHjxDdlpszAPZSg3Dyla7wXBtMJ+53e/f
 FjZOOJpCO48GwsrbLujfIrXfSJZKK28o3rN3E7fvCUZ3TZ9FD3wThrQbResce4inhp
 0wO8HrDkHEBtqTxnzTXMT08KcPb3HjIgz6OAnxTKJPV4cob5xRrqnOVxwInHvW+Uh2
 emj5pUA8xyVRACRY504yOB2i/fav4OWiLqrTbljJANeJS1YTaGdOHAajvJ/WRD3YC3
 svuZxmXhhPxNPQKKT0oHxgjoSt+8/inlTVC4iFSg99p1vFjuhEMUAdzvI4XJcA0OXx
 W0LtBSxRMTYYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amdgpu: block THP for HSA userptr notifiers
To: "Yitao Jiang" <jytscientist@hotmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <SY1PR01MB1059636EEFF3E5C5156F899B8C0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
References: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
 <SY1PR01MB1059636EEFF3E5C5156F899B8C0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 11:26:19 +0000
Message-Id: <20260625112620.3DA321F00A3E@smtp.kernel.org>
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
- [Critical] Unaligned user_addr from KFD_IOC_ALLOC_MEMORY_OF_GPU causes VM=
A tree corruption via split_vma()
--

commit 84a588c64a29eedb721607110e005505178f21fc
Author: Yitao Jiang <jytscientist@hotmail.com>

drm/amdgpu: block THP for HSA userptr notifiers

This commit modifies the registration of HSA userptr interval notifiers
to use the MMU_INTERVAL_NOTIFIER_BLOCK_THP flag. This prevents CPU THP
remaps of active userptr ranges from causing asynchronous GPU work failures.
GFX userptrs continue to use the existing notifier path.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hmm.c
> index 99bc9ad67d5b8..c0b36164c35e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
[ ... ]
> @@ -130,16 +131,24 @@ static const struct mmu_interval_notifier_ops amdgp=
u_hmm_hsa_ops =3D {
>   */
>  int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
>  {
[ ... ]
> +	if (bo->kfd_bo) {
> +		mmap_write_lock(mm);
> +		r =3D mmu_interval_notifier_insert_locked_flags(&bo->notifier, mm,
> +							      addr, size,
> +							      &amdgpu_hmm_hsa_ops,
> +							      MMU_INTERVAL_NOTIFIER_BLOCK_THP);
[Severity: Critical]
Can addr be unaligned when passed to this function?

A user space process can call the KFD_IOC_ALLOC_MEMORY_OF_GPU ioctl with the
KFD_IOC_ALLOC_MEM_FLAGS_USERPTR flag and provide an unaligned virtual addre=
ss
in args->mmap_offset. The ioctl handler in kfd_ioctl_alloc_memory_of_gpu()
(in drivers/gpu/drm/amd/amdkfd/kfd_chardev.c) does not enforce page alignme=
nt
on this offset:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_ioctl_alloc_memory_of_gpu() {
    ...
    err =3D amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
        dev->adev, args->va_addr, args->size,
        pdd->drm_priv, (struct kgd_mem **) &mem, &offset,
        flags, false);
    ...
}

The unaligned offset propagates through init_user_pages() unmodified as
user_addr, which is eventually passed here as addr to amdgpu_hmm_register().

With the MMU_INTERVAL_NOTIFIER_BLOCK_THP flag added by this patch, the core
MM calls mmu_interval_notifier_block_thp_locked(), which uses this addr as
the start address. It iteratively passes this address to vma_modify_flags()
and subsequently split_vma().

Since VMA boundaries must be strictly page-aligned, split_vma() will corrupt
the VMA tree and break invariants by applying the unaligned address to the =
new
VMA bounds. This can lead to kernel panics or a local denial-of-service.

Should addr and size be aligned before calling
mmu_interval_notifier_insert_locked_flags(), or should the ioctl enforce
page alignment on user pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SY1PR01MB10596EB754=
63208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com?part=3D2
