Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C57C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C9F10EE9D;
	Wed,  9 Sep 2026 04:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BIetPqOH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD5410EE9D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:16:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A4C3143C1E;
 Wed,  9 Sep 2026 04:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476821F00A3A;
 Wed,  9 Sep 2026 04:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788927406;
 bh=Kk+n7+Tp0if0aUpMMf85NHG2HS4ZYASCEPouOUOYss0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BIetPqOHDJiEgxE5tIjC7iO2UZkzlcsPz5BJ/VHycA2uY5ZvTPW4C4RCTKpY8THf4
 pXxy1GM5n8vUT4hyxxAcNrbf+VbEvJRmr/LHnUdyx1e/CF2D9gEQ9cYemxxrK0+XBH
 3qZr1/TRqreM2wPuFRC/HHXATv2oSQOvtgQbwlBiYIsmQNMVZcFxz5pC3wLqwyGX76
 JKFx6Kajkr6Iqf/jqpIdfBTql5vs5AGR6Z97XSp7NJ6+rzleQRTcNqGkdMcv3DSp4Q
 yUeIgFpm1wMsQGqmp38y2EZw74KCD7v7v03HzzPX4qPnA+8muIQyfD3jhUDuxiMmi/
 tWTLo1kCNGDmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/16] gpu: nova-core: mm: Add BAR1 user interface
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:16:45 +0000
Message-Id: <20260909041646.476821F00A3A@smtp.kernel.org>
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
- [High] Insufficient bounds check in `bar_offset()` allows out-of-bounds m=
ulti-byte accesses across mapping boundaries.
- [Medium] Decoupled `GpuMm` lifetime in `BarUser::map` and `release` allow=
s cross-device page table corruption.
- [Medium] `BarUserAccess` breaks RAII, silently leaking address space on s=
tandard Rust error paths.
- [Medium] BAR1 is mapped as uncacheable MMIO instead of write-combining (W=
C), causing massive performance degradation.
--

commit f4c54c8b0e0e82f490fc3199121f6bdbfd3815b4
Author: Joel Fernandes <joelagnelf@nvidia.com>
Subject: gpu: nova-core: mm: Add BAR1 user interface

Adds the BAR1 user interface for CPU access to GPU virtual memory through
the BAR1 aperture.

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 5723ff8f71ea4..0672a0707a713 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
[ ... ]
> @@ -82,12 +105,18 @@ fn probe<'bound>(
> =20
>              Ok(try_pin_init!(NovaCore {
>                  bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core=
/bar0")?,
> -                // TODO: Use `&bar` self-referential pin-init syntax onc=
e available.
> -                //
> -                // SAFETY: `bar` is initialized before this expression i=
s evaluated
> -                // (`try_pin_init!()` initializes fields in declaration =
order), lives at a pinned
> -                // stable address, and is dropped after `gpu` (struct fi=
eld drop order).
> -                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar=
) }),
> +                bar1: {
> +                    let bar1_idx =3D bar1_resource_index(pdev)?;
> +                    pdev.iomap_region(bar1_idx, c"nova-core/bar1")?

[Severity: Medium]
Will this uncacheable MMIO mapping cause severe performance bottlenecks for=
=20
CPU-to-GPU transfers?

BAR1 is the framebuffer aperture and is designed for bulk data transfers li=
ke
USERD or command buffers. By using iomap_region (uncacheable), every write
will generate a separate, synchronous PCIe transaction. Could this be mappe=
d=20
with write-combining instead, even if it requires adding new WC bindings to=
=20
the Rust pci module?

> +                },
> +                // TODO: Use self-referential pin-init syntax once avail=
able.
[ ... ]
> diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core=
/mm/bar_user.rs
> new file mode 100644
> index 0000000000000..ef1d8e6f8c9c3
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/bar_user.rs
[ ... ]
> +    /// Map physical pages to a contiguous BAR1 virtual range.
> +    pub(crate) fn map(
> +        self: &Arc<Self>,
> +        mm: &mut GpuMm<'_>,
> +        pfns: &[Pfn],
> +        writable: bool,
> +    ) -> Result<BarUserAccess<'gpu>> {

[Severity: Medium]
Does this decoupled GpuMm lifetime allow cross-device page table corruption?

Because the mm parameter uses an unbound anonymous lifetime instead of the
'gpu lifetime associated with BarUser, the Rust compiler cannot statically
prevent cross-device mixing.=20

In a multi-GPU system, could a caller inadvertently pass a GpuMm belonging =
to
a different device into the map or release methods, causing the method to=20
allocate from the first GPU's VMM but write page table entries to the second
GPU's PRAMIN?

> +        if pfns.is_empty() {
> +            return Err(EINVAL);
> +        }
> +        let mut vmm =3D self.vmm.lock();
> +        let mapped =3D vmm.map_pages(mm, pfns, None, writable)?;
[ ... ]
> +    /// Translate an offset within this mapping to a BAR1 aperture offse=
t.
> +    fn bar_offset(&self, offset: usize) -> Result<usize> {
> +        if offset >=3D self.size() {
> +            return Err(EINVAL);
> +        }

[Severity: High]
Does this bounds check properly account for the multi-byte access width?

When callers use BarUserAccess::try_read32/64 or try_write32/64, the access
extends 4 or 8 bytes past the provided offset. If offset =3D self.size() - =
2,
this check passes, but the access will overflow the mapping boundary. Could
this lead to unmapped MMIO reads/writes or accesses into adjacent=20
allocations?

> +
> +        let base_vfn: usize =3D self.mapped().vfn_start.raw().into_safe_=
cast();
> +        let base =3D base_vfn.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
> +        base.checked_add(offset).ok_or(EOVERFLOW)
> +    }
[ ... ]
> +impl Drop for BarUserAccess<'_> {
> +    fn drop(&mut self) {
> +        if self.mapped.is_some() {
> +            kernel::pr_warn!(
> +                "BarUserAccess dropped without calling release(). BarUse=
r address space will leak.\n"
> +            );
> +        }

[Severity: Medium]
Could this design break Rust's RAII guarantees and permanently leak address
space on standard error paths?

If a caller maps BAR1, performs some fallible operations using the ? operat=
or,
and returns an error before manually calling access.release(mm), the BAR1=20
virtual address space will leak.=20

Since BarUserAccess does not hold a reference to GpuMm, its Drop=20
implementation cannot unmap the pages. Is there a way to refactor this to=20
ensure automatic cleanup during drop?

> +        // The inner `MappedRange`'s own `MustUnmapGuard` will also fire,
> +        // identifying the leaked VA range.
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D15
