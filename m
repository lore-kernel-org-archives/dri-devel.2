Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C634DC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC7510E398;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="SMe+7ytG";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5160F10E5D9
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1789906444; x=1790165644;
 bh=FFArF+zmZlijNiWL8WyOKfrxWTrndzncvzJ7v/qcJwI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=SMe+7ytGWvydVYCAZeKvNwpwzyds4DPk0j3PPMS2QBIqohMtmslgHAFAfHtxZLSMR
 woliGKxjkfKnLfB0RfzloVUCeJFAVRiEnN6iciKNxxb8fmLeYBNWBJbC74qk1maI4+
 4QUAHTKNc5yHKCZVo2J41fzJ6DK5nMekuQ8pU6+qfcRZ7xlaZHwGtQPG2WQ/Q2B9GY
 pT/9TCqk45HPmkCWV3/SD6/RlXo6SYfdxaFn6erX/wEBN1ZnXhQ1haz4MD0ZlmuQA9
 dNgTZ/i7GcwAD9XWaONfRC57FEK/YwhA2MCVNkRgw9OqFiR1cMUe4W/HsceAMiCLKi
 DiLOas7uIuF/g==
Date: Sun, 20 Sep 2026 12:13:57 +0000
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
From: Lorenzo Delgado <lnsdev@proton.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v3] rust: io: convert ResourceSize into a transparent newtype
Message-ID: <20260920-resource-size-newtype-v3-1-9451444e83bb@proton.me>
Feedback-ID: 53083996:user:proton
X-Pm-Message-ID: ecc26dd13504dadec62f9f489bc7a969f187b114
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

`ResourceSize` is a bare type alias for `resource_size_t`, so it
inherits every integer operation and `as` cast. That allows operations
that make no sense for the size of a hardware resource, such as mixing
it with unrelated integers or truncating it with a cast.

Wrap it in a `#[repr(transparent)]` newtype so each conversion at a
boundary is explicit. The representation is unchanged, so this is
ABI-identical; only the spelling at the FFI boundary changes. Provide
`from_raw`/`into_raw`, `From` in both directions, and a fallible
`TryFrom<ResourceSize> for usize`. On 64-bit, where `resource_size_t`
is a `u64`, also implement `FromSafeCastArch<ResourceSize> for usize`,
so code that is specific to 64-bit can keep the conversion infallible.

Update the producers, `Resource::size` and `SGEntry::dma_len`, and the
`Region` and `request_region` consumers. nova-core only builds on
64-bit, so its page count in gsp.rs uses `from_safe_cast_arch()`. tyr
widens `dma_len()` to `u64`; go through `into_raw()` so that still
builds on 32-bit ARM, where `resource_size_t` is a `u32`.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1203
Signed-off-by: Lorenzo Delgado <lnsdev@proton.me>
---
Changes in v3:
- Rebase on rust-next (v7.3-rc4).
- Implement FromSafeCastArch<ResourceSize> for usize in the kernel
  crate, next to the type, now that the lossless casts live in
  kernel::num::casts. Drop the impl from nova-core's num.rs, and switch
  gsp.rs to usize::from_safe_cast_arch(), the same line the nova-core
  conversion to kernel::num uses.
- Convert the dma_len() user in tyr, added since v2. Without it, tyr
  fails to build on 32-bit ARM without LPAE.
- Link to v2: https://lore.kernel.org/r/20260719200945.687904-1-lnsdev@prot=
on.me
- Link to v1: https://lore.kernel.org/r/20260712113602.389060-1-lnsdev@prot=
on.me
---
 drivers/gpu/drm/tyr/vm.rs             |  2 +-
 drivers/gpu/nova-core/firmware/gsp.rs |  3 +-
 rust/kernel/io.rs                     | 83 +++++++++++++++++++++++++++++++=
+---
 rust/kernel/io/resource.rs            |  6 +--
 rust/kernel/scatterlist.rs            |  2 +-
 5 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index c5e307b1e241..c32d0259af5b 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -645,7 +645,7 @@ fn sm_step_map<'op>(
             #[allow(clippy::useless_conversion)]
             let mut paddr =3D u64::from(sgt_entry.dma_address());
             #[allow(clippy::useless_conversion)]
-            let mut sgt_entry_length =3D u64::from(sgt_entry.dma_len());
+            let mut sgt_entry_length =3D u64::from(sgt_entry.dma_len().int=
o_raw());
=20
             if bytes_left_to_map =3D=3D 0 {
                 break;
diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/=
firmware/gsp.rs
index e8f9491e84cc..956f76611cb0 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -9,6 +9,7 @@
         DmaAddress, //
     },
     firmware,
+    num::casts::arch::FromSafeCastArch,
     prelude::*,
     scatterlist::{
         Owned,
@@ -154,7 +155,7 @@ pub(crate) fn radix3_dma_address(&self) -> DmaAddress {
 fn map_into_lvl(sg_table: &SGTable<Owned<VVec<u8>>>, mut dst: VVec<u8>) ->=
 Result<VVec<u8>> {
     for sg_entry in sg_table.iter() {
         // Number of pages we need to map.
-        let num_pages =3D usize::from_safe_cast(sg_entry.dma_len()).div_ce=
il(GSP_PAGE_SIZE);
+        let num_pages =3D usize::from_safe_cast_arch(sg_entry.dma_len()).d=
iv_ceil(GSP_PAGE_SIZE);
=20
         for i in 0..num_pages {
             let entry =3D sg_entry.dma_address()
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 5ce9fd129068..3cc64983be82 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,11 +6,13 @@
=20
 use core::{
     marker::PhantomData,
-    mem::MaybeUninit, //
+    mem::MaybeUninit,
+    num::TryFromIntError, //
 };
=20
 use crate::{
     bindings,
+    fmt,
     prelude::*,
     ptr::{
         Alignment,
@@ -35,11 +37,82 @@
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
+
+// A `resource_size_t` is a `u64` on 64-bit platforms, so it fits into a `=
usize` there.
+#[cfg(CONFIG_64BIT)]
+impl crate::num::casts::arch::FromSafeCastArch<ResourceSize> for usize {
+    #[inline]
+    fn from_safe_cast_arch(value: ResourceSize) -> Self {
+        crate::num::casts::arch::u64_as_usize(value.into_raw())
+    }
+}
=20
 /// Untyped I/O region.
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

---
base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
change-id: 20260920-resource-size-newtype-63a82d4f2cdb

Best regards,
-- =20
Lorenzo Delgado <lnsdev@proton.me>


