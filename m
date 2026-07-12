Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C33C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C52310E81B;
	Mon, 13 Jul 2026 07:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="E8eegfOl";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE8E10E2C9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=idjl6gsmt5bhdow5z6z2rvgixu.protonmail; t=1783856171; x=1784115371;
 bh=G1MjZuFHK3Lys9+L8NuiAc1Kc/+5IEFQrCjyjzdi0vU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=E8eegfOl9Gh4aaUqD7FvJxo8017Jtu/z1+HCzOzj+kNJfHmZPQdSsvm8ZnaFBZEST
 5TZbGrGkNUNY3S9P/kQbmldmR4OSgaAKu1QSHauuaN+omW2RbwWy+NcSk5UE97eYiq
 UmVr6MhbV4Ebh7eyxHDgZP3E1rViSKBKnDM3PD55hatcnFZqAEBD3bPhBDU3qA6XfZ
 To8Y0VorGq9h8pxVwWThv+QAit4hUNjTghazU/GbBv3H0w3/Jc8CJrhyYpB4J9HLuI
 IOlyoSmZmL5itAx19NZpw/IJS3aSNCDREvb1LMO3j9p1kYGZV1NGVh2UQTSRkqSv11
 wlnuU0dE7IcPQ==
Date: Sun, 12 Jul 2026 11:36:05 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
From: Lorenzo Delgado <lnsdev@proton.me>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, John Hubbard <jhubbard@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 Lorenzo Delgado <lnsdev@proton.me>
Subject: [PATCH] rust: io: convert ResourceSize into a transparent newtype
Message-ID: <20260712113602.389060-1-lnsdev@proton.me>
Feedback-ID: 53083996:user:proton
X-Pm-Message-ID: edbbd905501a46a21956dba14434fbb5a51bd63e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:11:31 +0000
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
boundary changes. Provide the minimal conversion surface the call sites
need: `from_raw`/`into_raw`, `From` in both directions, and a fallible
`TryFrom<ResourceSize> for usize` for the page-count site that can
truncate on 32-bit. Update the two producers, `Resource::size` and
`SGEntry::dma_len`, and the `request_region` and nova-core consumers so
the tree builds green. Add doctest examples for the new type.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1203
Signed-off-by: Lorenzo Delgado <lnsdev@proton.me>
---
An earlier attempt at this conversion was posted by Moritz Zielke [1]. This
is a fresh, independent implementation that reuses none of that code; it
additionally converts the nova-core consumer and adds doctest examples.

[1] https://lore.kernel.org/all/20251203-res-size-newtype-v1-1-22ed0b8a7a18=
@gmail.com/

 drivers/gpu/nova-core/firmware/gsp.rs |  2 +-
 rust/kernel/io.rs                     | 73 +++++++++++++++++++++++++--
 rust/kernel/io/resource.rs            |  6 +--
 rust/kernel/scatterlist.rs            |  2 +-
 4 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/=
firmware/gsp.rs
index 99a302bae567..d7593888e65b 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -175,7 +175,7 @@ pub(crate) fn radix3_dma_handle(&self) -> DmaAddress {
 fn map_into_lvl(sg_table: &SGTable<Owned<VVec<u8>>>, mut dst: VVec<u8>) ->=
 Result<VVec<u8>> {
     for sg_entry in sg_table.iter() {
         // Number of pages we need to map.
-        let num_pages =3D usize::from_safe_cast(sg_entry.dma_len()).div_ce=
il(GSP_PAGE_SIZE);
+        let num_pages =3D usize::try_from(sg_entry.dma_len())?.div_ceil(GS=
P_PAGE_SIZE);
=20
         for i in 0..num_pages {
             let entry =3D sg_entry.dma_address()
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

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
--=20
2.54.0


