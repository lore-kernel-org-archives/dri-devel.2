Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE3606A330
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ag+MIQZ+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98862112587;
	Thu, 26 Nov 2026 16:05:32 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E04112587
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795709093; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=e0PPR9psFoU1dGOUInC7OFW7vFNlJW46bYVVmQCagB3Tbd0OHDaKyd6iXz5EfFdr3YBJ6e2FcWrFzvUnycHZZ0nO5kNQUXjK5luHq30iliXxNpUy1O8PWb2jAuPo37orBDK8hyGJEQRGGxp7dFi/u28YOySyuePQeBSUEfoXhKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795709093;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oY+lb1T78FAmK20LxOfcLtD9nvohP0xsrFvv9vx9VXs=; 
 b=kk6tTdvsI72XRTpYoxm6mOgqC18okfje5UgntgQDi4bEqiWqUPke/MLmjAYyYu8JoiiYnjq5E1J5I1V3Q+5b3ZM5yBixqVReiwTPDvm8/JyiZWakRPbNE2MQiJR2l99QlyQfVio9p2YD/6hcCfo6/sjTbz453v+6YMbvAq/3/nE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Ag+MIQZ+xlB1KgXr3yMeTkX6IaNApndDF2VeWD9XuBEX1KP1HIOZvcsa2HGTuCcEYsSepa6JY/NbCakS3NlQgIyem3w8RXXCoGD5kfYDthA5js/LgxwglDCyNN0lA5TpMaq0P0oj5wncz7RlJFK27nUQRt3GtGJih5Y0DuunBw0=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=oY+lb1T78FAmK20LxOfcLtD9nvohP0xsrFvv9vx9VXs=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795709090334246.02620113942362; 
 Thu, 26 Nov 2026 08:04:50 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 26 Nov 2026 13:04:29 -0300
Subject: [PATCH 2/7] rust: reset: add ExclusiveResetControl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-b4-rust-reset-v1-2-9c4c3d029080@collabora.com>
References: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
In-Reply-To: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an abstraction for exclusive reset controls, so that Rust drivers
can assert and deassert the reset lines of their device.

It follows the type-state pattern of the regulator abstraction. It
borrows the bound device it was obtained from, which ties it to the
binding as devm_reset_control_get_exclusive() does in C.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 MAINTAINERS          |   1 +
 rust/kernel/lib.rs   |   1 +
 rust/kernel/reset.rs | 333 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8bcacb7d8ef..e427742252d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24064,6 +24064,7 @@ F:	include/linux/reset-controller.h
 F:	include/linux/reset.h
 F:	include/linux/reset/
 F:	rust/helpers/reset.c
+F:	rust/kernel/reset.rs
 K:	\b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
 
 RESTARTABLE SEQUENCES SUPPORT
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..c0199ec055b8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -125,6 +125,7 @@
 pub mod ratelimit;
 pub mod rbtree;
 pub mod regulator;
+pub mod reset;
 pub mod revocable;
 pub mod safety;
 pub mod scatterlist;
diff --git a/rust/kernel/reset.rs b/rust/kernel/reset.rs
new file mode 100644
index 000000000000..396f1e19ee2e
--- /dev/null
+++ b/rust/kernel/reset.rs
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Reset control abstractions, the consumer side of the reset controller API.
+//!
+//! A reset controller controls a number of reset lines. A device is held in reset while its reset
+//! line is asserted.
+//!
+//! A driver gets an [`ExclusiveResetControl`] for a reset line of its device, and uses it to
+//! assert and deassert the line. A new control is in the [`Unknown`] state. Its `assert()` and
+//! `deassert()` methods, when they succeed, move it to the [`Asserted`] or [`Deasserted`] state.
+//!
+//! C header: [`include/linux/reset.h`](srctree/include/linux/reset.h)
+//!
+//! See [Reset controller API](https://docs.kernel.org/driver-api/reset.html) for more information.
+
+use crate::{
+    bindings,
+    device::{
+        Bound,
+        Device, //
+    },
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
+    prelude::*, //
+};
+
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ptr, //
+};
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Unknown {}
+    impl Sealed for super::Asserted {}
+    impl Sealed for super::Deasserted {}
+}
+
+/// A trait representing the different states a reset control can be in.
+pub trait ResetState: private::Sealed {
+    /// Whether dropping a reset control in this state asserts the line.
+    const ASSERT_ON_DROP: bool;
+}
+
+/// A state that records nothing about the reset line, which may be asserted or deasserted.
+///
+/// Dropping a reset control in this state does not change the line.
+pub struct Unknown;
+
+/// A state where the last successful operation on the reset control was an assert.
+///
+/// Dropping a reset control in this state does not change the line.
+pub struct Asserted;
+
+/// A state where the last successful operation on the reset control was a deassert.
+///
+/// Dropping a reset control in this state asserts the line. An error from that assert is
+/// discarded.
+pub struct Deasserted;
+
+impl ResetState for Unknown {
+    const ASSERT_ON_DROP: bool = false;
+}
+
+impl ResetState for Asserted {
+    const ASSERT_ON_DROP: bool = false;
+}
+
+impl ResetState for Deasserted {
+    const ASSERT_ON_DROP: bool = true;
+}
+
+/// An error that can occur when trying to move a reset control between states.
+pub struct Error<T> {
+    /// The error that occurred.
+    pub error: kernel::error::Error,
+
+    /// The reset control the operation failed on.
+    pub reset: T,
+}
+
+impl<T> From<Error<T>> for kernel::error::Error {
+    /// Drops the reset control and keeps the error, so that `?` works on the state transitions.
+    #[inline]
+    fn from(err: Error<T>) -> Self {
+        err.error
+    }
+}
+
+/// An exclusive reset control of a device.
+///
+/// Exclusive means that the driver has direct control over the reset line. A reset line can be
+/// held by one [`ExclusiveResetControl`] at a time.
+///
+/// A reset control obtained with [`ExclusiveResetControl::get_optional`] may have no reset line,
+/// in which case every operation on it succeeds and does nothing.
+///
+/// The reset control is released when the [`ExclusiveResetControl`] is dropped. The lifetime `'a`
+/// is that of the reference to the bound device it was obtained from, so an
+/// [`ExclusiveResetControl`] cannot outlive the binding of that device to its driver.
+///
+/// # Examples
+///
+/// Holding a device in reset while its clocks are turned on, then releasing it:
+///
+/// ```
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     reset::{
+///         Deasserted,
+///         ExclusiveResetControl, //
+///     },
+/// };
+///
+/// struct Data<'a> {
+///     // Dropping `Data` asserts the line again.
+///     reset: ExclusiveResetControl<'a, Deasserted>,
+/// }
+///
+/// fn probe<'a>(dev: &'a Device<Bound>) -> Result<Data<'a>> {
+///     // Put the device in reset.
+///     let reset = ExclusiveResetControl::get(dev, None)?.assert()?;
+///
+///     // For example, turn on the clocks of the device here, while it is held in reset.
+///
+///     // Release the device from reset.
+///     let reset = reset.deassert()?;
+///
+///     Ok(Data { reset })
+/// }
+/// ```
+///
+/// # Invariants
+///
+/// `inner` is a pointer obtained from a successful call to one of the following:
+///
+/// - [`reset_control_get_exclusive()`]
+/// - [`reset_control_get_optional_exclusive()`]
+///
+/// It is treated as an opaque token that may only be accessed using C API methods (e.g., it may be
+/// `NULL` if the C API returns `NULL`). The [`ExclusiveResetControl`] owns the reference that the
+/// call returned.
+///
+/// [`reset_control_get_exclusive()`]:
+/// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_exclusive
+/// [`reset_control_get_optional_exclusive()`]:
+/// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_optional_exclusive
+pub struct ExclusiveResetControl<'a, State: ResetState> {
+    inner: *mut bindings::reset_control,
+    _phantom: PhantomData<(&'a Device<Bound>, State)>,
+}
+
+// SAFETY: A reset control can be used and released from any thread.
+unsafe impl<State: ResetState> Send for ExclusiveResetControl<'_, State> {}
+
+// SAFETY: An `ExclusiveResetControl` has no `&self` methods, so references to it can be shared
+// between threads.
+unsafe impl<State: ResetState> Sync for ExclusiveResetControl<'_, State> {}
+
+impl<'a> ExclusiveResetControl<'a, Unknown> {
+    /// Gets the reset line `name` of `dev`, or its first reset line if `name` is `None`.
+    ///
+    /// Equivalent to the kernel's [`reset_control_get_exclusive()`].
+    ///
+    /// [`reset_control_get_exclusive()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_exclusive
+    #[inline]
+    pub fn get(dev: &'a Device<Bound>, name: Option<&CStr>) -> Result<Self> {
+        let id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: `dev` is a valid device, and `id` is `NULL` or a valid C string.
+        let inner = unsafe { bindings::reset_control_get_exclusive(dev.as_raw(), id) };
+        let inner = from_err_ptr(inner)?;
+
+        // INVARIANT: `inner` comes from a successful call to `reset_control_get_exclusive()`, and
+        // the returned value owns the reference from that call.
+        Ok(Self {
+            inner,
+            _phantom: PhantomData,
+        })
+    }
+
+    /// Gets the reset line `name` of `dev`, if there is one.
+    ///
+    /// Behaves the same as [`Self::get`], except when the device has no such reset line or
+    /// `CONFIG_RESET_CONTROLLER` is disabled. In those cases, it returns an
+    /// [`ExclusiveResetControl`] on which every operation succeeds and does nothing.
+    ///
+    /// Equivalent to the kernel's [`reset_control_get_optional_exclusive()`].
+    ///
+    /// [`reset_control_get_optional_exclusive()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_optional_exclusive
+    #[inline]
+    pub fn get_optional(dev: &'a Device<Bound>, name: Option<&CStr>) -> Result<Self> {
+        let id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: `dev` is a valid device, and `id` is `NULL` or a valid C string.
+        let inner = unsafe { bindings::reset_control_get_optional_exclusive(dev.as_raw(), id) };
+        let inner = from_err_ptr(inner)?;
+
+        // INVARIANT: `inner` comes from a successful call to
+        // `reset_control_get_optional_exclusive()`, and the returned value owns the reference from
+        // that call.
+        Ok(Self {
+            inner,
+            _phantom: PhantomData,
+        })
+    }
+}
+
+impl<'a, State: ResetState> ExclusiveResetControl<'a, State> {
+    /// Asserts the reset line and moves the [`ExclusiveResetControl`] to the [`Asserted`] state.
+    ///
+    /// Equivalent to the kernel's [`reset_control_assert()`].
+    ///
+    /// [`reset_control_assert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_assert
+    #[inline]
+    fn assert_internal(self) -> Result<ExclusiveResetControl<'a, Asserted>, Error<Self>> {
+        // INVARIANT: The reference that `self` owns moves to the value that this returns.
+        let reset = ManuallyDrop::new(self);
+
+        // SAFETY: By the type invariants, `reset.inner` is a pointer that a C getter returned, and
+        // `reset` owns its reference.
+        to_result(unsafe { bindings::reset_control_assert(reset.inner) })
+            .map(|()| ExclusiveResetControl {
+                inner: reset.inner,
+                _phantom: PhantomData,
+            })
+            .map_err(|error| Error {
+                error,
+                reset: ManuallyDrop::into_inner(reset),
+            })
+    }
+
+    /// Deasserts the reset line and moves the [`ExclusiveResetControl`] to the [`Deasserted`]
+    /// state.
+    ///
+    /// Equivalent to the kernel's [`reset_control_deassert()`].
+    ///
+    /// [`reset_control_deassert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_deassert
+    #[inline]
+    fn deassert_internal(self) -> Result<ExclusiveResetControl<'a, Deasserted>, Error<Self>> {
+        // INVARIANT: The reference that `self` owns moves to the value that this returns.
+        let reset = ManuallyDrop::new(self);
+
+        // SAFETY: By the type invariants, `reset.inner` is a pointer that a C getter returned, and
+        // `reset` owns its reference.
+        to_result(unsafe { bindings::reset_control_deassert(reset.inner) })
+            .map(|()| ExclusiveResetControl {
+                inner: reset.inner,
+                _phantom: PhantomData,
+            })
+            .map_err(|error| Error {
+                error,
+                reset: ManuallyDrop::into_inner(reset),
+            })
+    }
+}
+
+impl<'a> ExclusiveResetControl<'a, Unknown> {
+    /// Asserts the reset line and moves the [`ExclusiveResetControl`] to the [`Asserted`] state.
+    ///
+    /// Equivalent to the kernel's [`reset_control_assert()`].
+    ///
+    /// [`reset_control_assert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_assert
+    #[inline]
+    pub fn assert(self) -> Result<ExclusiveResetControl<'a, Asserted>, Error<Self>> {
+        self.assert_internal()
+    }
+
+    /// Deasserts the reset line and moves the [`ExclusiveResetControl`] to the [`Deasserted`]
+    /// state.
+    ///
+    /// Equivalent to the kernel's [`reset_control_deassert()`].
+    ///
+    /// [`reset_control_deassert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_deassert
+    #[inline]
+    pub fn deassert(self) -> Result<ExclusiveResetControl<'a, Deasserted>, Error<Self>> {
+        self.deassert_internal()
+    }
+}
+
+impl<'a> ExclusiveResetControl<'a, Asserted> {
+    /// Deasserts the reset line and moves the [`ExclusiveResetControl`] to the [`Deasserted`]
+    /// state.
+    ///
+    /// Equivalent to the kernel's [`reset_control_deassert()`].
+    ///
+    /// [`reset_control_deassert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_deassert
+    #[inline]
+    pub fn deassert(self) -> Result<ExclusiveResetControl<'a, Deasserted>, Error<Self>> {
+        self.deassert_internal()
+    }
+}
+
+impl<'a> ExclusiveResetControl<'a, Deasserted> {
+    /// Asserts the reset line and moves the [`ExclusiveResetControl`] to the [`Asserted`] state.
+    ///
+    /// Equivalent to the kernel's [`reset_control_assert()`].
+    ///
+    /// [`reset_control_assert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_assert
+    #[inline]
+    pub fn assert(self) -> Result<ExclusiveResetControl<'a, Asserted>, Error<Self>> {
+        self.assert_internal()
+    }
+}
+
+impl<State: ResetState> Drop for ExclusiveResetControl<'_, State> {
+    fn drop(&mut self) {
+        if State::ASSERT_ON_DROP {
+            // SAFETY: By the type invariants, `self.inner` is a pointer that a C getter returned,
+            // and `self` owns its reference.
+            unsafe { bindings::reset_control_assert(self.inner) };
+        }
+
+        // SAFETY: By the type invariants, `self` owns the reference that the C getter returned,
+        // so it is safe to relinquish it now.
+        unsafe { bindings::reset_control_put(self.inner) };
+    }
+}

-- 
2.56.0

