Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD34606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=LAipYRBo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F12112599;
	Thu, 26 Nov 2026 16:05:51 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CF5112590
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795709101; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AiT5EmWlElrYLYk4iA8AV/ClU0lpCCO3W0jqqSll0qkehbpvfy4LMs1bN97LmA9vzQ0sYgjVPNofAqHDK+iAtsF/W5l6iIFi3BmWuVtUmF83LutTIXYzS6FqeY8kj3HnL/uLXP9oNiLjStY4CgjoFMtHpx/Vchh4eATtF4P+OVg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795709101;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hH+O4poUD8IDco5i9Wi+HTMOJ8P6lijm/qP4q5nqc9w=; 
 b=DaFJmv49hw56BSuQftShnOoGawnGlfAGWj035DC8I94CmO0k3JQGKU72t6UJKqZeNZ1pnKjvDSDjAFeTlvjzs4UXx93GpMBqU18EVOlNhiXmSqeViFJmrcZXg7NOwhpCGUS52j6dzZpH6jLZxFe9cdrwQxfiwWiqojLHpM+caS4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=LAipYRBoa/XmOVpR1kxgt0DijMU5sZ8B3sU+J6dd1WnBF8QcW3x+PBjpMYoET63VlaU2nJSXaYDheDu2CjUhCRWuWJR22qmLxRyAo8s8yFxigpvamcqP0RbK+k77kWkIEcdvz5nx9itaKj2ChHyP8TTwwgozKDLT+UgGSynBYjo=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=hH+O4poUD8IDco5i9Wi+HTMOJ8P6lijm/qP4q5nqc9w=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179570909891318.635666966732288; 
 Thu, 26 Nov 2026 08:04:58 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 26 Nov 2026 13:04:30 -0300
Subject: [PATCH 3/7] rust: reset: add ExclusiveResetControl::get_array()
 and get_array_optional()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-b4-rust-reset-v1-3-9c4c3d029080@collabora.com>
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

Add ExclusiveResetControl::get_array() and get_array_optional(), which
get all the reset lines in the resets property of a device as a single
reset control. This is for drivers that assert and deassert all the
reset lines of their device together.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/reset.c |  7 ++++
 rust/kernel/reset.rs | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/reset.c b/rust/helpers/reset.c
index ea2e6f09b7d5..435f2c7c815d 100644
--- a/rust/helpers/reset.c
+++ b/rust/helpers/reset.c
@@ -16,6 +16,13 @@ rust_helper_reset_control_get_optional_exclusive(struct device *dev,
 }
 
 #ifndef CONFIG_RESET_CONTROLLER
+__rust_helper struct reset_control *
+rust_helper_fwnode_reset_control_array_get(struct fwnode_handle *fwnode,
+					   enum reset_control_flags flags)
+{
+	return fwnode_reset_control_array_get(fwnode, flags);
+}
+
 __rust_helper void rust_helper_reset_control_put(struct reset_control *rstc)
 {
 	reset_control_put(rstc);
diff --git a/rust/kernel/reset.rs b/rust/kernel/reset.rs
index 396f1e19ee2e..7ca83f2d6abf 100644
--- a/rust/kernel/reset.rs
+++ b/rust/kernel/reset.rs
@@ -9,6 +9,9 @@
 //! assert and deassert the line. A new control is in the [`Unknown`] state. Its `assert()` and
 //! `deassert()` methods, when they succeed, move it to the [`Asserted`] or [`Deasserted`] state.
 //!
+//! A driver can also get a single reset control for all the reset lines in the `resets`
+//! property of its device. Its operations then act on all of those lines.
+//!
 //! C header: [`include/linux/reset.h`](srctree/include/linux/reset.h)
 //!
 //! See [Reset controller API](https://docs.kernel.org/driver-api/reset.html) for more information.
@@ -96,8 +99,9 @@ fn from(err: Error<T>) -> Self {
 /// Exclusive means that the driver has direct control over the reset line. A reset line can be
 /// held by one [`ExclusiveResetControl`] at a time.
 ///
-/// A reset control obtained with [`ExclusiveResetControl::get_optional`] may have no reset line,
-/// in which case every operation on it succeeds and does nothing.
+/// A reset control obtained with [`ExclusiveResetControl::get_optional`] or
+/// [`ExclusiveResetControl::get_array_optional`] may have no reset line, in which case every
+/// operation on it succeeds and does nothing.
 ///
 /// The reset control is released when the [`ExclusiveResetControl`] is dropped. The lifetime `'a`
 /// is that of the reference to the bound device it was obtained from, so an
@@ -143,6 +147,8 @@ fn from(err: Error<T>) -> Self {
 ///
 /// - [`reset_control_get_exclusive()`]
 /// - [`reset_control_get_optional_exclusive()`]
+/// - `fwnode_reset_control_array_get()` with the `RESET_CONTROL_EXCLUSIVE` or
+///   `RESET_CONTROL_OPTIONAL_EXCLUSIVE` flag
 ///
 /// It is treated as an opaque token that may only be accessed using C API methods (e.g., it may be
 /// `NULL` if the C API returns `NULL`). The [`ExclusiveResetControl`] owns the reference that the
@@ -213,6 +219,92 @@ pub fn get_optional(dev: &'a Device<Bound>, name: Option<&CStr>) -> Result<Self>
             _phantom: PhantomData,
         })
     }
+
+    /// Gets the reset lines of `dev` as one [`ExclusiveResetControl`], as [`Self::get_array`] does
+    /// or, if `optional` is set, as [`Self::get_array_optional`] does.
+    fn get_array_internal(dev: &'a Device<Bound>, optional: bool) -> Result<Self> {
+        let flags = if optional {
+            bindings::reset_control_flags_RESET_CONTROL_OPTIONAL_EXCLUSIVE
+        } else {
+            bindings::reset_control_flags_RESET_CONTROL_EXCLUSIVE
+        };
+
+        let fwnode = dev
+            .fwnode()
+            .map_or(ptr::null_mut(), |fwnode| fwnode.as_raw());
+
+        // SAFETY: `fwnode` is the firmware node of `dev` or `NULL`, which
+        // `fwnode_reset_control_array_get()` checks for.
+        let inner = unsafe { bindings::fwnode_reset_control_array_get(fwnode, flags) };
+        let inner = from_err_ptr(inner)?;
+
+        // INVARIANT: `inner` comes from a successful call to `fwnode_reset_control_array_get()`
+        // with one of the two flags above, and the returned value owns the reference from that
+        // call.
+        Ok(Self {
+            inner,
+            _phantom: PhantomData,
+        })
+    }
+
+    /// Gets the reset lines listed in the `resets` property of `dev` as one
+    /// [`ExclusiveResetControl`].
+    ///
+    /// Its operations act on all the lines, in no guaranteed order. If one of them fails on a
+    /// line, the opposite operation is run on the lines it had already succeeded on, whatever
+    /// state they were in before. This includes operations that are done on drop. The caller only
+    /// gets the error from the line that failed, while errors from the opposite operation are
+    /// discarded.
+    ///
+    /// Equivalent to the kernel's `fwnode_reset_control_array_get()` on the firmware node of
+    /// `dev`, as `devm_reset_control_array_get_exclusive()` does.
+    ///
+    /// # Examples
+    ///
+    /// Keeping all the reset lines of a device deasserted:
+    ///
+    /// ```
+    /// use kernel::{
+    ///     device::{
+    ///         Bound,
+    ///         Device, //
+    ///     },
+    ///     reset::{
+    ///         Deasserted,
+    ///         ExclusiveResetControl, //
+    ///     },
+    /// };
+    ///
+    /// struct Data<'a> {
+    ///     // Dropping `Data` tries to assert the lines again.
+    ///     resets: ExclusiveResetControl<'a, Deasserted>,
+    /// }
+    ///
+    /// fn probe<'a>(dev: &'a Device<Bound>) -> Result<Data<'a>> {
+    ///     let resets = ExclusiveResetControl::get_array(dev)?.deassert()?;
+    ///
+    ///     Ok(Data { resets })
+    /// }
+    /// ```
+    #[inline]
+    pub fn get_array(dev: &'a Device<Bound>) -> Result<Self> {
+        Self::get_array_internal(dev, false)
+    }
+
+    /// Gets the reset lines listed in the `resets` property of `dev` as one
+    /// [`ExclusiveResetControl`], if there are any.
+    ///
+    /// Behaves the same as [`Self::get_array`], except when `dev` has no firmware node, when its
+    /// `resets` property has no entry or cannot be read, or when `CONFIG_RESET_CONTROLLER` is
+    /// disabled. In those cases, it returns an [`ExclusiveResetControl`] on which every operation
+    /// succeeds and does nothing.
+    ///
+    /// Equivalent to the kernel's `fwnode_reset_control_array_get()` on the firmware node of
+    /// `dev`, as `devm_reset_control_array_get_optional_exclusive()` does.
+    #[inline]
+    pub fn get_array_optional(dev: &'a Device<Bound>) -> Result<Self> {
+        Self::get_array_internal(dev, true)
+    }
 }
 
 impl<'a, State: ResetState> ExclusiveResetControl<'a, State> {

-- 
2.56.0

