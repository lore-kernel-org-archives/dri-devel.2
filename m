Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284D606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnUgRZ3j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499E610E43C;
	Sat, 14 Nov 2026 04:43:30 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EED910E43C
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 04:43:24 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cd8ba7c2694so644170a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794631403; x=1795236203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HfARJ3dPkm65eyZHkZTOuZn9KRZO6mvdFKT062tV4Mc=;
 b=tnUgRZ3j8BLKl1ZN0O6f5S60TV8CbNpyOHw4tDDPYbNlWPrLxbtrk4mOnJSspbAwxg
 AwPBN9vWhNlQp5IasDM9wIYOBT+gXTAdVqJrHZtvO76T5gUGFp5uNijDSHlBAVRZRYHJ
 SX1v/TD3HHSCIZBT35nZB1g0Ajhjh0VSq529+pKtgblargCxBYKQRaUpkxIf0WHhNOf9
 18JA7V+QJavau1v9R60Lr1c83jko5FRikTE6jFvcXfPYxEWXdl9x8OYTd1MgkPwS9/ZM
 jVFX9YpbhxTlO0xSwE2klUaGMRv6uDcHDGFE31eyGR8R3wghLQRk6TfPQVEsUQVhuxUi
 2GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794631403; x=1795236203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HfARJ3dPkm65eyZHkZTOuZn9KRZO6mvdFKT062tV4Mc=;
 b=cwpoPWOcp8ePXS6S2niPUC/3NIFpRsOSaB8gWoWwOMHZRdPxCyVdzrCKjK6MlDif0s
 huyY7PeEdsvyF9MldI9lu7Pq6zXJk8JzUESSbKNXmEimafv5a+ZSkhjPkbDQ2tRk+1wR
 7CTqh/EyLGK4LY7jKI93fmMTbwQvRkLD5NHApZE/RZp9+O3Gjuhx6ZA97IroHYBypjVx
 69Iw5Q8ZJ4dbT3h74VfSELZiH+InNGGQAlt/um9eK9uE2ipxG/KUh3m2UdnNLL3NSwxO
 obVMrrwnH/Q6QcO6Ahgio5j/+Wagla1j/QLhBEA5KUO6U9dVFoqGbHnuOVRiM3Y6xPJZ
 Lh4w==
X-Forwarded-Encrypted: i=1;
 AL+hErHmKfIePNWOuPe87K8Kt6BvLk+f+AC7LKOnHjBN3y+YXPyuyQ0CaIf1juaj/CAeZga7oySfTlfhRFM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+OXO+Kd0n4xMRQVSUoamJP62On37UpK7/YjaOcaTz6uDBMlW6V
 m1cNvxPhcrYxdlYMegUEOjABcGDs24AlBcQd1ibPRI7W0635Lqq0Qfqb
X-Gm-Gg: AYBFou2M9lOJ6QU3qdTREyq3vOm04vkjSnBjnMG/E38OWDuNHNi2sZznQHe7fdEcXlu
 ltgJ/ygjCfbe+IP2SVybQvlOaknGlvmX9M2mnu9V4o2CnyJoPuYdi4EovlvkDSprwJtUfuCKh0B
 vuoyrOKIW5L/TlqlM6dzRhOzW2v+HBs0QfLUZAHJyorQvHGv3d5fKSud74F1klcwbq8lv1bmMp/
 9hkgBN932KarfojmWBKARHDVmXdJAFGisSzreLBZRyhipa49lxHi6S9G5j8FxXyLKT3uUAU9L4n
 98t9mPl41pdrgkeyNNeicwuQx64AJgp8bKty46tJm4aRkaQeZbC3PTriSSTqQIwD805DtD0IN7K
 tOutmdBvS+9z/b+8/PtjedXbs1LQ1Yjyl3uLFX/7cq+tRdZxuRI4TKsRjdncuHvZvtm4ii8jDJg
 I7pdQchjbxLnFqEssRzNqL2TTiV2HCfwQJk1GztLTiv8V0D3kquL8KwsvHMbBLa4B/bNRc1E/2F
 jathJBxvkMawLe6qzt6veCR2G3UKtIai30mxuWW+7FXCmy2t/DNdfQw1Rusfzl+i4dNIJAMvPR0
 RE6ivXTZmHpuzb6BiPDIoTw3APlEnSzcm7o=
X-Received: by 2002:a17:90b:5703:b0:3ab:de4:7fa5 with SMTP id
 98e67ed59e1d1-3b1b0b659b2mr4801830a91.56.1794631403381; 
 Fri, 13 Nov 2026 20:43:23 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3eaf732sm3230685a91.3.2026.11.13.20.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:43:22 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v8 1/4] gpu: nova-core: move the debugfs root into the module
 data
Date: Sat, 14 Nov 2026 11:43:01 +0700
Message-ID: <20261114044304.245684-2-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114044304.245684-1-vladazaharova2018@gmail.com>
References: <20261114044304.245684-1-vladazaharova2018@gmail.com>
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
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
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

