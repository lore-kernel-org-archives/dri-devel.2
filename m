Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A44BC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0C510EE99;
	Wed,  9 Sep 2026 04:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ErFuqJCT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE9810EE99
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:12:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1845601FB;
 Wed,  9 Sep 2026 04:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9751F00A3A;
 Wed,  9 Sep 2026 04:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788927166;
 bh=SS5Oe6SrI7CnlQVcAlGDuCFW8OYErXYRg6Jy3ugHrf4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ErFuqJCTScI0E/Y5vHnqOgWQGUZErCvkRu6fHr3thU0ONd1OKWiNw4et+kj1U2TyE
 M6njlW2LDcSzGd5P3gvjdWhlVT5mWVzITwBBRFZ9/GxWbMF1FPWsO8r7CVzpiMVtf4
 eYDs5zMd+TDU2Xs2BYJSnQoueFXm2B+je2Kp1iETI8wtviwPQmhaglsz8DD9MBGn32
 iMSoPP1CQQvqz0TgJxsPbOe/bVQIhZD5P6BhL6W3JVq0TidtjJhxSUazBs2IFjl7P6
 dvP1UurKZ9MDxd51wrhER6AwNibAgDhXqYG7TkN3ihbOEWfd4SRsk7EK3/yDWjp+us
 bnJAoTqtWkw4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/16] gpu: nova-core: mm: Add MMU v2 page table types
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260909-mmrebase-v1-7-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-7-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:12:46 +0000
Message-Id: <20260909041246.7A9751F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PdeOps::invalid in MMU v2 creates a valid large page PTE instead o=
f an invalid PDE.
- [Medium] Commit message claims MMU v2 is for Hopper, contradicting the co=
de implementation.
--

commit 123f278dccc75525e59331c1fb9bc862c6096243
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add MMU v2 page table types

Add page table entry and directory structures for MMU version 2. The Pte,
Pde, and DualPde types each implement traits for the version-agnostic API
used by the forthcoming page-table walker and mapper.

>     Add page table entry and directory structures for MMU version 2 used =
by
>     Hopper and later GPUs.

[Severity: Medium]
Does the commit message have a typo regarding the supported architectures?

The commit message states MMU version 2 is used by Hopper and later GPUs,
but the module documentation in drivers/gpu/nova-core/mm/pagetable/ver2.rs
specifies it is for Turing, Ampere, and Ada GPUs. Hopper uses MMU v3.

> diff --git a/drivers/gpu/nova-core/mm/pagetable/ver2.rs b/drivers/gpu/nov=
a-core/mm/pagetable/ver2.rs
> new file mode 100644
> index 0000000000000..089e5cc2bfc30
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/pagetable/ver2.rs

[ ... ]

> +impl PdeOps for Pde {
> +    fn from_raw(val: u64) -> Self {
> +        Self::from_raw(val)
> +    }

[ ... ]

> +    fn invalid() -> Self {
> +        Self::zeroed()
> +            .with_valid_inverted(true)
> +            .with_aperture(AperturePde::Invalid)
> +    }

[Severity: High]
Does PdeOps::invalid() in MMU v2 create a valid large page PTE in hardware
instead of an invalid PDE?

By setting valid_inverted to true (bit 0 =3D 1), this constructs a raw value
where bit 0 is set. In NVIDIA MMU hardware, bit 0 at the PDE level acts as
the IS_PTE bit (0 =3D PDE, 1 =3D large page PTE).

The hardware will interpret this as a valid large page mapped to VRAM
physical address 0. If this is accessed, could it cause severe memory
corruption?=20

While currently unreachable by untrusted input because install_mappings()
only uses AperturePde::VideoMemory, this breaks the page table abstraction
for any future code that uses invalid() to clear a PDE slot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D7
