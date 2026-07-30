Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CAAC55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6186310F001;
	Thu, 30 Jul 2026 17:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="zHo+9Ys5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B8F10EFF5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:05:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9267E60A71;
 Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CA2EC4AF1A;
 Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1785431151; bh=GVCT8D7jTZC4iF9oYU9jLIUK2NmIVV1AdrU5/oeX5O4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=zHo+9Ys5jbQMG+Us9qdLC0FTvYtYyiYzzpS5B9c4zzpccG6CoSvM1d1U6zJMBU3tC
 mUcHRCAvPlNp/Af3y+fBBxQfTM2uSSXQ3Xv4kliUyzmcbo2ga8LSiR+0rWMkr6R7Jy
 OvcHIEmgWr+w/N5cnMi24bzfRxiSdbcnCYNVeodw=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 08864C55162;
 Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Fri, 31 Jul 2026 01:05:44 +0800
Subject: [PATCH v2 6/9] rust: drm: add DrmSeqShow seq_file adapter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-tyr-debugfs-v2-v2-6-aea19eccb996@linux.dev>
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
In-Reply-To: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Wambui Karuga <wambui.karugax@gmail.com>, 
 Eric Anholt <eric@anholt.net>, Ben Gamari <bgamari@gmail.com>, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785431148; l=2686;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=GVCT8D7jTZC4iF9oYU9jLIUK2NmIVV1AdrU5/oeX5O4=;
 b=+RGmMqtdp1gntYEKgcNqJHPleGq4GDbAxXoW3f3/rP3zzWKCFsIYNIsb7VKgS9WriBEl0+zsW
 laOIBDRYn20AOsbawtafVMeOLtdUeUSBA3Gzgq0bXg1yx6yKnrGd86T
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Add DrmSeqShow trait and its SeqShow blanket impl for Device<T, Normal>,
enabling Rust DRM drivers to expose device state via debugfs seq_file
entries. Device registration data is kept alive for the duration of
each seq_file read.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/drm/debugfs.rs | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs     |  1 +
 2 files changed, 50 insertions(+)

diff --git a/rust/kernel/drm/debugfs.rs b/rust/kernel/drm/debugfs.rs
new file mode 100644
index 0000000000000..26f3b400e24ac
--- /dev/null
+++ b/rust/kernel/drm/debugfs.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM-specific debugfs seq_file helpers.
+
+use crate::{
+    debugfs,
+    drm,
+    prelude::*,
+    seq_file,
+    sync::aref::AlwaysRefCounted, //
+};
+use core::ptr::NonNull;
+
+/// Renders DRM device state into a seq_file under SRCU protection.
+///
+/// Pass an implementing type to
+/// [`debugfs::ScopedDir::seq_file`]. The `show`
+/// method receives a [`drm::RegistrationGuard`] that keeps DRM device data alive
+/// for its duration.
+pub trait DrmSeqShow<T: drm::Driver> {
+    /// Writes debugfs output for the file.
+    fn show(guard: &drm::RegistrationGuard<'_, T>, m: &seq_file::SeqFile) -> Result;
+}
+
+impl<S: DrmSeqShow<T>, T: drm::Driver> debugfs::SeqShow<drm::Device<T, drm::Normal>> for S {
+    fn show(dev: &drm::Device<T, drm::Normal>, m: &seq_file::SeqFile) -> Result {
+        // SAFETY: `debugfs_init` runs after `dev->registered = true` is set,
+        // so the `Ioctl` invariant is satisfied. `Normal` and `Ioctl` share
+        // an identical layout.
+        let dev = unsafe { dev.assume_ctx::<drm::Ioctl>() };
+
+        let Some(guard) = dev.registration_guard() else {
+            return Err(ENODEV);
+        };
+        S::show(&guard, m)
+    }
+
+    fn open(dev: &drm::Device<T, drm::Normal>) -> Result {
+        // Hold a device reference so the device is not freed while the file is open.
+        dev.inc_ref();
+        Ok(())
+    }
+
+    unsafe fn release(dev: NonNull<drm::Device<T, drm::Normal>>) {
+        // Drop the reference taken in `open`.
+        // SAFETY: `dev` is valid per this function's safety contract.
+        unsafe { drm::Device::<T>::dec_ref(dev) };
+    }
+}
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index fd6ed35bc35a9..5ed2e6bb764eb 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -2,6 +2,7 @@
 
 //! DRM subsystem abstractions.
 
+pub mod debugfs;
 pub mod device;
 pub mod driver;
 pub mod file;

-- 
2.43.0


