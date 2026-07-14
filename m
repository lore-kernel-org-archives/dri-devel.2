Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6259C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A38910EBC7;
	Tue, 14 Jul 2026 03:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ej50Lvng";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A333810EBC7
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:28:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29084601DE;
 Tue, 14 Jul 2026 03:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A988A1F000E9;
 Tue, 14 Jul 2026 03:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783999713;
 bh=4Vg6WCEjKK0fjfqQIXRr4FFdJnZa6LIPQAreKEtH038=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ej50Lvngd0UiTbcmfkAIv6wddPkX1eAl9Xxau+R35Zfx4HZ1fT7teECIpumSvL1Zb
 3cxfN1ZV+k1nXEYlmEFNyee8bdcHA8S2gnXOsUTqtHsJay62cHJOK5KB1lCGR3F9gR
 SQJBKIoQFqockQaso3lGMmvajQ0tzxbIvuJA8CeCV+gUG71mQuyDsN9kcs25R3Z3oT
 8I1X1Ou9PWS0db3/WF7Ia+YWlEi9JAgB/dM5TuUlkRfe6+PeeNTImXFAgk/hCTj5JR
 aY5OBsNfQ3OHHIDaoP2JyMa8HD8xzqFkW2h+oCzzVGQU5MuncjZzqx9fNxgupNBChw
 yU5AOH+qguUwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/7] drm/tyr: add GPU virtual memory (VM) support
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260713-fw-boot-b4-v7-4-afd8dc1494dd@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-4-afd8dc1494dd@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:28:33 +0000
Message-Id: <20260714032833.A988A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Casting 64-bit physical and virtual addresses to `usize` cause=
s silent truncation on 32-bit platforms with LPAE, leading to incorrect map=
pings and memory corruption.
- [High] Insufficient `GpuVaAlloc` preallocation causes map/unmap operation=
s to fail midway with `EINVAL`, leaving hardware page tables out of sync wi=
th the GPUVM tree.
- [High] Unmapping regions backed by non-2MB-aligned physical addresses fai=
ls and leaks the mappings because `pt_unmap` incorrectly assumes the mapped=
 page size is 2MB.
- [High] Missing bounds check on GEM object size in `map_bo_range` allows c=
reating overgrown mappings, leading to permanent memory leaks and GPUVM tre=
e corruption.
- [Medium] Successfully mapped pages during a failing `pt.map_pages` call a=
re not unmapped, permanently leaking page table entries.
--

--- Patch [4]: [PATCH v7 4/7] drm/tyr: add GPU virtual memory (VM) support =
---
commit 809ab9f421f459ef56a480ccf227ec9341b24878
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add GPU virtual memory (VM) support

Add GPU virtual address space management using the DRM GPUVM framework.
Each virtual memory space is backed by ARM64 LPAE Stage 1 page tables
and can be mapped into hardware address space slots for GPU execution.

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 0000000000000..2358096afc7e8 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/vm.rs
[ ... ]
>     pub(crate) fn map_bo_range(
>         &self,
>         bo: &Bo,
>         bo_offset: u64,
>         size: u64,
>         va: u64,
>         flags: VmMapFlags,
>     ) -> Result {
>         let req =3D VmOpRequest {
>             op_type: VmOpType::Map(VmMapArgs {
>                 vm_bo: self.gpuvm.obtain(bo, ())?,
>                 flags,
>                 bo_offset,
>             }),
>             region: va..(va + size),
>         };

[Severity: High]
Does this code allow mapping a region larger than the actual GEM object?

If bo_offset + size exceeds the object's size, sm_step_map() will finish
when the scatter-gather table is exhausted but register a GPUVA node for
the full oversized range. When this oversized virtual address range is
later unmapped, the driver might attempt to unmap page table entries that
were never populated, which can cause pt.unmap_pages() to return 0 and
abort the unmap operation.

>         let mut resources =3D VmOpResources {
>             preallocated_gpuvas: [
>                 Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
>                 Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
>                 Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
>             ],
>         };

[Severity: High]
Is preallocating 3 VAs sufficient for a map operation?=20

If the new mapping overlaps and splits two existing mappings, it can trigger
two remaps. A single remap consumes 2 preallocated VAs, plus 1 for the new
mapping, requiring up to 5 VAs in total. Can this cause the map operation to
fail midway with EINVAL and leave the software GPUVM tracking tree out of
sync with the hardware page tables?

[ ... ]
>     pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
>         let req =3D VmOpRequest {
>             op_type: VmOpType::Unmap,
>             region: va..(va + size),
>         };
>         let mut resources =3D VmOpResources {
>             preallocated_gpuvas: [
>                 Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
>                 Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
>                 None,
>             ],
>         };

[Severity: High]
Will this array have enough VAs for a complex unmap?=20

An unmap operation that splits two existing mappings could require up to 4 =
VAs
for the leftover segments, but this initialization only allocates 2.

[ ... ]
> fn pt_map(
>     pt: &IoPageTable<'_, ARM64LPAES1>,
>     iova: u64,
>     paddr: u64,
>     len: u64,
>     prot: u32,
> ) -> Result<u64> {
[ ... ]
>         let (mapped, result) =3D unsafe {
>             pt.map_pages(
>                 curr_iova as usize,
>                 (curr_paddr as usize).try_into().unwrap(),
>                 pgsize as usize,
>                 pgcount as usize,
>                 prot,
>                 GFP_KERNEL,
>             )
>         };

[Severity: Critical]
Does casting curr_paddr and curr_iova to usize truncate 64-bit addresses
on 32-bit platforms with LPAE?=20

This could cause incorrect physical pages to be mapped into the GPU's
address space, potentially leading to unauthorized memory access or data
corruption.

>         if let Err(e) =3D result {
>             pr_err!("pt.map_pages failed at iova {:#x}: {:?}\n", curr_iov=
a, e);
>             if segment_mapped > 0 {
>                 let _ =3D pt_unmap(pt, iova..(iova + segment_mapped));
>             }
>             return Err(e);
>         }

[Severity: Medium]
If pt.map_pages() succeeds in mapping some pages but returns an error for
a subsequent page, does this error path leak the pages that were just
successfully mapped?=20

The cleanup unmaps segment_mapped (the bytes mapped in previous loop
iterations) but doesn't appear to include the mapped bytes returned by
the failing pt.map_pages() call.

[ ... ]
> fn pt_unmap(pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>) -> Resu=
lt {
>     let mut iova =3D range.start;
>     let mut bytes_left_to_unmap =3D range.end - range.start;
>=20
>     while bytes_left_to_unmap > 0 {
>         let (pgsize, pgcount) =3D get_pgsize(iova, bytes_left_to_unmap);
>=20
>         let unmapped =3D unsafe { pt.unmap_pages(iova as usize, pgsize as=
 usize, pgcount as usize) };

[Severity: High]
Can this fail to unmap regions if they were originally backed by physical
addresses that were not 2MB-aligned?

In pt_map(), the page size is calculated using both virtual and physical
addresses:

    get_pgsize(curr_iova | curr_paddr, remaining);

However, pt_unmap() calculates the page size using only the virtual address:

    get_pgsize(iova, bytes_left_to_unmap);

If a user maps a physical address that is not 2MB-aligned into a virtual
address that is 2MB-aligned, it appears pt_map() will fall back to 4KB
pages, but pt_unmap() will attempt to unmap using 2MB blocks.

[Severity: Critical]
Does casting iova to usize here also cause silent truncation on 32-bit
platforms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-fw-boot-b4=
-v7-0-afd8dc1494dd@collabora.com?part=3D4
