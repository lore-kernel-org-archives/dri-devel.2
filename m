Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B85EC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39A710EEA2;
	Wed,  9 Sep 2026 04:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CnOG0pNN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB6710EEA2
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:18:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C04AF43CEC;
 Wed,  9 Sep 2026 04:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FF11F00A3A;
 Wed,  9 Sep 2026 04:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788927539;
 bh=+oD4dm05hw5M/cWvLh1yAyaLYIKPJMWlv66Pfz7uEl8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CnOG0pNNQa7C+HHQeDkKQUhD5hSS795IQe1lxMHYmNP51p7gGTTi8ScTJIWduuM87
 SycMR9pTKO4nUz5p0+momtyDOt0o3TSSz1y7wL8PlHO0iSMQenn1HZFjycngb8B/9k
 jcPcB5hZKxciyH7Mc+DEPqJQZUJFeVDg4eFmHgqJMr8F5q7rkRmAFL4XGfygQP2P5Q
 xZFMspCWnuD23KdbAPozIlJQupqNHOCiSSwIHFIlKau3uWBxAh+trQ/Bm3kA/zwNHP
 dGP6NzjCpac4N3/c7mGPM8pfp0D03xjciF9KGUH6IMAtKurcD9VuKvhjLPaTg7xL53
 Nq7YDFN9Fa5RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/16] gpu: nova-core: mm: Add BAR1 memory management
 self-tests
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-mmrebase-v1-16-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-16-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:18:58 +0000
Message-Id: <20260909041859.61FF11F00A3A@smtp.kernel.org>
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
- [High] Hardware Use-After-Free due to dangling Page Directory Entries (PD=
Es) when temporary Vmm instances are dropped.
- [High] Hardware Use-After-Free: Early error returns bypass explicit unmap=
ping, leaking hardware PTEs pointing to freed VRAM.
- [Medium] Logic Error: Overlapping Virtual Frame Number (VFN) allocations =
corrupt global state.
- [Medium] Hardware Synchronization: Missing dummy reads to flush posted MM=
IO writes across different PCI BARs.
- [Low] Unconditional `#[expect(dead_code)]` causes a build error when self=
tests are enabled.
--

commit 8fda415a03ac7ee1e1b918cb7cfe5d0bb8315e6c
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add BAR1 memory management self-tests

Add self-tests for BAR1 access during driver probe when
CONFIG_NOVA_CORE_SELFTESTS is enabled (default disabled). This results in
testing the Vmm, GPU buddy allocator and BAR1 region all of which should
function correctly for the tests to pass.

> diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core=
/mm/bar_user.rs
> index ef1d8e6f8c9c3..1bef01d147ada 100644
> --- a/drivers/gpu/nova-core/mm/bar_user.rs
> +++ b/drivers/gpu/nova-core/mm/bar_user.rs

[ ... ]

> @@ -84,6 +87,7 @@ pub(crate) struct BarUserAccess<'gpu> {
>      mapped: Option<MappedRange>,
>  }
> =20
> +#[expect(dead_code)]
>  impl BarUserAccess<'_> {
>      /// Tear down the BAR1 mapping.
>      pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {

[Severity: Low]
When CONFIG_NOVA_CORE_SELFTESTS is enabled, try_read32 and release are
used by the self-test, so they are no longer dead code. Since kernel
Rust builds treat warnings as errors, does this unconditional lint
expectation cause a build failure?=20

Should this use cfg_attr to be conditionally applied?

[ ... ]

> +    // Create a VMM of size 64K to track virtual memory mappings.
> +    let mut vmm =3D Vmm::new(pdb_addr, chipset.mmu_version(), SZ_64K.int=
o_safe_cast())?;

[Severity: High]
Does dropping this temporary Vmm later in the function leave dangling PDEs
in the live hardware pointing to freed VRAM?=20

The Vmm allocates PT pages from the buddy allocator and writes PDEs into the
live hardware page directory, but its Drop implementation does not clear th=
em,
and the PT VRAM is freed when the temporary Vmm is dropped. If this VRAM is
reallocated for user buffers, could the GPU MMU misinterpret user data as
page tables?

[Severity: Medium]
Will this temporary Vmm (and the BarUser created later) allocate VFN 0
for their first mappings and blindly overwrite mappings placed in the
global page directory by the live driver's bar_user?

> +
> +    // Create a test mapping.
> +    let mapped =3D vmm.map_pages(mm, &[test_pfn], None, true)?;
> +    let test_vfn =3D mapped.vfn_start;
> +
> +    // Pre-compute test addresses for the PRAMIN to BAR1 read test.
> +    let vfn_offset: usize =3D test_vfn.raw().into_safe_cast();
> +    let bar1_base_offset =3D vfn_offset.checked_mul(PAGE_SIZE).ok_or(EOV=
ERFLOW)?;
> +    let bar1_read_offset: usize =3D bar1_base_offset + 0x100;
> +    let vram_read_addr =3D test_vram + 0x100;
> +
> +    // Test 1: Write via PRAMIN, read via BAR1.
> +    mm.pramin_mut()
> +        .window_at::<u32>(vram_read_addr)?
> +        .view()
> +        .write_val(PATTERN_PRAMIN);
> +
> +    // Read back via BAR1 aperture.
> +    let bar1_value =3D bar1.try_read32(bar1_read_offset)?;

[Severity: Medium]
Since PCI memory space writes are posted operations, could the read from
the BAR1 aperture arrive at VRAM before the write via PRAMIN completes?

Is a dummy read from PRAMIN required to explicitly flush the write before
reading via BAR1 to avoid spurious test failures?

[Severity: High]
If try_read32() returns an error, the function will return early via the
`?` operator. Since the early return bypasses explicit cleanup calls like
vmm.unmap_pages(), does this leak live PTEs in hardware pointing to freed
VRAM?

If the selftest fails early, the driver probe continues normally since the
error is caught in run_selftests() in gpu.rs, which would cement this UAF
condition in the running system.

[ ... ]

> +        for j in 0..num_pages {
> +            let page_bar1_off =3D bar1_base + j * PAGE_SIZE;
> +            let j_u64: u64 =3D j.into_safe_cast();
> +            let page_phys =3D block.offset()
> +                + j_u64
> +                    .checked_mul(PAGE_SIZE.into_safe_cast())
> +                    .ok_or(EOVERFLOW)?;
> +
> +            bar1.try_write32(PATTERN_BAR1, page_bar1_off)?;
> +
> +            let pramin_val =3D mm
> +                .pramin_mut()
> +                .window_at::<u32>(VramAddress::from_raw(page_phys))?
> +                .view()
> +                .read_val();

[Severity: Medium]
Similarly, does writing to BAR1 and immediately reading from PRAMIN
require a dummy read from BAR1 to flush the posted write?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D16
