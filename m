Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE4BC44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B1610E721;
	Mon, 20 Jul 2026 07:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="XIDe5Bxp";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B4C10E0A7
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 20:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=hr7fef3m5bcb3nzwxv7hcawpkm.protonmail; t=1784491794; x=1784750994;
 bh=YIlA/ffz+CiSppXBfyyFp/DZEaOzhgtsaIbJf8IEPJk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=XIDe5BxpOiZPwyCj4Yuh5bU57cJs5z9EkFRs7WjCxWGWBRLdSDo36yxkjjNUrKBi6
 BJIK8IWmBZljUseKpghmQSzhH4/YboOWW62wW9sr3Cu5eFdr9Jn//oKltxrn33U9lv
 a4xGmGYzXCR5dNaMXg6cVUGeUODfrhTmn+nbEHlvXSk/m2SGTW8cEt8COeG9ZU51mf
 YmOPeMX1gQo5pdt0oIcwI/WVx+0QkRO4jlq0Lt2S4CPyDdzNGzE72lwG5t5vfYODzE
 V5zl36MlUXVH2KwaWJPTmMI9Cy0FOVck8k3+jbJXoiM67leHx5XPGTApRwjgt0Skus
 VpyQOHmAN2ZFw==
Date: Sun, 19 Jul 2026 20:09:49 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>
From: Lorenzo Delgado <lnsdev@proton.me>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 Lorenzo Delgado <lnsdev@proton.me>
Subject: [PATCH v2] rust: io: convert ResourceSize into a transparent newtype
Message-ID: <20260719200945.687904-1-lnsdev@proton.me>
In-Reply-To: <20260712113602.389060-1-lnsdev@proton.me>
References: <20260712113602.389060-1-lnsdev@proton.me>
Feedback-ID: 53083996:user:proton
X-Pm-Message-ID: 81b8f77747862653e1bf7a1622bfe2725ec30257
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

`ResourceSize` was a bare type alias for `resource_size_t`, so it
inherited every integer operation and `as` cast. That silently permits
operations that are meaningless for the size of a hardware resource:
mixing it with unrelated integers and truncating casts.

Wrap it in a `#[repr(transparent)]` newtype so each conversion at a
boundary becomes explicit and reviewable. The representation is
unchanged, so this is ABI-identical; only the spelling at the FFI
boundary changes. Provide the conversion surface `from_raw`/`into_raw`,
`From` in both directions, and a fallible `TryFrom<ResourceSize> for
usize` for checked narrowing. Update the two producers, `Resource::size`
and `SGEntry::dma_len`, and the `request_region` consumer. In nova-core,
add an `impl FromSafeCast<ResourceSize> for usize` so its page-count
conversion keeps the infallible `usize::from_safe_cast(sg_entry.dma_len())`
unchanged.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1203
Signed-off-by: Lorenzo Delgado <lnsdev@proton.me>
---
v2: keep the nova-core page-count conversion infallible, per review
    (Danilo Krummrich). v1 changed it to a fallible
    usize::try_from(sg_entry.dma_len())?; instead of touching the call
    site, add an impl FromSafeCast<ResourceSize> for usize in nova-core's
    num.rs, so drivers/gpu/nova-core/firmware/gsp.rs keeps
    usize::from_safe_cast(sg_entry.dma_len()) unchanged. FromSafeCast is
    to move to the kernel crate subsequently. io.rs is unchanged from v1.

v1: https://lore.kernel.org/r/20260712113602.389060-1-lnsdev@proton.me

 drivers/gpu/nova-core/num.rs | 10 +++++
 rust/kernel/io.rs            | 73 ++++++++++++++++++++++++++++++++++--
 rust/kernel/io/resource.rs   |  6 +--
 rust/kernel/scatterlist.rs   |  2 +-
 4 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..7c0e878bbfb2 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -6,6 +6,7 @@
 //! crate.
=20
 use kernel::{
+    io::ResourceSize,
     macros::paste,
     prelude::*, //
 };
@@ -137,6 +138,15 @@ fn from_safe_cast(value: u64) -> Self {
     }
 }
=20
+// A `resource_size_t` fits into a `usize` on 64-bit platforms, where a `u=
size` is a `u64` and a
+// `resource_size_t` is at most a `u64`. Delegates to the primitive impl f=
or the underlying type.
+#[cfg(CONFIG_64BIT)]
+impl FromSafeCast<ResourceSize> for usize {
+    fn from_safe_cast(value: ResourceSize) -> Self {
+        Self::from_safe_cast(value.into_raw())
+    }
+}
+
 /// Counterpart to the [`FromSafeCast`] trait, i.e. this trait is to [`Fro=
mSafeCast`] what [`Into`]
 /// is to [`From`].
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..ebf00b4536d6 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,9 +6,12 @@
=20
 use crate::{
     bindings,
+    fmt,
     prelude::*, //
 };
=20
+use core::num::TryFromIntError;
+
 pub mod mem;
 pub mod poll;
 pub mod register;
@@ -25,11 +28,73 @@
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit archite=
ctures.
 pub type PhysAddr =3D bindings::phys_addr_t;
=20
-/// Resource Size type.
+/// Resource size type.
 ///
-/// This is a type alias to either `u32` or `u64` depending on the config =
option
-/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit archite=
ctures.
-pub type ResourceSize =3D bindings::resource_size_t;
+/// This wraps either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a `u64` even on 32-bit archi=
tectures.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::io::ResourceSize;
+///
+/// let size =3D ResourceSize::from_raw(0x1000);
+/// assert_eq!(size.into_raw(), 0x1000);
+///
+/// // Round-trips through the raw C type.
+/// let raw: kernel::bindings::resource_size_t =3D size.into();
+/// assert_eq!(ResourceSize::from(raw), size);
+///
+/// // Fallible conversion to `usize` (can truncate on 32-bit).
+/// assert_eq!(usize::try_from(size)?, 0x1000);
+/// # Ok::<(), core::num::TryFromIntError>(())
+/// ```
+#[repr(transparent)]
+#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
+pub struct ResourceSize(bindings::resource_size_t);
+
+impl ResourceSize {
+    /// Creates a resource size from the raw C type.
+    #[inline]
+    pub const fn from_raw(value: bindings::resource_size_t) -> Self {
+        Self(value)
+    }
+
+    /// Turns this resource size into the raw C type.
+    #[inline]
+    pub const fn into_raw(self) -> bindings::resource_size_t {
+        self.0
+    }
+}
+
+impl fmt::Debug for ResourceSize {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "{:#x}", self.0)
+    }
+}
+
+impl From<bindings::resource_size_t> for ResourceSize {
+    #[inline]
+    fn from(value: bindings::resource_size_t) -> Self {
+        Self::from_raw(value)
+    }
+}
+
+impl From<ResourceSize> for bindings::resource_size_t {
+    #[inline]
+    fn from(value: ResourceSize) -> Self {
+        value.into_raw()
+    }
+}
+
+impl TryFrom<ResourceSize> for usize {
+    type Error =3D TryFromIntError;
+
+    #[inline]
+    fn try_from(value: ResourceSize) -> Result<Self, Self::Error> {
+        Self::try_from(value.into_raw())
+    }
+}
=20
 /// Raw representation of an MMIO region.
 ///
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index 17b0c174cfc5..a33a416b289a 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -58,7 +58,7 @@ fn drop(&mut self) {
         };
=20
         // SAFETY: Safe as per the invariant of `Region`.
-        unsafe { release_fn(start, size) };
+        unsafe { release_fn(start, size.into_raw()) };
     }
 }
=20
@@ -114,7 +114,7 @@ pub fn request_region(
             bindings::__request_region(
                 self.0.get(),
                 start,
-                size,
+                size.into_raw(),
                 name.as_char_ptr(),
                 flags.0 as c_int,
             )
@@ -130,7 +130,7 @@ pub fn request_region(
     pub fn size(&self) -> ResourceSize {
         let inner =3D self.0.get();
         // SAFETY: Safe as per the invariants of `Resource`.
-        unsafe { bindings::resource_size(inner) }
+        ResourceSize::from_raw(unsafe { bindings::resource_size(inner) })
     }
=20
     /// Returns the start address of the resource.
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index b83c468b5c63..5d67242befd8 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -93,7 +93,7 @@ pub fn dma_address(&self) -> dma::DmaAddress {
     pub fn dma_len(&self) -> ResourceSize {
         #[allow(clippy::useless_conversion)]
         // SAFETY: `self.as_raw()` is a valid pointer to a `struct scatter=
list`.
-        unsafe { bindings::sg_dma_len(self.as_raw()) }.into()
+        ResourceSize::from_raw(unsafe { bindings::sg_dma_len(self.as_raw()=
) }.into())
     }
 }
=20

base-commit: 7059bdf4f04a3e14f4fafb3ac35fdca913e3e21a
--=20
2.54.0


