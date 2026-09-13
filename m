Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9D9C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A06F10E9C8;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AlmsXHna";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D73810E0B9
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:37:56 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2dd6665a10fso1460085ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789324676; x=1789929476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLpXy9tNi5ms1dbYyVi6I1as/81y8YWcT2cY9iWq8NU=;
 b=AlmsXHnagZDFOwgJbnkYBU6lr2t82O5moA9hrLVhSnpuYQYWRMxYxgiDzi113qsPC8
 XvS/1Om9PtPr3zUdKiiaYi8UlCuHBfzQKHc54v1BdgRKXhkNF84a8PjRZETxu8FEsW+j
 klhfR7kDvbYaWdMDeoIql+Wqzs4ntH1er78hhaO26tSHlCnpuV6VIL1zcZhcYDDwFtev
 +QQXlLVg/DunfV/Ize7i5Jx5UDKxREHw/veD2PugW9vGTexoVD/1h+2/ppvDvnvpj5E8
 A0mV/fGmUEibyjrNUVi7cpLpjCL/I45b96VpJtPSsRj2JRTXRQn712JN9sRWA14tUsQk
 j1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789324676; x=1789929476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hLpXy9tNi5ms1dbYyVi6I1as/81y8YWcT2cY9iWq8NU=;
 b=kU/AFEjSbZUqy2i9OAsGZv7ez9XzjH17T/RCfmad62VJzqTC2qcD5VYtfhFEvfbYjh
 i/fQy6q0I4dA2ejceZI5hDS/mtdU/op1WECEWCtjppw3MoAnqR95BGocFsAU464HWyhG
 QB32JItmfYoeCzmz79tK3Zd/eAHLtnFArblQVm2pKhaL/g2e5+K3yyNo4UAUSsACkAHt
 6zSSEc6b3FQc0gSiuJhncVPtBYpHk8oHZC1Bmggyot2/uPAri2NHcEvh688MoWwUjvUJ
 pmcNaHh1U2t3AiEkAYFRVBO9Xee22avh9dn+0diciAEQzIkPEv5pR7/3GxYeGeOrqnW/
 Uk0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNsSm1FHe6cbThdGPKw+8EVLuZ6gRdHyYYtRt6x2x8alsJQppHRlNtgd9tzO81f0NFUDLwaCYzmns=@lists.freedesktop.org
X-Gm-Message-State: AFuF++luIUxYOl9FUtw0l2zvAlRo4H+OT+tUvXAH59rbksoxcqsclPt3
 ApawHa6tQZwdUMw8pHZJUnkhOlF15Gy+ggqQrJ0DJCshr+2R4drdoFrC
X-Gm-Gg: AYBFou1zkkavJFUSEo0usFZmyQfX5slEjL1Gfq3H6AHSzSPRP2L2lZgf4tD2TfXNm0T
 xcbY98JgbiR3CH8dvUPDFPdyCiJ1QDR0mF7mKnTPawxazGpEFwypws6CJGoMyfG1CJr7VZVXQjR
 NHL1lHCNPOn5oQ0KYJTkNeB0YBVRFG/DchyLzt3zLRUU0wO9CAGIbkeDq3IZxmI5UnC7RImWcCT
 l0nYXYhO6lcQUd/9rT41jpOPzVjtDz/GvYBPbLeNw9m1RwUV8ZLhZq+XRGJEY5/NGCKVii3WhTH
 QkEXu1drcvwse96NlfsP2Y1+VJQDT5zFBp3Y7Fa6CLVXe3Ck3Vjr0mwFV8+kWI7ZUIc+aDFUKL8
 OESsSkm/yegTjUNuUToGsgU55tdr+LKaF76e6pNSh/nXeX1KzzC0vRd1KhraZuzegPO30PfcE12
 TYcbRFiE8AZrgzE4RsluvIy2Nx3tCD9BsNT2vziYls9mXBl/AXDFZamWtvXdI1PdLpmzsn//QQU
 pqmRQ==
X-Received: by 2002:a17:90b:3812:b0:398:990e:1587 with SMTP id
 98e67ed59e1d1-39d9beb8e80mr23558089a91.9.1789324675485; 
 Sun, 13 Sep 2026 11:37:55 -0700 (PDT)
Received: from localhost ([95.190.112.239]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d9b08165fsm4118447a91.1.2026.09.13.11.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 11:37:55 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v4 1/3] gpu: nova-core: move the debugfs root into the module
 data
Date: Mon, 14 Sep 2026 01:37:32 +0700
Message-ID: <20260913183734.134307-2-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913183734.134307-1-vladazaharova2018@gmail.com>
References: <20260913183734.134307-1-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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
module. What is left is one unsafe read for the users and one write on
each side, with no guard type. A registration that fails now drops the
data that was built before it, and the directory goes with it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 drivers/gpu/nova-core/gsp.rs       | 15 +++---
 drivers/gpu/nova-core/nova_core.rs | 82 +++++++++++++++++++++++-------
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 25ea43f1cbe9..f29e601e6753 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -196,15 +196,12 @@ pub(crate) fn new(pdev: &'gsp pci::Device<device::Bound>) -> impl PinInit<Self,
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
+                    // PANIC: The module data cannot be gone here. It is published before the
+                    // driver is registered and taken down after it is unregistered, so it is
+                    // there for as long as probe() can be called.
+                    let log_parent: &debugfs::Dir = crate::debugfs_data()
+                        .expect("module data not initialized")
+                        .root();
 
                     log_parent.scope(log_buffers, dev.name(), |logs, dir| {
                         dir.read_binary_file(c"loginit", &logs.loginit.0);
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 1133c6ce5c55..0f8501c26e05 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -30,40 +30,84 @@
 
 pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
-// TODO: Move this into per-module data once that exists.
-static mut DEBUGFS_ROOT: Option<debugfs::Dir> = None;
+/// Pointer to the [`DebugfsData`] the module owns.
+///
+/// A device has no way to reach the data of its module, so probe() goes through here instead.
+// TODO: Drop this once devices can reach the data of their module.
+static mut DEBUGFS_DATA: *const DebugfsData = core::ptr::null();
 
-/// Guard that clears `DEBUGFS_ROOT` when dropped.
-struct DebugfsRootGuard;
+/// Data the module shares with every GPU it drives.
+///
+/// # Invariants
+///
+/// A non-null `DEBUGFS_DATA` points at a live, pinned instance of this type that outlives the
+/// driver registration.
+#[pin_data(PinnedDrop)]
+pub(crate) struct DebugfsData {
+    /// Root directory of the driver in debugfs.
+    root: debugfs::Dir,
+}
+
+impl DebugfsData {
+    /// Creates the shared data and publishes it, so that [`debugfs_data()`] can hand it out.
+    fn new() -> impl PinInit<Self> {
+        pin_init!(&this in Self {
+            root: debugfs::Dir::new(c"nova-core"),
+            _: {
+                // SAFETY: Module initialization runs once and before the driver is registered, so
+                // nothing can be reading `DEBUGFS_DATA` while it is written here. `this` is where
+                // the data is being built, and it stays there: the module data never moves.
+                unsafe { DEBUGFS_DATA = this.as_ptr() };
+            },
+        })
+    }
+
+    /// Returns the root directory of the driver in debugfs.
+    pub(crate) fn root(&self) -> &debugfs::Dir {
+        &self.root
+    }
+}
 
-impl Drop for DebugfsRootGuard {
-    fn drop(&mut self) {
-        // SAFETY: This guard is dropped after `_driver` (due to field order),
-        // so the driver is unregistered and no probe() can be running.
-        unsafe { DEBUGFS_ROOT = None };
+#[pinned_drop]
+impl PinnedDrop for DebugfsData {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: This runs after the registration is dropped, as the fields of `NovaCoreModule`
+        // are dropped in declaration order, so the driver is unregistered and neither a probe()
+        // nor the teardown of a device can be reading `DEBUGFS_DATA`.
+        unsafe { DEBUGFS_DATA = core::ptr::null() };
     }
 }
 
+/// Returns the data the module shares with its devices, or [`None`] if there is none yet.
+///
+/// Only ever call this while the driver is registered, which is to say from probe() or from the
+/// teardown of a device that is bound: the data is built before the registration and dropped
+/// after it, and nothing else keeps what is returned here alive.
+pub(crate) fn debugfs_data() -> Option<&'static DebugfsData> {
+    // SAFETY: `DEBUGFS_DATA` is written while the module data is initialized, before the driver
+    // is registered, and again when that data is dropped, after the driver is unregistered. Both
+    // happen with no device bound, so a caller in probe() or in the teardown of a device cannot
+    // race with either, and by the type invariant what it gets points at live data that outlives
+    // the device it is used from.
+    unsafe { DEBUGFS_DATA.as_ref() }
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
             _driver <- Registration::new(MODULE_NAME, module),
-            _debugfs_guard: DebugfsRootGuard,
         })
     }
 }
-- 
2.55.0

