Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46B606A7C0
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMFUCMwp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8D910EC44;
	Wed, 18 Nov 2026 16:32:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F12E10E5B2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:32:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1790D46399;
 Wed, 18 Nov 2026 16:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E50D1F000C7;
 Wed, 18 Nov 2026 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019547;
 bh=xk+TZUF1TRmt+f+C/QPA3J720VtA09DDpLZ7FCFd5EA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AMFUCMwpmKeo7mfnNhAhB2/2s/eeAPSqbqk4ahoJ6gTtmxUVl90WdOhZcdmKstqeU
 vA8MmamLudMvT7lAq+NAyfUJlc0MySY07sioXKSKjKg7gTnswNb4HSpRymOfuC0scK
 59BIjgz8bFhgjB0XxETRkajVRK1hVWVGg4bdaGYrMdZP4Ly9GyjweU2pDLv/KXwfsb
 7DTItFEiNPvTpfAhy5hUOUDkZBVnHqKjQbIe90vxWrvVKK1+eeX8/mDv+YM8d23ymi
 HIx0uKaqAolvVjkC/dy72Nmgrp0qobjah01Zhk0H7v9qbAydxL+S6ZAvcJ22F8r1uv
 SQG6Wcv2R0fCw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] rust: drm: move file_operations from gem to device
Date: Wed, 18 Nov 2026 17:29:44 +0100
Message-ID: <20261118163203.2483856-4-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118163203.2483856-1-dakr@kernel.org>
References: <20261118163203.2483856-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the file_operations definition from drm::gem::create_fops() into
UnregisteredDevice in drm::device. This is the file_operations of the
DRM minor device, set through the drm_driver struct. It is not specific
to GEM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs  | 23 ++++++++++++++++++++---
 rust/kernel/drm/gem/mod.rs | 20 --------------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index dd1c83fef323..3340fa0dc46b 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -195,11 +195,28 @@ const fn compute_features() -> u32 {
         driver_features: Self::compute_features(),
         ioctls: T::IOCTLS.as_ptr(),
         num_ioctls: T::IOCTLS.len() as i32,
-        fops: &Self::GEM_FOPS,
+        fops: &Self::FOPS,
     };
 
-    const GEM_FOPS: bindings::file_operations =
-        drm::gem::create_fops(crate::module::this_module::<T::OwnerModule>().as_ptr());
+    const FOPS: bindings::file_operations = {
+        let mut fops: bindings::file_operations = pin_init::zeroed();
+
+        fops.owner = crate::module::this_module::<T::OwnerModule>().as_ptr();
+        fops.open = Some(bindings::drm_open);
+        fops.release = Some(bindings::drm_release);
+        fops.unlocked_ioctl = Some(bindings::drm_ioctl);
+        #[cfg(CONFIG_COMPAT)]
+        {
+            fops.compat_ioctl = Some(bindings::drm_compat_ioctl);
+        }
+        fops.poll = Some(bindings::drm_poll);
+        fops.read = Some(bindings::drm_read);
+        fops.llseek = Some(bindings::noop_llseek);
+        fops.mmap = Some(bindings::drm_gem_mmap);
+        fops.fop_flags = bindings::FOP_UNSIGNED_OFFSET;
+
+        fops
+    };
 
     /// Create a new `UnregisteredDevice` for a `drm::Driver`.
     ///
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 94355081edab..260f36817f96 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -388,23 +388,3 @@ impl<T: DriverObject, Ctx: DeviceContext> AllocImpl for Object<T, Ctx> {
         dumb_map_offset: None,
     };
 }
-
-pub(super) const fn create_fops(owner: *mut bindings::module) -> bindings::file_operations {
-    let mut fops: bindings::file_operations = pin_init::zeroed();
-
-    fops.owner = owner;
-    fops.open = Some(bindings::drm_open);
-    fops.release = Some(bindings::drm_release);
-    fops.unlocked_ioctl = Some(bindings::drm_ioctl);
-    #[cfg(CONFIG_COMPAT)]
-    {
-        fops.compat_ioctl = Some(bindings::drm_compat_ioctl);
-    }
-    fops.poll = Some(bindings::drm_poll);
-    fops.read = Some(bindings::drm_read);
-    fops.llseek = Some(bindings::noop_llseek);
-    fops.mmap = Some(bindings::drm_gem_mmap);
-    fops.fop_flags = bindings::FOP_UNSIGNED_OFFSET;
-
-    fops
-}
-- 
2.56.1

