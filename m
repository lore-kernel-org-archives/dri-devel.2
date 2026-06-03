Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC05CD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C4C10F72D;
	Wed,  3 Jun 2026 01:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bvjpGwio";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC0710F72B
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:10:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D53EC40687;
 Wed,  3 Jun 2026 01:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCD41F00893;
 Wed,  3 Jun 2026 01:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780449037;
 bh=1KEoJo7IVklqGes8vOy2JYJl+S37vQieuYALZbqcPNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bvjpGwiosFQPvp1zeoC4lFF+SJCs7y4g9VOCmLitoGujV6stCGF63t5PxAewMNBjZ
 XTQIALLq7SbSSZ6ZzVmQK+LZO1dyULyF2e5wtE/UrfcMncBOKPUtogEkGtG+u3orBk
 wbi/LwseSAacUWCq6G6vxKti8whTyuSwGwmJI4bT8zFy97xQjJwHSuuJFtceWRsfrP
 y5fa1YTU8zbnhqRzWkOV7r3Vzo4kZ+zYPUNEgGn9bmrNVs450pTI9T5pN6j5aShZjy
 JRUZwrw7UiKTUK1BfzJfApIQ2oqsEvwNR4h8kx8OFsBEbSV5YmUgM0uDDRK68m3q9v
 nRa09YdSvhxQA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com,
 ecourtney@nvidia.com, m.wilczynski@samsung.com, david.m.ertman@intel.com,
 ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com,
 bhelgaas@google.com, kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
Date: Wed,  3 Jun 2026 03:10:13 +0200
Message-ID: <20260603011020.2073650-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011020.2073650-1-dakr@kernel.org>
References: <20260603011020.2073650-1-dakr@kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add a new ForLt trait as a base for CovariantForLt:

  - ForLt (non-unsafe): represents a type generic over a lifetime, with
    no covariance guarantee.  Provides unsafe fn cast_ref_unchecked()
    for callers that can justify lifetime shortening via a round-trip
    safety argument.

  - CovariantForLt (unsafe): becomes a subtrait of ForLt that
    additionally proves the type is covariant over its lifetime
    parameter, providing a safe cast_ref() method.

This split allows non-covariant types (e.g. types behind a Mutex) to
implement ForLt and participate in DevresLt / registration data patterns
where the round-trip argument suffices, without requiring a covariance
proof that would fail to compile.

The internal macro backend is split accordingly: ForLt! emits ForLtImpl
(no covariance proof), CovariantForLt! emits CovariantForLtImpl (with
compile-time covariance proof).

No existing callers change; they all use CovariantForLt.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs        |   1 +
 rust/kernel/types/for_lt.rs | 101 ++++++++++++++++++++++++++++++------
 rust/macros/for_lt.rs       |  50 ++++++++++++++----
 rust/macros/lib.rs          |  19 ++++++-
 4 files changed, 145 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index cbe6907042d3..c1ed05d1046c 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -14,6 +14,7 @@
 #[doc(hidden)]
 pub mod for_lt;
 pub use for_lt::CovariantForLt;
+pub use for_lt::ForLt;
 
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
index ef510ab6c092..e1774b03dd1f 100644
--- a/rust/kernel/types/for_lt.rs
+++ b/rust/kernel/types/for_lt.rs
@@ -1,17 +1,74 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
-//! Provide implementation and test of the `CovariantForLt` trait and macro.
+//! Provide implementation and test of the `ForLt` and `CovariantForLt` traits and macros.
 //!
-//! This module is hidden and user should just use `CovariantForLt!` directly.
+//! This module is hidden and users should just use `ForLt!` / `CovariantForLt!` directly.
 
 use core::marker::PhantomData;
 
 /// Representation of types generic over a lifetime.
 ///
-/// The type must be covariant over the generic lifetime, i.e. the lifetime parameter
-/// can be soundly shortened.
+/// # Macro
+///
+/// It is not recommended to implement this trait directly. `ForLt!` macro is provided to obtain a
+/// type that implements this trait.
+///
+/// The full syntax is
+///
+/// ```
+/// # use kernel::types::ForLt;
+/// # fn expect_lt<F: ForLt>() {}
+/// # struct TypeThatUse<'a>(&'a ());
+/// # expect_lt::<
+/// ForLt!(for<'a> TypeThatUse<'a>)
+/// # >();
+/// ```
+///
+/// which gives a type so that `<ForLt!(for<'a> TypeThatUse<'a>) as ForLt>::Of<'b>`
+/// is `TypeThatUse<'b>`.
+///
+/// You may also use a short-hand syntax which works similar to lifetime elision.
+/// The macro also accepts types that do not involve a lifetime at all.
+///
+/// ```
+/// # use kernel::types::ForLt;
+/// # fn expect_lt<F: ForLt>() {}
+/// # struct TypeThatUse<'a>(&'a ());
+/// # expect_lt::<
+/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse<'a>)`.
+/// # >();
+/// # expect_lt::<
+/// ForLt!(&u32) // Equivalent to `ForLt!(for<'a> &'a u32)`.
+/// # >();
+/// # expect_lt::<
+/// ForLt!(u32) // Equivalent to `ForLt!(for<'a> u32)`.
+/// # >();
+/// ```
+pub trait ForLt {
+    /// The type parameterized by the lifetime.
+    type Of<'a>: 'a;
+
+    /// Cast a reference to a shorter lifetime.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the lifetime shortening is sound for their use case,
+    /// e.g. because the `'long` reference originated from a `'short`-to-`'static` transmute
+    /// and this is the reverse leg of that round-trip.
+    #[inline(always)]
+    unsafe fn cast_ref_unchecked<'r, 'short: 'r, 'long: 'short>(
+        long: &'r Self::Of<'long>,
+    ) -> &'r Self::Of<'short> {
+        // SAFETY: Caller guarantees the lifetime shortening is sound.
+        unsafe { core::mem::transmute(long) }
+    }
+}
+pub use macros::ForLt;
+
+/// [`trait@ForLt`] subtrait for types that are covariant over their lifetime parameter.
 ///
-/// The lifetime involved must be covariant.
+/// Provides a safe [`cast_ref`](CovariantForLt::cast_ref) method for types that are proven to be
+/// covariant. The `CovariantForLt!` macro syntax is the same as `ForLt!`.
 ///
 /// # Macro
 ///
@@ -84,10 +141,7 @@
 /// # Safety
 ///
 /// `Self::Of<'a>` must be covariant over the lifetime `'a`.
-pub unsafe trait CovariantForLt {
-    /// The type parameterized by the lifetime.
-    type Of<'a>: 'a;
-
+pub unsafe trait CovariantForLt: ForLt {
     /// Cast a reference to a shorter lifetime.
     #[inline(always)]
     fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>) -> &'r Self::Of<'short> {
@@ -97,27 +151,44 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>) -> &'r Sel
 }
 pub use macros::CovariantForLt;
 
-/// Helper type for the `CovariantForLt!` macro.
+/// Helper type for the `ForLt!` macro.
 ///
-/// Must only be used by the `CovariantForLt!` macro.
+/// Must only be used by the `ForLt!` macro.
 ///
 /// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated by macro.
 ///
 /// `WF` is a type that the macro can use to assert some specific type is well-formed.
+#[doc(hidden)]
+pub struct ForLtImpl<T: ?Sized, WF>(PhantomData<(WF, T)>);
+
+/// Helper type for the `CovariantForLt!` macro.
+///
+/// Must only be used by the `CovariantForLt!` macro.
+///
+/// `T` and `WF` are the same as in [`ForLtImpl`].
 ///
 /// `N` is to provide the macro a place to emit arbitrary items, in case it needs to prove
 /// additional properties.
 #[doc(hidden)]
 pub struct CovariantForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(WF, T)>);
 
-// This is a helper trait for implementation `CovariantForLt` to be able to use HRTB.
+// This is a helper trait for implementation `ForLt` to be able to use HRTB.
 #[doc(hidden)]
 pub trait WithLt<'a> {
     type Of: 'a;
 }
 
-// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated when naming
-// `CovariantForLtImpl` and it will fail to evaluate if the type is not covariant.
-unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for CovariantForLtImpl<T, WF, 0> {
+impl<T: ?Sized + for<'a> WithLt<'a>, WF> ForLt for ForLtImpl<T, WF> {
+    type Of<'a> = <T as WithLt<'a>>::Of;
+}
+
+impl<T: ?Sized + for<'a> WithLt<'a>, WF, const N: usize> ForLt for CovariantForLtImpl<T, WF, N> {
     type Of<'a> = <T as WithLt<'a>>::Of;
 }
+
+// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated in the `N` const generic
+// and it will fail to evaluate if the type is not covariant.
+unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF, const N: usize> CovariantForLt
+    for CovariantForLtImpl<T, WF, N>
+{
+}
diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
index 3cb094d00548..ad9809563fab 100644
--- a/rust/macros/for_lt.rs
+++ b/rust/macros/for_lt.rs
@@ -176,8 +176,10 @@ fn prove(&mut self, ty: &'a Type) {
     }
 }
 
-pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
-    let (ty, lifetime) = match input {
+/// Resolve the higher-ranked type into a concrete `(ty, lifetime)` pair, expanding elided
+/// lifetimes as needed. Shared by both `for_lt` and `covariant_for_lt`.
+fn resolve_hrt(input: HigherRankedType) -> (Type, Lifetime) {
+    match input {
         HigherRankedType::Explicit { lifetime, ty, .. } => (ty, lifetime),
         HigherRankedType::Implicit { ty } => {
             // If there's no explicit `for<'a>` binder, inject a synthetic `'__elided` lifetime
@@ -188,7 +190,41 @@ pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
             };
             (ty.expand_elided_lifetime(&lifetime), lifetime)
         }
-    };
+    }
+}
+
+/// Produce the `'static`-substituted type for the WF check. Shared by both macros.
+fn ty_static(ty: &Type, lifetime: &Lifetime) -> Type {
+    ty.replace_lifetime(
+        lifetime,
+        &Lifetime {
+            apostrophe: Span::mixed_site(),
+            ident: format_ident!("static"),
+        },
+    )
+}
+
+pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
+    let (ty, lifetime) = resolve_hrt(input);
+
+    // Make sure that the type is wellformed when substituting lifetime with `'static`.
+    //
+    // Currently the Rust compiler doesn't check this, see the `ProveWf` documentation in
+    // `covariant_for_lt` below.
+    //
+    // We prefer to use this way of proving WF-ness as it can work when generics are involved.
+    let ty_static = ty_static(&ty, &lifetime);
+
+    quote!(
+        ::kernel::types::for_lt::ForLtImpl::<
+            dyn for<#lifetime> ::kernel::types::for_lt::WithLt<#lifetime, Of = #ty>,
+            #ty_static,
+        >
+    )
+}
+
+pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
+    let (ty, lifetime) = resolve_hrt(input);
 
     let mut prover = Prover(&lifetime, Vec::new());
     prover.prove(&ty);
@@ -226,13 +262,7 @@ fn #cov_proof_name<'__short, '__long: '__short>(
     // Currently the Rust compiler doesn't check this, see the above `ProveWf` documentation.
     //
     // We prefer to use this way of proving WF-ness as it can work when generics are involved.
-    let ty_static = ty.replace_lifetime(
-        &lifetime,
-        &Lifetime {
-            apostrophe: Span::mixed_site(),
-            ident: format_ident!("static"),
-        },
-    );
+    let ty_static = ty_static(&ty, &lifetime);
 
     quote!(
         ::kernel::types::for_lt::CovariantForLtImpl::<
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2167cb270928..e970769609f3 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -491,11 +491,28 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
         .into()
 }
 
-/// Obtain a type that implements [`CovariantForLt`] for the given higher-ranked type.
+/// Obtain a type that implements [`ForLt`] for the given higher-ranked type.
+///
+/// Please refer to the documentation of the [`ForLt`] trait.
+///
+/// [`ForLt`]: trait.ForLt.html
+#[proc_macro]
+#[allow(non_snake_case)]
+pub fn ForLt(input: TokenStream) -> TokenStream {
+    for_lt::for_lt(parse_macro_input!(input)).into()
+}
+
+/// Obtain a type that implements [`CovariantForLt`] (and [`ForLt`]) for the given higher-ranked
+/// type.
+///
+/// Unlike [`ForLt!`], this macro additionally proves that the type is covariant over the lifetime,
+/// providing a safe [`CovariantForLt::cast_ref`] method.
 ///
 /// Please refer to the documentation of the [`CovariantForLt`] trait.
 ///
 /// [`CovariantForLt`]: trait.CovariantForLt.html
+/// [`CovariantForLt::cast_ref`]: trait.CovariantForLt.html#method.cast_ref
+/// [`ForLt`]: trait.ForLt.html
 #[proc_macro]
 #[allow(non_snake_case)]
 pub fn CovariantForLt(input: TokenStream) -> TokenStream {
-- 
2.54.0

