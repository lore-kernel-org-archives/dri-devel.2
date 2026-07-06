Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EABEC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A4010E973;
	Mon,  6 Jul 2026 12:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CcqzS4pv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146AA10E973
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BD12600DA;
 Mon,  6 Jul 2026 12:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF411F00A3A;
 Mon,  6 Jul 2026 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342768;
 bh=x71sSjquefL8a0V0B4EFNOSPwrR9u+0Idy2HXYjEVP8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CcqzS4pvR5/6FpzSx9Upg3cGPpm+Z5zJDka7dCMMGQv2FnaK20Zcym11n3nH5Rczw
 ctxwu14fpJ12Gi/ex1poErOyFz3BxVzPGPVQutS5xGGI2X/iIcmyYzHF/h1RsZeHYd
 paicOxmbQWyq1E4KYBSYDAdJJ8oiBkkgqjB6ZIe3OzaYQSCFF+w+gPkARSFRgR8Jyo
 4Zg7bjIKYT26Y5NlQqR8F7mofCOZPwqRqRhMNPtaeQOd47TIVkYa5XlvCc+by6fS56
 WUXDN07ud3FlJIvvYPpKRpDEcHtj237nXX8evqf1ZqFEWUA+K0GLSOIfzQub9L6NgZ
 VYCqN8YV+Xk9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/20] rust: io: implement `Mmio` as view type
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260706-io_projection-v6-7-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-7-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:59:27 +0000
Message-Id: <20260706125927.DEF411F00A3A@smtp.kernel.org>
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
- [High] Infallible 64-bit I/O accessors (`read64`, `write64`) and typed 64=
-bit registers cannot be used on MMIO regions, and custom view types are un=
supported by standard offsets.
--

commit 09225b49c257719774237bd1b25407607dd9df87
Author: Gary Guo <gary@garyguo.net>

rust: io: implement Mmio as view type

Implement Mmio as view type and convert RelaxedMmio to view type as
well. I/O implementations of MmioOwned are changed to delegate to the
Mmio view type.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index f93be7f780694..8110b49aa4307 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
[ ... ]
> @@ -847,17 +915,12 @@ unsafe fn io_write(self, value: $ty, address: usize=
) {
>  }
> =20
>  // MMIO regions support 8, 16, and 32-bit accesses.
> -impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
> -impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
> -impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
> +impl_mmio_io_capable!(Mmio, u8, readb, writeb);
> +impl_mmio_io_capable!(Mmio, u16, readw, writew);
> +impl_mmio_io_capable!(Mmio, u32, readl, writel);
>  // MMIO regions on 64-bit systems also support 64-bit accesses.
> -impl_mmio_io_capable!(
> -    MmioOwned,
> -    #[cfg(CONFIG_64BIT)]
> -    u64,
> -    readq,
> -    writeq
> -);
> +#[cfg(CONFIG_64BIT)]
> +impl_mmio_io_capable!(Mmio, u64, readq, writeq);

[Severity: High]
Does this actually allow infallible 64-bit I/O accesses when the target is
Region<SIZE>?

Region<SIZE> has a MIN_ALIGN of 4, so infallible 64-bit accessors like
read64() and write64() will fail the compile-time assertion in
io_view_assert():

    const_assert!(
        Alignment::of::<U>().as_usize() <=3D IO::Target::MIN_ALIGN.as_usize=
()
    );

For U =3D u64, the alignment is 8 on 64-bit architectures, which fails the
assertion since 8 <=3D 4 is false.

Additionally, while this patch introduces Mmio as a generic view type, can
users create a custom target type (e.g. with align(8)) to work around this?

Looking at impl_usize_ioloc in rust/kernel/io.rs and the IoLoc implementati=
on
in rust/kernel/io/register.rs, both usize offsets and typed registers are
strictly implemented only for IoLoc<Region<SIZE>, T>.

Because standard offsets and registers are restricted to Region<SIZE>, a cu=
stom
view type cannot be used with them. Does this leave 64-bit infallible acces=
ses
and 64-bit typed registers unusable on MMIO regions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D7
