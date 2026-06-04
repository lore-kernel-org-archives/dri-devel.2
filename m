Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B19CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6761113EBA;
	Thu,  4 Jun 2026 10:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PLTPUNlZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC53F113EBA
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 10:07:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 242DF601DF;
 Thu,  4 Jun 2026 10:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECEA1F00899;
 Thu,  4 Jun 2026 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780567641;
 bh=f6IiuQyCCd9+XTT/wJA2mEBlLO2Tpnx7cUeg37VNANw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PLTPUNlZFUHaPSUClkWhwd5Rp3EcZxlW1ALTKuMiIMErUCoQ9qblCkox0ZWwYIx68
 ClCo1YJp0FruxfJwmD+1//QU+KVU6mEadhCCtAbWqYwWgAjd3EPQKGTjgEHtOv9If3
 0trmnTkYFAXjCKEkeeuYii2N+WBR8OELPJMnhHu2mFqYfo/tgZVJhtsljHj6mACX0w
 QFoFB0FmDelUtOA6b04bhFN1EhuqMNIsK4ZzF/EmkFWhFvVRkj/X+ISVp5jiKbwxCh
 DrcStj4b5ZF7iWTRc0uBtjm29OXa1saVGo161QNLh+JvD6x450GtRdF8fWZwaYgDrR
 5fV85eGGwBpVg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 2/7] drm/xe/vm: Preserve cpu_autoreset_active across
 GPUVA operations
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604095012.367231-3-arvind.yadav@intel.com>
References: <20260604095012.367231-3-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 10:07:21 +0000
Message-Id: <20260604100721.7ECEA1F00899@smtp.kernel.org>
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
- [Critical] Merging adjacent VMAs during CPU mirror pagefaults silently cl=
obbers creation flags (e.g., READ_ONLY, MADV_AUTORESET), permanently alteri=
ng memory properties and potentially leading to privilege escalation.
--

commit 1d97ca671d925d0481b9d913f989dc8216596164
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe/vm: Preserve cpu_autoreset_active across GPUVA operations

GPUVA split and remap operations rebuild VMAs from create flags. This
commit explicitly forwards XE_VMA_CPU_AUTORESET_ACTIVE through the
MAP/REMAP pipeline so xe_vma_create() can restore cpu_autoreset_active.
It also relaxes the UNMAP attribute warning for MADVISE_AUTORESET VMAs.

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c

[ ... ]

> @@ -4728,19 +4752,24 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
>  		if (!is_madvise) {
>  			if (__op->op =3D=3D DRM_GPUVA_OP_UNMAP) {
>  				vma =3D gpuva_to_vma(op->base.unmap.va);
> -				XE_WARN_ON(!xe_vma_has_default_mem_attrs(vma));
> +				/* AUTORESET VMAs may carry madvise-managed attrs. */
> +				XE_WARN_ON(!xe_vma_has_default_mem_attrs(vma) &&
> +					   !(vma->gpuva.flags & XE_VMA_MADV_AUTORESET));
>  				default_pat =3D vma->attr.default_pat_index;
> -				vma_flags =3D vma->gpuva.flags;
> +				vma_flags =3D xe_vma_effective_create_flags(vma);
>  			}
> =20
>  			if (__op->op =3D=3D DRM_GPUVA_OP_REMAP) {
>  				vma =3D gpuva_to_vma(op->base.remap.unmap->va);
>  				default_pat =3D vma->attr.default_pat_index;
> -				vma_flags =3D vma->gpuva.flags;
> +				vma_flags =3D xe_vma_effective_create_flags(vma);
>  			}
> =20
>  			if (__op->op =3D=3D DRM_GPUVA_OP_MAP) {
>  				op->map.vma_flags |=3D vma_flags & XE_VMA_CREATE_MASK;

[Severity: Critical]
This is a pre-existing issue, but does this loop silently clobber creation
flags like XE_VMA_READ_ONLY when merging adjacent VMAs during CPU mirror
pagefaults?

When xe_svm_handle_pagefault() attempts to expand a VMA mapping, it calls
xe_vm_find_cpu_addr_mirror_vma_range(). That function coalesces adjacent
VMAs using is_cpu_addr_vma_with_default_attr():

drivers/gpu/drm/xe/xe_vm.c:is_cpu_addr_vma_with_default_attr() {
	return vma && xe_vma_is_cpu_addr_mirror(vma) &&
	       xe_vma_has_default_mem_attrs(vma);
}

This check verifies the system allocator flag and default memory attributes,
but it doesn't ensure that vma->gpuva.flags (such as XE_VMA_READ_ONLY or
XE_VMA_DUMPABLE) match between the adjacent VMAs.

As a result, xe_vm_alloc_vma() creates a single MAP operation for the
merged range. In the drm_gpuva_for_each_op() loop here, the local vma_flags
variable is continuously overwritten by each UNMAP and REMAP operation.

When the final MAP operation processes this line, it inherits flags
exclusively from the last processed VMA. If a read-write VMA is merged
with an adjacent read-only VMA, is the XE_VMA_READ_ONLY flag completely
lost for the coalesced region, potentially granting writable access to a
mapping originally requested as read-only?

> +				/* Forward pipeline-only state. */
> +				if (vma_flags & XE_VMA_CPU_AUTORESET_ACTIVE)
> +					op->map.vma_flags |=3D XE_VMA_CPU_AUTORESET_ACTIVE;
>  				op->map.pat_index =3D default_pat;
>  			}
>  		} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095012.3672=
31-1-arvind.yadav@intel.com?part=3D2
