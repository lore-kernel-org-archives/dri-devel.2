Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F7606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WTVfqfOx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9FC4112591;
	Thu, 26 Nov 2026 16:06:06 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38288112590
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795709117; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O93n2JmT7meWj3j2m0HSnZDbXBzjcEqAzXD4chWINAhCJNV+PYehrTcLW88JwAaulV7u433VyV9WFogQyAoYKwd+vUy6Wfk4sDkWDh/0Bfs9swrGjP9qDSHwNwNI5n4Y11WqGuuVxEDsd6jJb7RmxteCphObUeE43R5u3kUHHkg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795709117;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MaqWnhotP0A9JBelhqa5PHtOUAcOBdNtyY+HvpWycn8=; 
 b=GBp+F+n7GVYyQFW2Jj9m1XnrxTj7TIEG1o8uUmP2p396tn0zCCDdDEjUksslTTIMznVDbuNTPDMV+jjr1AJ7nxYVgpWgF3qiyrPOT/ZsWZiQ19hAQIM87A7KJ/r380wnnbIvvTkTgF6h/yC2vFdYgb4vLY4MScgJu0Ccs6zrTvw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=WTVfqfOxZqw4VQFY8YUNeoFtIZSM/p5SaKvhYJ/9SHzBAEWVVUEjDr3EuOzSlvlgkd2cjwbb64q9xooxTwQa+d77u3kSopzNhJp9ZSUcupvLG5YTALEJ7w2MtT2TlkcPyT2Q2iRtoB09z0cXAWc+x1RegnadDmvVcaDbdVDaK9g=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=MaqWnhotP0A9JBelhqa5PHtOUAcOBdNtyY+HvpWycn8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795709114756463.37080823559893; 
 Thu, 26 Nov 2026 08:05:14 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 26 Nov 2026 13:04:33 -0300
Subject: [PATCH 6/7] rust: reset: add SharedResetControl::get_array() and
 get_array_optional()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-b4-rust-reset-v1-6-9c4c3d029080@collabora.com>
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

Add SharedResetControl::get_array() and get_array_optional(), which get
all the reset lines in the resets property of a device as a single
shared reset control, as devm_reset_control_array_get_shared() and
devm_reset_control_array_get_optional_shared() do in C. This is for
drivers that assert and deassert all the shared reset lines of their
device together.

Nothing uses them yet.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/reset.rs | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/rust/kernel/reset.rs b/rust/kernel/reset.rs
index 4d241ec6e549..85c51fc153ac 100644
--- a/rust/kernel/reset.rs
+++ b/rust/kernel/reset.rs
@@ -568,6 +568,8 @@ fn drop(&mut self) {
 ///
 /// - [`reset_control_get_shared()`]
 /// - [`reset_control_get_optional_shared()`]
+/// - `fwnode_reset_control_array_get()` with the `RESET_CONTROL_SHARED` or
+///   `RESET_CONTROL_OPTIONAL_SHARED` flag
 ///
 /// It is treated as an opaque token that may only be accessed using C API methods (e.g., it may be
 /// `NULL` if the C API returns `NULL`). The [`SharedResetControl`] owns the reference that the
@@ -639,6 +641,95 @@ pub fn get_optional(dev: &'a Device<Bound>, name: Option<&CStr>) -> Result<Self>
         })
     }
 
+    /// Gets the reset lines of `dev` as one [`SharedResetControl`], as [`Self::get_array`] does
+    /// or, if `optional` is set, as [`Self::get_array_optional`] does.
+    fn get_array_internal(dev: &'a Device<Bound>, optional: bool) -> Result<Self> {
+        let flags = if optional {
+            bindings::reset_control_flags_RESET_CONTROL_OPTIONAL_SHARED
+        } else {
+            bindings::reset_control_flags_RESET_CONTROL_SHARED
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
+    /// [`SharedResetControl`].
+    ///
+    /// Its operations act on all the lines, in no guaranteed order. If one of them fails on a
+    /// line, the opposite operation is run on the lines it had already succeeded on. This
+    /// includes the assert that is done on drop. The caller only gets the error from the line
+    /// that failed, while errors from the opposite operation are discarded.
+    ///
+    /// A [`SharedResetControl::assert`] that fails on one line therefore leaves the control
+    /// holding its deasserts on the other lines. The control is in the [`Unknown`] state then,
+    /// and does not give them back.
+    ///
+    /// Equivalent to the kernel's `fwnode_reset_control_array_get()` on the firmware node of
+    /// `dev`, as `devm_reset_control_array_get_shared()` does.
+    ///
+    /// # Examples
+    ///
+    /// Keeping all the shared reset lines of a device deasserted:
+    ///
+    /// ```
+    /// use kernel::{
+    ///     device::{
+    ///         Bound,
+    ///         Device, //
+    ///     },
+    ///     reset::{
+    ///         Deasserted,
+    ///         SharedResetControl, //
+    ///     },
+    /// };
+    ///
+    /// struct Data<'a> {
+    ///     // Dropping `Data` asserts the reset control again.
+    ///     resets: SharedResetControl<'a, Deasserted>,
+    /// }
+    ///
+    /// fn probe<'a>(dev: &'a Device<Bound>) -> Result<Data<'a>> {
+    ///     let resets = SharedResetControl::get_array(dev)?.deassert()?;
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
+    /// [`SharedResetControl`], if there are any.
+    ///
+    /// Behaves the same as [`Self::get_array`], except when `dev` has no firmware node, when its
+    /// `resets` property has no entry or cannot be read, or when `CONFIG_RESET_CONTROLLER` is
+    /// disabled. In those cases, it returns a [`SharedResetControl`] on which every operation
+    /// succeeds and does nothing.
+    ///
+    /// Equivalent to the kernel's `fwnode_reset_control_array_get()` on the firmware node of
+    /// `dev`, as `devm_reset_control_array_get_optional_shared()` does.
+    #[inline]
+    pub fn get_array_optional(dev: &'a Device<Bound>) -> Result<Self> {
+        Self::get_array_internal(dev, true)
+    }
+
     /// Deasserts the reset line and moves the [`SharedResetControl`] to the [`Deasserted`] state.
     ///
     /// Equivalent to the kernel's [`reset_control_deassert()`].

-- 
2.56.0

