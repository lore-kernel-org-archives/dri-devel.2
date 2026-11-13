Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C66606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQ8919u5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D274A10EB8E;
	Fri, 13 Nov 2026 07:53:44 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C3310EB8E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:53:39 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3b09a83d12aso993974a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794556419; x=1795161219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zwU7tBpZX44iULEudpXOZjxGHCjhyfh7bS2JLZeD11k=;
 b=qQ8919u5MGUF2VN75H2vq4sdy37Ns2F/WY0Dpy8Gb+sAFvs9wydzdwX1/yEko7TJJW
 rHCrh21nFfIbGyKEGVwK2ZqIsMjceHStMv2+DjjHtwUJbFjAO3NhV4eYVlZXWXbilmsH
 FCxoVH90GEtw9GgcDzBTOL8DRNSNbNLEZPhNMLhueL4GM9PdeQS1CsRfUeQr5UcMwao3
 gOzjoc446cmQowjawarPXP151RcJ5N6O8ysYMr91aPJDRp8j7OTFnx1Ty0E/Yw5cbYoV
 I26ugfKpmvjISaUzp+oZLD0M4+FSIgLtYAPhuE7jLFwElCDx2hWIdiwwLehUwH9Z+86P
 He4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556419; x=1795161219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zwU7tBpZX44iULEudpXOZjxGHCjhyfh7bS2JLZeD11k=;
 b=lJY5lHmp7xwickWFBgUDdsEyppLUx2yHZnnqPvywubKUgG3oVla2EC6KWjK2qXjIDU
 eMzpUyD7O/1YsVcub1NWP6DUtnNWmEB6GPBN4mMcRfoEXI3ZuiMGyjFFzTxHgLZR1ISB
 9nKdjiqm+qub80aHFa6TzRUh7du6azewOP2FnpIrLgwdimu6JPgmIh1AzjSF5M23yQYj
 fHN6XtWw0oMyNydyM0/EnP5XATq+Jkr2jnCspWCaEG1kiSa+FzDOf27dsmby9H4l1p9R
 84NtfkwhZDuTo4UUhQfRn6SXHVOFzIr3b4yM6PyNfAKFoYg5LLV+PLzpIK23ajznhLPO
 U6Dg==
X-Forwarded-Encrypted: i=1;
 AL+hErHXre9fG3Sd2dcgKZD8RvMYqeqiPfSphHQkCJyuPFfFQ6913Sl8C16UE/xpbApg8EAZvf6/qY0Btps=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PZ+tjjbOOPanmldl6WYJdnoezMG74T/61Rv4izGFSgRgOMG1Y
 3GZxswqli52uDA4FVqsOvTcxfoh/HgWH7TAN9wvAmKkVbYeHC5DS+F8W
X-Gm-Gg: AYBFou3xpwM+7rDE5lPOYTHcViLJnwLRkV6FZulRIQkuF08sL2KVHnpu776Czin/SDB
 cMDgVcR75/LkZk9dXgnlUPlYSzKnDETTplRgml3eRwVQvSKdyvrie9wQvpqL3gZRBVCpSsEj8Uw
 XS/ME+ybSQYmIzQfm6kAieNAuj4GHzcpfgvEDqRWc1LVMh51cugL4vKs7JhfbMX0M9NERoiZ/if
 xIEQcRcb+9GAy8xcyVG3u9jcuFZ01d/1pTB7EkGSTFxY0lTpejZSSvsJfErxHD86dv5shuEIZvx
 IOtO3QNQmO3DM6UvDzeDJxez6NBBgnjrc7McKv3HQgNCKT1i+f5NSXSaUUw6cBLMurpcsKy6CYD
 HfZ27lLRtifQY2PxESV5XE3ECe8tlP/bDvJyYB0JHx7PAygwsy6CcWpaAD+bxqU/D8m+GtyHKNN
 9sP8QJ/bU2iAWgY44qdEUjs7wLSOPJNVi+WDyumRBf3PPTdoYDQwZ4H+IIBYZmn28lvCKVe/3m8
 Qiqxm4ZxUYy9PSqHPuVDNc7kSi7mIA6BBMfhCGjNSrdOJUQc9tcO19WZgsIFHNy8XoclTpUQDCA
 vcWNWXzcHsSCUA1PkDflELWh3GC+jpTJe4oxGERaUOjTZylRjWf4qZ54
X-Received: by 2002:a17:90b:3808:b0:3a0:ca1d:b40d with SMTP id
 98e67ed59e1d1-3b1b0d08ec9mr1691398a91.55.1794556418764; 
 Thu, 12 Nov 2026 23:53:38 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3b708adsm993234a91.4.2026.11.12.23.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:53:38 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v7 1/4] gpu: nova-core: move the debugfs root into the module
 data
Date: Fri, 13 Nov 2026 14:53:14 +0700
Message-ID: <20261113075317.934264-2-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113075317.934264-1-vladazaharova2018@gmail.com>
References: <20261113075317.934264-1-vladazaharova2018@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The debugfs root lives in a static that is cleared by a guard field of
the module data. The guard is built after the driver registration, so if
the registration fails, the root is never removed and the next module
load finds the name taken.

Move the root into a DebugfsData owned by the module data, and keep only
a pointer to it in the static, for devices that cannot reach the module
data yet. If the registration fails, the root is dropped with the rest
of the module data.

Fixes: 09691f5d8070 ("gpu: nova-core: create debugfs root in module init")
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 drivers/gpu/nova-core/debugfs.rs   | 29 ++++++++++++++
 drivers/gpu/nova-core/gsp.rs       | 11 +-----
 drivers/gpu/nova-core/nova_core.rs | 62 ++++++++++++++++++------------
 3 files changed, 69 insertions(+), 33 deletions(-)
 create mode 100644 drivers/gpu/nova-core/debugfs.rs

diff --git a/drivers/gpu/nova-core/debugfs.rs b/drivers/gpu/nova-core/debugfs.rs
new file mode 100644
index 000000000000..6c6ed129f0da
--- /dev/null
+++ b/drivers/gpu/nova-core/debugfs.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Debugfs data shared by all GPUs of the driver.
+
+use kernel::{
+    debugfs,
+    prelude::*, //
+};
+
+/// Debugfs data the module shares with every GPU it drives.
+#[pin_data]
+pub(crate) struct DebugfsData {
+    /// Root directory of the driver in debugfs.
+    root: debugfs::Dir,
+}
+
+impl DebugfsData {
+    /// Creates the debugfs data of the module.
+    pub(crate) fn new() -> impl PinInit<Self> {
+        pin_init!(Self {
+            root: debugfs::Dir::new(c"nova-core"),
+        })
+    }
+
+    /// Returns the root directory of the driver.
+    pub(crate) fn root(&self) -> &debugfs::Dir {
+        &self.root
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index a4b832f6aec1..79ee74a0a16f 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -200,15 +200,8 @@ pub(crate) fn new(
                         logrm,
                     };
 
-                    #[allow(static_mut_refs)]
-                    // SAFETY: `DEBUGFS_ROOT` is created before driver registration and cleared
-                    // after driver unregistration, so no probe() can race with its modification.
-                    //
-                    // PANIC: `DEBUGFS_ROOT` cannot be `None` here.  It is set before driver
-                    // registration and cleared after driver unregistration, so it is always
-                    // `Some` for the entire lifetime that probe() can be called.
-                    let log_parent: &debugfs::Dir = unsafe { crate::DEBUGFS_ROOT.as_ref() }
-                        .expect("DEBUGFS_ROOT not initialized");
+                    let log_parent: &debugfs::Dir =
+                        crate::NovaCoreModule::debugfs_data(dev).root();
 
                     log_parent.scope(log_buffers, dev.name(), |logs, dir| {
                         dir.read_binary_file(c"loginit", &logs.loginit.0);
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index a8f6dc22057b..f5d08de8a212 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -3,7 +3,7 @@
 //! Nova Core GPU Driver
 
 use kernel::{
-    debugfs,
+    device,
     driver::Registration,
     pci,
     prelude::*,
@@ -11,6 +11,7 @@
 };
 
 pub mod api;
+mod debugfs;
 mod driver;
 mod falcon;
 mod fb;
@@ -30,42 +31,55 @@
 mod vbios;
 mod vgpu;
 
-pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
-
-// TODO: Move this into per-module data once that exists.
-static mut DEBUGFS_ROOT: Option<debugfs::Dir> = None;
+use debugfs::DebugfsData;
 
-/// Guard that clears `DEBUGFS_ROOT` when dropped.
-struct DebugfsRootGuard;
+pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
-impl Drop for DebugfsRootGuard {
-    fn drop(&mut self) {
-        // SAFETY: This guard is dropped after `_driver` (due to field order),
-        // so the driver is unregistered and no probe() can be running.
-        unsafe { DEBUGFS_ROOT = None };
-    }
-}
+/// Pointer to the [`DebugfsData`] of the module.
+///
+/// A device currently has no way to reach the data of its module, so it goes through here.
+///
+/// # Invariants
+///
+/// - Only written once before the driver is registered.
+/// - Points to a valid [`DebugfsData`] for as long as the driver is registered.
+// TODO: Drop this once devices can reach the data of their module.
+static mut DEBUGFS_DATA: *const DebugfsData = core::ptr::null();
 
 #[pin_data]
 struct NovaCoreModule {
-    // Fields are dropped in declaration order, so `_driver` is dropped first,
-    // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
+    // Fields are dropped in declaration order. `_driver` must be dropped before `_debugfs` to
+    // uphold the invariant of `DEBUGFS_DATA` that it remains valid for as long as the driver is
+    // registered.
     #[pin]
     _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
-    _debugfs_guard: DebugfsRootGuard,
+    #[pin]
+    _debugfs: DebugfsData,
+}
+
+impl NovaCoreModule {
+    /// Returns the debugfs data of the module.
+    pub(crate) fn debugfs_data<'a>(_dev: &'a device::Device<device::Bound>) -> &'a DebugfsData {
+        // SAFETY: `_dev` is bound, so the driver is registered. Per the invariants of
+        // `DEBUGFS_DATA`, the pointer is thus valid and not being written to. The `'a` lifetime
+        // ensures that the returned reference cannot outlive the bound device.
+        unsafe { &*DEBUGFS_DATA }
+    }
 }
 
 impl InPlaceModule for NovaCoreModule {
     fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
-        let dir = debugfs::Dir::new(c"nova-core");
-
-        // SAFETY: We are the only driver code running during init, so there
-        // cannot be any concurrent access to `DEBUGFS_ROOT`.
-        unsafe { DEBUGFS_ROOT = Some(dir) };
-
         try_pin_init!(Self {
+            _debugfs <- DebugfsData::new(),
+            _: {
+                // SAFETY: The driver is not registered yet, meaning that no device can be probed
+                // and thus nothing can access `DEBUGFS_DATA` concurrently.
+                //
+                // INVARIANT: `DEBUGFS_DATA` is written before the driver is registered below and
+                // points to `_debugfs`, which is pinned and dropped after `_driver`.
+                unsafe { DEBUGFS_DATA = &*_debugfs };
+            },
             _driver <- Registration::new(MODULE_NAME, module),
-            _debugfs_guard: DebugfsRootGuard,
         })
     }
 }
-- 
2.56.0

