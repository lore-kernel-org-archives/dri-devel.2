Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90440C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 20:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419CC10E357;
	Sun, 16 Aug 2026 20:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cxj9giKn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D4710E357
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 20:03:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12C736013A;
 Sun, 16 Aug 2026 20:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870791F000E9;
 Sun, 16 Aug 2026 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786910606;
 bh=NbKfPVvrM9F0HPsAnuR+lyP4PE/fiNDIwQ0Gdo3se94=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cxj9giKniLBQlurXquGmKf+rBDLkbR94F46KcSTYZTAUpCB/tcSbR1k5d5FsLO46q
 Y/72bmNvrDnX/+e89ViT2UlwSCZS8Q0cPDLMn8f9iUc1oiD9rxwnxI269c6oCd3Ns6
 LIrAUjMJSt1zVUoDWC6yZteW/qSJ8PcnvOpmNov0bm1qFkz8mT+HhYjt6I6IpAr6y5
 mrH6oSNrnHxUIQDA2PFlpsHeQIDYBeqzkkILGjcA4WClULnlHhTFlUalYAOP/XMr+Q
 03cBOSz/7zsEfYQv0PWFF2m3YwlTEhy2uP22NVi6xUHqi1ZkPYWaRjWckbxvmLozih
 Tv4eH3cw/LIgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/imagination: Add sparse mappings to VM_BIND
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260817-pvr-vm-bind-v1-4-0a0f21be7d38@gmail.com>
References: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
 <20260817-pvr-vm-bind-v1-4-0a0f21be7d38@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 20:03:26 +0000
Message-Id: <20260816200326.870791F000E9@smtp.kernel.org>
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
- [Critical] Integer underflow in page table preallocation size calculation=
 allows unprivileged users to cause OOM panic.
- [High] Page table preallocation calculates requirements using object offs=
et instead of device address, leading to -ENOMEM during valid mappings.
- [High] Mapping errors are masked during scatterlist processing, leaving h=
oles in hardware page tables.
--

--- Patch [4]: [PATCH 4/4] drm/imagination: Add sparse mappings to VM_BIND =
---
commit 8758f312b45a84c218f5a0a8c5687d9c21928110
Author: Gyeyoung Baek <gye976@gmail.com>
Subject: drm/imagination: Add sparse mappings to VM_BIND

This commit adds support for Vulkan sparse residency by allowing ranges
to be mapped without naming a buffer object. It introduces
DRM_PVR_VM_BIND_OP_MAP_SPARSE, where every page table entry in the range
points to the same file-specific dummy page.

> diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imag=
ination/pvr_mmu.c
> index 3cac482e10347..fc1347d6f233b 100644
> --- a/drivers/gpu/drm/imagination/pvr_mmu.c
> +++ b/drivers/gpu/drm/imagination/pvr_mmu.c
> @@ -2558,6 +2558,77 @@ pvr_mmu_map_sgl(struct pvr_mmu_op_context *op_ctx,=
 struct scatterlist *sgl,
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but does pvr_mmu_map_sgl() mask the original
error code on failure?

If an error occurs during page table entry creation in pvr_mmu_map_sgl(), t=
he
code jumps to the err_destroy_pages label:

drivers/gpu/drm/imagination/pvr_mmu.c:pvr_mmu_map_sgl() {
    ...
err_destroy_pages:
	memcpy(&op_ctx->curr_page, &ptr_copy, sizeof(op_ctx->curr_page));
	err =3D pvr_mmu_op_context_unmap_curr_page(op_ctx, page);

	return err;
}

Since pvr_mmu_op_context_unmap_curr_page() typically succeeds and returns 0,
the original error code is overwritten with 0. The function then incorrectly
signals success to the caller, leaving holes in the hardware page tables.
This could cause unpredictable hardware page faults when accessed by the GP=
U.

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index f92bfeacd7ac4..d11e192c7726d 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -267,7 +273,7 @@ static int
>  pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
>  			struct pvr_vm_context *vm_ctx,
>  			struct pvr_gem_object *pvr_obj, u64 offset,
> -			u64 device_addr, u64 size)
> +			u64 device_addr, u64 size, bool sparse)
>  {
>  	struct drm_gem_object *obj =3D gem_from_pvr_gem(pvr_obj);
>  	const bool is_user =3D vm_ctx !=3D vm_ctx->pvr_dev->kernel_vm_ctx;
> @@ -285,11 +291,19 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind=
_op,
>  	}
> =20
>  	if (!pvr_device_addr_and_size_are_valid(vm_ctx, device_addr, size) ||
> -	    offset & ~PAGE_MASK || size & ~PAGE_MASK ||
> -	    offset >=3D pvr_obj_size || offset_plus_size > pvr_obj_size)
> +	    offset & ~PAGE_MASK || size & ~PAGE_MASK)
> +		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does the page table prealloc=
ation
calculate requirements using the object offset instead of the device addres=
s?

When a VM_BIND request is made, pvr_vm_bind_op_map_init() calls
pvr_mmu_op_context_create(), passing offset as the sgt_offset:

drivers/gpu/drm/imagination/pvr_mmu.c:pvr_mmu_op_context_create() {
    ...
		const u32 l0_start_idx =3D pvr_page_table_l1_idx(sgt_offset);
		const u32 l0_end_idx =3D pvr_page_table_l1_idx(sgt_offset + size);
		const u32 l0_count =3D l0_end_idx - l0_start_idx + 1;
    ...
}

If the device_addr alignment causes the mapping to span more 2MB or 1GB
boundaries than sgt_offset does, this will under-allocate page tables.
For instance, mapping an 8KB chunk with offset=3D0 to a device_addr that cr=
osses
a 2MB boundary requires 2 L0 page tables, but the logic using sgt_offset
calculates only 1.

When the driver attempts to insert the second page, the preallocated pool is
empty and returns -ENOMEM. This would cause valid mappings to fail, and for
the newly introduced sparse mappings where offset is always 0, it guarantees
this failure whenever a sparse mapping crosses a 2MB boundary.

[Severity: Critical]
This is a pre-existing issue related to the above calculation, but can this
integer underflow allow unprivileged users to cause an OOM panic?

In the same calculation:

drivers/gpu/drm/imagination/pvr_mmu.c:pvr_mmu_op_context_create() {
    ...
		const u32 l0_start_idx =3D pvr_page_table_l1_idx(sgt_offset);
		const u32 l0_end_idx =3D pvr_page_table_l1_idx(sgt_offset + size);
		const u32 l0_count =3D l0_end_idx - l0_start_idx + 1;
    ...
}

The function pvr_page_table_l1_idx() masks out higher bits to return a boun=
ded
9-bit local index:

drivers/gpu/drm/imagination/pvr_mmu.c:pvr_page_table_l1_idx() {
	return (device_addr & ~ROGUE_MMUCTRL_VADDR_PD_INDEX_CLRMSK) >>
	       ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT;
}

If an unprivileged user calls the VM_BIND ioctl with an offset and size such
that offset + size crosses a 1GB page directory boundary, l0_end_idx will be
smaller than l0_start_idx (e.g., 0 < 511).

This causes l0_count to underflow to roughly 4.29 billion, leading to an
immediate kernel out-of-memory (OOM) panic as the driver attempts to alloca=
te
billions of page table structures in a tight loop.

> +	/*
> +	 * A sparse mapping repeats one page over a deliberately wider range,
> +	 * so the containment check only applies to ordinary mappings.
> +	 */
> +	if (!sparse &&
> +	    (offset >=3D pvr_obj_size || offset_plus_size > pvr_obj_size))
>  		return -EINVAL;
> =20
>  	bind_op->type =3D PVR_VM_BIND_TYPE_MAP;
> +	bind_op->sparse =3D sparse;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-pvr-vm-bin=
d-v1-0-0a0f21be7d38@gmail.com?part=3D4
