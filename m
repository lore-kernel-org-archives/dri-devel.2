Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B60BC61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 19:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3D810E1EF;
	Sun, 30 Aug 2026 19:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hze88aWY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474B610E1EF
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 19:47:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B3C7600E2;
 Sun, 30 Aug 2026 19:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C7E1F000E9;
 Sun, 30 Aug 2026 19:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788119275;
 bh=tUiHh50G0S71Jiuoozb1JPkjqnd05cCQFxu/1rYgjgo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hze88aWYU2jIbZcX73Ehksk4FDLl+NIB5I7WLlQKsNLDz5vV41OyY17VUGQUB6elM
 +sQz786w9fvMIAxi2DWsSUr6hY2xNozYEI/avBEiEkOBo08hVJy1cMgZZvsmz0CNIq
 muyro5IDysGCVKV4SbFvo+h+d5JtqdG0+2DRINtGzn0xixLeOYVzk87oTWURVfZQeC
 rWYN5MEW97kuNooDuVtCPRnFP6oZ07OVcOuMBsAHBtKl63EtQdZX6xcTvmoodqOGKz
 hIbeqhIP4YdTFmbeSIfEGnPzB8mhN4xW+Z/NVRDnq7AJxPIDSkDN7/7MzANmeYj11t
 d17N6N0mTynkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] rust: dma: tie Coherent and CoherentBox to the
 device's bound lifetime
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260830193824.471089-5-dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 19:47:54 +0000
Message-Id: <20260830194754.C7C7E1F000E9@smtp.kernel.org>
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
- [Medium] Safe constructors of `Coherent` and `CoherentBox` allow leaking =
DMA allocations (e.g., via `std::mem::forget`), causing device resources li=
ke IOMMU mappings to outlive the device's bound lifetime, which can lead to=
 Undefined Behavior upon device unbind.
--

commit 6e4d094e50aec8e58639ef61e8619143bb52d532
Author: Danilo Krummrich <dakr@kernel.org>
Subject: rust: dma: tie Coherent and CoherentBox to the device's bound life=
time

This commit adds a lifetime parameter to Coherent and CoherentBox that ties
the DMA allocation to the device's bound scope. This helps ensure it is
freed before the device is unbound.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 79f453e9ec0b6..4ce914b7d1dad 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
[ ... ]
> @@ -663,10 +656,10 @@ pub unsafe fn as_mut(&self) -> &mut T {
>      }
>  }
> =20
> -impl<T: AsBytes + FromBytes> Coherent<T> {
> +impl<'a, T: AsBytes + FromBytes> Coherent<'a, T> {
>      /// Allocates a region of `T` of coherent memory.
>      fn alloc_with_attrs(
> -        dev: &device::Device<Bound>,
> +        dev: &'a device::Device<Bound>,
>          gfp_flags: kernel::alloc::Flags,
>          dma_attrs: Attrs,
>      ) -> Result<Self> {

[Severity: Medium]
Is it safe to expose constructors like alloc_with_attrs() as safe APIs=20
given that the returned object can be deliberately leaked via safe code?

The documentation on Coherent notes this is an accepted soundness hole,=20
but allowing a DMA allocation to be leaked (e.g., via std::mem::forget)=20
means device resources like IOMMU mappings can outlive the device's bound=20
lifetime.=20

If the device unbinds and its structures are torn down, could these leaked=
=20
active DMA mappings lead to memory corruption or undefined behavior?

Since exposing a safe API that can trigger undefined behavior through entir=
ely
safe code violates standard safety guarantees, would it make sense to mark=
=20
alloc_with_attrs() and similar allocation functions as unsafe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830193824.4710=
89-1-dakr@kernel.org?part=3D4
