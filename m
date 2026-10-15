Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571C6CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727BF10F27B;
	Thu, 15 Oct 2026 12:39:46 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA61110EBAD
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792067978; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SYR+JcckoeIPBpaSy4Jn5EtpG0RcV/jNU/GdubIgUtb01GPJOpH6QIUoSzAmZYureOg52UJsTYnOs3edSX3c8EzqXwrrG/xyxR8FhNjfMit8zJnIdMnkXOuKfKgikR4GiKKSTTStYtYB0GnQKhf73/ZqwGcWqZ/eO3y4VNEHFJw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792067978;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ltzYYSYrndLaIvxs1Wxb7B9oHjD7meehlnBm5QI9WGw=; 
 b=O/C5NX27pCvfL2pbN3QK4Z8RpbuLxaZtoHz8W4rVrBZMjZe0OIaUrZokyCYMsLFt/PgSX4/nzTrgPob2kB7gwN8OF9KWYRRHi/kTJD2aIbpUsFN1QRgi28h1Jh1s3KrYKLwH0ew8U57VsY1bXdusBMWt7mbyWXEvyiyxhkfWUHo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067978; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=ltzYYSYrndLaIvxs1Wxb7B9oHjD7meehlnBm5QI9WGw=;
 b=HAlsDRYtggV1yZDjQXFrieOSsvt4GGryp4OqBeKbjZDEWm1aX2+MfldWVGScChuO
 dY10bwOsr1iYT1baFn9f+gHFGq87yYKiyRJn20Ptrl5ctcIboSY8bPlr9Nw4bv/Vbmv
 kfpInkRBEhlTsmrbZAoZHiWvtXfJY9mu9u3UFIkw=
Received: by smtp.zohomail.com with SMTPS id 1792067975281355.6348964848903;
 Thu, 15 Oct 2026 05:39:35 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 15 Oct 2026 09:39:07 -0300
Subject: [PATCH 3/7] rust: io: add read-only and write-only views
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-io-access-modes-v1-3-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
In-Reply-To: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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

An I/O view can always be both read and written, as long as its backend
supports both directions. The I/O API has no view that only allows the
accesses the hardware or firmware permits, such as a status register
that must not be written or a doorbell that must not be read.

Add `ReadOnly` and `WriteOnly`, which wrap a view of any backend, and
their backends `ReadOnlyBackend` and `WriteOnlyBackend`. A read-only
backend implements `IoReadable` and `IoCopyReadable` where the wrapped
backend does, by forwarding to it, and implements neither `IoWritable`
nor `IoCopyWritable`, so the write methods of `Io` do not compile on a
`ReadOnly` view. `WriteOnly` is the converse. Views projected from a
wrapped view stay wrapped, and the wrapped view cannot be retrieved.

Add `Io::read_only` and `Io::write_only` to create them from any view or
I/O handle.

There are no users yet. Register locations with an access mode will be
the first, in a following patch.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/io.rs | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ae60099fd4c3..03af0590b0f4 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -540,6 +540,60 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
         Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
     }
 
+    /// Returns a view of this I/O region that can only be read.
+    ///
+    /// The returned view, and every view projected from it, provides the read methods of [`Io`]
+    /// and none of the write methods.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     Io,
+    ///     Mmio,
+    ///     ReadOnly,
+    ///     Region,
+    /// };
+    ///
+    /// fn do_reads(io: Mmio<'_, Region<0x100>>) -> u32 {
+    ///     let ro: ReadOnly<Mmio<'_, Region<0x100>>> = io.read_only();
+    ///
+    ///     // Reads work as on `io`. A write such as `ro.write32(0, 0x10)` does not compile.
+    ///     ro.read32(0x10)
+    /// }
+    /// ```
+    #[inline]
+    fn read_only(self) -> ReadOnly<<Self::Backend as IoBackend>::View<'a, Self::Target>> {
+        ReadOnly(self.as_view())
+    }
+
+    /// Returns a view of this I/O region that can only be written.
+    ///
+    /// The returned view, and every view projected from it, provides the write methods of [`Io`]
+    /// and none of the read methods.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     Io,
+    ///     Mmio,
+    ///     Region,
+    ///     WriteOnly,
+    /// };
+    ///
+    /// fn do_writes(io: Mmio<'_, Region<0x100>>) {
+    ///     let wo: WriteOnly<Mmio<'_, Region<0x100>>> = io.write_only();
+    ///
+    ///     // Writes work as on `io`. A read such as `wo.read32(0x10)` does not compile.
+    ///     wo.write32(1, 0x10);
+    /// }
+    /// ```
+    #[inline]
+    fn write_only(self) -> WriteOnly<<Self::Backend as IoBackend>::View<'a, Self::Target>> {
+        WriteOnly(self.as_view())
+    }
+
     /// Read a value from I/O.
     ///
     /// This only works for primitives supported by the I/O backend.
@@ -1697,6 +1751,128 @@ fn as_view(self) -> IoSysMap<'a, T> {
     }
 }
 
+/// A view that can only be read.
+///
+/// It wraps a view `V` of another I/O backend and provides the read methods of [`Io`] for it, but
+/// none of the write methods. Views projected from it are read-only too, and the wrapped view
+/// cannot be retrieved.
+///
+/// See [`Io::read_only`] for a usage example.
+#[derive(Clone, Copy)]
+pub struct ReadOnly<V>(V);
+
+/// I/O Backend for [`ReadOnly`] views of backend `B`.
+pub struct ReadOnlyBackend<B>(PhantomData<B>);
+
+impl<B: IoBackend> IoBackend for ReadOnlyBackend<B> {
+    type View<'a, T: ?Sized + KnownSize> = ReadOnly<B::View<'a, T>>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        B::as_ptr(view.0)
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // SAFETY: Per safety requirement.
+        ReadOnly(unsafe { B::project_view(view.0, ptr) })
+    }
+}
+
+impl<'a, V: IoBase<'a>> IoBase<'a> for ReadOnly<V> {
+    type Backend = ReadOnlyBackend<V::Backend>;
+    type Target = V::Target;
+
+    #[inline]
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
+        ReadOnly(self.0.as_view())
+    }
+}
+
+impl<B: IoReadable<T>, T> IoReadable<T> for ReadOnlyBackend<B> {
+    #[inline]
+    fn io_read(view: Self::View<'_, T>) -> T {
+        B::io_read(view.0)
+    }
+}
+
+impl<B: IoCopyReadable> IoCopyReadable for ReadOnlyBackend<B> {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // SAFETY: Per safety requirement.
+        unsafe { B::copy_from_io(view.0, buffer) }
+    }
+
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        B::copy_read(view.0)
+    }
+}
+
+/// A view that can only be written.
+///
+/// It wraps a view `V` of another I/O backend and provides the write methods of [`Io`] for it, but
+/// none of the read methods. Views projected from it are write-only too, and the wrapped view
+/// cannot be retrieved.
+///
+/// See [`Io::write_only`] for a usage example.
+#[derive(Clone, Copy)]
+pub struct WriteOnly<V>(V);
+
+/// I/O Backend for [`WriteOnly`] views of backend `B`.
+pub struct WriteOnlyBackend<B>(PhantomData<B>);
+
+impl<B: IoBackend> IoBackend for WriteOnlyBackend<B> {
+    type View<'a, T: ?Sized + KnownSize> = WriteOnly<B::View<'a, T>>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        B::as_ptr(view.0)
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // SAFETY: Per safety requirement.
+        WriteOnly(unsafe { B::project_view(view.0, ptr) })
+    }
+}
+
+impl<'a, V: IoBase<'a>> IoBase<'a> for WriteOnly<V> {
+    type Backend = WriteOnlyBackend<V::Backend>;
+    type Target = V::Target;
+
+    #[inline]
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
+        WriteOnly(self.0.as_view())
+    }
+}
+
+impl<B: IoWritable<T>, T> IoWritable<T> for WriteOnlyBackend<B> {
+    #[inline]
+    fn io_write(view: Self::View<'_, T>, value: T) {
+        B::io_write(view.0, value)
+    }
+}
+
+impl<B: IoCopyWritable> IoCopyWritable for WriteOnlyBackend<B> {
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // SAFETY: Per safety requirement.
+        unsafe { B::copy_to_io(view.0, buffer) }
+    }
+
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        B::copy_write(view.0, value)
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.56.0

