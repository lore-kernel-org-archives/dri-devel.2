Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED2EC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5BD10EE95;
	Wed,  9 Sep 2026 04:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FlR77AJ6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B80710EE95
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:08:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 969AE601FB;
 Wed,  9 Sep 2026 04:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A81F00A3A;
 Wed,  9 Sep 2026 04:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788926907;
 bh=N/dlLkDvgKiNfBEKdc15ZsTQGfVv3CwY9rQ3L2CUZv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FlR77AJ6dLZ4YjgoXBTXZFujcCv7dicuf6Wpj8J8otBRORypWD/j1dGvhkLdWT/kl
 Qxnae84qvD1xxw8x3B0J/YCJgQbKw+XaT7ZZblL8/W4MwcHuKOJyQQFHhP5q6WYZJz
 WPT3mDvsIrsfAYestRrE1ATmtnGFQJw6LEdrtLYWFuNGj8C8quhiu82VyEHfihTjT0
 ksrKVbhm2bBhD+P/dgJTW+0CJZH3wExNKQT4Fa/UiYTBEZMekLaKyafAs/h0tYpvJI
 BPKmFiEw3fZYij1FMaXgqb2yTBCNoMAh0X9jrTKmOySuFa+1Tc/RkEJxEObdvWfEBF
 iewoN3OZrA9yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/16] gpu: nova-core: mm: pagetable: Add PdeOps trait
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-5-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-5-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:08:26 +0000
Message-Id: <20260909040827.1F9A81F00A3A@smtp.kernel.org>
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
- [High] The `PdeOps` trait only provides a `table_vram_address()` getter i=
nstead of a generic `table_pfn()`, causing a semantic mismatch and data cor=
ruption for system memory PDEs.
--

commit 43d16f339a2596bedc1626661f8f6564c220f1cb
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: pagetable: Add PdeOps trait
   =20
Introduce a trait for GPU Page Directory Entries (PDEs). Default
`read()`/`write()` helpers via a `Pramin` are provided. The forthcoming MMU
v2, v3 PDE structs will each implement `PdeOps`, allowing the later page-ta=
ble
walker and mapper to call PDE operations.

> diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-cor=
e/mm/pagetable.rs
> index a23370b4b62d1..14436fa6adf04 100644
> --- a/drivers/gpu/nova-core/mm/pagetable.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable.rs
> @@ -128,6 +128,47 @@ fn write(&self, pramin: &mut pramin::Pramin<'_>, add=
r: VramAddress) -> Result {
>      }
>  }
> =20
> +/// Operations on Page Directory Entries (`PDE`s).
> +pub(super) trait PdeOps: Copy + core::fmt::Debug + Into<u64> {

[ ... ]

> +    /// Get the memory aperture of this `PDE`.
> +    fn aperture(&self) -> AperturePde;
> +
> +    /// Get the VRAM address of the page table.
> +    fn table_vram_address(&self) -> VramAddress;

[Severity: High]
Does this trait need a generic table_pfn() method instead of forcing VRAM
addresses?

When a PDE points to system memory (AperturePde::SystemCoherent), forcing t=
he
implementation to return a VRAM address causes issues. For instance, in
PtWalkInner::walk_pde_levels(), the page table walker calls
dpde.small_vram_address() (which delegates to PdeOps::table_vram_address)
after only checking if the PDE has a small page table:

drivers/gpu/nova-core/mm/pagetable/walk.rs:PtWalkInner::walk_pde_levels() {
    ...
                if dpde.has_small() {
                    cur_table =3D dpde.small_vram_address();
                    continue;
                }
    ...
}

Because system memory PFNs are often stored in different bitfields than VRAM
PFNs, returning a VRAM address for a system memory PDE can result in
returning a corrupted frame number or panicking in debug builds, which
would cause the walker to perform an out-of-bounds VRAM read via pramin.

> +
> +    /// Read a `PDE` from VRAM.
> +    fn read(pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Resul=
t<Self> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D5
