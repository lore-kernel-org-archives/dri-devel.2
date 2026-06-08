Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065F8CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7370210F9A4;
	Mon,  8 Jun 2026 20:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gZF2qYAr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48ADB10F9A4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2585B40B06;
 Mon,  8 Jun 2026 20:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB7B1F00893;
 Mon,  8 Jun 2026 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780949713;
 bh=ifbh8fYOTXkmLAe+CKUdDA6NozpnE9fwN1eon8f4+04=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gZF2qYArB5VqlBdqosCI9mQWonyTB3NYqDCC27ePJtITGOKXkQ/yA1uz5N8PBW4Be
 zB9grFXHlTPw6/NKhpiuZeqQDMQ9tiMPIN5tpV8i+0Hwf2oafwhXUt6Cif7KobkM+8
 KahJD1wrW2vVzhfm6UgF9ztfQFZaqksd+EQOztaeREX/huQZqm4C4PqRr/KTyck9BM
 +QoLNXva0ax0tKrGsywNmes4JPP+NOycHLrEep/VtIdDVbTMJHE2AGTQNZBtlo9myU
 3CuhcHGuxnCI96MdPs4nST5tHVo8zZ0p5jswaU4pI834Od91k+XaAH2AlYeqjzE6fQ
 EAyEVU24l/bqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/19] rust: io: implement `Mmio` as view type
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-7-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-7-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:15:12 +0000
Message-Id: <20260608201512.BCB7B1F00893@smtp.kernel.org>
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
- [Medium] `RelaxedMmio` is missing `Send` and `Sync` trait implementations=
, preventing it from being shared or sent across threads.
- [Low] The `Mmio::relaxed` method is missing the required `#[inline]` anno=
tation.
- [Low] The doc comment for `Mmio::relaxed` incorrectly claims to return a =
reference.
--

commit 2af28174275bf1ccd9fc4579aef4a245e6ff315d
Author: Gary Guo <gary@garyguo.net>

rust: io: implement `Mmio` as view type

This commit implements Mmio as a view type and converts RelaxedMmio to a vi=
ew
type. I/O implementations of MmioOwned are changed to delegate to the Mmio =
view
type. Documentation users of MmioOwned are updated to reflect these semanti=
cs.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d5c233a66846d..771372a8aa36b 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> @@ -888,32 +968,53 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>)=
 -> &Self {

[ ... ]

> +pub struct RelaxedMmio<'a, T: ?Sized> {
> +    ptr: *mut T,
> +    phantom: PhantomData<&'a ()>,
> +}

[Severity: Medium]
Because RelaxedMmio now contains a raw pointer (*mut T), it is implicitly
!Send and !Sync.

While the newly introduced Mmio type received explicit Send and Sync
implementations, they seem to be omitted here.

Should RelaxedMmio also implement Send and Sync so it can be shared or sent
across threads by drivers?

[ ... ]

> -impl<const SIZE: usize> MmioOwned<SIZE> {
> +impl<'a, T: ?Sized> Mmio<'a, T> {
>      /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O op=
erations.

[Severity: Low]
This isn't a bug, but the doc comment says it returns a reference, while the
function signature below now returns the view type by value. Could this be
updated to reflect the new semantics?

>      ///
>      /// Relaxed accessors do not provide ordering guarantees with respec=
t to DMA or memory accesses
> @@ -924,20 +1025,23 @@ impl<const SIZE: usize> MmioOwned<SIZE> {

[ ... ]

> -    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
> -        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `MmioOwn=
ed`, so `MmioOwned<SIZE>`
> -        // and `RelaxedMmio<SIZE>` have identical layout.
> -        unsafe { core::mem::transmute(self) }
> +    pub fn relaxed(self) -> RelaxedMmio<'a, T> {
> +        // INVARIANT: `RelaxedMmio` has the same invariant as `Mmio`.
> +        RelaxedMmio {
> +            ptr: self.ptr,
> +            phantom: PhantomData,
> +        }
>      }

[Severity: Low]
This isn't a bug, but should this small abstraction function be annotated w=
ith
#[inline]?

According to the Rust subsystem coding guidelines, functions in abstractions
that are small or just forwarding to a binding call should be inlined. This
would match other view-creation methods like Mmio::from_raw.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D7
