Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBA606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WXcrJueY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471ED112590;
	Thu, 26 Nov 2026 16:06:00 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D08112596
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795709121; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WaFoaevjSvKOihdPmiAisqhB1ZAaTpDgQwK5GgpVl9K3v+bPvCs0Q0qZa1KrHyR5ZoTT1IxNpdt4OwaMKx6+l1R0gIH6o+jXsvNuE/IouGmmq50DSv+iUYsyBDbAKq2ygkjGWHi9Tc/O1ZoCLTzXgcC9kHCTIbTTLY+vMYbMt2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795709121;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ezpDVLPiEaEtFTNaj70JjgOUybFAP7tEVWA6y3sqCCI=; 
 b=C082wI5EtACzL3W3O5l2FnlAV+0RofRoV8aknwMB0/td2Lq43KKlMzVjvz5K0+6KXF7EqdDB83b9q+2HXTttncjQdJid3uxh22ZCTmwdYxbFz+IpSo7fBlwFQbgq7JZr5ktPOPh0C/cJNwA92vBqDJN89ToX7VhAcC9jMAJ0Dj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=WXcrJueYvyIT4UJViCpxykx8Cep3wtksAdmley8oLFbH0u4uk/wDHi4mPBplsI4Vuv3Nb4dqcLJHl7dDj7Vnft1lWWcOAIxAelWLofiLzjjiJaQ2CVt/+1uoVXa0SZ92wDIDnEIfv/eAZU1rA7w8w3FYy90Y+8XOfu1Fymz6rac=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=ezpDVLPiEaEtFTNaj70JjgOUybFAP7tEVWA6y3sqCCI=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795709119834326.1696665766045;
 Thu, 26 Nov 2026 08:05:19 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 26 Nov 2026 13:04:34 -0300
Subject: [PATCH 7/7] rust: reset: add devm_deassert() and
 devm_deassert_optional()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-b4-rust-reset-v1-7-9c4c3d029080@collabora.com>
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

Many drivers need the reset line of their device deasserted while the
device is bound, but otherwise do not care about exerting finer control
over it. C drivers do that with
devm_reset_control_get_exclusive_deasserted() and
devm_reset_control_get_optional_exclusive_deasserted().

Add ExclusiveResetControl::devm_deassert() and devm_deassert_optional(),
which call them and leave the reset control to devres.

Nothing uses them yet.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/reset.c | 14 +++++++++++
 rust/kernel/reset.rs | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/rust/helpers/reset.c b/rust/helpers/reset.c
index 9c106d8b6de1..aa20b3e7a88b 100644
--- a/rust/helpers/reset.c
+++ b/rust/helpers/reset.c
@@ -28,6 +28,20 @@ rust_helper_reset_control_get_optional_shared(struct device *dev,
 	return reset_control_get_optional_shared(dev, id);
 }
 
+__rust_helper struct reset_control *
+rust_helper_devm_reset_control_get_exclusive_deasserted(struct device *dev,
+							const char *id)
+{
+	return devm_reset_control_get_exclusive_deasserted(dev, id);
+}
+
+__rust_helper struct reset_control *
+rust_helper_devm_reset_control_get_optional_exclusive_deasserted(struct device *dev,
+								 const char *id)
+{
+	return devm_reset_control_get_optional_exclusive_deasserted(dev, id);
+}
+
 #ifndef CONFIG_RESET_CONTROLLER
 __rust_helper struct reset_control *
 rust_helper_fwnode_reset_control_array_get(struct fwnode_handle *fwnode,
diff --git a/rust/kernel/reset.rs b/rust/kernel/reset.rs
index 85c51fc153ac..e2fbd4c2147c 100644
--- a/rust/kernel/reset.rs
+++ b/rust/kernel/reset.rs
@@ -19,6 +19,9 @@
 //! If the reset line is shared with other devices, the driver asks for a [`SharedResetControl`]
 //! instead.
 //!
+//! A driver that only needs its reset line deasserted while it is bound can call
+//! [`ExclusiveResetControl::devm_deassert`] instead of keeping a reset control.
+//!
 //! C header: [`include/linux/reset.h`](srctree/include/linux/reset.h)
 //!
 //! See [Reset controller API](https://docs.kernel.org/driver-api/reset.html) for more information.
@@ -324,6 +327,69 @@ pub fn get_array(dev: &'a Device<Bound>) -> Result<Self> {
     pub fn get_array_optional(dev: &'a Device<Bound>) -> Result<Self> {
         Self::get_array_internal(dev, true)
     }
+
+    /// Deasserts the reset line `name` of `dev`, or its first reset line if `name` is `None`, until
+    /// `dev` is unbound.
+    ///
+    /// The reset control is managed by devres, which asserts the line and releases the control
+    /// when `dev` is unbound. An error from that assert is discarded. Until then, devres holds
+    /// the line as an [`ExclusiveResetControl`] does.
+    ///
+    /// Equivalent to the kernel's [`devm_reset_control_get_exclusive_deasserted()`].
+    ///
+    /// # Examples
+    ///
+    /// Keeping the reset line of a device deasserted until the device is unbound:
+    ///
+    /// ```
+    /// use kernel::{
+    ///     device::{
+    ///         Bound,
+    ///         Device, //
+    ///     },
+    ///     reset::ExclusiveResetControl,
+    /// };
+    ///
+    /// fn probe(dev: &Device<Bound>) -> Result {
+    ///     ExclusiveResetControl::devm_deassert(dev, None)
+    /// }
+    /// ```
+    ///
+    /// [`devm_reset_control_get_exclusive_deasserted()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.devm_reset_control_get_exclusive_deasserted
+    #[inline]
+    pub fn devm_deassert(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: `dev` is a valid and bound device, and `id` is `NULL` or a valid C string.
+        let inner =
+            unsafe { bindings::devm_reset_control_get_exclusive_deasserted(dev.as_raw(), id) };
+        from_err_ptr(inner)?;
+
+        Ok(())
+    }
+
+    /// Deasserts the reset line `name` of `dev` until `dev` is unbound, if there is such a line.
+    ///
+    /// Behaves the same as [`Self::devm_deassert`], except when the device has no such reset line
+    /// or `CONFIG_RESET_CONTROLLER` is disabled. In those cases, it succeeds and does nothing.
+    ///
+    /// Equivalent to the kernel's [`devm_reset_control_get_optional_exclusive_deasserted()`].
+    ///
+    /// [`devm_reset_control_get_optional_exclusive_deasserted()`]:
+    /// https://docs.kernel.org/driver-api/reset.html#c.devm_reset_control_get_optional_exclusive_deasserted
+    #[inline]
+    pub fn devm_deassert_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: `dev` is a valid and bound device, and `id` is `NULL` or a valid C string.
+        let inner = unsafe {
+            bindings::devm_reset_control_get_optional_exclusive_deasserted(dev.as_raw(), id)
+        };
+        from_err_ptr(inner)?;
+
+        Ok(())
+    }
 }
 
 impl<'a, State: ResetState> ExclusiveResetControl<'a, State> {

-- 
2.56.0

