Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540A1CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B956810E110;
	Mon, 19 Oct 2026 13:37:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084B610E110
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:37:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC48143A5D;
 Mon, 19 Oct 2026 13:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA721F000C4;
 Mon, 19 Oct 2026 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792417056;
 bh=3eRADoTLOXkqjjrw/UrGjAry3gq+uCsNvBDP+KQWRL8=;
 h=From:To:Cc:Subject:Date:Reply-To;
 b=epofOUUlKo52JU0CYFCw5QqNLKgjIsXBRtpERVJaBqRpr4pokpXWYb9bMAR07RrqX
 cs1q+A3FSzqXmauxMMf1rWcQTLn543/iLuE6htDD8RRgMdaln1stcdznNgMa4gJOY7
 A8djYpl2eqftIqvYs7Tgd3AN0YGoVt0W9QuX+y5SJS4yLu1hxzFr9x82iRFb1K2pZ/
 iJmCCkQvC/5HSW8aMblM0fQCPEYDfYBMW4h/4k7H/K6tRR6cCDmgfDkQbZWKtR2vty
 6AwEIk44HPkdU47lnAH2aj1jqn4WCUFOeO8t5/wC3mw7n3cWNaIqLQNhxqFEH0D/As
 vBuU/4AbblyeA==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH] gpu: nova-core: replace unsafe pointer cast with pin-init
 self-reference
Date: Mon, 19 Oct 2026 14:36:45 +0100
Message-ID: <20261019133647.1279779-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

Nova core's driver data makes use of a few unsafe self-references for
device resources. Replace them with pin-init's self reference feature
instead.

`auxiliary::Registration` is only allowed to capture a single lifetime, but
it needs to capture `&'gpu Gpu<'bar>`. However, we cannot use coercion here
as `Gpu` is invariant over `'bar`. As we know that `'bar` outlives `'gpu`,
use pin-init's existential lifetime to erase the `'bar` lifetime in
`NovaCoreApi`.

Swap bar1 and bar0's drop order to make pin-init happy.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/api.rs    | 15 ++++++++++-----
 drivers/gpu/nova-core/driver.rs | 27 ++++++++-------------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 29207c4bb743..62b1c8fe7125 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -22,9 +22,14 @@
 };
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
-pub struct NovaCoreApi<'bound> {
-    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
-    pub(crate) pdev: &'bound pci::Device<Bound>,
+#[pin_data]
+pub struct NovaCoreApi<'gpu>
+where
+    exists<'bar>: 'gpu,
+{
+    #[uses('bar: invariant)]
+    pub(crate) gpu: Pin<&'gpu Gpu<'bar>>,
+    pub(crate) pdev: &'gpu pci::Device<Bound>,
 }
 
 impl NovaCoreApi<'_> {
@@ -36,12 +41,12 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
 
     /// Returns the GPU [`GetGspStaticInfoReply`].
     pub fn gsp_static_info(&self) -> &GetGspStaticInfoReply {
-        &self.gpu.gsp_static_info
+        self.with_gpu(|gpu| &gpu.gsp_static_info)
     }
 
     /// Returns the GPU [`Spec`].
     pub fn spec(&self) -> &Spec {
-        &self.gpu.spec
+        self.with_gpu(|gpu| &gpu.spec)
     }
 
     /// Returns the size of the PCIe BAR used for accessing VRAM, typically
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 560a70c4f5a7..7ddde686879f 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -33,11 +33,13 @@
 #[pin_data]
 pub(crate) struct NovaCore<'bound> {
     #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
+    #[uses('gpu: invariant)]
+    _reg: auxiliary::Registration<'gpu, ForLt!(NovaCoreApi<'_>)>,
     #[pin]
-    pub(crate) gpu: Gpu<'bound>,
-    bar: pci::Bar<'bound, BAR0_SIZE>,
+    #[uses('bar1: invariant, 'bar: invariant)]
+    pub(crate) gpu: Gpu<'bar1>,
     bar1: pci::Bar<'bound>,
+    bar: pci::Bar<'bound, BAR0_SIZE>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -129,13 +131,10 @@ fn probe<'bound>(
                 crate::irq::doorbell_test::run_selftest(pdev, bar, spec.chipset)?;
             },
 
-            // TODO: Use self-referential pin-init syntax once available.
             gpu <- Gpu::new(
                 pdev,
-                // SAFETY: `bar` is initialized above, pinned, and outlives `gpu`.
-                unsafe { &*core::ptr::from_ref(bar) },
-                // SAFETY: `bar1` is initialized above, pinned, and outlives `gpu`.
-                unsafe { &*core::ptr::from_ref(bar1) },
+                bar,
+                bar1,
             ).pin_chain(|_gpu| {
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
                 _gpu.run_selftests(pdev);
@@ -143,16 +142,6 @@ fn probe<'bound>(
             }),
 
             _reg: {
-                // TODO: Use `&gpu` self-referential pin-init syntax once available.
-                //
-                // SAFETY: `gpu` is initialized before this expression is evaluated
-                // (`try_pin_init!()` initializes fields in initializer order), lives at
-                // a pinned stable address, and is dropped after `_reg` (struct field
-                // drop order).
-                let gpu = unsafe {
-                    Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_ref().get_ref()))
-                };
-
                 // SAFETY: `NovaCore` is dropped when the device is unbound;
                 // i.e. `mem::forget()` is never called on it.
                 unsafe {
@@ -164,7 +153,7 @@ fn probe<'bound>(
                         // never recycles IDs.
                         AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
                         crate::MODULE_NAME,
-                        NovaCoreApi { gpu, pdev },
+                        pin_init!(NovaCoreApi { gpu, pdev }),
                     )?
                 }
             },

base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
-- 
2.54.0

