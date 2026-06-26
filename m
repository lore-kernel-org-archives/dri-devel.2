Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6703C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F1A10F642;
	Fri, 26 Jun 2026 14:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GwG1Ydks";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9843C10F642
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:56:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E7D542B93;
 Fri, 26 Jun 2026 14:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2031F000E9;
 Fri, 26 Jun 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485766;
 bh=zo3fydT/aQhfWOH8v5fE5Ppqrgys/5Y5DW29+OOJh6Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GwG1Ydks9so0F/annHcog1IC2vggsS7o25Maz9pJpjWx2ED/MIzNsuM8U4iBuzbTk
 UwPNMdnwESyme5ddPCwHwxwX6TGdML/GbYDMSQu3YaO1/SHCvgt8PLA4ytXcmydTzN
 dBADr/XdYMrx+0EVivW0qmceikqQvdvvNlKMNYKePAA1Jr47HQ8nWCUjOcFxAjykSJ
 F/9G+bZdUeFZ7h9addJHQkuU0ZHpcmyEhjk2i041OypF4C/RUS1fOioGFZ8yGlXKFd
 TT5dvZ/+siUy71ReQdCQ2CMqLW9kH2LfJ+25cZZsLB2k/heNQ1c+MtBnVnwNeJDyqe
 OjAgmRSFD3ayQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/20] rust: io: rename `Mmio` to `MmioOwned`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-6-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-6-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:56:04 +0000
Message-Id: <20260626145605.2D2031F000E9@smtp.kernel.org>
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

New issues:
- [High] `IoMem::ioremap` unnecessarily rejects valid memory regions whose =
sizes are not multiples of 4 or whose base addresses are not perfectly 4-by=
te aligned.

Pre-existing issues:
- [High] Virtual address space leaked in `IoMem::ioremap` on error path.
--

commit c64b5401d29b1a7d49e9330767d6549fcf42f22c
Author: Gary Guo <gary@garyguo.net>

rust: io: rename Mmio to MmioOwned

This commit renames the owned MMIO instance from Mmio to MmioOwned.
This frees up the name Mmio to be used for the view type instead, making
it more intuitive for users who usually interact with the view.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 12be266d7ed7e..f93be7f780694 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[Severity: High]
Does Region::ptr_try_from_raw_parts_mut() unnecessarily reject valid
memory regions?

When MmioRaw::new_region() is called, it checks the size and alignment:

rust/kernel/io.rs:Region::ptr_try_from_raw_parts_mut() {
    if size < SIZE || base.align_offset(4) !=3D 0 || !size.is_multiple_of(4=
) {
        return Err(EINVAL);
    }
}

Does this cause driver probes to fail with EINVAL when trying to map valid
but small or unaligned hardware resources, such as 1-byte or 2-byte
registers?

[ ... ]

> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 9e15bc8fde784..8f6c257c5b8e6 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
IoMem::ioremap() leak the virtual address space mapping?

When a driver calls IoMem::ioremap():

rust/kernel/io/mem.rs:IoMem::ioremap() {
    let addr =3D if resource.flags().contains(io::resource::Flags::IORESOUR=
CE_MEM_NONPOSTED) {
        unsafe { bindings::ioremap_np(res_start, size) }
    } else {
        unsafe { bindings::ioremap(res_start, size) }
    };

    if addr.is_null() {
        return Err(ENOMEM);
    }

    let io =3D MmioRaw::new_region(addr as usize, size)?;
    Ok(IoMem { dev, io })
}

If bindings::ioremap() succeeds but MmioRaw::new_region() fails (such as
from the size and alignment constraints mentioned above), the ? operator
returns immediately.

Does this bypass unmapping the memory, resulting in virtual address space
exhaustion, since the IoMem object is never constructed and its Drop
implementation never runs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D6
