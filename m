Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289BEC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7EF10EE9E;
	Wed,  9 Sep 2026 04:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hGOF50mN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3522A10EE9E
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:17:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95F5D601FE;
 Wed,  9 Sep 2026 04:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1596A1F00A3A;
 Wed,  9 Sep 2026 04:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788927427;
 bh=2eJgv8KprPlbudHwyfe8f0TdGvmnicEsY9nSKyfBgPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hGOF50mNqSv5rWm0aHKKRawcKHco4KzNn/TXu4zCbRMSjYHOYHM6rwCOY9QL4w3u2
 JdaGA7ZAvQtyMY8YvDCrC4Wu6YOg7DZCGAhTyDJAmWx92x4GX4lGUt/O5ZY23ge72F
 Ix63fvB2/GBF1ujoJ9ogHXeiXaTNUMgfguiPXHIlnAs7ndxYIMvm+g+JP5ddb2O08t
 PEBxP6p+WlCVjsC9ux3xFXQkOzfm0kwmhUVx41FrD1Co/kUUvPN6iUx81u1VUUqyh4
 SlINCmK3fgb44W1om3u3gNdOGHXk0iY/YmPSKrWCeAN9Dbszoz4vKedia/Lew/dw1w
 3bc64EWP1/Jvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/16] gpu: nova-core: mm: Add multi-page mapping API to
 VMM
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-13-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-13-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:17:06 +0000
Message-Id: <20260909041707.1596A1F00A3A@smtp.kernel.org>
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
- [Critical] Capacity exhaustion during page table installation causes hard=
ware Use-After-Free.
- [Critical] Freeing the VFN range on partial mapping/unmapping failure lea=
ves dangling hardware PTEs.
- [High] Early error return in `invalidate_ptes` skips mandatory TLB flush.
- [Medium] `PreparedMapping` and `MappedRange` permanently leak VFN space o=
n drop.
- [Low] Spurious false-positive kernel warning on `execute_map` validation =
failure.
--

commit dc299c1a2ad37eca6a9c91c4b5425f4e7871fa45
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add multi-page mapping API to VMM

Add the page table mapping and unmapping API to the Virtual Memory
Manager, implementing a two-phase prepare/execute model suitable for
use both inside and outside the DMA fence signalling critical path.

> diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova=
-core/mm/pagetable/map.rs
> --- a/drivers/gpu/nova-core/mm/pagetable/map.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
[ ... ]
> +    pub(super) fn prepare_map(
> +        &self,
> +        mm: &mut GpuMm<'_>,
> +        vfn_start: Vfn,
> +        num_pages: usize,
> +        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
> +        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
> +    ) -> Result {
> +        // Pre-reserve so install_mappings() can use push_within_capacit=
y (no alloc
> +        // in fence signalling critical path).
> +        let pt_upper_bound =3D M::pt_pages_upper_bound(num_pages);
> +        page_table_allocs.reserve(pt_upper_bound, GFP_KERNEL)?;

[Severity: Critical]
Does this reservation fail to account for multiple pending allocations?
If prepare_map() is called multiple times before execute_map() or fails
partway through, orphaned pages accumulate in the shared pt_pages tree.
This regression occurs because page_table_allocs.reserve() does not
accumulate capacity across multiple calls, causing install_mappings()
to later run out of reserved capacity.

[ ... ]
> +    pub(super) fn install_mappings(
> +        &self,
> +        mm: &mut GpuMm<'_>,
> +        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
> +        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
> +        vfn_start: Vfn,
> +        pfns: &[Pfn],
> +        writable: bool,
> +    ) -> Result {
> +        {
> +            let pramin =3D mm.pramin_mut();
> +
> +            // Drain prepared PT pages, install all pending PDEs.
> +            let mut cursor =3D pt_pages.cursor_front_mut();
> +            while let Some(c) =3D cursor {
> +                let (next, node) =3D c.remove_current();
> +                let (install_addr, page) =3D node.to_key_value();
> +                let page_vram =3D
> +                    VramAddress::from_raw(page.alloc.iter().next().ok_or=
(ENOMEM)?.offset());
> +
> +                if page.level =3D=3D M::DUAL_PDE_LEVEL {
> +                    let new_dpde =3D M::DualPde::new_small(Pfn::from(pag=
e_vram));
> +                    new_dpde.write(pramin, install_addr)?;
> +                } else {
> +                    let new_pde =3D M::Pde::new(AperturePde::VideoMemory=
, Pfn::from(page_vram));
> +                    new_pde.write(pramin, install_addr)?;
> +                }
> +
> +                page_table_allocs
> +                    .push_within_capacity(page.alloc)
> +                    .map_err(|_| ENOMEM)?;

[Severity: Critical]
Can this capacity check failure lead to a use-after-free in the hardware?
The physical memory is committed to the hardware PDE right before the
capacity check fails. If push_within_capacity() returns an error, this
regression causes the allocation to be dropped and the memory to be freed
back to the buddy allocator, but the hardware PDE is left pointing to that
freed memory.

[ ... ]
> +    pub(super) fn invalidate_ptes(
> +        &self,
> +        mm: &mut GpuMm<'_>,
> +        vfn_start: Vfn,
> +        num_pages: usize,
> +    ) -> Result {
> +        let invalid_pte =3D M::Pte::invalid();
> +
> +        {
> +            let pramin =3D mm.pramin_mut();
> +            for i in 0..num_pages {
> +                let i_u64: u64 =3D i.into_safe_cast();
> +                let vfn =3D Vfn::new(vfn_start.raw() + i_u64);
> +                let result =3D self.walker.walk_to_pte_lookup_with_windo=
w(pramin, vfn)?;
> +
> +                match result {
> +                    WalkResult::Mapped { pte_addr, .. } | WalkResult::Un=
mapped { pte_addr } =3D> {
> +                        invalid_pte.write(pramin, pte_addr)?;
> +                    }

[Severity: High]
Does the ? operator here skip the mandatory TLB flush? If a hardware I/O
error occurs during the page table window write, the function returns
early.

> +                    WalkResult::PageTableMissing =3D> {
> +                        continue;
> +                    }
> +                }
> +            }
> +        }
> +
> +        mm.tlb().flush(self.pdb_addr)
> +    }

[Severity: High]
This required TLB flush is bypassed on the early error return mentioned
above. Any PTEs successfully invalidated before the error will remain
active in the GPU's TLB, creating a regression where continued access to
memory is allowed after it has been unmapped and freed.

> diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/v=
mm.rs
> --- a/drivers/gpu/nova-core/mm/vmm.rs
> +++ b/drivers/gpu/nova-core/mm/vmm.rs
[ ... ]
> +impl Drop for MustExecuteGuard {
> +    fn drop(&mut self) {
> +        if self.armed.get() {
> +            kernel::pr_warn!("PreparedMapping dropped without calling ex=
ecute_map()\n");
> +        }
> +    }
> +}

[Severity: Medium]
Does this drop guard permanently leak the allocated VFN space? While the
guard logs a warning, it lacks a reference to the Vmm and cannot free the
underlying virtual address allocation from the maple tree, causing a
regression that permanently leaks virtual address space.

[ ... ]
> +impl Drop for MustUnmapGuard {
> +    fn drop(&mut self) {
> +        if self.armed.get() {
> +            kernel::pr_warn!("MappedRange dropped without calling unmap_=
pages()\n");
> +        }
> +    }
> +}

[Severity: Medium]
Similarly, does dropping a MappedRange without calling unmap_pages() leak
the virtual address space? If a caller propagates an error and drops the
range, the warning is printed but the VFN space is permanently lost.

[ ... ]
> +    pub(crate) fn execute_map(
> +        &mut self,
> +        mm: &mut GpuMm<'_>,
> +        prepared: PreparedMapping,
> +        pfns: &[Pfn],
> +        writable: bool,
> +    ) -> Result<MappedRange> {
> +        if pfns.len() !=3D prepared.num_pages {
> +            self.free_vfn(prepared.vfn_start);
> +            return Err(EINVAL);
> +        }

[Severity: Low]
Could this validation failure trigger a false-positive kernel warning?
The prepared mapping is passed by value and is dropped on this early
return. Because its drop guard is still armed, MustExecuteGuard::drop()
will log a warning that the mapping was dropped without calling
execute_map(), even though the caller did correctly invoke execute_map().

[ ... ]
> +        if let Err(e) =3D self.pt_map.install_mappings(
> +            mm,
> +            &mut self.pt_pages,
> +            &mut self.page_table_allocs,
> +            vfn_start,
> +            pfns,
> +            writable,
> +        ) {
> +            self.free_vfn(vfn_start);
> +            return Err(e);
> +        }

[Severity: Critical]
Does freeing the VFN range on partial mapping failure leave dangling
hardware PTEs? If install_mappings() returns early due to an I/O error
after writing some PTEs, self.free_vfn() frees the virtual address space,
and the caller will likely free the underlying physical pages. However, the
successfully written hardware PTEs are not rolled back. This regression
allows the GPU to access the freed physical memory.

[ ... ]
> +    pub(crate) fn unmap_pages(&mut self, mm: &mut GpuMm<'_>, range: Mapp=
edRange) -> Result {
> +        let result =3D self
> +            .pt_map
> +            .invalidate_ptes(mm, range.vfn_start, range.num_pages);
> +
> +        // TODO: Internal page table pages (PDE, PTE pages) are still ke=
pt around.
> +        // This is by design as repeated maps/unmaps will be fast. As a =
future TODO,
> +        // we can add a reclaimer here to reclaim if VRAM is short. For =
now, the PT
> +        // pages are dropped once the `Vmm` is dropped.
> +
> +        // Free the VA range regardless of PTE invalidation success, so =
that the VA
> +        // range is recovered even on failure (PTEs may be stale, but th=
at is better
> +        // than leaking both PTEs and VA range).
> +        self.free_vfn(range.vfn_start);

[Severity: Critical]
Is it safe to free the VFN range if PTE invalidation fails? If
invalidate_ptes() fails partially, explicit freeing of the VFN range
leaves active, stale PTEs in the hardware. This regression allows the GPU
to retain access to physical pages that the caller will assume are safe to
free and reuse.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D13
