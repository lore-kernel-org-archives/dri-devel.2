Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C405CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D9110E058;
	Fri, 16 Oct 2026 07:08:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFC31125EF
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:08:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A304436C4;
 Fri, 16 Oct 2026 07:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C9C1F000C4;
 Fri, 16 Oct 2026 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792134527;
 bh=rBVDK7cGxI8EIRGpDXeLrVpvDEF5/x39XaR9Lv/H2Jw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X70OVbl3ice69M5yow2Rgn4hFlPhTtyF2AVZqmCnOvp7sYv2PFtAIZzU7T8cBQIbH
 DBrei+/xbreg/YvzwSKZY/OP3MZMVaRWSn6X0qq5J+KLNonWe0OpVA26i6+kjUSxqt
 84NTOYu2XCG6Y8tDXAKhwGdtjWacZGuutK24dZ1zZ4aQ4nP+sVQyEduReYB4jbS2HR
 cXp1Uh9zN/C2he072i8cyb82ZLe/GlTk/JLuEMwIRPiUka5vZZofTI1KAQeZ9rH9+8
 8V5lcGQN7D1Kg7BsUCM8U8Q0lektwDKR+LmPfsnxedmvZ/RBikjOdZw9Tzc05A4KAm
 S2v0T6a1OvBoQ==
Message-ID: <sashiko-outbox-173901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: disable SVM when the GPUVM cannot cover CPU
 addresses
To: "Daniel Huang" <danielhu@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016145129.69645-1-danielhu@amd.com>
References: <20261016145129.69645-1-danielhu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:08:46 +0000
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
- [High] amdgpu: out-of-bounds array access due to flawed KFD SVM bounds ch=
eck
--

commit f15cd1b71660722b40bc92fadadb46cc7210b7fd
Author: Daniel Huang <danielhu@amd.com>
Date:   Fri Oct 16 14:51:29 2026 +0000

    drm/amdkfd: disable SVM when the GPUVM cannot cover CPU addresses
   =20
    KFD SVM maps memory in GPUVM at the same virtual address used by
    the CPU. However, svm_range_map_to_gpu() passes the corresponding
    PFNs to amdgpu_vm_update_range() without checking them against
    vm_manager.max_pfn.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.h
> index c7d7adae4476b..6235ce0f988ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,11 +203,25 @@ struct kfd_process_device *
>  svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *nod=
e);
>  void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, str=
uct mm_struct *mm);
> =20
> +/*
> + * SVM uses CPU virtual addresses for GPU mappings. Disable SVM if the G=
PUVM
> + * address range cannot cover the required CPU address range.
> + *
> + * The parameter must be named adev since AMDGPU_GMC_HOLE_START referenc=
es
> + * adev->vm_manager.max_level.
> + */
> +static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
> +{
> +	return (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) >=3D
> +		AMDGPU_GMC_HOLE_START;

[Severity: High]
Does this check erroneously rely on the GPU-dependent hole start instead of
the CPU's actual maximum user virtual address?

AMDGPU_GMC_HOLE_START is defined based on the GPU's capabilities:

drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h:
#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.max_level =3D=3D 4 ?\
				0x0100000000000000ULL : 0x0000800000000000ULL)

On a system with a 57-bit (5-level) CPU and a 48-bit (4-level) GPU, this
comparison evaluates to true, keeping SVM enabled. A malicious userspace
program could then map a valid CPU address above 48 bits and pass it to
KFD SVM.

This would result in svm_range_validate_and_map() passing the unvalidated
address to amdgpu_vm_update_range(), leading to an out-of-bounds access in
amdgpu_vm_pt_descendant():

drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:amdgpu_vm_pt_descendant() {
    ...
	idx =3D (cursor->pfn >> shift) & mask;
	cursor->parent =3D cursor->entry;
	cursor->entry =3D &to_amdgpu_bo_vm(cursor->entry->bo)->entries[idx];
    ...
}

Should this check use a CPU-specific limit like TASK_SIZE_MAX to ensure SVM
is safely disabled when the GPU cannot cover the CPU's address space?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016145129.6964=
5-1-danielhu@amd.com?part=3D1
