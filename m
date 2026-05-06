Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98107CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C3910EED8;
	Wed,  6 May 2026 22:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A14q5gM6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A8310EED8
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:00:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 180C860181;
 Wed,  6 May 2026 22:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A96EC2BCB2;
 Wed,  6 May 2026 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104846;
 bh=g+VFtZvKf6WOxAsZvmu6omoAgBIUzl+XzC7tNpmWzIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A14q5gM6aGbC2I6AMqUEeS3HHs2BKtkXPO3aDMJZy593n38fIbQNFfr2z32OJ2HZg
 8kko1Oawj/aju7hvKtu0fmNMthou/yrcayyzJ945It9C/z/BMrxEUdynLDFbbXxVcX
 m8tC66F9Zu2FImco+oDcVfRNZKsisY86Wm5kB05eeMRj6FQ45zxOCWhAACOudXNlch
 HIiAE9+Hrcr3Drfyq+8nG1GJztuNUrK3POEpgoIL13tKe2jH0uQwzabKg+bEaKO2XD
 WP+o9jGDTy2is5XI45w+xrDflxgjIafKI8mJSeJct/fgho30d2BEIgv3oA71aQjoMB
 f/+yV0jMgwwwA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/3] rust: pci: return DevresLt from Bar::into_devres()
Date: Wed,  6 May 2026 23:58:34 +0200
Message-ID: <20260506220012.855173-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506220012.855173-1-dakr@kernel.org>
References: <20260506220012.855173-1-dakr@kernel.org>
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

Implement ForLt for Bar<'static, SIZE> so that DevresLt can shorten the
stored 'static lifetime back to the caller's borrow lifetime via
ForLt::cast_ref. Without this, Devres<Bar<'static, SIZE>>::access()
would return &'bound Bar<'static, SIZE>, allowing the inner 'static to
leak through methods like pdev().

Add a DevresBar<SIZE> type alias for convenience.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs    |  1 +
 rust/kernel/pci/io.rs | 30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 1335857cae94..265d06b18e42 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -48,6 +48,7 @@
     ConfigSpace,
     ConfigSpaceKind,
     ConfigSpaceSize,
+    DevresBar,
     Extended,
     Normal, //
 };
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 5668394a155b..7a5b5210cf66 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -6,7 +6,7 @@
 use crate::{
     bindings,
     device,
-    devres::Devres,
+    devres::DevresLt,
     io::{
         Io,
         IoCapable,
@@ -14,7 +14,8 @@
         Mmio,
         MmioRaw, //
     },
-    prelude::*, //
+    prelude::*,
+    types::ForLt, //
 };
 use core::{
     marker::PhantomData,
@@ -151,6 +152,18 @@ pub struct Bar<'bound, const SIZE: usize = 0> {
     num: i32,
 }
 
+// SAFETY: `Bar<'bound, SIZE>` is covariant over `'bound` -- it holds
+// `&'bound Device<Bound>`, which is covariant. Shortening the lifetime
+// is therefore sound.
+unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
+    type Of<'bound> = Bar<'bound, SIZE>;
+}
+
+/// A device-managed PCI BAR mapping.
+///
+/// See [`Bar::into_devres`].
+pub type DevresBar<const SIZE: usize> = DevresLt<Bar<'static, SIZE>>;
+
 impl<'bound, const SIZE: usize> Bar<'bound, SIZE> {
     pub(super) fn new(pdev: &'bound Device<device::Bound>, num: u32, name: &CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
@@ -219,15 +232,16 @@ fn release(&self) {
 
     /// Consume the `Bar` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the original lifetime `'bound`. Access
-    /// to the BAR is revoked when the device is unbound.
-    pub fn into_devres(self) -> Result<Devres<Bar<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `Bar` does not
+    /// Access methods on the returned [`DevresLt`] shorten the inner lifetime via
+    /// [`ForLt::cast_ref`], so the transmuted `'static` is never exposed to callers.
+    pub fn into_devres(self) -> Result<DevresLt<Bar<'static, SIZE>>> {
+        // SAFETY: Casting to `'static` is sound because `DevresLt` guarantees the `Bar` does not
         // actually outlive the device -- access is revoked and the resource is released when the
-        // device is unbound.
+        // device is unbound. The `ForLt` encoding ensures `access()` shortens the lifetime back
+        // to the caller's borrow, preventing `'static` from leaking.
         let bar: Bar<'static, SIZE> = unsafe { core::mem::transmute(self) };
         let pdev = bar.pdev;
-        Devres::new(pdev.as_ref(), bar)
+        DevresLt::new(pdev.as_ref(), bar)
     }
 }
 
-- 
2.54.0

