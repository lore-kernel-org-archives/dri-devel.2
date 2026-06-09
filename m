Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C2CCD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE2C910E408;
	Tue,  9 Jun 2026 14:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nwDszgGM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E90510E408
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:27:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32EF443EBB;
 Tue,  9 Jun 2026 14:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C0D1F00893;
 Tue,  9 Jun 2026 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781015229;
 bh=7b6cZO88qxYhwPQRHX9JdG5EbRfREDm6sv5DAhrto3Y=;
 h=From:To:Cc:Subject:Date:Reply-To;
 b=nwDszgGMS4Q5Gx6dDnrYmmxG3JFRwCznR8eeTRISzUFizK3fvgodofWAu0j6qV7Vm
 x8jzUygPHi0X7dKckNz5MK6s/lYGVbDQhxCVCq/CV6YZzLrPMaloIQFmQ9JFuDUE5t
 bsKGaAtZc/eXQskQawfXOzP2QBNT3/JHr9JepY5csJaBJqqS9brT6suCfR/tDAY0dl
 3cy1egpS8C+a924GwJU7wfUap2OVoYsh+qWf3VZMyjzZUZq62sEE4olr+tg2BSk3eU
 n3m/ldEIak5tl9p0RlIcfwcAmJu0eCLrYxhxYEWpbrCZaUgMHWORyNWIt7SezgpP9w
 fnMRyl333y4xg==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Tamir Duberstein <tamird@kernel.org>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, netdev@vger.kernel.org
Subject: [PATCH v4] rust: make `build_assert` module the home of related macros
Date: Tue,  9 Jun 2026 15:26:33 +0100
Message-ID: <20260609142637.373347-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

Given the macro scoping rules, all macros are rendered twice, in the
module and in the top-level of kernel crate.

Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
re-export inside `build_assert` module so the top-level items are hidden.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
This is the remaining unapplied patch from
https://lore.kernel.org/rust-for-linux/20260319121653.2975748-1-gary@kernel.org/.

Changes:
- Rebased so it applies cleanly. (both on linux-next and rust-next)
- Picked up tags
- Updated commit message to reflect that my other patch "rust: doc: disable
  doc inlining for all prelude items" already reduce number of rendering
  times from 3 to 2.
---
 drivers/gpu/nova-core/bitfield.rs    |  4 ++--
 drivers/gpu/nova-core/num.rs         |  2 +-
 rust/kernel/build_assert.rs          | 19 ++++++++++++-------
 rust/kernel/io/register.rs           | 19 ++++++++++++-------
 rust/kernel/io/resource.rs           |  2 +-
 rust/kernel/ioctl.rs                 |  2 +-
 rust/kernel/net/phy/reg.rs           |  8 +++++---
 rust/kernel/num/bounded.rs           |  2 +-
 rust/kernel/prelude.rs               | 12 ++++++++----
 rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
 rust/kernel/sync/atomic/predefine.rs |  2 +-
 rust/kernel/sync/locked_by.rs        |  2 +-
 rust/kernel/sync/refcount.rs         |  8 +++++---
 rust/kernel/xarray.rs                | 10 ++++++++--
 14 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 02efdcf78d89..660c3911402d 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -170,7 +170,7 @@ impl $name {
     (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) => {
         #[allow(clippy::eq_op)]
         const _: () = {
-            ::kernel::build_assert!(
+            ::kernel::build_assert::build_assert!(
                 $hi == $lo,
                 concat!("boolean field `", stringify!($field), "` covers more than one bit")
             );
@@ -181,7 +181,7 @@ impl $name {
     (@check_field_bounds $hi:tt:$lo:tt $field:ident as $type:tt) => {
         #[allow(clippy::eq_op)]
         const _: () = {
-            ::kernel::build_assert!(
+            ::kernel::build_assert::build_assert!(
                 $hi >= $lo,
                 concat!("field `", stringify!($field), "`'s MSB is smaller than its LSB")
             );
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6c824b8d7b97..6eb174d136ab 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -49,7 +49,7 @@ macro_rules! impl_safe_as {
             #[allow(unused)]
             #[inline(always)]
             pub(crate) const fn [<$from _as_ $into>](value: $from) -> $into {
-                kernel::static_assert!(size_of::<$into>() >= size_of::<$from>());
+                ::kernel::build_assert::static_assert!(size_of::<$into>() >= size_of::<$from>());
 
                 value as $into
             }
diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
index 2ea2154ec30c..c3acb9b68a65 100644
--- a/rust/kernel/build_assert.rs
+++ b/rust/kernel/build_assert.rs
@@ -61,15 +61,16 @@
 //! undefined symbols and linker errors, it is not developer friendly to debug, so it is recommended
 //! to avoid it and prefer other two assertions where possible.
 
+#[doc(inline)]
 pub use crate::{
-    build_assert,
+    build_assert_macro as build_assert,
     build_error,
     const_assert,
     static_assert, //
 };
 
 #[doc(hidden)]
-pub use build_error::build_error;
+pub use build_error::build_error as build_error_fn;
 
 /// Static assert (i.e. compile-time assert).
 ///
@@ -105,6 +106,7 @@
 /// static_assert!(f(40) == 42, "f(x) must add 2 to the given input.");
 /// ```
 #[macro_export]
+#[doc(hidden)]
 macro_rules! static_assert {
     ($condition:expr $(,$arg:literal)?) => {
         const _: () = ::core::assert!($condition $(,$arg)?);
@@ -133,6 +135,7 @@ macro_rules! static_assert {
 /// }
 /// ```
 #[macro_export]
+#[doc(hidden)]
 macro_rules! const_assert {
     ($condition:expr $(,$arg:literal)?) => {
         const { ::core::assert!($condition $(,$arg)?) };
@@ -157,12 +160,13 @@ macro_rules! const_assert {
 /// // foo(usize::MAX); // Fails to compile.
 /// ```
 #[macro_export]
+#[doc(hidden)]
 macro_rules! build_error {
     () => {{
-        $crate::build_assert::build_error("")
+        $crate::build_assert::build_error_fn("")
     }};
     ($msg:expr) => {{
-        $crate::build_assert::build_error($msg)
+        $crate::build_assert::build_error_fn($msg)
     }};
 }
 
@@ -200,15 +204,16 @@ macro_rules! build_error {
 /// const _: () = const_bar(2);
 /// ```
 #[macro_export]
-macro_rules! build_assert {
+#[doc(hidden)]
+macro_rules! build_assert_macro {
     ($cond:expr $(,)?) => {{
         if !$cond {
-            $crate::build_assert::build_error(concat!("assertion failed: ", stringify!($cond)));
+            $crate::build_assert::build_error_fn(concat!("assertion failed: ", stringify!($cond)));
         }
     }};
     ($cond:expr, $msg:expr) => {{
         if !$cond {
-            $crate::build_assert::build_error($msg);
+            $crate::build_assert::build_error_fn($msg);
         }
     }};
 }
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 388647f28292..f924c7c7c1db 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -108,9 +108,10 @@
 
 use core::marker::PhantomData;
 
-use crate::io::IoLoc;
-
-use kernel::build_assert;
+use crate::{
+    build_assert::build_assert,
+    io::IoLoc, //
+};
 
 /// Trait implemented by all registers.
 pub trait Register: Sized {
@@ -872,7 +873,7 @@ macro_rules! register {
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr, stride = $stride:expr ] @ $offset:literal { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
+        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
@@ -895,7 +896,9 @@ macro_rules! register {
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
             { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!($idx < <$alias as $crate::io::register::RegisterArray>::SIZE);
+        $crate::build_assert::static_assert!(
+            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
+        );
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
@@ -912,7 +915,7 @@ macro_rules! register {
             [ $size:expr, stride = $stride:expr ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
+        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
@@ -938,7 +941,9 @@ macro_rules! register {
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!($idx < <$alias as $crate::io::register::RegisterArray>::SIZE);
+        $crate::build_assert::static_assert!(
+            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
+        );
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index b7ac9faf141d..17b0c174cfc5 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -229,7 +229,7 @@ impl Flags {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     const fn new(value: u32) -> Self {
-        crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
+        build_assert!(value as u64 <= c_ulong::MAX as u64);
         Flags(value as c_ulong)
     }
 }
diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index 2fc7662339e5..5bb5b48cf949 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -6,7 +6,7 @@
 
 #![expect(non_snake_case)]
 
-use crate::build_assert;
+use crate::build_assert::build_assert;
 
 /// Build an ioctl number, analogous to the C macro of the same name.
 #[inline(always)]
diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
index a7db0064cb7d..80e22c264ea8 100644
--- a/rust/kernel/net/phy/reg.rs
+++ b/rust/kernel/net/phy/reg.rs
@@ -9,9 +9,11 @@
 //! defined in IEEE 802.3.
 
 use super::Device;
-use crate::build_assert;
-use crate::error::*;
-use crate::uapi;
+use crate::{
+    build_assert::build_assert,
+    error::*,
+    uapi, //
+};
 
 mod private {
     /// Marker that a trait cannot be implemented outside of this crate
diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index f9f90d6ec482..dafe77782d79 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -364,7 +364,7 @@ pub fn try_new(value: T) -> Option<Self> {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     pub fn from_expr(expr: T) -> Self {
-        crate::build_assert!(
+        crate::build_assert::build_assert!(
             fits_within(expr, N),
             "Requested value larger than maximal representable value."
         );
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ca260cc3937a..f6e852638ade 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -79,9 +79,6 @@
         VVec,
         Vec, //
     },
-    build_assert,
-    build_error,
-    const_assert,
     current,
     dev_alert,
     dev_crit,
@@ -105,7 +102,6 @@
     pr_info,
     pr_notice,
     pr_warn,
-    static_assert,
     str::CStrExt as _,
     try_init,
     try_pin_init,
@@ -113,6 +109,14 @@
     ThisModule, //
 };
 
+#[doc(no_inline)]
+pub use crate::build_assert::{
+    build_assert,
+    build_error,
+    const_assert,
+    static_assert, //
+};
+
 // `super::std_vendor` is hidden, which makes the macro inline for some reason.
 #[doc(no_inline)]
 pub use super::dbg;
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
index ad810c2172ec..9c8a7a203abd 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -4,8 +4,11 @@
 //!
 //! Provides 1:1 mapping to the C atomic operations.
 
-use crate::bindings;
-use crate::macros::paste;
+use crate::{
+    bindings,
+    build_assert::static_assert,
+    macros::paste, //
+};
 use core::cell::UnsafeCell;
 use ffi::c_void;
 
@@ -46,7 +49,7 @@ pub trait AtomicImpl: Sized + Copy + private::Sealed {
 // In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n architecture plans to support Rust, the
 // load/store helpers that guarantee atomicity against RmW operations (usually via a lock) need to
 // be added.
-crate::static_assert!(
+static_assert!(
     cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
     "The current implementation of atomic i8/i16/ptr relies on the architecure being \
     ARCH_SUPPORTS_ATOMIC_RMW"
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 7468153429e1..adc5fa126487 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -2,7 +2,7 @@
 
 //! Pre-defined atomic types
 
-use crate::static_assert;
+use crate::prelude::*;
 use core::mem::{align_of, size_of};
 use ffi::c_void;
 
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index 61f100a45b35..fb4a1430b3b4 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -3,7 +3,7 @@
 //! A wrapper for data protected by a lock that does not wrap it.
 
 use super::{lock::Backend, lock::Lock};
-use crate::build_assert;
+use crate::build_assert::build_assert;
 use core::{cell::UnsafeCell, mem::size_of, ptr};
 
 /// Allows access to some data to be serialised by a lock that does not wrap it.
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index 6c7ae8b05a0b..23a5d201f343 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -4,9 +4,11 @@
 //!
 //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
 
-use crate::build_assert;
-use crate::sync::atomic::Atomic;
-use crate::types::Opaque;
+use crate::{
+    build_assert::build_assert,
+    sync::atomic::Atomic,
+    types::Opaque, //
+};
 
 /// Atomic reference counter.
 ///
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 46e5f43223fe..987c9c0c2198 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -5,10 +5,16 @@
 //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
 
 use crate::{
-    alloc, bindings, build_assert,
+    alloc,
+    bindings,
+    build_assert::build_assert,
     error::{Error, Result},
     ffi::c_void,
-    types::{ForeignOwnable, NotThreadSafe, Opaque},
+    types::{
+        ForeignOwnable,
+        NotThreadSafe,
+        Opaque, //
+    }, //
 };
 use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
 use pin_init::{pin_data, pin_init, pinned_drop, PinInit};

base-commit: 98cc68794c003bc76fc9da2e8a075e947eee5921
-- 
2.54.0

