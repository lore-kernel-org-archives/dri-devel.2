Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48CAC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C95E10E7DB;
	Wed, 23 Sep 2026 04:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gscRAqAx";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54ED310E7DB
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 04:56:13 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-87c90648f99so465727b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790139373; x=1790744173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/sjzjwfKOPK+68pn0ND2VFCH5pb05Tmcgf4f+gG+DjE=;
 b=gscRAqAxmuEux3DmS3KCtU39th/Oz56MJzA1EVJ6zmBX0ro26W5V4JXbkhnErE4efJ
 cJSEyP+yWmbocb9UIYniLZ6+ecn4Jsaa+1J+2tgsrIg2K3jnISB32dlPrGByKyyiSQxn
 9oIUfy3oSm7e19jzqgcr0Pnc0ZgqcIMf14YCfTx15ju0eskAwgCEGew1/gKejc8o3H7v
 NxO+c1H3D8/xkf0kWkk+7X1kBtfYBRlBu4xPSy/lzDzhZ2WY3Sl4QiLD+lM9+UbKkhsN
 PYtgujWd7Mks4SXmz17JZqkIBa/U3z8vZXa+A2imIMjr/t0XDtG9DubWug+LXlQwM3vh
 E/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790139373; x=1790744173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/sjzjwfKOPK+68pn0ND2VFCH5pb05Tmcgf4f+gG+DjE=;
 b=LiUbJhtGPw20oTBlAJB9Gkj8aeGl6W2Azu1OIFYcg5GX4EMvQMxN0qtFeYbideDUR3
 12AAREOWqm/h4mKUgAM/EkFGzKya2EEcxX6+s6LbstMBBTSg7lJeWUiEg9wPVjJi0E0w
 CVygG5KgN+JporY7znHInhbyBebo2U4TXZ6gm1Ikvxtxlci1KMcsZIIZxEEDhjVNo4/s
 AQZ118eguTP8L5ywxutsepK4rO6Q8FzkMXU4UzCZnsZDPfPuuSjFjMDM3sEOzhv9drxU
 HYv1Ji0MqDZoy8n/6PTm7a0o8AlAmFOijrL9wNW4ZEC4HeAk9nhLm0O6UHI6Pvs77XOx
 V3yQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByopCJPomGfSve2vbk2y6o8APTY8x2ZxpShDGYIS5ceRICF9QFdgZ6X5uF90qyCchDctmrATBEgYaE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5BZga3uepjNcfLc6+cetDSq/QxPXH57Lj0w1kktHcb4hcZXhu
 j2bs02TvjsMRVeCD3xjLFY4UpLykA8surw6+KXu1jm6kWB5wYWnYtE/c
X-Gm-Gg: AYBFou3871XHFeQrryly44tVFmMrtnR/M+HtTmwEsIuCIswb5qWUOTl3nSSg65FqXfX
 snRLDGgjuoi67og153aG9k91OwCOiiGoqOCS0Voj+6iFVpbxbQelC0ZI5qYzhjUhnSVXfSSLp87
 Il2foSR8zX5iC2kCuZ6Q2up0wDUDxLxA+X7t53yRuBlqkhBclFPlmcP40qa3PGLiXeHiFq0S09H
 wbOwghbKdtjHVy1iKEe1rVjoxBca2MJf83RPdgVekKLlNtfCYmF79pAGO3SjJrO/TVMH9HfbhRC
 iZq/slfKIMPFZ065KQcB2fvLE05Hjif3Mv+aTfCDnYaMA5R7GP6aS2VG7pxvyD5BgpLqkpJI5j+
 wR3cVltJHlgj+wlYYVexWvJOrLvv8gFfpIc8In8QxaBRaCQbpLtr+svFLpMwOG0qUmrglJWTidt
 JgCkjZT9aWqgTnHF/LZ4C9iZhAbyZXvzfIuikHQHHIX1vDmHOHok3F1WOax5c/j3t+kbqUdBEBN
 iUP52hwRWLGQmI=
X-Received: by 2002:a05:6a00:1586:b0:87d:3894:1986 with SMTP id
 d2e1a72fcca58-87d389421e7mr1072428b3a.31.1790139371407; 
 Tue, 22 Sep 2026 21:56:11 -0700 (PDT)
Received: from localhost ([95.190.82.222]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1cec2d34sm664129b3a.14.2026.09.22.21.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 21:56:10 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v5 1/3] gpu: nova-core: move the debugfs root into the module
 data
Date: Wed, 23 Sep 2026 11:55:49 +0700
Message-ID: <20260923045551.229259-2-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923045551.229259-1-vladazaharova2018@gmail.com>
References: <20260923045551.229259-1-vladazaharova2018@gmail.com>
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

The debugfs root lives in a static that init() fills in and a guard
field of the module data clears again. That costs a `static mut`, an
unsafe write on each side and a guard type whose only job is to undo
the write.

It also leaks. try_pin_init! drops only the fields it has already
built, and the guard is written after the Registration, so a
registration that fails leaves the guard unbuilt and the static set.
Statics are never dropped, and the module is unloaded right away, so
the directory outlives everything that could remove it. The next load
then finds the name taken: debugfs_create_dir() returns -EEXIST, which
Entry keeps as it would any other pointer, and the driver comes up with
no debugfs at all until the machine is rebooted.

Have the module data own a DebugfsData instead, built before the
registration and dropped after it, and keep only a pointer to it in the
static, for devices that have no other way to reach the data of their
module. What is left is one unsafe read for the users and a single write
when the data is built, with no guard type. A registration that fails
now drops the data that was built before it, and the directory goes with
it.

Assisted-by: LLM
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 drivers/gpu/nova-core/gsp.rs       | 10 +---
 drivers/gpu/nova-core/nova_core.rs | 73 ++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index dda58095f40b..01ed4adffe93 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -199,15 +199,7 @@ pub(crate) fn new(
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
+                    let log_parent: &debugfs::Dir = crate::debugfs_data(dev).root();
 
                     log_parent.scope(log_buffers, dev.name(), |logs, dir| {
                         dir.read_binary_file(c"loginit", &logs.loginit.0);
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 1133c6ce5c55..08509f64770e 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -4,6 +4,7 @@
 
 use kernel::{
     debugfs,
+    device,
     driver::Registration,
     pci,
     prelude::*,
@@ -30,40 +31,74 @@
 
 pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
-// TODO: Move this into per-module data once that exists.
-static mut DEBUGFS_ROOT: Option<debugfs::Dir> = None;
+/// Pointer to the [`DebugfsData`] the module owns.
+///
+/// A device has no way to reach the data of its module, so code running on behalf of a bound
+/// device goes through here instead.
+/// Written once, while the module data is built, and never again: what it points at is dropped
+/// only after the driver is unregistered, so it is good for as long as any device is bound, and
+/// is not read outside of that.
+// TODO: Drop this once devices can reach the data of their module.
+static mut DEBUGFS_DATA: *const DebugfsData = core::ptr::null();
 
-/// Guard that clears `DEBUGFS_ROOT` when dropped.
-struct DebugfsRootGuard;
+/// Data the module shares with every GPU it drives.
+///
+/// Reached from a device through [`debugfs_data()`].
+#[pin_data]
+pub(crate) struct DebugfsData {
+    /// Root directory of the driver in debugfs.
+    root: debugfs::Dir,
+}
+
+impl DebugfsData {
+    /// Creates the shared data.
+    fn new() -> impl PinInit<Self> {
+        pin_init!(Self {
+            root: debugfs::Dir::new(c"nova-core"),
+        })
+    }
 
-impl Drop for DebugfsRootGuard {
-    fn drop(&mut self) {
-        // SAFETY: This guard is dropped after `_driver` (due to field order),
-        // so the driver is unregistered and no probe() can be running.
-        unsafe { DEBUGFS_ROOT = None };
+    /// Returns the root directory of the driver in debugfs.
+    pub(crate) fn root(&self) -> &debugfs::Dir {
+        &self.root
     }
 }
 
+/// Returns the data the module shares with its devices.
+///
+/// The bound device is what makes this sound: the data is built before the driver is registered
+/// and dropped after it is unregistered, so it outlives every device that is bound, and the
+/// returned reference cannot be held past the one it is taken for.
+pub(crate) fn debugfs_data<'a>(_dev: &'a device::Device<device::Bound>) -> &'a DebugfsData {
+    // SAFETY: A device can only be bound once the driver is registered, which happens after
+    // `DEBUGFS_DATA` is written, so it points at the data of this module, which lives at least
+    // as long as the caller's device is bound.
+    unsafe { &*DEBUGFS_DATA }
+}
+
 #[pin_data]
 struct NovaCoreModule {
-    // Fields are dropped in declaration order, so `_driver` is dropped first,
-    // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
+    // Fields are dropped in declaration order, so the registration goes first and no probe() can
+    // still be running once the shared data is torn down. `init()` builds them the other way
+    // round, as the data has to be there before the first probe() reaches for it.
     #[pin]
     _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
-    _debugfs_guard: DebugfsRootGuard,
+    #[pin]
+    _debugfs: DebugfsData,
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
+                // SAFETY: Nothing reads `DEBUGFS_DATA` before a device is bound, which cannot
+                // happen until the driver is registered below. What it points at is dropped only
+                // once the driver is unregistered, so it is valid for as long as any device is
+                // bound, and nothing reads it outside of that.
+                unsafe { DEBUGFS_DATA = &*_debugfs };
+            },
             _driver <- Registration::new(MODULE_NAME, module),
-            _debugfs_guard: DebugfsRootGuard,
         })
     }
 }
-- 
2.55.0

