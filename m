Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B89ECA5FA6
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661F010E8DB;
	Mon, 28 Sep 2026 08:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Y/FBx5xe";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822A710E1A9
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=u5wzv53u35d3xnejuqwvus4ajq.protonmail2; t=1790532701;
 x=1790791901; bh=rU/Pw4sVsLNksMs3xC6f2YsQun2aeEfNFU7iJX4s9UQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Y/FBx5xecDNqd1o2B9PBc6SqEPBtQOKvV/+qg8RY6HmFjzB1wdF1OvQ68sLvdqBia
 y1V5H1piD9Eg2brhj1OJMexK/1G1ZPeCCAIjBIXOBAv7IGMOsK8+k5j9FQFdw/SUaS
 irIAfOYsHvWCiXyHZHHze5pnXJuk2sHKDlhBvsWQcYVQkqZ3wMfZlE2cpoWKOSBNHd
 tHK2wvrlDAXdBjWDxnNeroFlN5chnwOrGP29u63sdwCGY9WRNqrEGO9vY7MkKlHM2J
 Awrha0r8vQ0+T0m46MabEZn+mf1ygifsE1kraQPLovU5GN/oei+T7CeCHyeVK05mbi
 8ViURjdMmwptQ==
Date: Sun, 27 Sep 2026 18:11:38 +0000
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
From: Lorenzo Delgado <lnsdev@proton.me>
Cc: Lorenzo Delgado <lnsdev@proton.me>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v4 2/2] rust: io: convert ResourceSize into a transparent
 newtype
Message-ID: <20260927-resource-size-newtype-v4-2-447a08af23fb@proton.me>
In-Reply-To: <20260927-resource-size-newtype-v4-0-447a08af23fb@proton.me>
References: <20260927-resource-size-newtype-v4-0-447a08af23fb@proton.me>
Feedback-ID: 53083996:user:proton
X-Pm-Message-ID: ec408884551717dee2135b6cb11405ceb3d6df7f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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
`TryFrom<ResourceSize> for usize`, since `resource_size_t` can be wider
than `usize` on 32-bit.

Update the producer, `Resource::size`, and its consumers in `Region`
and `request_region`.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1203
Signed-off-by: Lorenzo Delgado <lnsdev@proton.me>
---
 rust/kernel/io.rs          | 74 ++++++++++++++++++++++++++++++++++++++++++=
----
 rust/kernel/io/resource.rs |  6 ++--
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 5ce9fd129068..09b0586acf1a 100644
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
@@ -35,11 +37,73 @@
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

--=20
2.55.0


