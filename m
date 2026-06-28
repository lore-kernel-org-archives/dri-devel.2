Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB62C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB85710E61E;
	Sun, 28 Jun 2026 14:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZS7YB8Dy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4C610E620
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E62D5600AA;
 Sun, 28 Jun 2026 14:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0B61F00A3D;
 Sun, 28 Jun 2026 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658478;
 bh=M4R1ncCH7yJe9pq5SwvtMy7E6HQj3lvtK28zS3b2iX8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZS7YB8Dy9sHNzUvb5EgaLBdcTl+gikwDyrNs1UBrxqmsq/Hy9ZWjsqwqin7wzbS/I
 wlIBtYfaE7ix6NUB/sidogzcf3S3nxCanPLOQ8N0fnmUDlK2kg3xBck7DsSi+Tcfta
 WnpqxbEdrJcZfhODzKkxqOUp9av1ks1RECy92xajjnmecbkPluKMwo4JNJD0f/e4cU
 wPJ9X3fMIv76zdR/bewsUq1DTBviddeIVsteeuwzRJgx4Ka9rb4uuqt6uR593q6wKJ
 ebcndxjhOu8TWbhBMaw7b3iHO/DLhSHoPd8f4EM5UAt0w61aTyGrXkX4VZq0E8r6no
 RDtmZbobYfGpA==
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
Subject: [PATCH v5 06/19] rust: drm: restrict AlwaysRefCounted to Normal
 Device context
Date: Sun, 28 Jun 2026 16:53:26 +0200
Message-ID: <20260628145406.2107056-7-dakr@kernel.org>
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

Restrict the AlwaysRefCounted implementation for drm::Device to the
Normal context. Registered devices represent a non-owning view of a
device within a RegistrationGuard scope and must not be independently
reference-counted.

Reviewed-by: Lyude Paul <lyude@redhat.com>
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

