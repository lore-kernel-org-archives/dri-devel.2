Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B398C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E533110E14F;
	Wed,  9 Sep 2026 04:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QWy4v8jE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0767E10E14F
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:12:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4ECE2601FB;
 Wed,  9 Sep 2026 04:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96661F00A3A;
 Wed,  9 Sep 2026 04:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788927121;
 bh=sKAtSvI2qvo3vbw/ddRiKVgajyax4CqE4bfdsifhcAM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QWy4v8jEieqFoQAZVjt3M0DENU3RkwAAW+8ucSB3sinrwrDTlG3u1fu3+jDGAqI1c
 du4OLS1vcDBaa+OEWytIb4tPtFLPj+AjOdddqbDLip7Wh3oqqwv8xq3ZJ9j9K6FEqr
 /R1d0J7UcdOlsq7wt4S/umgCWDUIV2Fzne+wVEwn1LvYzCzngtNzhabTyqFL0n73Xf
 e+wsTAmtqg6Q4OdFdG9A27U4/ItHrL11BnXspM4+iHI7Dk+jeMh7mBwAJ8NpeZb01Z
 WTmjr9cFQB2ZIJO6Eq7fwn8cwntuZtPZeuInQyREEk890ftWXkAEblmlmqM7/nsYAq
 FuTbY3exyRnWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/16] gpu: nova-core: mm: pagetable: Add MmuConfig trait
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-mmrebase-v1-9-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-9-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:12:00 +0000
Message-Id: <20260909041200.B96661F00A3A@smtp.kernel.org>
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
- [Critical] pt_pages_upper_bound incorrectly computes the best-case page t=
able capacity, leading to GPU Use-After-Free via under-allocation.
--

commit 48288e6179a4c23329aba38095ea6a337c240c2a
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: pagetable: Add MmuConfig trait

This commit introduces the MmuConfig trait to tie entry-operation
traits together with version-specific constants and helpers. It provides
zero-sized marker structs for MMU v2 and v3 to fully resolve dispatch
at compile time without runtime overhead.

> diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-cor=
e/mm/pagetable.rs
> index 128bfc0d277a8..d88499ed3d563 100644
> --- a/drivers/gpu/nova-core/mm/pagetable.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable.rs
[ ... ]
> @@ -213,6 +214,114 @@ fn write(&self, pramin: &mut pramin::Pramin<'_>, ad=
dr: VramAddress) -> Result {
[ ... ]
> +    /// Compute upper bound on page table pages needed for `num_virt_pag=
es`.
> +    ///
> +    /// Walks from PTE level up through PDE levels, accumulating the tre=
e.
> +    fn pt_pages_upper_bound(num_virt_pages: usize) -> usize {
> +        let mut total =3D 0;
> +
> +        // PTE pages at the leaf level.
> +        let pte_epp =3D Self::entries_per_page(Self::PTE_LEVEL);
> +        let mut pages_at_level =3D num_virt_pages.div_ceil(pte_epp);
> +        total +=3D pages_at_level;
> +
> +        // Walk PDE levels bottom-up (reverse of PDE_LEVELS).
> +        for &level in Self::PDE_LEVELS.iter().rev() {
> +            let epp =3D Self::entries_per_page(level);
> +
> +            // How many pages at this level do we need to point to
> +            // the previous pages_at_level?
> +            pages_at_level =3D pages_at_level.div_ceil(epp);

[Severity: Critical]
Does this calculation account for unaligned virtual memory mappings?

If a userspace application requests an unaligned virtual memory mapping
(e.g., via a BAR1 mapping or DRM VM bind that crosses a 512-page PTE
boundary), computing capacity using div_ceil on num_virt_pages and
pages_at_level assumes perfect alignment. This propagates the flawed
alignment assumption to all higher directory levels, systematically
underestimating the maximum pages required.

If the capacity is underestimated, when install_mappings allocates PDEs
and pushes the newly allocated pages into page_table_allocs,
push_within_capacity can fail with ENOMEM. Since this happens after
the hardware PDE has already been written, the function bails out and
AllocatedBlocks is dropped. This frees the VRAM while the GPU MMU still
points to it, which could lead to a use-after-free of GPU VRAM.

> +            total +=3D pages_at_level;
> +        }
> +
> +        total
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D9
