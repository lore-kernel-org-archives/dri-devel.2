Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4531C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE5510EEA0;
	Wed,  9 Sep 2026 04:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SrSc4bje";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DAD10EEA0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:18:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC5FA601FD;
 Wed,  9 Sep 2026 04:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452AA1F00A3A;
 Wed,  9 Sep 2026 04:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788927488;
 bh=B7MCc+648WddKtFkulJTGlQgHabfszHuMryvZA2vTt4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SrSc4bjekjAY1ZBwmKNxJ4FK2ytIIfX5T5A0NpA9xDhVRQriLpfCOvjW+qPggXqW0
 0JHCd3aLerk2tp7v43T3YhKP7FyY11DTn8qnB0YvEZmml9oq+NX1yJnfaaCmAU1vqT
 we9Er9V9RXHsIstwbU5447aiNc1hKJDLTUr/Xj0tzmshyHZyBkjQXO4XuW0P+G8sW7
 xP5HqS2YFds63O7OWMUzUnNZGPHNs7L6OpRDrti2m/gbeWaw1d1fpVeUkVcSQEF1Lu
 8OtS800iGprBVYwJK4faLZhqlLqWFrBaLD9r5bGI0SH2WxnGJIm6dUzs6KkeYyCtt/
 El4jmFT8bbJ0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/16] gpu: nova-core: mm: Add virtual address range
 tracking to VMM
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-mmrebase-v1-12-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-12-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:18:07 +0000
Message-Id: <20260909041808.452AA1F00A3A@smtp.kernel.org>
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
- [High] `free_vfn` inadvertently frees entire multi-page or unrelated adja=
cent allocations because the maple tree automatically coalesces identical v=
alues and `erase` removes the full node.
- [High] `alloc_vfn_range` silently truncates unaligned requested virtual a=
ddresses instead of returning an error, mapping a different virtual address=
 range than requested.
- [High] `alloc_vfn_range` fails to validate that an explicitly requested `=
va_range` falls within the VMM's maximum address space limits.
--

commit 72ebdc957b03c40c8135fdeabd96b70130feb75f
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add virtual address range tracking to VMM
   =20
This commit adds a maple tree allocator for tracking contiguous virtual
address ranges. It enables allocating and freeing virtual frame numbers
for mappings.

> diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/v=
mm.rs
> index a7911efb65a03..0bcae29db4f2c 100644
> --- a/drivers/gpu/nova-core/mm/vmm.rs
> +++ b/drivers/gpu/nova-core/mm/vmm.rs

[ ... ]

> @@ -34,18 +43,74 @@ pub(crate) struct Vmm {
>      mmu_version: MmuVersion,
>      /// Page table allocations required for mappings.
>      page_table_allocs: KVec<Pin<KBox<AllocatedBlocks>>>,
> +    /// Maple tree allocator for virtual address range tracking.
> +    virt_alloc: Pin<KBox<MapleTreeAlloc<()>>>,
> +    /// Total number of pages in the virtual address space.
> +    va_pages: usize,
>  }
> =20
>  impl Vmm {
>      /// Create a new [`Vmm`] for the given Page Directory Base address.
> -    pub(crate) fn new(pdb_addr: VramAddress, mmu_version: MmuVersion) ->=
 Result<Self> {
> +    ///
> +    /// The [`Vmm`] will manage a virtual address space of `va_size` byt=
es.
> +    pub(crate) fn new(
> +        pdb_addr: VramAddress,
> +        mmu_version: MmuVersion,
> +        va_size: u64,
> +    ) -> Result<Self> {
> +        let page_size: u64 =3D PAGE_SIZE.into_safe_cast();
> +        let va_pages: usize =3D (va_size / page_size).into_safe_cast();
> +        let virt_alloc =3D KBox::pin_init(MapleTreeAlloc::<()>::new(), G=
FP_KERNEL)?;

[Severity: High]
Since the maple tree allocator is instantiated with () as the value, won't =
it
automatically coalesce contiguous allocations into a single node because the
stored pointers are identical?

> +
>          Ok(Self {
>              pdb_addr,
>              mmu_version,
>              page_table_allocs: KVec::new(),
> +            virt_alloc,
> +            va_pages,
>          })
>      }
> =20
> +    /// Allocate a contiguous virtual frame number range.
> +    ///
> +    /// # Arguments
> +    ///
> +    /// - `num_pages`: Number of pages to allocate.
> +    /// - `va_range`: `None` =3D allocate anywhere, `Some(range)` =3D co=
nstrain allocation to the given
> +    ///   range.
> +    fn alloc_vfn_range(&self, num_pages: usize, va_range: Option<Range<u=
64>>) -> Result<Vfn> {
> +        let page_size: u64 =3D PAGE_SIZE.into_safe_cast();
> +
> +        let start_vfn =3D match va_range {
> +            Some(r) =3D> {
> +                let num_pages_u64: u64 =3D num_pages.into_safe_cast();
> +                let size =3D num_pages_u64.checked_mul(page_size).ok_or(=
EOVERFLOW)?;
> +                let range_size =3D r.end.checked_sub(r.start).ok_or(EOVE=
RFLOW)?;
> +                if range_size !=3D size {
> +                    return Err(EINVAL);
> +                }
> +                let start_vfn: usize =3D (r.start / page_size).into_safe=
_cast();
> +                let end_vfn: usize =3D (r.end / page_size).into_safe_cas=
t();

[Severity: High]
Could the integer division truncate misaligned addresses here?

If r.start or r.end are not page-aligned, this division silently maps a
different page-aligned address instead of returning -EINVAL for the misalig=
ned
request.

> +                self.virt_alloc
> +                    .insert_range(start_vfn..end_vfn, (), GFP_KERNEL)?;

[Severity: High]
Does this insertion need to be validated against the VMM's maximum address =
space
limit?

If an explicitly requested end_vfn exceeds self.va_pages, this succeeds but
could later cause wrap-around truncation and page table corruption during
hardware programming.

> +                start_vfn
> +            }
> +            None =3D> self
> +                .virt_alloc
> +                .alloc_range(num_pages, (), ..self.va_pages, GFP_KERNEL)=
?,
> +        };
> +
> +        Ok(Vfn::new(start_vfn.into_safe_cast()))
> +    }
> +
> +    /// Free a virtual frame number range back to the maple tree.
> +    fn free_vfn(&self, vfn: Vfn) {
> +        let vfn_index: usize =3D vfn.raw().into_safe_cast();
> +        if self.virt_alloc.erase(vfn_index).is_none() {

[Severity: High]
If the maple tree automatically coalesced contiguous allocations because th=
ey all
share the () value, won't erase() remove the entire coalesced node rather
than just the originally requested range?

This could inadvertently free unrelated adjacent mappings or the remainder =
of a
multi-page allocation.

> +            kernel::pr_warn!("free_vfn: VFN {} not found in maple tree\n=
", vfn_index);
> +        }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D12
