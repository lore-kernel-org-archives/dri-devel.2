Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3163FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2F210E7C8;
	Mon, 27 Apr 2026 15:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kYwUJNum";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8237010E2BA;
 Mon, 27 Apr 2026 15:00:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EFF416014C;
 Mon, 27 Apr 2026 15:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65621C2BCB4;
 Mon, 27 Apr 2026 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777302016;
 bh=enHPVof/9FLPu/a6Y6BKK7lLNOBS2sIllbJ+2p/YGYY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kYwUJNumsI10BCdeUQ8wvHhV9fq2guhy8YPscb5AoG2z69uSedSerCgEXFXiZNSNY
 2bYowxvS/50I531O4zg7g4NCvMb385M2/EtoLDYNVDx4Jqr0T3jlAp0O44gbbjROQf
 B62H45xiaTSf7ywsi3JD5BGVfwtQc3HyFFIgCRL1sa+qk46UtBTxITUv2bHggacINT
 swaR+H/CiAz79GY20YleqnsUw/4rJh6AR7YaOfTT+KeTP5xBMoA2GbPqld3psbQTZi
 Q68GnVmCF1qxdPj669F/wVfnhm7gIrJrbnsCE7ntqAENTb3DhdpkErPRZpdGVxQrlH
 6xUQpD7+4wrKg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Abdiel
 Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 03/11] rust: io: use pointer types instead of address
In-Reply-To: <20260421-io_projection-v2-3-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-3-4c251c692ef4@garyguo.net>
Date: Mon, 27 Apr 2026 16:20:54 +0200
Message-ID: <87cxzkqybd.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Gary Guo <gary@garyguo.net> writes:

> This carries the size information with the pointer type and metadata, makes
> it possible to use I/O projections and paves the way for IO view types.
>
> With this change, minimum size information becomes available through types;
> so `KnownSize::MIN_SIZE` can be used and `IoKnownSize` trait is no longer
> necessary. The trait is kept for compatibility and can be removed when
> users stop using it for bounds.
>
> PCI config space uses only offsets and not pointers like MMIO; for this
> null pointers (with proper size metadata) is used. This is okay as I/O
> trait impl and I/O projections can operate on invalid pointers, and for PCI
> config space we will only use address info and ignore the provenance.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/devres.rs |   2 +-
>  rust/kernel/io.rs     | 123 +++++++++++++++++++++-----------------------------
>  rust/kernel/io/mem.rs |   2 +-
>  rust/kernel/pci/io.rs |  74 ++++++++++++++++++------------
>  4 files changed, 99 insertions(+), 102 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 3e22c63efb98..ea86e9c62cdf 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -101,7 +101,7 @@ struct Inner<T> {
>  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>  ///     fn drop(&mut self) {
>  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
> +///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
>  ///     }
>  /// }
>  ///
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 0b9c97c0a1d7..1682f2a0d20d 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -105,8 +105,8 @@ pub fn new_region(addr: usize, size: usize) -> Result<Self> {
>  impl<T: ?Sized + KnownSize> MmioRaw<T> {
>      /// Returns the base address of the MMIO region.
>      #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.addr.addr()
> +    pub fn as_ptr(&self) -> *mut T {
> +        self.addr
>      }
>  
>      /// Returns the size of the MMIO region.
> @@ -166,7 +166,7 @@ pub fn size(&self) -> usize {
>  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>  ///     fn drop(&mut self) {
>  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
> +///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
>  ///     }
>  /// }
>  ///
> @@ -217,14 +217,14 @@ pub trait IoCapable<T> {
>      /// # Safety
>      ///
>      /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> -    unsafe fn io_read(&self, address: usize) -> T;
> +    unsafe fn io_read(&self, address: *mut T) -> T;
>  
>      /// Performs an I/O write of `value` at `address`.
>      ///
>      /// # Safety
>      ///
>      /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> -    unsafe fn io_write(&self, value: T, address: usize);
> +    unsafe fn io_write(&self, value: T, address: *mut T);
>  }
>  

In v1 you had a requirement for `address` to be aligned. Why did you
drop that?


Best regards,
Andreas Hindborg


