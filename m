Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD8BC5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 10:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46CC10E239;
	Sun, 23 Aug 2026 10:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="geTsZfBG";
	dkim-atps=neutral
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DBE10E02A
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1787482263; x=1787741463;
 bh=ndGal1cXVZUbezixECVIKJYKCvb9q7L6KKpWhIR5QSk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=geTsZfBGJutpILb5vWiA2fufhYvDRzHo/ZXng50lfiSWLz/DrTJMzm7irYZkACsTA
 ZO6WPrET4ylLh+BqI007YyHVlHV/Q3jyBstnET+CfBFzXFonEz5LIhojaJLlyw+gYZ
 FLHJrYN2se0Mhyn9Q5I+c7f9d4//HHn07eUtSoqj8GHWO8cPZQzezK6CK7hiwtV+Vt
 T+34yrmjwAvZhYDQbAeOM5hBHL9GsnFdygNuIMbmKiV7JyA1kvy1ONvIwEt2q3Etdj
 jDOFNHpLSD0t6Omduf2c8sCqBDmh6CkXbE9Fa6rjtCKaXrXms4o88i/DRTCrxtehK+
 QNw+oYDwxWPGQ==
X-Pm-Submission-Id: 4hSW6r4w0dz1DDWs
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 2/2] drm/tyr: unplug the GPU when reset fails
Date: Sun, 23 Aug 2026 13:50:08 +0300
Message-ID: <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Wrap the DRM registration in Arc<Revocable<_>> and share it with the
reset controller. If a reset fails, stop reset scheduling and revoke
the registration. Dropping the registration calls drm_dev_unplug()
which prevents new DRM critical sections and waits for existing ones
before the registration data is released.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs | 12 +++++++-----
 drivers/gpu/drm/tyr/reset.rs  | 32 +++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 92ed0de0b4e4..03ad00a89420 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -22,6 +22,7 @@
     prelude::*,
     regulator,
     regulator::Regulator,
+    revocable::Revocable,
     sizes::SZ_2M,
     sync::{
         aref::ARef,
@@ -56,7 +57,7 @@ pub(crate) struct TyrPlatformDriverData<'bound> {
     // ensure the correct drop order.
     #[pin]
     _reset: reset::ResetHandle<'bound>,
-    _reg: drm::Registration<'bound, TyrDrmDriver>,
+    _reg: Arc<Revocable<drm::Registration<'bound, TyrDrmDriver>>>,
     _device: ARef<TyrDrmDevice>,
 }
 
@@ -161,17 +162,18 @@ fn probe<'bound>(
                     gpu_info,
             });
 
-            // SAFETY: `reg` is stored in the platform driver data and is not leaked or
-            // forgotten, so it is dropped before the `'bound` registration data can become
-            // invalid.
+            // SAFETY: `reg` is wrapped in a `Revocable` owned by the platform driver
+            // data and its reset handle. Neither is leaked or forgotten, so `reg` is
+            // dropped before the `'bound` registration data can become invalid.
             let reg =
                 unsafe { drm::Registration::new_with_lt(pdev.as_ref(), unreg_dev, reg_data, 0)? };
             let device = reg.device().into();
+            let reg = Arc::pin_init(Revocable::new(reg), GFP_KERNEL)?;
 
             let driver = try_pin_init!(TyrPlatformDriverData {
                 // SAFETY: `ResetHandle` is stored in platform driver data and is
                 // dropped before the borrowed device and MMIO references expire.
-                _reset <- unsafe { reset::ResetHandle::new(pdev, hw)? },
+                _reset <- unsafe { reset::ResetHandle::new(pdev, hw, reg.clone())? },
                 _reg: reg,
                 _device: device,
                 _: {
diff --git a/drivers/gpu/drm/tyr/reset.rs b/drivers/gpu/drm/tyr/reset.rs
index 1abcd25877d3..50690daec31a 100644
--- a/drivers/gpu/drm/tyr/reset.rs
+++ b/drivers/gpu/drm/tyr/reset.rs
@@ -28,12 +28,14 @@
         Bound,
         Device, //
     },
+    drm,
     io::{
         poll,
         Io, //
     },
     platform,
     prelude::*,
+    revocable::Revocable,
     sync::{
         atomic::{
             Atomic,
@@ -53,7 +55,10 @@
 };
 
 use crate::{
-    driver::IoMem,
+    driver::{
+        IoMem,
+        TyrDrmDriver, //
+    },
     gpu,
     regs::gpu_control::*, //
 };
@@ -87,6 +92,8 @@ struct Controller<'ctrl> {
     state: Atomic<ResetState>,
     /// Shared gate that coordinates hardware access with GPU reset.
     hw: Arc<HwGate<'ctrl>>,
+    /// DRM registration revoked when a reset fails.
+    registration: Arc<Revocable<drm::Registration<'ctrl, TyrDrmDriver>>>,
 }
 
 impl<'ctrl> ScopedWorkItem for Controller<'ctrl> {
@@ -100,11 +107,13 @@ impl<'ctrl> Controller<'ctrl> {
     fn new(
         pdev: &'ctrl platform::Device<Bound>,
         hw: Arc<HwGate<'ctrl>>,
+        registration: Arc<Revocable<drm::Registration<'ctrl, TyrDrmDriver>>>,
     ) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
             pdev,
             state: Atomic::new(ResetState::Idle),
             hw,
+            registration,
         })
     }
 
@@ -119,8 +128,8 @@ fn try_transition(&self, from: ResetState, to: ResetState) -> bool {
     /// If the pending reset cannot be claimed, the worker returns immediately.
     ///
     /// It first claims [`ResetState::Pending`], then waits for earlier hardware
-    /// accesses to complete before issuing the reset and returning the worker
-    /// state to [`ResetState::Idle`].
+    /// accesses to complete before issuing the reset. A successful reset returns
+    /// the worker state to [`ResetState::Idle`]; a failure unplugs the DRM device.
     ///
     /// Panthor reference:
     /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
@@ -134,16 +143,13 @@ fn reset_work(&self) {
         let reset_result = run_reset(self.pdev.as_ref(), &self.hw);
 
         if let Err(e) = reset_result {
-            dev_err!(self.pdev, "GPU reset failed: {:?}\n", e);
-
-            // TODO: Unplug the GPU.
-            // There is no API for unplugging the GPU and this is unreachable
-            // for now since there are no hardware users for reset API.
+            dev_err!(self.pdev, "GPU reset failed, unplugging the GPU: {:?}\n", e);
+            let _ = self.try_transition(ResetState::InProgress, ResetState::ShuttingDown);
+            self.registration.revoke();
         } else {
             dev_dbg!(self.pdev, "GPU reset completed.\n");
+            let _ = self.try_transition(ResetState::InProgress, ResetState::Idle);
         }
-
-        let _ = self.try_transition(ResetState::InProgress, ResetState::Idle);
     }
 }
 
@@ -168,9 +174,13 @@ impl<'reset> ResetHandle<'reset> {
     pub(crate) unsafe fn new(
         pdev: &'reset platform::Device<Bound>,
         hw: Arc<HwGate<'reset>>,
+        registration: Arc<Revocable<drm::Registration<'reset, TyrDrmDriver>>>,
     ) -> Result<impl PinInit<Self, Error>> {
         Ok(try_pin_init!(Self {
-            controller <- kernel::new_scoped_work!("tyr::reset", Controller::new(pdev, hw)),
+            controller <- kernel::new_scoped_work!(
+                "tyr::reset",
+                Controller::new(pdev, hw, registration)
+            ),
             // SAFETY: The caller guarantees the handle is dropped.
             wq: unsafe { ScopedQueue::new(c"tyr-reset-wq")? },
         }))

-- 
2.51.2
