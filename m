Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66821CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B032910E9D9;
	Wed, 14 Oct 2026 15:46:21 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D1810E9D9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:46:15 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-85377c8bc96so1873622b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791992775; x=1792597575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sy22pDYfeuvek64LZa9ynQRcmq/GB+YgHcRlx1f8W0A=;
 b=c2YQGHaPOd9fRGDJ4Gb+vOec2pkFcfUxUoD16FFM5gCUAv+YHLVYICAQxl3fZbElPK
 aW8O5TeY850pEM64RGE6YdzKgS22hHNrRS/A6qDGpLTEz65O+6cAwyttHZoVWM6hg51G
 uaj51TT5rUxma+emO8URJD8EvhqtOtSA3I3u51UmGBHsWLyQ8ov5FIe81NATMQsK29JP
 PCwQ8CltycB77HSeMN0oxbWOQpC6Un1Wmw2ROJcJwBBfRgEgU5lh5O/gAY6gn71u1617
 myCjsROmh++BAOx/TM5E2U8oPJYwnOn6BXpYqMgQaFDk1SANme7GWu3zkw6qTX3z0nRk
 ElpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791992775; x=1792597575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sy22pDYfeuvek64LZa9ynQRcmq/GB+YgHcRlx1f8W0A=;
 b=bDysu5ABxmiGj1O4WHP3bBNwKncD5M0inhyc9gdeffg8DwWrSYIRgO+K5sXmBsB/35
 5C+STcX2UWzGN60P+UrrSvUsvKrvIF/UyJgHaiyZyIrnm0KNjRO9S8AYEXT6kkObwEJ2
 xM3GiZN4ci9ng4cLImPYWSkdeDEBuOuiullB1tH0Rwe5uWYAZ1HITRdzLwBt0+q+8jlg
 kiOV1GiyfkhhbtSuuq1j9f56EXgRw7MMkICQQPAFndxxobIV/Dr5YMDNMSU2OPhJ/v/w
 zvciI881C8BIJ22/CyUfS7RCIDsfEfLR9b8AG0ryHdGrxHZeKqvCqZ2NA8HLHd7L5aEz
 JvdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2sFncLqbUZvyuA8cf5MCq1eohcreIvBayL50zLLrZLifvAs6c3+ikGV9jFeEAHeGB2SB5KTA3GbI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYCZbn6oEC/TU7NCTv5s4b69uPNzeXI0DkUwIrBGXGg9OaKdbE
 cRWpNAvATiduZ9VxTghkvJqE7yOps0ToCDooGeVqcj7KZw/uFW7jlIZe
X-Gm-Gg: AYBFou0C6i75Fy7xGeOHCGXewlYm0r+ES8US9rDT3HuD+qjYPYQR17ka6JFJS/uqGpB
 88n8iXLDKnotUWYX79yu96rop+MAGzMcHeZKKyYY428xbM/kw9ln+zR/SZBsRMlXBPBVtQD7ugG
 6aP/CBryj1lpcsUs4rQk4lC30ZltDIJfpZfSSYb32ZhPQdKYANXGeA79g9GOH2CYxITm2DikdOf
 83/g5DEduv4v+5DsxoClBoUrT3+RnBUn7RqHoomqX9Y0XQeYFTKYDunZgP9ZLnnUmxa9o0VsWpQ
 2p13YOrllorW/er3Fapm3ecW0WaKDv0vHKx39RieZsDZ9l7UwW2Kg31ZutQeaCTxwgwwRJHSbqF
 LCeSSo1eCGAhliQnfT8x+uJpIdUE+h1UypY0Rsp1pESXp04UYp6Nvs7WfP+Qq+tta6FMfKW9Jid
 lAWapba7/iC8saxAtkgebQgjNSwIqB0H8/CcQK/WFBjJfcDdD6eZgcWpAwUReghi7GwHVm2jbMm
 BGZ
X-Received: by 2002:a05:6a00:22ce:b0:89d:7832:55f2 with SMTP id
 d2e1a72fcca58-89d78325697mr3135446b3a.36.1791992774636; 
 Wed, 14 Oct 2026 08:46:14 -0700 (PDT)
Received: from localhost ([37.22.102.248]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d80511db9sm1300598b3a.56.2026.10.14.08.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:46:14 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v6 1/3] gpu: nova-core: move the debugfs root into the module
 data
Date: Wed, 14 Oct 2026 22:45:52 +0700
Message-ID: <20261014154554.231015-2-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014154554.231015-1-vladazaharova2018@gmail.com>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
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
 drivers/gpu/nova-core/nova_core.rs | 74 ++++++++++++++++++++++--------
 2 files changed, 56 insertions(+), 28 deletions(-)

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
index a8f6dc22057b..ee3a6600f320 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -4,6 +4,7 @@
 
 use kernel::{
     debugfs,
+    device,
     driver::Registration,
     pci,
     prelude::*,
@@ -32,40 +33,75 @@
 
 pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
-// TODO: Move this into per-module data once that exists.
-static mut DEBUGFS_ROOT: Option<debugfs::Dir> = None;
+/// Pointer to the [`DebugfsData`] the module owns.
+///
+/// A device has no way to reach the data of its module, so code running on behalf of a bound
+/// device goes through here instead.
+///
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
2.56.0

