Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0FFCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FD4113EAF;
	Thu,  4 Jun 2026 10:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Js0HQQf1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E902F113EAF
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 10:03:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11DD4601F5;
 Thu,  4 Jun 2026 10:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C581F00893;
 Thu,  4 Jun 2026 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780567420;
 bh=aMQzR6I8brBIEqdpXVCBJV2699SakFXIV+Sucj9eaw4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Js0HQQf1qkoma53BfSHPDn3oMW8R6Dd5A5nHSAI04xbugY3GHcf0jRWMExTZ6mY5u
 YLasW3Go1mes7eabty3wxG+KqF9o5jxJ3AnvqQ/AfG/eLNxBWVodDFQXFCVcPkoeu4
 KZQ0/79IuQm0kOyhp0VRF1AbhkjFG7b5OLnxAOH7WYEhAs5lm6Sy3dLJDc1r93f7G9
 Nj5H6mXe9CVob8a2ifzxyQoE0G/FkjygghUY1ucrF6k+n2OxGS9x6rRw4PH7njxjKd
 8lF3jcfbE4ImDvO1ihboXahmWqgVuh9ZDtYgJTN8lJEk1OdbqCO5PsVi4P9AF3cQMC
 NZq7JDrj3LtTA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 5/7] drm/xe/vm: Disable madvise notifier on GPU touch
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604095012.367231-6-arvind.yadav@intel.com>
References: <20260604095012.367231-6-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 10:03:40 +0000
Message-Id: <20260604100340.96C581F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unbounded accumulation of `xe_madvise_notifier` structs leading to=
 memory leak and Denial of Service (OOM).
--

commit 01cdfed4cb38d71774f4ae69b625419325962b05
Author: Arvind Yadav <arvind.yadav@intel.com>
drm/xe/vm: Disable madvise notifier on GPU touch

This commit adds an active flag to xe_madvise_notifier to stop queueing
autoreset work once a CPU-only VMA has been GPU-faulted. It modifies the
pagefault handler to touch the VMA and deactivate exact-match notifiers
in the maple tree.

> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_v=
m_madvise.c
> index c2abe712598a1..6c42ce8e3f525 100644
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
[ ... ]
> @@ -1236,3 +1238,46 @@ int xe_vm_madvise_register_notifier_range(struct x=
e_vm *vm, u64 start, u64 end)
> =20
>  	return err;
>  }
> +
> +/**
> + * xe_vm_deactivate_madvise_notifier_for_range - Disable callbacks for a=
 VMA
> + * @vm: VM
> + * @start: VMA start
> + * @end: VMA end
> + */
> +static void xe_vm_deactivate_madvise_notifier_for_range(struct xe_vm *vm=
, u64 start, u64 end)
> +{
> +	struct xe_madvise_notifier *notifier;
> +	unsigned long index =3D start;
> +
> +	lockdep_assert_held_write(&vm->lock);
> +
> +	if (!vm->svm.madvise_work.wq)
> +		return;
> +
> +	/*
> +	 * Only exact-match notifiers are disabled. Broader notifiers may still
> +	 * cover CPU-only split siblings.
> +	 */
> +	mt_for_each(&vm->svm.madvise_notifiers, notifier, index, end - 1)
> +		if (notifier->vma_start =3D=3D start && notifier->vma_end =3D=3D end)
> +			WRITE_ONCE(notifier->active, false);

[Severity: High]
This is a pre-existing issue, but does leaving these deactivated notifiers =
in
memory without freeing them contribute to an unbounded accumulation?

Looking at xe_vm_madvise_register_notifier_range(), notifiers are allocated
and linked to the VM indefinitely:

xe_vm_madvise_register_notifier_range() {
    notifier =3D xe_madvise_notifier_alloc(vm, start, end);
    if (!notifier)
        return -ENOMEM;
    ...
    list_add_tail(&notifier->link, &vm->svm.madvise_notifier_list);
}

Since older notifiers are only freed if they are fully covered by a new ran=
ge
or during VM teardown, could userspace intentionally map, bind with AUTORES=
ET,
madvise, and unbind at different addresses across the virtual address space?

This sequence seems like it would bypass the displacement logic and permane=
ntly
leak the notifier objects, potentially consuming kernel memory and causing a
denial of service.

Should xe_vm_deactivate_madvise_notifier_for_range() or the unbind path
actively clean up these deactivated objects?

> +}
> +
> +/**
> + * xe_vm_madvise_gpu_touch - Disable madvise notifier after GPU touch
> + * @vm: VM
> + * @vma: GPU-touched VMA
> + */
> +void xe_vm_madvise_gpu_touch(struct xe_vm *vm, struct xe_vma *vma)
> +{
> +	lockdep_assert_held_write(&vm->lock);
> +
> +	/* Only AUTORESET VMAs have madvise notifiers. */
> +	if (!(vma->gpuva.flags & XE_VMA_MADV_AUTORESET))
> +		return;
> +
> +	xe_vm_deactivate_madvise_notifier_for_range(vm,
> +						xe_vma_start(vma),
> +						xe_vma_end(vma));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095012.3672=
31-1-arvind.yadav@intel.com?part=3D5
