Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E771099B37
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A6410EC18;
	Fri, 20 Mar 2026 19:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qgeRGwfO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EFFA10EC1A;
 Fri, 20 Mar 2026 19:47:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 508776015B;
 Fri, 20 Mar 2026 19:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF42C2BC87;
 Fri, 20 Mar 2026 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774036034;
 bh=kJQ6AOlUSC0Z7dQ3ABfDnQ43PiQSAaKqxuGU0btOtaI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qgeRGwfOJGZFKbLJ3oAa2We51rBAXugmtmyTIeSEI5kjmIa9op5sB7klGzJ/ubzjI
 f/sIlAyx+Ku2mY9D2uDzl/5X7imli75QOl4VFS0vdCJHmfZr7rme5lhXs1jtwZHkBr
 2lqX8y2NzH9jSXYFUg34CGpHOGZAUQGChOVa3OAKrEKhydVfKxt/X9C3AmZzyocGRT
 4+U1cJufxnrnleyXJWgHr9znn+hBGVQkOsYAXNgwqh7NOm7zVjcM/w2jaJZ9gGq3KF
 WUbxjV5PuqusyjiQe9bksoHsVB9F7zmXtT/0cf1ShtvWYgpIsdYPo/L+TrhMWbEZIW
 XeIEFWMBqDLRA==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 8/8] gpu: nova-core: convert to new dma::Coherent API
Date: Fri, 20 Mar 2026 20:45:43 +0100
Message-ID: <20260320194626.36263-9-dakr@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

Remove all usages of dma::CoherentAllocation and use the new
dma::Coherent type instead.

Note that there are still remainders of the old dma::CoherentAllocation
API, such as as_slice() and as_slice_mut().

Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/dma.rs      | 19 ++++++-------
 drivers/gpu/nova-core/falcon.rs   |  5 ++--
 drivers/gpu/nova-core/gsp.rs      | 21 ++++++++------
 drivers/gpu/nova-core/gsp/cmdq.rs | 21 ++++++--------
 drivers/gpu/nova-core/gsp/fw.rs   | 46 ++++++++++---------------------
 5 files changed, 47 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
index 7215398969da..3c19d5ffcfe8 100644
--- a/drivers/gpu/nova-core/dma.rs
+++ b/drivers/gpu/nova-core/dma.rs
@@ -9,13 +9,13 @@
 
 use kernel::{
     device,
-    dma::CoherentAllocation,
+    dma::Coherent,
     page::PAGE_SIZE,
     prelude::*, //
 };
 
 pub(crate) struct DmaObject {
-    dma: CoherentAllocation<u8>,
+    dma: Coherent<[u8]>,
 }
 
 impl DmaObject {
@@ -24,23 +24,22 @@ pub(crate) fn new(dev: &device::Device<device::Bound>, len: usize) -> Result<Sel
             .map_err(|_| EINVAL)?
             .pad_to_align()
             .size();
-        let dma = CoherentAllocation::alloc_coherent(dev, len, GFP_KERNEL | __GFP_ZERO)?;
+        let dma = Coherent::zeroed_slice(dev, len, GFP_KERNEL)?;
 
         Ok(Self { dma })
     }
 
     pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self> {
-        Self::new(dev, data.len()).and_then(|mut dma_obj| {
-            // SAFETY: We have just allocated the DMA memory, we are the only users and
-            // we haven't made the device aware of the handle yet.
-            unsafe { dma_obj.write(data, 0)? }
-            Ok(dma_obj)
-        })
+        let dma_obj = Self::new(dev, data.len())?;
+        // SAFETY: We have just allocated the DMA memory, we are the only users and
+        // we haven't made the device aware of the handle yet.
+        unsafe { dma_obj.as_mut()[..data.len()].copy_from_slice(data) };
+        Ok(dma_obj)
     }
 }
 
 impl Deref for DmaObject {
-    type Target = CoherentAllocation<u8>;
+    type Target = Coherent<[u8]>;
 
     fn deref(&self) -> &Self::Target {
         &self.dma
diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 7097a206ec3c..5bf8da8760bf 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -26,8 +26,7 @@
     gpu::Chipset,
     num::{
         self,
-        FromSafeCast,
-        IntoSafeCast, //
+        FromSafeCast, //
     },
     regs,
     regs::macros::RegisterBase, //
@@ -653,7 +652,7 @@ fn dma_wr(
             }
             FalconMem::Dmem => (
                 0,
-                dma_obj.dma_handle_with_offset(load_offsets.src_start.into_safe_cast())?,
+                dma_obj.dma_handle() + DmaAddress::from(load_offsets.src_start),
             ),
         };
         if dma_start % DmaAddress::from(DMA_LEN) > 0 {
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index f0a50bdc4c00..a045c4189989 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -6,13 +6,15 @@
     device,
     dma::{
         Coherent,
-        CoherentAllocation,
         CoherentBox,
         DmaAddress, //
     },
     pci,
     prelude::*,
-    transmute::AsBytes, //
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    }, //
 };
 
 pub(crate) mod cmdq;
@@ -44,6 +46,9 @@
 #[repr(C)]
 struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
 
+/// SAFETY: arrays of `u64` implement `FromBytes` and we are but a wrapper around one.
+unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES> {}
+
 /// SAFETY: arrays of `u64` implement `AsBytes` and we are but a wrapper around one.
 unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> {}
 
@@ -71,26 +76,24 @@ fn entry(start: DmaAddress, index: usize) -> Result<u64> {
 /// then pp points to index into the buffer where the next logging entry will
 /// be written. Therefore, the logging data is valid if:
 ///   1 <= pp < sizeof(buffer)/sizeof(u64)
-struct LogBuffer(CoherentAllocation<u8>);
+struct LogBuffer(Coherent<[u8]>);
 
 impl LogBuffer {
     /// Creates a new `LogBuffer` mapped on `dev`.
     fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         const NUM_PAGES: usize = RM_LOG_BUFFER_NUM_PAGES;
 
-        let mut obj = Self(CoherentAllocation::<u8>::alloc_coherent(
+        let obj = Self(Coherent::<u8>::zeroed_slice(
             dev,
             NUM_PAGES * GSP_PAGE_SIZE,
-            GFP_KERNEL | __GFP_ZERO,
+            GFP_KERNEL,
         )?);
 
         let start_addr = obj.0.dma_handle();
 
         // SAFETY: `obj` has just been created and we are its sole user.
-        let pte_region = unsafe {
-            obj.0
-                .as_slice_mut(size_of::<u64>(), NUM_PAGES * size_of::<u64>())?
-        };
+        let pte_region =
+            unsafe { &mut obj.0.as_mut()[size_of::<u64>()..][..NUM_PAGES * size_of::<u64>()] };
 
         // Write values one by one to avoid an on-stack instance of `PteArray`.
         for (i, chunk) in pte_region.chunks_exact_mut(size_of::<u64>()).enumerate() {
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d36a62ba1c60..f38790601a0f 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -7,7 +7,7 @@
 use kernel::{
     device,
     dma::{
-        CoherentAllocation,
+        Coherent,
         DmaAddress, //
     },
     dma_write,
@@ -207,7 +207,7 @@ unsafe impl AsBytes for GspMem {}
 // that is not a problem because they are not used outside the kernel.
 unsafe impl FromBytes for GspMem {}
 
-/// Wrapper around [`GspMem`] to share it with the GPU using a [`CoherentAllocation`].
+/// Wrapper around [`GspMem`] to share it with the GPU using a [`Coherent`].
 ///
 /// This provides the low-level functionality to communicate with the GSP, including allocation of
 /// queue space to write messages to and management of read/write pointers.
@@ -218,7 +218,7 @@ unsafe impl FromBytes for GspMem {}
 ///   pointer and the GSP read pointer. This region is returned by [`Self::driver_write_area`].
 /// * The driver owns (i.e. can read from) the part of the GSP message queue between the CPU read
 ///   pointer and the GSP write pointer. This region is returned by [`Self::driver_read_area`].
-struct DmaGspMem(CoherentAllocation<GspMem>);
+struct DmaGspMem(Coherent<GspMem>);
 
 impl DmaGspMem {
     /// Allocate a new instance and map it for `dev`.
@@ -226,21 +226,20 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
         const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
-        let gsp_mem =
-            CoherentAllocation::<GspMem>::alloc_coherent(dev, 1, GFP_KERNEL | __GFP_ZERO)?;
+        let gsp_mem = Coherent::<GspMem>::zeroed(dev, GFP_KERNEL)?;
 
         let start = gsp_mem.dma_handle();
         // Write values one by one to avoid an on-stack instance of `PteArray`.
         for i in 0..GspMem::PTE_ARRAY_SIZE {
-            dma_write!(gsp_mem, [0]?.ptes.0[i], PteArray::<0>::entry(start, i)?);
+            dma_write!(gsp_mem, .ptes.0[i], PteArray::<0>::entry(start, i)?);
         }
 
         dma_write!(
             gsp_mem,
-            [0]?.cpuq.tx,
+            .cpuq.tx,
             MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES)
         );
-        dma_write!(gsp_mem, [0]?.cpuq.rx, MsgqRxHeader::new());
+        dma_write!(gsp_mem, .cpuq.rx, MsgqRxHeader::new());
 
         Ok(Self(gsp_mem))
     }
@@ -255,10 +254,9 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         let rx = self.gsp_read_ptr() as usize;
 
         // SAFETY:
-        // - The `CoherentAllocation` contains exactly one object.
         // - We will only access the driver-owned part of the shared memory.
         // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = &mut unsafe { self.0.as_slice_mut(0, 1) }.unwrap()[0];
+        let gsp_mem = unsafe { &mut *self.0.as_mut() };
         // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_NUM_PAGES`.
         let (before_tx, after_tx) = gsp_mem.cpuq.msgq.data.split_at_mut(tx);
 
@@ -309,10 +307,9 @@ fn driver_write_area_size(&self) -> usize {
         let rx = self.cpu_read_ptr() as usize;
 
         // SAFETY:
-        // - The `CoherentAllocation` contains exactly one object.
         // - We will only access the driver-owned part of the shared memory.
         // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
+        let gsp_mem = unsafe { &*self.0.as_ptr() };
         let data = &gsp_mem.gspq.msgq.data;
 
         // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NUM_PAGES, inclusive,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0d8daf6a80b7..847b5eb215d4 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -40,8 +40,7 @@
     },
 };
 
-// TODO: Replace with `IoView` projections once available; the `unwrap()` calls go away once we
-// switch to the new `dma::Coherent` API.
+// TODO: Replace with `IoView` projections once available.
 pub(super) mod gsp_mem {
     use core::sync::atomic::{
         fence,
@@ -49,10 +48,9 @@ pub(super) mod gsp_mem {
     };
 
     use kernel::{
-        dma::CoherentAllocation,
+        dma::Coherent,
         dma_read,
-        dma_write,
-        prelude::*, //
+        dma_write, //
     };
 
     use crate::gsp::cmdq::{
@@ -60,49 +58,35 @@ pub(super) mod gsp_mem {
         MSGQ_NUM_PAGES, //
     };
 
-    pub(in crate::gsp) fn gsp_write_ptr(qs: &CoherentAllocation<GspMem>) -> u32 {
-        // PANIC: A `dma::CoherentAllocation` always contains at least one element.
-        || -> Result<u32> { Ok(dma_read!(qs, [0]?.gspq.tx.0.writePtr) % MSGQ_NUM_PAGES) }().unwrap()
+    pub(in crate::gsp) fn gsp_write_ptr(qs: &Coherent<GspMem>) -> u32 {
+        dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES
     }
 
-    pub(in crate::gsp) fn gsp_read_ptr(qs: &CoherentAllocation<GspMem>) -> u32 {
-        // PANIC: A `dma::CoherentAllocation` always contains at least one element.
-        || -> Result<u32> { Ok(dma_read!(qs, [0]?.gspq.rx.0.readPtr) % MSGQ_NUM_PAGES) }().unwrap()
+    pub(in crate::gsp) fn gsp_read_ptr(qs: &Coherent<GspMem>) -> u32 {
+        dma_read!(qs, .gspq.rx.0.readPtr) % MSGQ_NUM_PAGES
     }
 
-    pub(in crate::gsp) fn cpu_read_ptr(qs: &CoherentAllocation<GspMem>) -> u32 {
-        // PANIC: A `dma::CoherentAllocation` always contains at least one element.
-        || -> Result<u32> { Ok(dma_read!(qs, [0]?.cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES) }().unwrap()
+    pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
+        dma_read!(qs, .cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES
     }
 
-    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &CoherentAllocation<GspMem>, count: u32) {
+    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
         let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
 
         // Ensure read pointer is properly ordered.
         fence(Ordering::SeqCst);
 
-        // PANIC: A `dma::CoherentAllocation` always contains at least one element.
-        || -> Result {
-            dma_write!(qs, [0]?.cpuq.rx.0.readPtr, rptr);
-            Ok(())
-        }()
-        .unwrap()
+        dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
     }
 
-    pub(in crate::gsp) fn cpu_write_ptr(qs: &CoherentAllocation<GspMem>) -> u32 {
-        // PANIC: A `dma::CoherentAllocation` always contains at least one element.
-        || -> Result<u32> { Ok(dma_read!(qs, [0]?.cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES) }().unwrap()
+    pub(in crate::gsp) fn cpu_write_ptr(qs: &Coherent<GspMem>) -> u32 {
+        dma_read!(qs, .cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES
     }
 
-    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &CoherentAllocation<GspMem>, count: u32) {
+    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
         let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
 
-        // PANIC: A `dma::CoherentAllocation` always contains at least one element.
-        || -> Result {
-            dma_write!(qs, [0]?.cpuq.tx.0.writePtr, wptr);
-            Ok(())
-        }()
-        .unwrap();
+        dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
 
         // Ensure all command data is visible before triggering the GSP read.
         fence(Ordering::SeqCst);
-- 
2.53.0

