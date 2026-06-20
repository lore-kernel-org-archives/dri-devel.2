Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B01CD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2792710E143;
	Sat, 20 Jun 2026 00:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a4BbblC5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F2F10E143
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D3E9601E4;
 Sat, 20 Jun 2026 00:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE991F000E9;
 Sat, 20 Jun 2026 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917158;
 bh=ovlLpIFcIqJIS4zpHh69eliJrNZqKzaspRBt9Riw0zc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a4BbblC5cN62eclmD4C4TDruE8ujeK/gG+Jtm0Nvk+7Ctfn4xIMjfC/3Zos0HBznN
 VT7+r6nKFC7v/agT1ovtsx3C99B3/90krsyKMH9cJOWNScnZqs/NRhD7qmC0gOISzx
 xv+IMPfprLRkPfdPbvhjFZyTu3jCShuX9poh7dqdyBHGChqCmKd1k9+5e9uPzDa8Jc
 Pd9MaB8E+yT7ALmOu7BQZ6skHj3Qcv+N5RhT+piI3ODqd6zMo5sFlL5n47dwXcrgyR
 uWrQSuVn8heaVxUnE+laFLC0mCTh/uVhwk1tOpsyJgVFhNzSq7Fno/aM/tAZ9E6AJ9
 Zj25Wuef5mN+A==
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
Subject: [PATCH v3 04/13] rust: drm: restrict AlwaysRefCounted to Normal
 Device context
Date: Sat, 20 Jun 2026 02:51:16 +0200
Message-ID: <20260620005431.1562115-5-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620005431.1562115-1-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
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

Restrict the AlwaysRefCounted implementation for drm::Device to the
Normal context. Registered devices represent a non-owning view of a
device within a RegistrationGuard scope and must not be independently
reference-counted.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index d712387707d2..9825d52832af 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -85,6 +85,9 @@ pub trait DeviceContext: Sealed + Send + Sync {}
 ///
 /// A [`Device`] in this context may or may not be registered with userspace. This context is used
 /// for reference-counted device handles and during device setup via [`UnregisteredDevice`].
+///
+/// [`AlwaysRefCounted`] is only implemented for `Device<T, Normal>`, making this the required
+/// context for [`ARef`]-based device handles.
 pub struct Normal;
 
 impl Sealed for Normal {}
@@ -327,7 +330,7 @@ fn deref(&self) -> &Self::Target {
 
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
-unsafe impl<T: drm::Driver, C: DeviceContext> AlwaysRefCounted for Device<T, C> {
+unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::drm_dev_get(self.as_raw()) };
@@ -357,12 +360,10 @@ unsafe impl<T: drm::Driver, C: DeviceContext> Send for Device<T, C> {}
 // by the synchronization in `struct drm_device`.
 unsafe impl<T: drm::Driver, C: DeviceContext> Sync for Device<T, C> {}
 
-impl<T, C, const ID: u64> WorkItem<ID> for Device<T, C>
+impl<T: drm::Driver, const ID: u64> WorkItem<ID> for Device<T>
 where
-    T: drm::Driver,
     T::Data: WorkItem<ID, Pointer = ARef<Self>>,
     T::Data: HasWork<Self, ID>,
-    C: DeviceContext,
 {
     type Pointer = ARef<Self>;
 
-- 
2.54.0

