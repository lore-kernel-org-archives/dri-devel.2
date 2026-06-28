Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F60FC43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4C510E622;
	Sun, 28 Jun 2026 14:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jhC6S3ZE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC49010E622
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4EC9401BD;
 Sun, 28 Jun 2026 14:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75071F000E9;
 Sun, 28 Jun 2026 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658491;
 bh=0nDjy07ax4ZT73XGf3sgGXI/MEYdniVyQ98WeLPrXdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jhC6S3ZE031SbkjxsWhDdNkHIX3Nv+Nn9YWFgyt6UWONhUtLpQc7Z0FebZ4zAapcZ
 Q/SyO9mxZ03X2/JqsGlr3qSaJAff3VBAecHC0tvbBY6Yf53l2l7BzdhsuWtCIOAC3W
 grsUO5Z6yK4dArxoHYErMydO6Py9mEKnAM0Xk2cYkMn81wEkxbCppf8E2lNGXvyA6t
 Bjpl6WZqxjh20kP/OUp3Uduyhq5Mw1fTSJ9kruI9mu2aZUrJ7/QyZe9sb1UiHuOC1F
 h/Fm24PkWL58W4lNkYio0Ln6NuwK4SC0rBDd/cM7hUd/SR6C2Y/lHOH5a0d6tKYZBr
 nwy4pjoC9o2Mw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 09/19] rust: drm: split Deref for Device context typestates
Date: Sun, 28 Jun 2026 16:53:29 +0200
Message-ID: <20260628145406.2107056-10-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
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

Split the Deref implementation for drm::Device by context:

  - Device<T> (Normal) dereferences to T::Data.
  - Device<T, Registered> dereferences to Device<T> (Normal).

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 6f3af46ff647..86a7fca1d33f 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -79,6 +79,9 @@ macro_rules! drm_legacy_fields {
 /// - [`Normal`]: The general-purpose, reference-counted context. A [`Device`] in this context may
 ///   or may not be registered with userspace.
 /// - [`Registered`]: The device has been registered with userspace at some point.
+///
+/// `Device<T, Registered>` dereferences to `Device<T>` ([`Normal`]), so any method available on a
+/// [`Normal`] device is also available on a [`Registered`] one.
 pub trait DeviceContext: Sealed + Send + Sync {}
 
 /// The general-purpose, reference-counted [`DeviceContext`].
@@ -320,7 +323,7 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
     }
 }
 
-impl<T: drm::Driver, C: DeviceContext> Deref for Device<T, C> {
+impl<T: drm::Driver> Deref for Device<T> {
     type Target = T::Data;
 
     fn deref(&self) -> &Self::Target {
@@ -328,6 +331,17 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
+impl<T: drm::Driver> Deref for Device<T, Registered> {
+    type Target = Device<T>;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller holds a `Device<T, Registered>`, which guarantees all invariants
+        // of the weaker `Normal` context.
+        unsafe { self.assume_ctx() }
+    }
+}
+
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
 unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
-- 
2.54.0

