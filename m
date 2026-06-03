Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B36CD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0498010F734;
	Wed,  3 Jun 2026 01:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LgEpdA1y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6A210F733
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:11:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 056DA43B57;
 Wed,  3 Jun 2026 01:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1964E1F00898;
 Wed,  3 Jun 2026 01:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780449063;
 bh=6kwWxpERwhRfbh+IYbhqXFQAvVIriNywyEds62Ao6CA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LgEpdA1ysW/6aW4sNfMAY+vmwXWjmraQAX/521n//865SRjUM0K5USCa9W0rmp8mV
 kJtjn0vbIlFRpLBSMH43IbdFtr5qpA/M8wS61jkuHqzV7pdAmYFVADgmJfM6g4LFbX
 s5zVBwIWG5EciXEKIUiIL2smDUQttiYVMhQk1/KnPtxfDjZlQ875R9Mz6N7/29y4Gn
 R+vrN2bF5qjOx7t8sh+3y0GFri5uDP2GcL/qsEaoDAO1YWilBBoD+u+mqmgVufANnA
 ykfuJna16K/nJ4u36Odn3M0lIuL2fh2YVfrSjmvTdn/r67lelpXpXm1CuGc9lLcdsd
 mOzs+75PWde7g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com,
 ecourtney@nvidia.com, m.wilczynski@samsung.com, david.m.ertman@intel.com,
 ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com,
 bhelgaas@google.com, kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 7/7] rust: io: mem: return DevresLt from
 IoMem/ExclusiveIoMem::into_devres()
Date: Wed,  3 Jun 2026 03:10:18 +0200
Message-ID: <20260603011020.2073650-8-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011020.2073650-1-dakr@kernel.org>
References: <20260603011020.2073650-1-dakr@kernel.org>
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

Implement ForLt and CovariantForLt for IoMem<'static, SIZE> and
ExclusiveIoMem<'static, SIZE> so that DevresLt can shorten the stored
'static lifetime back to the caller's borrow lifetime.

CovariantForLt is sound because both types only hold &'a Device<Bound>,
which is covariant over 'a.

Since DevresLt::new() handles the lifetime transmutation internally,
into_devres() no longer needs an explicit transmute to 'static.

Add DevresIoMem<SIZE> and DevresExclusiveIoMem<SIZE> type aliases.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/pwm/pwm_th1520.rs |  5 ++-
 rust/kernel/io/mem.rs     | 65 +++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 48808cd80737..7e3a06ed369f 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -24,9 +24,8 @@
 use kernel::{
     clk::Clk,
     device::{Bound, Core, Device},
-    devres,
     io::{
-        mem::IoMem,
+        mem::DevresIoMem,
         Io, //
     },
     of, platform,
@@ -92,7 +91,7 @@ struct Th1520WfHw {
 #[pin_data(PinnedDrop)]
 struct Th1520PwmDriverData {
     #[pin]
-    iomem: devres::Devres<IoMem<'static, TH1520_PWM_REG_SIZE>>,
+    iomem: DevresIoMem<TH1520_PWM_REG_SIZE>,
     clk: Clk,
 }
 
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index fc2a3e24f8d5..4691a01a3cf7 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -9,7 +9,7 @@
         Bound,
         Device, //
     },
-    devres::Devres,
+    devres::DevresLt,
     io::{
         self,
         resource::{
@@ -20,6 +20,10 @@
         MmioRaw, //
     },
     prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    },
 };
 
 /// An IO request for a specific device and resource.
@@ -172,6 +176,19 @@ pub struct ExclusiveIoMem<'a, const SIZE: usize> {
     _region: Region,
 }
 
+impl<const SIZE: usize> ForLt for ExclusiveIoMem<'static, SIZE> {
+    type Of<'a> = ExclusiveIoMem<'a, SIZE>;
+}
+
+// SAFETY: `ExclusiveIoMem<'a, SIZE>` is covariant over `'a`; it holds an `IoMem<'a, SIZE>`,
+// which holds `&'a Device<Bound>`, which is covariant.
+unsafe impl<const SIZE: usize> CovariantForLt for ExclusiveIoMem<'static, SIZE> {}
+
+/// A device-managed exclusive I/O memory region.
+///
+/// See [`ExclusiveIoMem::into_devres`].
+pub type DevresExclusiveIoMem<const SIZE: usize> = DevresLt<ExclusiveIoMem<'static, SIZE>>;
+
 impl<'a, const SIZE: usize> ExclusiveIoMem<'a, SIZE> {
     /// Creates a new `ExclusiveIoMem` instance.
     fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
@@ -198,15 +215,13 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
 
     /// Consume the `ExclusiveIoMem` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<ExclusiveIoMem<'static, SIZE>>` can outlive the original lifetime
-    /// `'a`. Access to the I/O memory is revoked when the device is unbound.
-    pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the
-        // `ExclusiveIoMem` does not actually outlive the device -- access is revoked and the
-        // resource is released when the device is unbound.
-        let iomem: ExclusiveIoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
-        let dev = iomem.iomem.dev;
-        Devres::new(dev, iomem)
+    /// The returned [`DevresExclusiveIoMem`] can outlive the original borrow and be stored in
+    /// driver data. Access to the I/O memory is revoked automatically when the device is unbound.
+    pub fn into_devres(self) -> Result<DevresExclusiveIoMem<SIZE>> {
+        let dev = self.iomem.dev;
+        // SAFETY: `ExclusiveIoMem` only holds a device reference and an I/O mapping, both of
+        // which remain valid for the device's full bound scope, not just for `'a`.
+        unsafe { DevresLt::new(dev, self) }
     }
 }
 
@@ -232,6 +247,19 @@ pub struct IoMem<'a, const SIZE: usize = 0> {
     io: MmioRaw<SIZE>,
 }
 
+impl<const SIZE: usize> ForLt for IoMem<'static, SIZE> {
+    type Of<'a> = IoMem<'a, SIZE>;
+}
+
+// SAFETY: `IoMem<'a, SIZE>` is covariant over `'a`; it holds `&'a Device<Bound>`,
+// which is covariant.
+unsafe impl<const SIZE: usize> CovariantForLt for IoMem<'static, SIZE> {}
+
+/// A device-managed I/O memory region.
+///
+/// See [`IoMem::into_devres`].
+pub type DevresIoMem<const SIZE: usize> = DevresLt<IoMem<'static, SIZE>>;
+
 impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
     fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
         // Note: Some ioremap() implementations use types that depend on the CPU
@@ -271,16 +299,13 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
 
     /// Consume the `IoMem` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<IoMem<'static, SIZE>>` can outlive the original
-    /// lifetime `'a`. Access to the I/O memory is revoked when the device
-    /// is unbound.
-    pub fn into_devres(self) -> Result<Devres<IoMem<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `IoMem` does not
-        // actually outlive the device -- access is revoked and the resource is released when the
-        // device is unbound.
-        let iomem: IoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
-        let dev = iomem.dev;
-        Devres::new(dev, iomem)
+    /// The returned [`DevresIoMem`] can outlive the original borrow and be stored in driver data.
+    /// Access to the I/O memory is revoked automatically when the device is unbound.
+    pub fn into_devres(self) -> Result<DevresIoMem<SIZE>> {
+        let dev = self.dev;
+        // SAFETY: `IoMem` only holds a device reference and an I/O mapping, both of which
+        // remain valid for the device's full bound scope, not just for `'a`.
+        unsafe { DevresLt::new(dev, self) }
     }
 }
 
-- 
2.54.0

