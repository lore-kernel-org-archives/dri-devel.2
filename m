Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA1C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F05410F6F2;
	Fri, 26 Jun 2026 18:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E8MlqPeN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F410910F6F2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 18:36:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7870860A61;
 Fri, 26 Jun 2026 18:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A4C1F00A3D;
 Fri, 26 Jun 2026 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782499016;
 bh=RPb8YdizCdHRgJNFdlPXuuKMRX6FlYypJFHJ2cj7UxM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E8MlqPeNZ/Le1kKCl1go68pYmh3IpVV6W8xZt/1QN7yjK8oSwguElD1PerX4xhEYe
 GrzGf5Ou9RmRK3Cec/sj8nNgW52MK++bF7V3hxbb/AR2f3jQ+zLMt2QsiqRXkvRk29
 FViDndApRuMe11hz2R7oihGfOoRtJI9JA8sTJoXb8odJ2qtPKVpySeTEVg99NdzAu1
 Tn6YVdMBnCg1W1tE9dYrMOgP2S/JeSqNUzfdFi0WMdxCDZYhU6QoRFwp1XNgVzsJyK
 QhU9Zx/UGCeo72h0D3/CKqRNRuXfEYsoLRBMdH6CKFalAsje4tJxxaz9HT5oKxkzwf
 bWxngWbHAeeYw==
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
Subject: [PATCH v4 3/7] rust: auxiliary: add registration_data_with() for
 ForLt types
Date: Fri, 26 Jun 2026 20:36:10 +0200
Message-ID: <20260626183630.2585057-4-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626183630.2585057-1-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
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

Add registration_data_with() taking a for<'a> closure that receives
Pin<&'a F::Of<'a>>, which works with any ForLt type. Taking a for<'a>
closure rather than returning a direct reference prevents callers from
choosing a concrete lifetime for the data, which is required for
soundness with non-covariant ForLt types.

Extract the common null-check, TypeId-check and KBox-borrow logic into a
private registration_data_pinned() helper shared by both
registration_data_with() and the existing registration_data().

Relax Registration's bound from CovariantForLt to ForLt so that
non-covariant types can be registered.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 93 +++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 40a0af74a8e5..19a488700bb9 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -21,6 +21,7 @@
     prelude::*,
     types::{
         CovariantForLt,
+        ForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -270,18 +271,15 @@ pub fn parent(&self) -> &device::Device<device::Bound> {
         unsafe { parent.as_bound() }
     }
 
-    /// Returns a pinned reference to the registration data set by the registering (parent) driver.
+    /// Returns the stored registration data as a pinned reference.
     ///
-    /// `F` is the [`CovariantForLt`](trait@CovariantForLt) encoding of the data type. The returned
-    /// reference has its lifetime shortened from `'static` to `&self`'s borrow lifetime via
-    /// [`CovariantForLt::cast_ref`].
+    /// Performs null and [`TypeId`] checks, then borrows the stored [`KBox`].
     ///
-    /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
-    /// [`Registration::new()`].
+    /// # Safety
     ///
-    /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
-    /// registered by a C driver.
-    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+    /// Callers must ensure that the lifetime shortening from the original `'static` storage to
+    /// `'_` is sound, e.g. via an HRTB closure or [`CovariantForLt`] guarantee.
+    unsafe fn registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
         // SAFETY: By the type invariant, `self.as_raw()` is a valid `struct auxiliary_device`.
         let ptr = unsafe { (*self.as_raw()).registration_data_rust };
         if ptr.is_null() {
@@ -300,17 +298,59 @@ pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::O
             return Err(EINVAL);
         }
 
-        // SAFETY: The `TypeId` check above confirms that the stored type matches
-        // `F::Of<'static>`; `ptr` remains valid until `Registration::drop()` calls
-        // `from_foreign()`.
-        let wrapper = unsafe { Pin::<KBox<RegistrationData<F::Of<'static>>>>::borrow(ptr) };
+        // SAFETY: The `TypeId` check above confirms that the stored type matches `F`'s
+        // encoding; lifetimes are erased at runtime, so borrowing as `F::Of<'_>` is
+        // layout-compatible with the stored `F::Of<'static>`. `ptr` remains valid until
+        // `Registration::drop()` calls `from_foreign()`.
+        let wrapper = unsafe { Pin::<KBox<RegistrationData<F::Of<'_>>>>::borrow(ptr) };
 
         // SAFETY: `data` is a structurally pinned field of `RegistrationData`.
-        let pinned: Pin<&F::Of<'_>> = unsafe { wrapper.map_unchecked(|w| &w.data) };
+        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
+    }
 
-        // SAFETY: The data was pinned when stored; `cast_ref` only shortens
-        // the lifetime, so the pinning guarantee is preserved.
-        Ok(unsafe { Pin::new_unchecked(F::cast_ref(pinned.get_ref())) })
+    /// Access the registration data set by the registering (parent) driver through a closure.
+    ///
+    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The closure receives a pinned
+    /// reference to the registration data.
+    ///
+    /// For covariant types that implement [`trait@CovariantForLt`], prefer
+    /// [`registration_data`](Self::registration_data) which returns a direct reference.
+    ///
+    /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
+    /// [`Registration::new()`].
+    ///
+    /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
+    /// registered by a C driver.
+    #[inline]
+    pub fn registration_data_with<F: ForLt + 'static, R>(
+        &self,
+        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
+    ) -> Result<R> {
+        // SAFETY: The HRTB closure prevents the caller from smuggling in references with a
+        // concrete short lifetime, making the round-trip from `'static` sound regardless of
+        // variance.
+        let pinned = unsafe { self.registration_data_pinned::<F>()? };
+
+        Ok(f(pinned))
+    }
+
+    /// Returns a pinned reference to the registration data set by the registering (parent) driver.
+    ///
+    /// This method is only available when `F` implements [`trait@CovariantForLt`], which guarantees
+    /// that the lifetime shortening is sound.
+    ///
+    /// For non-covariant types, use the closure-based [`Self::registration_data_with`].
+    ///
+    /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
+    /// [`Registration::new()`].
+    ///
+    /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
+    /// registered by a C driver.
+    #[inline]
+    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        // SAFETY: `CovariantForLt` guarantees covariance, which makes the lifetime shortening
+        // from `'static` to `'_` performed by `registration_data_pinned` sound.
+        unsafe { self.registration_data_pinned::<F>() }
     }
 }
 
@@ -399,22 +439,23 @@ struct RegistrationData<T> {
 /// This type represents the registration of a [`struct auxiliary_device`]. When its parent device
 /// is unbound, the corresponding auxiliary device will be unregistered from the system.
 ///
-/// The type parameter `F` is a [`CovariantForLt`](trait@CovariantForLt) encoding of the
-/// registration data type. For non-lifetime-parameterized types, use
-/// [`CovariantForLt!(T)`](macro@CovariantForLt).
-/// The data can be accessed by the auxiliary driver through [`Device::registration_data()`].
+/// The type parameter `F` is a [`ForLt`](trait@ForLt) encoding of the registration
+/// data type. For non-lifetime-parameterized types, use [`ForLt!(T)`](macro@ForLt).
+///
+/// The data can be accessed by the auxiliary driver through [`Device::registration_data()`] and
+/// [`Device::registration_data_with()`].
 ///
 /// # Invariants
 ///
 /// `self.adev` always holds a valid pointer to an initialized and registered
 /// [`struct auxiliary_device`] whose `registration_data_rust` field points to a
 /// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
-pub struct Registration<'a, F: CovariantForLt + 'static> {
+pub struct Registration<'a, F: ForLt + 'static> {
     adev: NonNull<bindings::auxiliary_device>,
     _phantom: PhantomData<F::Of<'a>>,
 }
 
-impl<'a, F: CovariantForLt> Registration<'a, F>
+impl<'a, F: ForLt> Registration<'a, F>
 where
     for<'b> F::Of<'b>: Send + Sync,
 {
@@ -526,7 +567,7 @@ pub fn new<E>(
     }
 }
 
-impl<F: CovariantForLt> Drop for Registration<'_, F> {
+impl<F: ForLt> Drop for Registration<'_, F> {
     fn drop(&mut self) {
         // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
@@ -548,7 +589,7 @@ fn drop(&mut self) {
 }
 
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
-unsafe impl<F: CovariantForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
+unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
 
 // SAFETY: `Registration` does not expose any methods or fields that need synchronization.
-unsafe impl<F: CovariantForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
+unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
-- 
2.54.0

