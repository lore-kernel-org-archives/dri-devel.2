Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFACCD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290DF10F9A6;
	Mon,  8 Jun 2026 20:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bup5tgNh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B08810F9A6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:14:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CE286001D;
 Mon,  8 Jun 2026 20:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023961F00893;
 Mon,  8 Jun 2026 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780949687;
 bh=UL6gxhhWkgf1tHWdOsbgNQAoOnFjvodLgGxcXKlyXdA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bup5tgNhvLfetTJ9TmrATcv/tIpT76wasYiS4U7WB4nRMm2hJmVqLT79oKgfBLBSF
 ye2HW4LIUyi55lli8Cc5nGhSil/CREH0lH1KRcSStY2ShBoY3ym1Y5sYsPInPxxQhd
 H1B2j3Q8AsA3loIAxXWKGvlsYa7t0hxLWVmAsEffcgOF/cRUL2NTcasCu+s2Jv+dNE
 jrCkDVFs4UYV2g16o07p6EdlwbjaMjLOmTfxw+EqSbTPjoe/e4m+WfjYbVBNTQUDbO
 A0z6hKQuDbSAQ7kaPw53KwJqyW8jvikJmJc9ddNkfYSBDGYeBf+7C9uapmRXfPwSO0
 WZJ7T8Zlt8Oxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/19] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-5-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-5-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:14:46 +0000
Message-Id: <20260608201447.023961F00893@smtp.kernel.org>
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
- [High] Strict `usize` alignment check in `Region::ptr_try_from_raw_parts_=
mut` breaks driver probes for valid 4-byte aligned MMIO mappings.
--

commit facc65605656f1d5585f26a25f200941e6ae7d73
Author: Gary Guo <gary@garyguo.net>

rust: io: generalize MmioRaw to pointer to arbitrary type

This commit generalizes MmioRaw to represent an untyped I/O region using
the dynamically-sized Region<SIZE> type. It renames the maxsize method
to size and implements Clone, Copy, Send, and Sync manually.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d57df2a072a0e..c9533d3f003ba 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> @@ -90,37 +90,67 @@ fn size(p: *const Self) -> usize {

[ ... ]

> +impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
> +    /// Create a `MmioRaw` representing a I/O region with given size.
> +    ///
> +    /// The size is checked against the minimum size specified via const=
 generics.
> +    #[inline]
> +    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
> +        Ok(Self {
> +            ptr: Region::ptr_try_from_raw_parts_mut(core::ptr::without_p=
rovenance_mut(addr), size)?,

[Severity: High]
Does this alignment check break driver probes for standard 4-byte aligned
MMIO mappings on 64-bit architectures?

Looking at Region::ptr_try_from_raw_parts_mut(), it enforces a strict
usize alignment on the base address:

rust/kernel/io.rs:Region::ptr_try_from_raw_parts_mut() {
    ...
    if size < SIZE || base.align_offset(size_of::<usize>()) !=3D 0 {
        return Err(EINVAL);
    }
    ...
}

On 64-bit systems, this forces an 8-byte alignment requirement.

However, PCI 32-bit BARs and SoC IP block MMIO regions frequently have
4-byte aligned physical base addresses. When mapped with ioremap() or
pci_iomap(), the resulting virtual address retains this 4-byte alignment
offset, which would fail the 8-byte alignment check here.

Consequently, standard hardware mapping operations in devres::IoMem::new(),
IoMem::ioremap(), and pci::Bar::new() will unconditionally fail at runtime
with -EINVAL during driver probe for these devices, making them unusable.

> +        })
>      }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D5
