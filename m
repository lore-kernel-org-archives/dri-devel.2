Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E40C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BD410E94B;
	Mon,  6 Jul 2026 12:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aXES8N7R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D04310E94B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:56:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 870AF600BB;
 Mon,  6 Jul 2026 12:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D846E1F000E9;
 Mon,  6 Jul 2026 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342597;
 bh=gBRfJKWNcI3cvUpCBBt7q0axDYPYo57w7+jvekMpP3s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aXES8N7RWd92gWbbX2z5zS0KqTNii+KKbYZ8xdV9j8Jw4Dyn+aO/tzgWoavdJbO1O
 9euq/mtUsXG7XpvPrrC/iE0sox5GqKy2Bf8Yj/zGEet1Gyq4bwA9Au8bjgMjOsur/F
 GAFDWSufd/q28+s/Ss0iY3buieK+73jkyH1CP5zseujctG81tXopeT0Yr4q+oGhCRd
 oh/C52keqiJVCjtjb+7TufRy4soRp9/vMkE0AxQVg+O5O+y9YDkDKIj2GxkFBzFq5y
 NIFXm7n07nCRdeXZ6YEPMwn/TXJbQAUFYw1olqDIyBPgGeHHhTdFf2jvy8rsXpGF1X
 RT9zyRFgtNv8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260706-io_projection-v6-5-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-5-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:56:36 +0000
Message-Id: <20260706125636.D846E1F000E9@smtp.kernel.org>
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
- [High] Using `Region<SIZE>` for `IoMem` and `pci::Bar` breaks I/O mapping=
s for valid resources with non-4-byte alignment or odd sizes.
--

commit ac5441d891df2073c7c58a81916e6a7310f48450
Author: Gary Guo <gary@garyguo.net>

rust: io: generalize `MmioRaw` to pointer to arbitrary type

This commit updates MmioRaw to be generic over the type it points to.
It introduces MmioRaw::new_region utilizing the Region type and updates
IoMem and pci::Bar to use this new region API instead of the raw address.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 9f060dd291826..12be266d7ed7e 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

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
Does this change prevent drivers from mapping valid hardware resources that
are not 4-byte aligned or have sizes that aren't multiples of 4?

Looking at Region::ptr_try_from_raw_parts_mut(), it enforces strict
alignment and size constraints:

    if size < SIZE || base.align_offset(4) !=3D 0 || !size.is_multiple_of(4=
) {
        return Err(EINVAL);
    }

Since IoMem::ioremap() and pci::Bar::new() now both call MmioRaw::new_regio=
n()
instead of MmioRaw::new(), wouldn't this cause device probes to uncondition=
ally
fail for drivers attempting to map legacy 8-bit or 16-bit peripherals where
the I/O resources are not strictly 4-byte aligned or sized?

> +        })
> +    }
> +}

[ ... ]

> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index fc2a3e24f8d5d..9e15bc8fde784 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs

[ ... ]

> @@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resourc=
e) -> Result<Self> {
>              return Err(ENOMEM);
>          }
> =20
> -        let io =3D MmioRaw::new(addr as usize, size)?;
> -
> +        let io =3D MmioRaw::new_region(addr as usize, size)?;
>          Ok(IoMem { dev, io })
>      }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D5
