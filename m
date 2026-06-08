Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE820CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF7310F9A0;
	Mon,  8 Jun 2026 20:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="is1R5EdN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B788E10F9A0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:12:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0ED1438D3;
 Mon,  8 Jun 2026 20:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347BC1F00893;
 Mon,  8 Jun 2026 20:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780949538;
 bh=xoxHklwVewED//F79bu1ZKZyWAzeOSjwHCeChxBm0FU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=is1R5EdNlXYdFiqPN1HGwJK92ab7bmJtJcmLMSm/nJ6J0NamwXxBrEb2iD/X1DMxC
 kHDDT6es27/YhNGermx/cB2bpCkyOlOVDMIdmm0yj5lscnH8NNz7Y4HvufpSHHOXGo
 7xn82Q197dv0bg3/DXSVTbbw2PSlBk5GnVblO2WThoxmVzuWweTdaS7FY/nwxFaMKi
 pb7tfmUrl1wt+RemXxQABcJfgSCtR0Tmy/AEkiaaf4CJzHX6IHl3N921r9noOW2V7z
 Qi6INUjoiLVPWLnFLnm/z6G20opBx/TyBOqhC6A+xrW3HULMInlmv0CsgN+dybvtv3
 x1WBf5dLjlYfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/19] rust: io: remove `MmioOwned`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-10-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-10-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:12:17 +0000
Message-Id: <20260608201218.347BC1F00893@smtp.kernel.org>
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
- [High] The newly introduced `Region` type strictly requires 8-byte alignm=
ent on 64-bit platforms, causing `iomap()` to fail for perfectly valid 4-by=
te aligned MMIO devices.
--

commit 4db6d2e35660784e019ec935f99ababad3a399c3
Author: Gary Guo <gary@garyguo.net>

rust: io: remove `MmioOwned`

The Io trait is now easier to implement, allowing Bar and IoMem to implement
it directly. This change removes the MmioOwned wrapper struct.

> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 8f6c257c5b8e6..d9b3189d09b46 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs

[ ... ]

> @@ -290,11 +292,13 @@ fn drop(&mut self) {
>      }
>  }
> =20
> -impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
> -    type Target =3D MmioOwned<SIZE>;
> +impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
> +    type Backend =3D MmioBackend;
> +    type Target =3D super::Region<SIZE>;

[Severity: High]
Does this new Region target properly support 4-byte aligned MMIO devices on
64-bit platforms?

Looking at Region::ptr_try_from_raw_parts_mut() in rust/kernel/io.rs, it
strictly requires the base pointer to be naturally aligned to usize (8 bytes
on 64-bit platforms):

rust/kernel/io.rs:Region::ptr_try_from_raw_parts_mut() {
    ...
    if size < SIZE || base.align_offset(size_of::<usize>()) !=3D 0 {
        return Err(EINVAL);
    }
    ...
}

When IoMem::ioremap() maps hardware resources into the kernel, it calls
MmioRaw::new_region(), which enforces this alignment requirement:

rust/kernel/io/mem.rs:IoMem::ioremap() {
    ...
    let io =3D MmioRaw::new_region(addr as usize, size)?;
    Ok(IoMem { dev, io })
}

Since ioremap() preserves the page offset of the physical address, mapping a
physical resource starting at an offset of 0x04 will cause
base.align_offset(8) !=3D 0 to evaluate to true.

Will this cause the entire iomap() driver probe to predictably fail with
-EINVAL for perfectly valid 4-byte aligned MMIO devices?

> +
> +    #[inline]
> +    fn as_view(self) -> Mmio<'a, Self::Target> {
>          // SAFETY: Safe as by the invariant of `IoMem`.
> -        unsafe { MmioOwned::from_raw(&self.io) }
> +        unsafe { Mmio::from_raw(self.io) }
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D10
