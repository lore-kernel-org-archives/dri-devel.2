Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE5606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=P/DAG6bk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971C011258A;
	Thu, 26 Nov 2026 16:05:38 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704D5112589
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795709111; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V1cnK3u/wZsIO0U75FP3Q69UjKJCs3UoCJLYh3m39VJubUpqxKm9LGLXt926mN+4bT0UHRC6nW6zAkDDbmyiTfbPuqzw5ocEpowpsidxRwZXs7dxaDtwiKYuy7bcQTmoIdqr+1MPjmObhCW904x9XVbZ3XggmgW3UX2Lp/dG9Og=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795709111;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uQX/ag9XQcgzQ4dlIGGVtSvLlM5mYm5ubhZSsc5HGdg=; 
 b=CaXn1l0ez3KO3ZvVwF+AC14TigplRVJnLgi9sFwj89Z1vlfeLSU+VRcyrw8tNl2ET0hERYQ+8wW3x9iUSjyEU56rsG5Rx4d9Dn6Z1UqxutZCX4wl63rZjw4Wu2cJOTj9aumGQVVrnZnXq15RQhgqpi3BcTZRNrMOF6S4067YdKw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=P/DAG6bk4Idb74gYVIXERQUYL4/ZgONhgbHs9KhM6ZDN9wNn1KD8TxnhpYTpH5Rny5IfloVsuNPW7eO7LbkA7pqSqFF+3RAWwp+vpI9qKll/PsCBxrt6K8HulR2QCB76hHfkf0Wh6XGsiOpd6nAU9lDfpUVOe40NRELVOIz1QhI=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=uQX/ag9XQcgzQ4dlIGGVtSvLlM5mYm5ubhZSsc5HGdg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795709109706328.90004797539507; 
 Thu, 26 Nov 2026 08:05:09 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 26 Nov 2026 13:04:32 -0300
Subject: [PATCH 5/7] rust: reset: add SharedResetControl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-b4-rust-reset-v1-5-9c4c3d029080@collabora.com>
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

A reset line can be shared between devices. The reset core then counts
the deasserts on the line, and only the first deassert and the last
assert act on it.

Add SharedResetControl for such lines, with get() and get_optional().
It has two states, Unknown and Deasserted, which correspond to Disabled
and Enabled of Regulator<T>. An assert returns it to Unknown, since
other users may keep the line deasserted.

Like ExclusiveResetControl, it borrows the bound device it was obtained
from, which ties it to the binding as devm_reset_control_get_shared()
does in C.

Nothing uses SharedResetControl yet.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/reset.c |  13 ++++
 rust/kernel/reset.rs | 206 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+)

diff --git a/rust/helpers/reset.c b/rust/helpers/reset.c
index 435f2c7c815d..9c106d8b6de1 100644
--- a/rust/helpers/reset.c
+++ b/rust/helpers/reset.c
@@ -15,6 +15,19 @@ rust_helper_reset_control_get_optional_exclusive(struct device *dev,
 	return reset_control_get_optional_exclusive(dev, id);
 }
 
+__rust_helper struct reset_control *
+rust_helper_reset_control_get_shared(struct device *dev, const char *id)
+{
+	return reset_control_get_shared(dev, id);
+}
+
+__rust_helper struct reset_control *
+rust_helper_reset_control_get_optional_shared(struct device *dev,
+					      const char *id)
+{
+	return reset_control_get_optional_shared(dev, id);
+}
+
 #ifndef CONFIG_RESET_CONTROLLER
 __rust_helper struct reset_control *
 rust_helper_fwnode_reset_control_array_get(struct fwnode_handle *fwnode,
diff --git a/rust/kernel/reset.rs b/rust/kernel/reset.rs
index 3bbd226825d8..4d241ec6e549 100644
--- a/rust/kernel/reset.rs
+++ b/rust/kernel/reset.rs
@@ -16,6 +16,9 @@
 //! time, with [`ExclusiveResetControl::assert_guard`]. The [`AssertedGuard`] that it returns
 //! deasserts the line when dropped, and the control stays in the [`Unknown`] state.
 //!
+//! If the reset line is shared with other devices, the driver asks for a [`SharedResetControl`]
+//! instead.
+//!
 //! C header: [`include/linux/reset.h`](srctree/include/linux/reset.h)
 //!
 //! See [Reset controller API](https://docs.kernel.org/driver-api/reset.html) for more information.
@@ -67,6 +70,9 @@ pub trait ResetState: private::Sealed {
 ///
 /// Dropping a reset control in this state asserts the line. An error from that assert is
 /// discarded.
+///
+/// For a [`SharedResetControl`], the line may still be deasserted after that assert, as described
+/// in [`SharedResetControl::assert`].
 pub struct Deasserted;
 
 impl ResetState for Unknown {
@@ -81,6 +87,15 @@ impl ResetState for Deasserted {
     const ASSERT_ON_DROP: bool = true;
 }
 
+/// A trait representing the states a [`SharedResetControl`] can be in.
+///
+/// [`Asserted`] is not one of them, since the line may still be deasserted after a
+/// [`SharedResetControl`] is asserted.
+pub trait SharedResetState: ResetState {}
+
+impl SharedResetState for Unknown {}
+impl SharedResetState for Deasserted {}
+
 /// An error that can occur when trying to move a reset control between states.
 pub struct Error<T> {
     /// The error that occurred.
@@ -505,3 +520,194 @@ fn drop(&mut self) {
         unsafe { bindings::reset_control_deassert(self.reset.inner) };
     }
 }
+
+/// A shared reset control of a device.
+///
+/// Shared means that other devices may use the same reset line. The deasserts on the line are
+/// counted, and only the first deassert and the last assert act on it. A [`SharedResetControl`]
+/// can only be asserted after it was deasserted, as the C API requires.
+///
+/// A reset line cannot be held by a [`SharedResetControl`] and by an [`ExclusiveResetControl`] at
+/// the same time.
+///
+/// The reset control is released when the [`SharedResetControl`] is dropped. The lifetime `'a` is
+/// that of the reference to the bound device it was obtained from, so a [`SharedResetControl`]
+/// cannot outlive the binding of that device to its driver.
+///
+/// # Examples
+///
+/// Keeping a shared reset line deasserted:
+///
+/// ```
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     reset::{
+///         Deasserted,
+///         SharedResetControl, //
+///     },
+/// };
+///
+/// struct Data<'a> {
+///     // Dropping `Data` asserts the reset control again.
+///     reset: SharedResetControl<'a, Deasserted>,
+/// }
+///
+/// fn probe<'a>(dev: &'a Device<Bound>) -> Result<Data<'a>> {
+///     let reset = SharedResetControl::get(dev, None)?.deassert()?;
+///
+///     Ok(Data { reset })
+/// }
+/// ```
+///
+/// # Invariants
+///
+/// `inner` is a pointer obtained from a successful call to one of the following:
+///
+/// - [`reset_control_get_shared()`]
+/// - [`reset_control_get_optional_shared()`]
+///
+/// It is treated as an opaque token that may only be accessed using C API methods (e.g., it may be
+/// `NULL` if the C API returns `NULL`). The [`SharedResetControl`] owns the reference that the
+/// call returned.
+///
+/// [`reset_control_get_shared()`]:
+/// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_shared
+/// [`reset_control_get_optional_shared()`]:
+/// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_optional_shared
+pub struct SharedResetControl<'a, State: SharedResetState> {
+    inner: *mut bindings::reset_control,
+    _phantom: PhantomData<(&'a Device<Bound>, State)>,
+}
+
+// SAFETY: A reset control can be used and released from any thread.
+unsafe impl<State: SharedResetState> Send for SharedResetControl<'_, State> {}
+
+// SAFETY: A `SharedResetControl` has no `&self` methods, so references to it can be shared between
+// threads.
+unsafe impl<State: SharedResetState> Sync for SharedResetControl<'_, State> {}
+
+impl<'a> SharedResetControl<'a, Unknown> {
+    /// Gets the reset line `name` of `dev`, or its first reset line if `name` is `None`.
+    ///
+    /// Equivalent to the kernel's [`reset_control_get_shared()`].
+    ///
+    /// [`reset_control_get_shared()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_shared
+    #[inline]
+    pub fn get(dev: &'a Device<Bound>, name: Option<&CStr>) -> Result<Self> {
+        let id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: `dev` is a valid device, and `id` is `NULL` or a valid C string.
+        let inner = unsafe { bindings::reset_control_get_shared(dev.as_raw(), id) };
+        let inner = from_err_ptr(inner)?;
+
+        // INVARIANT: `inner` comes from a successful call to `reset_control_get_shared()`, and the
+        // returned value owns the reference from that call.
+        Ok(Self {
+            inner,
+            _phantom: PhantomData,
+        })
+    }
+
+    /// Gets the reset line `name` of `dev`, if there is one.
+    ///
+    /// Behaves the same as [`Self::get`], except when the device has no such reset line or
+    /// `CONFIG_RESET_CONTROLLER` is disabled. In those cases, it returns a [`SharedResetControl`]
+    /// on which every operation succeeds and does nothing.
+    ///
+    /// Equivalent to the kernel's [`reset_control_get_optional_shared()`].
+    ///
+    /// [`reset_control_get_optional_shared()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_get_optional_shared
+    #[inline]
+    pub fn get_optional(dev: &'a Device<Bound>, name: Option<&CStr>) -> Result<Self> {
+        let id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: `dev` is a valid device, and `id` is `NULL` or a valid C string.
+        let inner = unsafe { bindings::reset_control_get_optional_shared(dev.as_raw(), id) };
+        let inner = from_err_ptr(inner)?;
+
+        // INVARIANT: `inner` comes from a successful call to
+        // `reset_control_get_optional_shared()`, and the returned value owns the reference from
+        // that call.
+        Ok(Self {
+            inner,
+            _phantom: PhantomData,
+        })
+    }
+
+    /// Deasserts the reset line and moves the [`SharedResetControl`] to the [`Deasserted`] state.
+    ///
+    /// Equivalent to the kernel's [`reset_control_deassert()`].
+    ///
+    /// [`reset_control_deassert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_deassert
+    #[inline]
+    pub fn deassert(self) -> Result<SharedResetControl<'a, Deasserted>, Error<Self>> {
+        // INVARIANT: The reference that `self` owns moves to the value that this returns.
+        let reset = ManuallyDrop::new(self);
+
+        // SAFETY: By the type invariants, `reset.inner` is a pointer that a C getter returned, and
+        // `reset` owns its reference.
+        to_result(unsafe { bindings::reset_control_deassert(reset.inner) })
+            .map(|()| SharedResetControl {
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
+impl<'a> SharedResetControl<'a, Deasserted> {
+    /// Asserts the reset line and moves the [`SharedResetControl`] to the [`Unknown`] state.
+    ///
+    /// The line may still be deasserted afterwards, for as long as other users keep it so.
+    ///
+    /// If this fails, the [`SharedResetControl`] is returned in the [`Unknown`] state as well.
+    ///
+    /// Equivalent to the kernel's [`reset_control_assert()`].
+    ///
+    /// [`reset_control_assert()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.reset_control_assert
+    #[inline]
+    pub fn assert(
+        self,
+    ) -> Result<SharedResetControl<'a, Unknown>, Error<SharedResetControl<'a, Unknown>>> {
+        // INVARIANT: The reference that `self` owns moves to `reset`.
+        let this = ManuallyDrop::new(self);
+        let reset = SharedResetControl {
+            inner: this.inner,
+            _phantom: PhantomData,
+        };
+
+        // An assert that fails may already have given the deassert back, so `reset` is `Unknown`
+        // in both cases.
+        //
+        // SAFETY: By the type invariants, `reset.inner` is a pointer that a C getter returned, and
+        // `reset` owns its reference.
+        match to_result(unsafe { bindings::reset_control_assert(reset.inner) }) {
+            Ok(()) => Ok(reset),
+            Err(error) => Err(Error { error, reset }),
+        }
+    }
+}
+
+impl<State: SharedResetState> Drop for SharedResetControl<'_, State> {
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

