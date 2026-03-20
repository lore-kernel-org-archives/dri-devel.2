Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEEA1099B37
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61FA10EC19;
	Fri, 20 Mar 2026 19:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XfiuRB0r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB3310EBD6;
 Fri, 20 Mar 2026 19:47:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DE67E6091C;
 Fri, 20 Mar 2026 19:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4BBC2BCAF;
 Fri, 20 Mar 2026 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774036030;
 bh=H19eCxDOxVLkokvJ6mibpjYwYFYpFnwlymEHSUKk2CM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XfiuRB0rmDmC7dl8VW4ICAzjET0MPrSZ9M/Kxxz/Vbq4Y7R1xbCYg7GFgHNtvkEz9
 KCR4fLPOCokYjrVerEKuP/3JWyKGiSWhgZlb7tXTTsFBHpo6+VtyG5kxN8AFU+OHud
 uYuNpxG/JaG1tLiySY0M89cpXZEIy4OV6vL+LSKp+4T094FwVjeele90B15LxxVd5F
 aM5ZzulIxzSG4Onk03Mg7iZ6sbj//7bW5HR6S/uUx+nsq8m946rTRcR7M9i3+OcQq5
 JBU5qLiGZURTfRxksi7i/V/Ey0q+jKSBqB9hXtjJMNrArV1l8JV6lyQiKcNIgnEjSW
 cuXY1ut48OF/A==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 7/8] gpu: nova-core: convert Gsp::new() to use CoherentBox
Date: Fri, 20 Mar 2026 20:45:42 +0100
Message-ID: <20260320194626.36263-8-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320194626.36263-1-dakr@kernel.org>
References: <20260320194626.36263-1-dakr@kernel.org>
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

Convert libos (LibosMemoryRegionInitArgument) and rmargs
(GspArgumentsPadded) to use CoherentBox / Coherent::init() and simplify
the initialization. This also avoids separate initialization on the
stack.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/gsp.rs    | 47 +++++++++++--------------
 drivers/gpu/nova-core/gsp/fw.rs | 62 +++++++++++++++++++++++----------
 2 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 72f173726f87..f0a50bdc4c00 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -5,10 +5,11 @@
 use kernel::{
     device,
     dma::{
+        Coherent,
         CoherentAllocation,
+        CoherentBox,
         DmaAddress, //
     },
-    dma_write,
     pci,
     prelude::*,
     transmute::AsBytes, //
@@ -106,7 +107,7 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
 #[pin_data]
 pub(crate) struct Gsp {
     /// Libos arguments.
-    pub(crate) libos: CoherentAllocation<LibosMemoryRegionInitArgument>,
+    pub(crate) libos: Coherent<[LibosMemoryRegionInitArgument]>,
     /// Init log buffer.
     loginit: LogBuffer,
     /// Interrupts log buffer.
@@ -117,7 +118,7 @@ pub(crate) struct Gsp {
     #[pin]
     pub(crate) cmdq: Cmdq,
     /// RM arguments.
-    rmargs: CoherentAllocation<GspArgumentsPadded>,
+    rmargs: Coherent<GspArgumentsPadded>,
 }
 
 impl Gsp {
@@ -126,34 +127,28 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
         pin_init::pin_init_scope(move || {
             let dev = pdev.as_ref();
 
+            // Initialise the logging structures. The OpenRM equivalents are in:
+            // _kgspInitLibosLoggingStructures (allocates memory for buffers)
+            // kgspSetupLibosInitArgs_IMPL (creates pLibosInitArgs[] array)
             Ok(try_pin_init!(Self {
-                libos: CoherentAllocation::<LibosMemoryRegionInitArgument>::alloc_coherent(
-                    dev,
-                    GSP_PAGE_SIZE / size_of::<LibosMemoryRegionInitArgument>(),
-                    GFP_KERNEL | __GFP_ZERO,
-                )?,
                 loginit: LogBuffer::new(dev)?,
                 logintr: LogBuffer::new(dev)?,
                 logrm: LogBuffer::new(dev)?,
                 cmdq <- Cmdq::new(dev),
-                rmargs: CoherentAllocation::<GspArgumentsPadded>::alloc_coherent(
-                    dev,
-                    1,
-                    GFP_KERNEL | __GFP_ZERO,
-                )?,
-                _: {
-                    // Initialise the logging structures. The OpenRM equivalents are in:
-                    // _kgspInitLibosLoggingStructures (allocates memory for buffers)
-                    // kgspSetupLibosInitArgs_IMPL (creates pLibosInitArgs[] array)
-                    dma_write!(
-                        libos, [0]?, LibosMemoryRegionInitArgument::new("LOGINIT", &loginit.0)
-                    );
-                    dma_write!(
-                        libos, [1]?, LibosMemoryRegionInitArgument::new("LOGINTR", &logintr.0)
-                    );
-                    dma_write!(libos, [2]?, LibosMemoryRegionInitArgument::new("LOGRM", &logrm.0));
-                    dma_write!(rmargs, [0]?.inner, fw::GspArgumentsCached::new(&cmdq));
-                    dma_write!(libos, [3]?, LibosMemoryRegionInitArgument::new("RMARGS", rmargs));
+                rmargs: Coherent::init(dev, GFP_KERNEL, GspArgumentsPadded::new(&cmdq))?,
+                libos: {
+                    let mut libos = CoherentBox::zeroed_slice(
+                        dev,
+                        GSP_PAGE_SIZE / size_of::<LibosMemoryRegionInitArgument>(),
+                        GFP_KERNEL,
+                    )?;
+
+                    libos.init_at(0, LibosMemoryRegionInitArgument::new("LOGINIT", &loginit.0))?;
+                    libos.init_at(1, LibosMemoryRegionInitArgument::new("LOGINTR", &logintr.0))?;
+                    libos.init_at(2, LibosMemoryRegionInitArgument::new("LOGRM", &logrm.0))?;
+                    libos.init_at(3, LibosMemoryRegionInitArgument::new("RMARGS", rmargs))?;
+
+                    libos.into()
                 },
             }))
         })
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4e3bfc6c4c47..0d8daf6a80b7 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -9,11 +9,12 @@
 use core::ops::Range;
 
 use kernel::{
-    dma::CoherentAllocation,
+    dma::Coherent,
     prelude::*,
     ptr::{
         Alignable,
-        Alignment, //
+        Alignment,
+        KnownSize, //
     },
     sizes::{
         SZ_128K,
@@ -648,7 +649,9 @@ unsafe impl AsBytes for RunCpuSequencer {}
 /// The memory allocated for the arguments must remain until the GSP sends the
 /// init_done RPC.
 #[repr(transparent)]
-pub(crate) struct LibosMemoryRegionInitArgument(bindings::LibosMemoryRegionInitArgument);
+pub(crate) struct LibosMemoryRegionInitArgument {
+    inner: bindings::LibosMemoryRegionInitArgument,
+}
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.
 unsafe impl AsBytes for LibosMemoryRegionInitArgument {}
@@ -658,10 +661,10 @@ unsafe impl AsBytes for LibosMemoryRegionInitArgument {}
 unsafe impl FromBytes for LibosMemoryRegionInitArgument {}
 
 impl LibosMemoryRegionInitArgument {
-    pub(crate) fn new<A: AsBytes + FromBytes>(
+    pub(crate) fn new<'a, A: AsBytes + FromBytes + KnownSize + ?Sized>(
         name: &'static str,
-        obj: &CoherentAllocation<A>,
-    ) -> Self {
+        obj: &'a Coherent<A>,
+    ) -> impl Init<Self> + 'a {
         /// Generates the `ID8` identifier required for some GSP objects.
         fn id8(name: &str) -> u64 {
             let mut bytes = [0u8; core::mem::size_of::<u64>()];
@@ -673,7 +676,8 @@ fn id8(name: &str) -> u64 {
             u64::from_ne_bytes(bytes)
         }
 
-        Self(bindings::LibosMemoryRegionInitArgument {
+        #[allow(non_snake_case)]
+        let init_inner = init!(bindings::LibosMemoryRegionInitArgument {
             id8: id8(name),
             pa: obj.dma_handle(),
             size: num::usize_as_u64(obj.size()),
@@ -683,7 +687,11 @@ fn id8(name: &str) -> u64 {
             loc: num::u32_into_u8::<
                 { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM },
             >(),
-            ..Default::default()
+            ..Zeroable::init_zeroed()
+        });
+
+        init!(LibosMemoryRegionInitArgument {
+            inner <- init_inner,
         })
     }
 }
@@ -862,15 +870,23 @@ unsafe impl FromBytes for GspMsgElement {}
 
 /// Arguments for GSP startup.
 #[repr(transparent)]
-pub(crate) struct GspArgumentsCached(bindings::GSP_ARGUMENTS_CACHED);
+#[derive(Zeroable)]
+pub(crate) struct GspArgumentsCached {
+    inner: bindings::GSP_ARGUMENTS_CACHED,
+}
 
 impl GspArgumentsCached {
     /// Creates the arguments for starting the GSP up using `cmdq` as its command queue.
-    pub(crate) fn new(cmdq: &Cmdq) -> Self {
-        Self(bindings::GSP_ARGUMENTS_CACHED {
-            messageQueueInitArguments: MessageQueueInitArguments::new(cmdq).0,
+    pub(crate) fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
+        #[allow(non_snake_case)]
+        let init_inner = init!(bindings::GSP_ARGUMENTS_CACHED {
+            messageQueueInitArguments <- MessageQueueInitArguments::new(cmdq),
             bDmemStack: 1,
-            ..Default::default()
+            ..Zeroable::init_zeroed()
+        });
+
+        init!(GspArgumentsCached {
+            inner <- init_inner,
         })
     }
 }
@@ -882,11 +898,21 @@ unsafe impl AsBytes for GspArgumentsCached {}
 /// must all be a multiple of GSP_PAGE_SIZE in size, so add padding to force it
 /// to that size.
 #[repr(C)]
+#[derive(Zeroable)]
 pub(crate) struct GspArgumentsPadded {
     pub(crate) inner: GspArgumentsCached,
     _padding: [u8; GSP_PAGE_SIZE - core::mem::size_of::<bindings::GSP_ARGUMENTS_CACHED>()],
 }
 
+impl GspArgumentsPadded {
+    pub(crate) fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
+        init!(GspArgumentsPadded {
+            inner <- GspArgumentsCached::new(cmdq),
+            ..Zeroable::init_zeroed()
+        })
+    }
+}
+
 // SAFETY: Padding is explicit and will not contain uninitialized data.
 unsafe impl AsBytes for GspArgumentsPadded {}
 
@@ -895,18 +921,18 @@ unsafe impl AsBytes for GspArgumentsPadded {}
 unsafe impl FromBytes for GspArgumentsPadded {}
 
 /// Init arguments for the message queue.
-#[repr(transparent)]
-struct MessageQueueInitArguments(bindings::MESSAGE_QUEUE_INIT_ARGUMENTS);
+type MessageQueueInitArguments = bindings::MESSAGE_QUEUE_INIT_ARGUMENTS;
 
 impl MessageQueueInitArguments {
     /// Creates a new init arguments structure for `cmdq`.
-    fn new(cmdq: &Cmdq) -> Self {
-        Self(bindings::MESSAGE_QUEUE_INIT_ARGUMENTS {
+    #[allow(non_snake_case)]
+    fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
+        init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_handle(),
             pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
             cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
             statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
-            ..Default::default()
+            ..Zeroable::init_zeroed()
         })
     }
 }
-- 
2.53.0

