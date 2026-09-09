Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE92EC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A11910EE91;
	Wed,  9 Sep 2026 04:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UP3yNutc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A70810EE91
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:07:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFA5643469;
 Wed,  9 Sep 2026 04:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D43D1F00A3A;
 Wed,  9 Sep 2026 04:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788926850;
 bh=DO2yrBIrBGucc4BWF/L/nRU1pvJD6GyS25GhO2rivgg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UP3yNutcGPaWBh3dAdcxsATzTiToNj8P/0Sl0bsJT2rWu4VGOpn5cu+CvRDHjZGrl
 FfEPji9IjdTC3B3QjmXZ1ZkjO6/YGEqhEUzdeUE1Ww8qg13hR4ZtRfqBPxSlBFIWMX
 vzQv7x9xYdDYrd8TRsP1aItErrXucz3/u7nzdopd5OFxL+W5A1DUeXadMMs4rcLy3i
 MRSzm0ertwwVHv8BfALvK3vm95uaTLFxzuK8RMhOsU6Y38lxANpdHDiI0N6kjEEMG1
 Yyy1Nm5SCDu9NEWb1U3jqRSa6F3GIAU7VQc9o7nA8EyawJ/PlnnoIBZWmUSJtdnAlR
 0QcQcstqbEmog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/16] gpu: nova-core: mm: Add page table walker for MMU
 v2/v3
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-mmrebase-v1-10-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-10-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:07:30 +0000
Message-Id: <20260909040730.8D43D1F00A3A@smtp.kernel.org>
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
- [High] The page table walker treats valid system-memory PDEs as missing, =
which can lead to silent lookup failures or page table corruption if overwr=
itten.
- [High] The page table walker silently truncates system-memory Dual PDEs, =
bypassing the VRAM location check and causing it to read from an invalid ph=
ysical address.
- [Medium] The page table walker unconditionally traverses only the small p=
age table in Dual PDEs, ignoring big page mappings and incorrectly reportin=
g them as missing or unmapped.
--

commit 8ab80bbde0121304a601722ca26dc100aca36061
Author: Joel Fernandes <joelagnelf@nvidia.com>
gpu: nova-core: mm: Add page table walker for MMU v2/v3

This commit adds the page table walker implementation that traverses the
page table hierarchy for both MMU v2 (5-level) and MMU v3 (6-level) to
resolve virtual addresses to physical addresses or find PTE locations.

> diff --git a/drivers/gpu/nova-core/mm/pagetable/walk.rs b/drivers/gpu/nov=
a-core/mm/pagetable/walk.rs
> new file mode 100644
> index 0000000000000..76c1729971f53
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/pagetable/walk.rs

[ ... ]

> +    pub(super) fn walk_pde_levels(
> +        &self,
> +        pramin: &mut pramin::Pramin<'_>,
> +        vfn: Vfn,
> +        resolve_prepared: impl Fn(VramAddress) -> Option<VramAddress>,
> +    ) -> Result<WalkPdeResult> {
> +        let va =3D VirtualAddress::from(vfn);
> +        let mut cur_table =3D self.pdb_addr;
> +
> +        for &level in M::PDE_LEVELS {
> +            let idx =3D M::level_index(va, level.as_index());
> +            let install_addr =3D Self::entry_addr(cur_table, level, idx);
> +
> +            if level =3D=3D M::DUAL_PDE_LEVEL {
> +                // 128-bit dual PDE with big+small page table pointers.
> +                let dpde =3D M::DualPde::read(pramin, install_addr)?;
> +                if dpde.has_small() {

[Severity: Medium]
Are big page mappings intentionally ignored here? The walker unconditionally
traverses only the small page table in Dual PDEs.

If a virtual address is mapped via a big page, this would either fall
through to WalkPdeResult::Missing (if has_small() is false) or incorrectly
search the small page table and fail, resulting in lookup failures instead
of returning an explicit error or resolving the mapping.

> +                    cur_table =3D dpde.small_vram_address();

[Severity: High]
Does this silently truncate system-memory Dual PDEs?=20

Unlike the regular PDE path which explicitly checks pde.is_valid_vram() to
prevent truncating the wider system-memory frame number, this Dual PDE path
unconditionally calls dpde.small_vram_address(). If a Dual PDE points to a
small page table in system memory, this could read from an invalid physical
VRAM address, leading to data corruption or a GPU fault.

> +                    continue;
> +                }
> +            } else {
> +                // Regular 64-bit PDE. Use `is_valid_vram()` because
> +                // `table_vram_address()` only reads the VRAM frame-numb=
er
> +                // bitfield; system-memory PDEs store the address in a
> +                // different (wider) field and would be silently truncat=
ed.
> +                let pde =3D M::Pde::read(pramin, install_addr)?;
> +                if pde.is_valid_vram() {
> +                    cur_table =3D pde.table_vram_address();
> +                    continue;
> +                }
> +            }
> +
> +            // PDE missing in HW. Ask caller for resolution.
> +            if let Some(prepared_addr) =3D resolve_prepared(install_addr=
) {

[Severity: High]
Could this lead to overwriting valid system-memory PDEs?=20

When walk_pde_levels() encounters a regular PDE that points to system
memory, pde.is_valid_vram() will return false. The logic then falls through
to this "PDE missing" block.

If the walker is used to allocate or install a missing PDE, it could
instruct the caller to overwrite the valid system-memory PDE with a new VRAM
PDE, causing a memory leak of the old page table and loss of its mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D10
