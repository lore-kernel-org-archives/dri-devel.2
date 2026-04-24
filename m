Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E2FFF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A4310F705;
	Fri, 24 Apr 2026 23:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="hEFJsVCG";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339FA10F6FD
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073979; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n9oG17o/fiVK1UKBIAYDC5nRTb2mQSuRrngqyhx4X4lU6//3ntyJ38B2VLoyaU/JeMhsZs8T7FvclGei14j7qIGkoxL5aUrJINCC8AE4J06/fR/C2Jmx6sy46NYPWTU+Z7tTTFOx5aFPd1tBj/7IkCPC7tWHDi/+jrBX+dPVuYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073979;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Pz7rulSqsLBpHMRDDHExlB2tuYHqyjqxBj9+o+Qw6F4=; 
 b=IvF4SO7AOzflG0wZxu9e12NwEcz1+IszFsT3VmW09/jTHwXyFhrjURMjmcnoYzr89P/iOklxU4/j6IKRb4MtAdKyBpCqzS0MihNfegU0cV1+I0EtBXNlXAZdNJhrrH+W7Wq8Kd3D95oXAhPYmS93X5EYhg7un4Kj1fdjpO5MuT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073979; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Pz7rulSqsLBpHMRDDHExlB2tuYHqyjqxBj9+o+Qw6F4=;
 b=hEFJsVCGwBDBoYmLasId+zKoYt2QYzR6I0yo0OB0SDT6Yay+IqzHHJeZ+E9LMOop
 9SauT5hjKPD0H38LI2L6VugEpPdx8C/D/Zh4U0wX79MebM41eicct6RjnEoFbOQzEM1
 QY+QfXVfiOmsF+fXlBlGQ3GWl1mJTku+mjN/fa5U=
Received: by mx.zohomail.com with SMTPS id 1777073977021269.18756773571704;
 Fri, 24 Apr 2026 16:39:37 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:12 -0700
Subject: [PATCH v4 18/20] drm/tyr: add CSF firmware interface support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-b4-fw-boot-v4-v4-18-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=84083;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=6lpwKm10idXgHrlymJ2KQzZcfCkWoTCc3gE3QB8MdzM=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yv8fn8+xSP48oqvLJW+xX3VYXOWPNL5Ha/I5L/QK
 qHSdNW0jlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACYSdZjhn23d+xtBPaHF894+
 eOe5RjNC4YBV8ORvN1uXcNdODVT3rGVkeP8sbc2jPuMPzeIWH+xWxs0O7XfVP7L7cuB014fNU/f
 KMQIA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Add initial support for the Command Stream Frontend (CSF) firmware
interfaces, enabling communication between the driver and the MCU through
shared memory.

Implement the global (GLB), command stream group (CSG), and command stream
(CS) interfaces. These provide access to the firmware control, input, and
output blocks and allow discovery of the available CSGs and CSs at
runtime.

Store the global interface in the firmware state and initialize it after
firmware boot during probe.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs        |    2 +-
 drivers/gpu/drm/tyr/fw.rs            |   62 +-
 drivers/gpu/drm/tyr/fw/interfaces.rs | 2005 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs           |    5 +
 4 files changed, 2061 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 3225385cd511..20ae114a4180 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -189,10 +189,10 @@ fn probe(
         devres::register(pdev.as_ref(), job_irq, GFP_KERNEL)?;
 
         firmware.boot()?;
-
         firmware
             .wait_ready(1000)
             .inspect_err(|_| pr_err!("Timed out waiting for firmware to be ready.\n"))?;
+        firmware.enable_global_interface()?;
 
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 14815cdafac8..598e399a58ae 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -36,7 +36,8 @@
     str::CString,
     sync::{
         Arc,
-        ArcBorrow, //
+        ArcBorrow,
+        Mutex, //
     },
     time,
     types::ARef, //
@@ -47,9 +48,12 @@
         IoMem,
         TyrDrmDevice, //
     },
-    fw::parser::{
-        FwParser,
-        ParsedSection, //
+    fw::{
+        interfaces::GlobalInterface,
+        parser::{
+            FwParser,
+            ParsedSection, //
+        },
     },
     gem,
     gem::{
@@ -73,12 +77,16 @@
     }, //
 };
 
+mod interfaces;
 pub(crate) mod irq;
 mod parser;
 
 /// Maximum number of CSG interfaces supported by hardware.
 const MAX_CSG: usize = 16;
 
+/// Maximum number of CS interfaces supported by hardware.
+const MAX_CS: usize = 16;
+
 impl_flags!(
     #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
     pub(super) struct SectionFlags(u32);
@@ -100,6 +108,11 @@ pub(super) enum SectionFlag {
 
 pub(super) const CACHE_MODE_MASK: SectionFlags = SectionFlags(genmask_u32(3..=4));
 
+/// MCU virtual address where the CSF shared memory region starts.
+///
+/// This region contains the firmware interface structures for communication between
+/// the CPU driver and MCU firmware, including the GLB_CONTROL_BLOCK at this base address.
+/// The firmware binary contains a section marked to be loaded at this address.
 pub(super) const CSF_MCU_SHARED_REGION_START: u32 = 0x04000000;
 
 impl SectionFlags {
@@ -129,18 +142,18 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 }
 
 /// A parsed section of the firmware binary.
-struct Section {
+pub(crate) struct Section {
     // Raw firmware section data for reset purposes
     #[expect(dead_code)]
     data: KVec<u8>,
 
     // Keep the BO backing this firmware section so that both the
     // GPU mapping and CPU mapping remain valid until the Section is dropped.
-    #[expect(dead_code)]
     mem: gem::KernelBo,
 }
 
 /// Loaded firmware with sections mapped into MCU VM.
+#[pin_data(PinnedDrop)]
 pub(crate) struct Firmware {
     /// Platform device reference (needed to access the MCU JOB_IRQ registers).
     pdev: ARef<platform::Device>,
@@ -152,7 +165,6 @@ pub(crate) struct Firmware {
     vm: Arc<Vm>,
 
     /// List of firmware sections.
-    #[expect(dead_code)]
     sections: KVec<Section>,
 
     /// A condvar representing a wait on a firmware event.
@@ -160,10 +172,15 @@ pub(crate) struct Firmware {
 
     /// Latched to `true` by the IRQ handler when the firmware signals readiness via the GLB bit.
     pub(crate) fw_ready: Arc<AtomicBool>,
+
+    /// The global FW interface.
+    #[pin]
+    global_iface: Mutex<GlobalInterface>,
 }
 
-impl Drop for Firmware {
-    fn drop(&mut self) {
+#[pinned_drop]
+impl PinnedDrop for Firmware {
+    fn drop(self: Pin<&mut Self>) {
         // AS slots retain a VM ref, we need to kill the circular ref manually.
         self.vm.kill();
     }
@@ -258,21 +275,36 @@ pub(crate) fn new(
             sections.push(Section { data, mem }, GFP_KERNEL)?;
         }
 
-        let firmware = Arc::new(
-            Firmware {
+        let firmware = Arc::pin_init(
+            try_pin_init!(Firmware {
                 pdev: pdev.into(),
                 iomem,
                 vm,
                 sections,
                 ready_wait: new_wait!()?,
                 fw_ready: Arc::new(AtomicBool::new(false), GFP_KERNEL)?,
-            },
+                global_iface <- new_mutex!(GlobalInterface::new()?),
+            }),
             GFP_KERNEL,
         )?;
 
         Ok(firmware)
     }
 
+    /// Get the shared memory section containing firmware interface structures.
+    pub(crate) fn shared_section(&self) -> Result<&Section> {
+        self.sections
+            .iter()
+            .find(|section| section.mem.va_range().start == u64::from(CSF_MCU_SHARED_REGION_START))
+            .ok_or_else(|| {
+                pr_err!(
+                    "CSF shared section not found at 0x{:08x}\n",
+                    CSF_MCU_SHARED_REGION_START
+                );
+                EINVAL
+            })
+    }
+
     pub(crate) fn boot(&self) -> Result {
         // SAFETY: Boot is currently only called in the probe path, so we're sure we have a bound
         // device.
@@ -303,4 +335,10 @@ pub(crate) fn wait_ready(&self, timeout_ms: u32) -> Result {
             }
         })
     }
+
+    /// Enable the global interface.
+    pub(crate) fn enable_global_interface(&self) -> Result {
+        let shared_section = self.shared_section()?;
+        self.global_iface.lock().enable(shared_section)
+    }
 }
diff --git a/drivers/gpu/drm/tyr/fw/interfaces.rs b/drivers/gpu/drm/tyr/fw/interfaces.rs
new file mode 100644
index 000000000000..07cdb1c76a3f
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/interfaces.rs
@@ -0,0 +1,2005 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Code to control the global interface of the CSF firmware.
+//!
+//! For abbreviation definitions (CEU, CS, CSF, CSG, CSHW, GLB, JASID, MCU, MMU), see the top-level
+//! module documentation in [`crate::regs`].
+//!
+//! # Interface Overview
+//!
+//! Tyr interacts with the CSF firmware running on the MCU through shared memory
+//! interfaces. The CSF manages job submission via a hierarchy of:
+//! - **GLB**: Global interface - controls operations common to all CSs
+//! - **CSG**: Command Stream Groups - groups of related command streams
+//! - **CS**: Command Streams - individual sequences of GPU commands
+//!
+//! ```
+//! ┌──────────────────────────────────────────┐
+//! │ GPU                                      │
+//! │ ┌─────┐ ┌──────────────────────────────┐ │
+//! │ │ MMU │ │  CSF                         │ │
+//! │ └─────┘ │ ┌────────────┐ ┌─────┐       │ │
+//! │         │ │ CSHW (CEU) │ │ MCU │       │ │
+//! │         │ └────────────┘ └─────┘       │ │
+//! └─────────┼──────────────────────────────┼─┘
+//!           │ ┌──────────────────────────┐ │
+//!           │ │ Shared Memory            │ │
+//!           │ │ ┌────────┐ ┌────┐ ┌────┐ │ │
+//!           │ │ │  CSG0  │ │GLB │ │ FW │ │ │
+//!           │ │ │ ┌────┐ │ └────┘ └────┘ │ │
+//!           │ │ │ │CS0 │ │               │ │
+//!           │ │ │ └────┘ │               │ │
+//!           │ │ └────────┘               │ │
+//!           │ └──────────────────────────┘ │
+//!           └──────────────┬───────────────┘
+//!                          │
+//!                      ┌───┴───┐
+//!                      │  Tyr  │
+//!                      └───────┘
+//! ```
+//!
+
+use crate::fw::Section;
+use iface::FwInterface;
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+/// Offset from GLB_CONTROL_BLOCK start to the first GROUP_CONTROL block.
+const CSG_GROUP_CONTROL_OFFSET: usize = 0x1000;
+
+/// Offset from GROUP_CONTROL_BLOCK start to the first STREAM_CONTROL block.
+const CS_CONTROL_OFFSET: usize = 0x40;
+
+/// Generic firmware interface infrastructure.
+///
+/// Provides a bounded VMap-backed IO wrapper for accessing CSF shared memory regions.
+mod iface {
+    use core::{
+        mem::size_of,
+        ops::Range,
+        ptr::{
+            read_volatile,
+            write_volatile, //
+        }, //
+    };
+
+    use kernel::{
+        drm::gem::shmem::VMapOwned,
+        io::{
+            Io,
+            IoCapable,
+            IoKnownSize, //
+        },
+        prelude::*, //
+    };
+
+    use crate::gem::BoData;
+
+    /// Firmware interface wrapper for accessing CSF shared memory regions.
+    ///
+    /// Provides bounds-checked access to firmware interface blocks mapped into
+    /// driver memory via a VMap.
+    pub(super) struct FwInterface<const FW_IFACE_SIZE: usize> {
+        /// Virtual mapping of the shared memory buffer.
+        vmap: VMapOwned<BoData>,
+        /// Offset within the shared memory buffer where this interface starts.
+        offset: usize,
+    }
+
+    impl<const FW_IFACE_SIZE: usize> FwInterface<FW_IFACE_SIZE> {
+        /// Creates a new firmware interface wrapper at the specified MCU virtual address.
+        ///
+        /// Validates that the whole interface block is within the section's address range.
+        pub(super) fn new(
+            vmap: &VMapOwned<BoData>,
+            va_range: &Range<u64>,
+            shared_iface_addr: u64,
+        ) -> Result<FwInterface<FW_IFACE_SIZE>> {
+            let shared_mem_start = va_range.start;
+            let shared_mem_end = va_range.end;
+
+            let iface_end = shared_iface_addr
+                .checked_add(FW_IFACE_SIZE as u64)
+                .ok_or(EINVAL)?;
+
+            if shared_iface_addr < shared_mem_start || iface_end > shared_mem_end {
+                pr_err!(
+                    "FwInterface::new: interface [0x{:x}..0x{:x}) out of bounds [0x{:x}..0x{:x})\n",
+                    shared_iface_addr,
+                    iface_end,
+                    shared_mem_start,
+                    shared_mem_end
+                );
+                return Err(EINVAL);
+            }
+
+            let offset = (shared_iface_addr - shared_mem_start) as usize;
+            Ok(FwInterface {
+                vmap: vmap.clone(),
+                offset,
+            })
+        }
+    }
+
+    impl<const FW_IFACE_SIZE: usize> Io for FwInterface<FW_IFACE_SIZE> {
+        #[inline]
+        fn addr(&self) -> usize {
+            self.vmap.addr() + self.offset
+        }
+
+        #[inline]
+        fn maxsize(&self) -> usize {
+            FW_IFACE_SIZE
+        }
+    }
+
+    impl<const FW_IFACE_SIZE: usize> IoKnownSize for FwInterface<FW_IFACE_SIZE> {
+        const MIN_SIZE: usize = FW_IFACE_SIZE;
+    }
+
+    impl<T, const FW_IFACE_SIZE: usize> IoCapable<T> for FwInterface<FW_IFACE_SIZE> {
+        unsafe fn io_read(&self, addr: usize) -> T {
+            let base = self.addr();
+            let size = size_of::<T>();
+
+            if addr < base || addr.saturating_add(size) > base + FW_IFACE_SIZE {
+                pr_err!(
+                    "io_read: address 0x{:x} out of bounds [0x{:x}..0x{:x})\n",
+                    addr,
+                    base,
+                    base + FW_IFACE_SIZE
+                );
+                panic!("io_read: address 0x{:x} out of bounds", addr);
+            }
+
+            let ptr = addr as *const T;
+
+            // SAFETY: ptr is within bounds (checked above) and valid for the VMap lifetime.
+            unsafe { read_volatile(ptr) }
+        }
+
+        unsafe fn io_write(&self, value: T, addr: usize) {
+            let base = self.addr();
+            let size = size_of::<T>();
+
+            if addr < base || addr.saturating_add(size) > base + FW_IFACE_SIZE {
+                pr_err!(
+                    "io_write: address 0x{:x} out of bounds [0x{:x}..0x{:x})\n",
+                    addr,
+                    base,
+                    base + FW_IFACE_SIZE
+                );
+                panic!("io_write: address 0x{:x} out of bounds", addr);
+            }
+
+            let ptr = addr as *mut T;
+
+            // SAFETY: ptr is within bounds (checked above) and valid for the VMap lifetime.
+            unsafe { write_volatile(ptr, value) };
+        }
+    }
+}
+
+/// GLB (Global) interface definitions.
+///
+/// This module contains the register definitions and types for the global CSF interface,
+/// including control, input, and output blocks.
+mod glb {
+    use core::convert::TryFrom;
+
+    use kernel::{
+        error::{
+            code::EINVAL,
+            Error, //
+        },
+        num::Bounded, //
+    };
+
+    /// Size of the GLB_CONTROL_BLOCK base registers (not including GROUP_CONTROL blocks).
+    ///
+    /// This covers only the GLB_CONTROL base registers: 0x00-0x1C.
+    /// GROUP_CONTROL (CSG) blocks are accessed separately via runtime calculations.
+    pub(super) const GLB_CONTROL_BLOCK_SIZE: usize = 0x20;
+
+    /// Size of the GLB_INPUT_BLOCK register block excluding reserved space at the end.
+    pub(super) const GLB_INPUT_BLOCK_SIZE: usize = 0x84;
+
+    /// Size of the GLB_OUTPUT_BLOCK register block excluding reserved space at the end.
+    pub(super) const GLB_OUTPUT_BLOCK_SIZE: usize = 0x1C;
+
+    /// Timestamp source selection for timers.
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum TimestampSource {
+        /// The system timestamp is used.
+        /// This is the value exposed in the TIMESTAMP register
+        /// ([`TIMESTAMP_LO`](crate::regs::gpu_control::TIMESTAMP_LO) and
+        /// [`TIMESTAMP_HI`](crate::regs::gpu_control::TIMESTAMP_HI)).
+        SystemTimestamp = 0,
+        /// The GPU cycle counter is used.
+        /// This is the value exposed in the CYCLE_COUNT register
+        /// ([`CYCLE_COUNT_LO`](crate::regs::gpu_control::CYCLE_COUNT_LO) and
+        /// [`CYCLE_COUNT_HI`](crate::regs::gpu_control::CYCLE_COUNT_HI)).
+        GpuCounter = 1,
+    }
+
+    impl From<Bounded<u32, 1>> for TimestampSource {
+        fn from(val: Bounded<u32, 1>) -> Self {
+            match val.get() {
+                0 => TimestampSource::SystemTimestamp,
+                1 => TimestampSource::GpuCounter,
+                _ => unreachable!(),
+            }
+        }
+    }
+
+    impl From<TimestampSource> for Bounded<u32, 1> {
+        fn from(src: TimestampSource) -> Self {
+            Bounded::try_new(src as u32).unwrap()
+        }
+    }
+
+    /// Global halt status values.
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u32)]
+    pub(super) enum HaltStatus {
+        /// No problem reported.
+        Ok = 0x00000000,
+        /// A fatal error has occurred, but unable to determine cause.
+        Panic = 0x0000004E,
+        /// A watchdog timer has expired.
+        Wd = 0x0000004F,
+    }
+
+    impl TryFrom<Bounded<u32, 32>> for HaltStatus {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 32>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0x00000000 => Ok(HaltStatus::Ok),
+                0x0000004E => Ok(HaltStatus::Panic),
+                0x0000004F => Ok(HaltStatus::Wd),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<HaltStatus> for Bounded<u32, 32> {
+        fn from(status: HaltStatus) -> Self {
+            Bounded::try_new(status as u32).unwrap()
+        }
+    }
+
+    /// GLB_CONTROL_BLOCK - Global interface control and capabilities.
+    ///
+    /// These macros represent virtualized registers for the global interface control block.
+    /// They allow Tyr to query global CSF interface capabilities and to
+    /// retrieve the MCU's virtual addresses for the global input/output blocks.
+    pub(super) mod control {
+        use kernel::register;
+
+        register! {
+            /// Global interface version.
+            pub GLB_VERSION(u32) @ 0x00 {
+                /// Patch number.
+                15:0 patch;
+                /// Minor version number.
+                23:16 minor;
+                /// Major version number.
+                31:24 major;
+            }
+
+            /// Capabilities of the global CSF interface.
+            pub GLB_FEATURES(u32) @ 0x04 {
+                // Suspend compute jobs supported.
+                0:0 compute_suspend => bool;
+                /// Suspend fragment jobs supported.
+                1:1 fragment_suspend => bool;
+                /// Suspend tiler jobs supported.
+                2:2 tiler_suspend => bool;
+                /// Support for multiple PROGRESS_WAIT.
+                3:3 progress_multi_wait => bool;
+            }
+
+            /// MCU virtual address of the global input block.
+            pub GLB_INPUT_VA(u32) @ 0x08 {
+                31:0 value;
+            }
+
+            /// MCU virtual address of the global output block.
+            pub GLB_OUTPUT_VA(u32) @ 0x0C {
+                31:0 value;
+            }
+
+            /// This register contains the count of CSG interfaces supported.
+            pub GLB_GROUP_NUM(u32) @ 0x10 {
+                4:0 value;
+            }
+
+            /// Stride, in bytes, between each CSG interface capabilities structure.
+            pub GLB_GROUP_STRIDE(u32) @ 0x14 {
+                31:0 value;
+            }
+
+            /// Size, in bytes, of the GPU performance counters.
+            pub GLB_PRFCNT_SIZE(u32) @ 0x18 {
+                /// Size of GPU hardware performance counter data.
+                15:0 hardware_size;
+                /// Size of GPU firmware performance counter data.
+                31:16 firmware_size;
+            }
+
+            /// Features of instrumentation buffer used by the TRACE_POINT instruction.
+            pub GLB_INSTR_FEATURES(u32) @ 0x1C {
+                /// How often the buffer offset is updated.
+                3:0 offset_update_rate;
+                /// Maximum size of each stored event
+                7:4 event_size_max;
+            }
+        }
+    }
+
+    /// GLB_INPUT_BLOCK - Global register interface, input area.
+    ///
+    /// These macros represent virtualized registers for the global input block.
+    /// Only Tyr updates these registers; CSF has read-only access.
+    pub(super) mod input {
+        use super::TimestampSource;
+        use kernel::register;
+
+        register! {
+            /// Global request register.
+            ///
+            /// Tyr makes requests to the CSF by changing the value of bits in
+            /// this register.
+            pub GLB_REQ(u32) @ 0x00 {
+                /// Halt the MCU.
+                0:0 halt => bool;
+                /// Update the progress timer timeout.
+                1:1 cfg_progress_timer => bool;
+                /// Update the shader core allocation mask.
+                2:2 cfg_alloc_en => bool;
+                /// Update the shader core power down timeout.
+                3:3 cfg_pwroff_timer => bool;
+                /// Switch the GPU into protected mode.
+                4:4 protm_enter => bool;
+                /// Control performance counters.
+                5:5 prfcnt_enable => bool;
+                /// Sample performance counters.
+                6:6 prfcnt_sample => bool;
+                /// Enable cycle counter and timestamp.
+                7:7 counter_enable => bool;
+                /// Check if firmware is alive.
+                8:8 ping => bool;
+                /// Update firmware configuration settings.
+                9:9 firmware_config_update => bool;
+                /// Enable idle state reporting.
+                10:10 idle_enable => bool;
+                /// Inactive compute iterator event.
+                20:20 inactive_compute => bool;
+                /// Inactive fragment iterator event.
+                21:21 inactive_fragment => bool;
+                /// Inactive tiler iterator event.
+                22:22 inactive_tiler => bool;
+                /// GPU exit protected mode event.
+                23:23 protm_exit => bool;
+                /// Performance counter buffer hit 50% threshold.
+                24:24 prfcnt_threshold => bool;
+                /// Performance counter buffer overflow.
+                25:25 prfcnt_overflow => bool;
+                /// Idle state reached.
+                26:26 idle_event => bool;
+            }
+
+            /// Global acknowledge IRQ mask.
+            ///
+            /// Tyr uses this bit mask to indicate which CSF acknowledgements
+            /// it wishes to be notified about. The bit mask corresponds to
+            /// the request register which also corresponds to the CSF's ack
+            /// register in the Output block.
+            pub GLB_ACK_IRQ_MASK(u32) @ 0x04 {
+                /// Halt the MCU.
+                0:0 halt => bool;
+                /// Update the progress timer timeout.
+                1:1 cfg_progress_timer => bool;
+                /// Update the shader core allocation mask.
+                2:2 cfg_alloc_en => bool;
+                /// Update the shader core power down timeout.
+                3:3 cfg_pwroff_timer => bool;
+                /// Switch the GPU into protected mode.
+                4:4 protm_enter => bool;
+                /// Control performance counters.
+                5:5 prfcnt_enable => bool;
+                /// Sample performance counters.
+                6:6 prfcnt_sample => bool;
+                /// Enable cycle counter and timestamp.
+                7:7 counter_enable => bool;
+                /// Check if firmware is alive.
+                8:8 ping => bool;
+                /// Update firmware configuration.
+                9:9 firmware_config_update => bool;
+                /// Enable idle state reporting.
+                10:10 idle_enable => bool;
+                /// Inactive compute iterator event.
+                20:20 inactive_compute => bool;
+                /// Inactive fragment iterator event.
+                21:21 inactive_fragment => bool;
+                /// Inactive tiler iterator event.
+                22:22 inactive_tiler => bool;
+                /// GPU exit protected mode event.
+                23:23 protm_exit => bool;
+                /// Performance counter buffer threshold reached.
+                24:24 prfcnt_threshold => bool;
+                /// Performance counter buffer overflow.
+                25:25 prfcnt_overflow => bool;
+                /// Idle state reached.
+                26:26 idle_event => bool;
+            }
+
+            /// Global doorbell request.
+            ///
+            /// Each bit in this register is a request flag for the doorbell to
+            /// the corresponding CSG.
+            pub GLB_DB_REQ(u32) @ 0x08 {
+                31:0 mask;
+            }
+
+            /// Global progress timeout.
+            ///
+            /// Tyr uses this register to configure the maximum time limit without
+            /// forward progress before an interrupt or event is generated.
+            /// Timeout is given in clock cycles; a value of 0 disables the timeout.
+            pub GLB_PROGRESS_TIMER(u32) @ 0x10 {
+                31:0 timeout;
+            }
+
+            /// Global shader core power down timer.
+            ///
+            /// Configures the timeout for automatic shader core and tiler power domain
+            /// powerdown. A nonzero value enables the timeout; 0 disables it.
+            pub GLB_PWROFF_TIMER(u32) @ 0x14 {
+                30:0 timeout;
+                31:31 timer_source => TimestampSource;
+            }
+
+            /// Global shader core allocation enable mask.
+            ///
+            /// Each bit in this register controls which shader cores are
+            /// available for endpoint allocation.
+            pub GLB_ALLOC_EN(u64) @ 0x18 {
+                63:0 mask;
+            }
+
+            /// Configure COHERENCY_ENABLE register value to use in protected
+            /// mode execution.
+            pub GLB_PROTM_COHERENCY(u32) @ 0x20 {
+                31:0 value;
+            }
+
+            /// Performance counter address space.
+            pub GLB_PRFCNT_JASID(u32) @ 0x24 {
+                3:0 jasid;
+            }
+
+            /// Performance counter buffer address.
+            pub GLB_PRFCNT_BASE(u64) @ 0x28 {
+                63:0 pointer;
+            }
+
+            /// Performance counter buffer extract index.
+            pub GLB_PRFCNT_EXTRACT(u32) @ 0x30 {
+                31:0 index;
+            }
+
+            /// Performance counter configuration.
+            pub GLB_PRFCNT_CONFIG(u32) @ 0x40 {
+                7:0 size;
+                9:8 set_select;
+            }
+
+            /// CSG performance counting enable.
+            pub GLB_PRFCNT_CSG_SELECT(u32) @ 0x44 {
+                31:0 enable;
+            }
+
+            /// Performance counter enable for firmware.
+            pub GLB_PRFCNT_FW_EN(u32) @ 0x48 {
+                /// Enable flags for groups of 4 counters.
+                31:0 enable;
+            }
+
+            /// Performance counter enable for CSG.
+            pub GLB_PRFCNT_CSG_EN(u32) @ 0x4C {
+                /// Enable flags for groups of 4 counters.
+                31:0 enable;
+            }
+
+            /// Performance counter enable for CSF.
+            pub GLB_PRFCNT_CSF_EN(u32) @ 0x50 {
+                /// Enable flags for groups of 4 counters.
+                31:0 enable;
+            }
+
+            /// Performance counter enable for shader cores.
+            pub GLB_PRFCNT_SHADER_EN(u32) @ 0x54 {
+                /// Enable flags for groups of 4 counters.
+                31:0 enable;
+            }
+
+            /// Performance counter enable for tiler.
+            pub GLB_PRFCNT_TILER_EN(u32) @ 0x58 {
+                /// Enable flags for groups of 4 counters.
+                31:0 enable;
+            }
+
+            /// Performance counter enable for MMU/L2 cache.
+            pub GLB_PRFCNT_MMU_L2_EN(u32) @ 0x5C {
+                /// Enable flags for groups of 4 counters.
+                31:0 enable;
+            }
+
+            /// Global idle event timer.
+            ///
+            /// Configures the timeout for reporting that the GPU has become idle.
+            /// If the value is 0, then idleness is reported immediately.
+            pub GLB_IDLE_TIMER(u32) @ 0x80 {
+                30:0 timeout;
+                31:31 timer_source => TimestampSource;
+            }
+        }
+    }
+
+    /// GLB_OUTPUT_BLOCK - Global register interface, output area.
+    ///
+    /// These macros represent virtualized registers for the global output block.
+    /// Only the CSF updates registers in this area; Tyr has read-only access.
+    pub(super) mod output {
+        use super::HaltStatus;
+        use kernel::register;
+
+        register! {
+            /// Global acknowledge register.
+            ///
+            /// The CSF acknowledges requests from Tyr by changing the value of
+            /// bits in this register.
+            pub GLB_ACK(u32) @ 0x00 {
+                /// Update the progress timer timeout.
+                1:1 cfg_progress_timer => bool;
+                /// Update the shader core allocation mask.
+                2:2 cfg_alloc_en => bool;
+                /// Update the shader core power down timeout.
+                3:3 cfg_pwroff_timer => bool;
+                /// Switch the GPU into protected mode.
+                4:4 protm_enter => bool;
+                /// Control performance counters.
+                5:5 prfcnt_enable => bool;
+                /// Sample performance counters.
+                6:6 prfcnt_sample => bool;
+                /// Enable cycle counter and timestamp.
+                7:7 counter_enable => bool;
+                /// Check if firmware is alive.
+                8:8 ping => bool;
+                /// Update firmware configuration settings.
+                9:9 firmware_config_update => bool;
+                /// Enable idle state reporting.
+                10:10 idle_enable => bool;
+                /// Inactive compute iterator event.
+                20:20 inactive_compute => bool;
+                /// Inactive fragment iterator event.
+                21:21 inactive_fragment => bool;
+                /// Inactive tiler iterator event.
+                22:22 inactive_tiler => bool;
+                /// The GPU has exited protected mode.
+                23:23 protm_exit => bool;
+                /// Performance counter buffer hit 50% threshold.
+                24:24 prfcnt_threshold => bool;
+                /// Performance counter buffer overflow.
+                25:25 prfcnt_overflow => bool;
+                /// Idle state reached.
+                26:26 idle_event => bool;
+            }
+
+            /// Global doorbell acknowledge.
+            ///
+            /// Each bit in this register is an acknowledgement flag from the
+            /// doorbell to the corresponding CSG.
+            pub GLB_DB_ACK(u32) @ 0x08 {
+                31:0 mask;
+            }
+
+            /// Global halt status.
+            ///
+            /// If the MCU has entered the HALT state due to a serious error, then the
+            /// firmware can write a value to this field to supply more information about
+            /// the source of the error.
+            pub GLB_HALT_STATUS(u32) @ 0x10 {
+                31:0 value ?=> HaltStatus;
+            }
+
+            /// Performance counter status.
+            ///
+            /// This register contains information about the last performance-counter
+            /// sample operation.
+            pub GLB_PRFCNT_STATUS(u32) @ 0x14 {
+                /// Performance counter operation failed.
+                0:0 failed => bool;
+                /// Performance counter operation affected by POWER_ON.
+                1:1 power_on_transition => bool;
+                /// Performance counter operation affected by POWER_OFF.
+                2:2 power_off_transition => bool;
+                /// Performance counter operation affected by protected mode.
+                3:3 protected_session => bool;
+            }
+
+            /// Performance counter buffer insert index.
+            pub GLB_PRFCNT_INSERT(u32) @ 0x18 {
+                31:0 index;
+            }
+        }
+    }
+}
+
+/// CSG (Command Stream Group) interface definitions for GROUP_CONTROL_BLOCK.
+///
+/// This module contains the register definitions and types for CSG interfaces,
+/// including control, input, and output blocks.
+mod csg {
+    use core::convert::TryFrom;
+
+    use kernel::{
+        error::{
+            code::EINVAL,
+            Error, //
+        },
+        num::Bounded, //
+    };
+
+    /// Size of a single CSG control block header (GROUP_FEATURES through GROUP_STREAM_STRIDE).
+    ///
+    /// This covers the per-CSG control registers at offsets 0x00-0x18
+    /// STREAM_CONTROL (CS) blocks are accessed separately via runtime calculations.
+    pub(super) const CSG_CONTROL_BLOCK_SIZE: usize = 0x1C;
+
+    /// Size of the CSG_INPUT_BLOCK register block (up to and including CSG_CONFIG at 0x50 + 4 bytes).
+    pub(super) const CSG_INPUT_BLOCK_SIZE: usize = 0x54;
+
+    /// Size of the CSG_OUTPUT_BLOCK register block (up to and including CSG_RESOURCE_DEP at 0x1C + 4 bytes).
+    pub(super) const CSG_OUTPUT_BLOCK_SIZE: usize = 0x20;
+
+    /// CSG execution state (csg_execution_state_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsgExecutionState {
+        /// Terminate execution without saving any state.
+        Terminate = 0,
+        /// Start execution of the command stream group without restoring any state.
+        Start = 1,
+        /// Suspend the command stream. The state of the command stream is saved in the suspend
+        /// buffer, and then the status update registers are updated.
+        Suspend = 2,
+        /// Restore command stream group state from the suspend buffer and continue execution of
+        /// the command stream group.
+        Resume = 3,
+    }
+
+    impl TryFrom<Bounded<u32, 3>> for CsgExecutionState {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 3>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(CsgExecutionState::Terminate),
+                1 => Ok(CsgExecutionState::Start),
+                2 => Ok(CsgExecutionState::Suspend),
+                3 => Ok(CsgExecutionState::Resume),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsgExecutionState> for Bounded<u32, 3> {
+        fn from(state: CsgExecutionState) -> Self {
+            Bounded::try_new(state as u32).unwrap()
+        }
+    }
+
+    /// CSG state interrupt mask (csf_state_irq_mask_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsgStateIrqMask {
+        /// Host interrupt disabled.
+        Disabled = 0,
+        /// Host interrupt enabled.
+        /// This interrupt mask enables interrupts for all 3 bits of the STATUS field,
+        /// and therefore triggers on any value change.
+        Enabled = 7,
+    }
+
+    impl TryFrom<Bounded<u32, 3>> for CsgStateIrqMask {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 3>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(CsgStateIrqMask::Disabled),
+                7 => Ok(CsgStateIrqMask::Enabled),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsgStateIrqMask> for Bounded<u32, 3> {
+        fn from(mask: CsgStateIrqMask) -> Self {
+            Bounded::try_new(mask as u32).unwrap()
+        }
+    }
+
+    /// GROUP_CONTROL_BLOCK - CSG interface control and capabilities.
+    ///
+    /// This defines the register layout for a single CSG interface control block.
+    /// Each CSG's control block is accessed by calculating its runtime offset.
+    pub(super) mod control {
+        use kernel::register;
+
+        register! {
+            /// CSG interface features.
+            ///
+            /// This register contains information about the capabilities of the CSG.
+            pub GROUP_FEATURES(u32) @ 0x00 {
+                /// Suspend buffer type.
+                ///
+                /// Suspend data can be interchanged between two CSGs with the same suspend type.
+                /// Suspend type values have no specific meaning and are otherwise opaque to Tyr.
+                7:0 suspend_type;
+                /// Detailed resource tracking supported. Default is 0 (false).
+                8:8 detailed_tracking => bool;
+            }
+
+            /// MCU virtual address of CSG_INPUT_BLOCK.
+            pub GROUP_INPUT_VA(u32) @ 0x04 {
+                31:0 value;
+            }
+
+            /// MCU virtual address of CSG_OUTPUT_BLOCK.
+            pub GROUP_OUTPUT_VA(u32) @ 0x08 {
+                31:0 value;
+            }
+
+            /// Size, in bytes, required to write suspend data for a CSG buffer in unprotected mode.
+            pub GROUP_SUSPEND_SIZE(u32) @ 0x0C {
+                31:0 value;
+            }
+
+            /// Size, in bytes, required to write suspend data for a CSG buffer in protected mode.
+            pub GROUP_PROTM_SUSPEND_SIZE(u32) @ 0x10 {
+                31:0 value;
+            }
+
+            /// Number of CS interfaces supported by this CSG.
+            pub GROUP_STREAM_NUM(u32) @ 0x14 {
+                5:0 value;
+            }
+
+            /// Stride, in bytes, between CS interface capabilities structures.
+            pub GROUP_STREAM_STRIDE(u32) @ 0x18 {
+                31:0 value;
+            }
+        }
+    }
+
+    /// CSG_INPUT_BLOCK - CSG control, input area.
+    ///
+    /// Only Tyr updates registers in this area. This area is used for control
+    /// of a particular CSG.
+    pub(super) mod input {
+        use super::{
+            CsgExecutionState,
+            CsgStateIrqMask, //
+        };
+        use kernel::register;
+
+        register! {
+            /// CSG request.
+            ///
+            /// Controls various features of the CSG through
+            /// request/acknowledge communication with CSG_ACK.
+            pub CSG_REQ(u32) @ 0x00 {
+                /// Request change of Execution state.
+                2:0 state ?=> CsgExecutionState;
+                /// Request endpoint configuration update.
+                4:4 ep_cfg => bool;
+                /// Request status update.
+                5:5 status_update => bool;
+                /// Notification of sync status change.
+                28:28 sync_update => bool;
+                /// Notification of idle status.
+                29:29 idle => bool;
+                /// Notification of forward progress timeout.
+                31:31 progress_timer_event => bool;
+            }
+
+            /// Global acknowledge IRQ mask.
+            ///
+            /// Controls which flags in CSG_ACK trigger a host IRQ when updated.
+            pub CSG_ACK_IRQ_MASK(u32) @ 0x04 {
+                /// Execution state change event.
+                2:0 state ?=> CsgStateIrqMask;
+                /// Endpoint configuration complete event.
+                4:4 ep_cfg => bool;
+                /// Status update event.
+                5:5 status_update => bool;
+                /// Sync status change event.
+                28:28 sync_update => bool;
+                /// Idle event.
+                29:29 idle => bool;
+                /// Progress timer event.
+                31:31 progress_timer_event => bool;
+            }
+
+            /// CS doorbell request.
+            ///
+            /// Each bit is a request flag for the doorbell to the corresponding CS
+            /// within this CSG. Checked when the global DOORBELL register is written.
+            pub CSG_DB_REQ(u32) @ 0x08 {
+                31:0 mask;
+            }
+
+            /// CS IRQ acknowledge.
+            ///
+            /// Each bit is an acknowledge flag for the IRQ to the corresponding
+            /// CS within the CSG.
+            pub CSG_IRQ_ACK(u32) @ 0x0C {
+                31:0 mask;
+            }
+
+            /// Allowed compute endpoints.
+            pub CSG_ALLOW_COMPUTE(u64) @ 0x20 {
+                63:0 mask;
+            }
+
+            /// Allowed fragment endpoints.
+            pub CSG_ALLOW_FRAGMENT(u64) @ 0x28 {
+                63:0 mask;
+            }
+
+            /// Allowed other endpoints.
+            pub CSG_ALLOW_OTHER(u32) @ 0x30 {
+                31:0 mask;
+            }
+
+            /// Endpoint allocation request.
+            ///
+            /// Configures the allowed requests for each type of endpoint for this CSG.
+            pub CSG_EP_REQ(u32) @ 0x34 {
+                /// Maximum number of endpoints which can run compute jobs.
+                7:0 compute_ep;
+                /// Maximum number of endpoints which can run fragment jobs.
+                15:8 fragment_ep;
+                /// Maximum number of endpoints which can run tiler jobs.
+                19:16 tiler_ep;
+                /// Endpoint exclusively runs compute jobs.
+                20:20 exclusive_compute => bool;
+                /// Endpoint exclusively runs fragment jobs.
+                21:21 exclusive_fragment => bool;
+                /// Priority of the CSG with respect to other CSGs (higher value = higher priority).
+                31:28 priority;
+            }
+
+            /// Normal mode suspend buffer address.
+            pub CSG_SUSPEND_BUF(u64) @ 0x40 {
+                63:0 pointer;
+            }
+
+            /// Protected mode suspend buffer address.
+            pub CSG_PROTM_SUSPEND_BUF(u64) @ 0x48 {
+                63:0 pointer;
+            }
+
+            /// CSG configuration options.
+            pub CSG_CONFIG(u32) @ 0x50 {
+                3:0 jasid;
+                8:8 l2c_allocate_ring => bool;
+                16:16 l2c_allocate_other => bool;
+            }
+        }
+    }
+
+    /// CSG_OUTPUT_BLOCK - CSG control, output area.
+    ///
+    /// Only the CSF updates the registers in this area. This area is used for control
+    /// of a particular CSG.
+    ///
+    /// Instances of this virtual register page are referenced by the
+    /// GROUP_CONTROL_BLOCK.GROUP_OUTPUT_VA register.
+    pub(super) mod output {
+        use super::CsgExecutionState;
+        use kernel::register;
+
+        register! {
+            /// CSG acknowledge flags.
+            ///
+            /// Interacts with CSG_REQ to control various features of the CSG
+            /// through request/acknowledge communication.
+            pub CSG_ACK(u32) @ 0x00 {
+                /// Current Execution state.
+                2:0 state ?=> CsgExecutionState;
+                /// Completion of endpoint configuration.
+                4:4 ep_cfg => bool;
+                /// Completion of status update.
+                5:5 status_update => bool;
+                /// Notification of sync status change.
+                28:28 sync_update => bool;
+                /// Notification of idle status.
+                29:29 idle => bool;
+                /// Notification of forward progress timeout.
+                31:31 progress_timer_event => bool;
+            }
+
+            /// CS kernel doorbell acknowledge flags.
+            ///
+            /// Each bit is an acknowledge flag for the doorbell to the corresponding
+            /// CS within this CSG. The doorbell for CSn is active when
+            /// bit n in CSG_DB_REQ and CSG_DB_ACK differ.
+            pub CSG_DB_ACK(u32) @ 0x08 {
+                31:0 mask;
+            }
+
+            /// CS IRQ request flags.
+            pub CSG_IRQ_REQ(u32) @ 0x0C {
+                31:0 mask;
+            }
+
+            /// Endpoint allocation status register.
+            ///
+            /// Provides information on the number of endpoints currently allocated
+            /// to this CSG.
+            pub CSG_STATUS_EP_CURRENT(u32) @ 0x10 {
+                /// Number of compute endpoints.
+                7:0 compute_ep;
+                /// Number of fragment endpoints.
+                15:8 fragment_ep;
+                /// Number of tiler endpoints.
+                19:16 tiler_ep;
+            }
+
+            /// Endpoint request status register.
+            ///
+            /// Provides information on the number of endpoints currently requested
+            /// by this CSG.
+            pub CSG_STATUS_EP_REQ(u32) @ 0x14 {
+                /// Number of compute endpoints.
+                7:0 compute_ep;
+                /// Number of fragment endpoints.
+                15:8 fragment_ep;
+                /// Number of tiler endpoints.
+                19:16 tiler_ep;
+                /// Endpoint exclusively runs compute jobs.
+                20:20 exclusive_compute => bool;
+                /// Endpoint exclusively runs fragment jobs.
+                21:21 exclusive_fragment => bool;
+            }
+
+            /// Overall state status register.
+            pub CSG_STATUS_STATE(u32) @ 0x18 {
+                0:0 idle => bool;
+            }
+
+            /// Current resource dependencies.
+            pub CSG_RESOURCE_DEP(u32) @ 0x1C {
+                /// Stream using no resources.
+                0:0 none => bool;
+                /// Stream using only compute resources.
+                1:1 using_compute => bool;
+                /// Stream using only fragment resources.
+                2:2 using_fragment => bool;
+                /// Stream using compute and fragment resources.
+                3:3 using_compute_fragment => bool;
+                /// Stream using only tiler resources.
+                4:4 using_tiler => bool;
+                /// Stream using compute and tiler resources.
+                5:5 using_compute_tiler => bool;
+                /// Stream using fragment and tiler resources.
+                6:6 using_fragment_tiler => bool;
+                /// Stream using compute, fragment and tiler resources.
+                7:7 using_compute_fragment_tiler => bool;
+                /// Compute resource available.
+                16:16 avail_compute => bool;
+                /// Fragment resource available.
+                17:17 avail_fragment => bool;
+                /// Tiler resource available.
+                18:18 avail_tiler => bool;
+                /// Active compute resource request.
+                20:20 active_compute => bool;
+                /// Active fragment resource request.
+                21:21 active_fragment => bool;
+                /// Active tiler resource request.
+                22:22 active_tiler => bool;
+            }
+        }
+    }
+}
+
+/// CS interface definitions for STREAM_CONTROL_BLOCK
+///
+/// This module contains the register definitions and types for CS interfaces,
+/// including control, input, and output blocks.
+mod cs {
+    use core::convert::TryFrom;
+
+    use kernel::{
+        error::{
+            code::EINVAL,
+            Error, //
+        },
+        num::Bounded, //
+    };
+
+    /// Size of a single CS control block header.
+    ///
+    /// This covers the per-CS control registers at offsets 0x00-0x08
+    /// CS blocks are accessed separately via runtime calculations.
+    pub(super) const CS_CONTROL_BLOCK_SIZE: usize = 0xC;
+
+    /// Size of the CS_KERNEL_INPUT_BLOCK register block.
+    pub(super) const CS_KERNEL_INPUT_BLOCK_SIZE: usize = 0x58;
+
+    /// Size of the CS_KERNEL_OUTPUT_BLOCK register block.
+    pub(super) const CS_KERNEL_OUTPUT_BLOCK_SIZE: usize = 0xD8;
+
+    /// CS execution state (cs_state_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsState {
+        /// Stop the command stream.
+        /// The execution of command stream instructions stops and any job active from the
+        /// command stream runs to completion (unless terminated at the CSG level) before
+        /// the STOP request completes.
+        Stop = 0,
+        /// Initialize the command stream and start execution.
+        Start = 1,
+    }
+
+    impl TryFrom<Bounded<u32, 3>> for CsState {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 3>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(CsState::Stop),
+                1 => Ok(CsState::Start),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsState> for Bounded<u32, 3> {
+        fn from(state: CsState) -> Self {
+            Bounded::try_new(state as u32).unwrap()
+        }
+    }
+
+    /// CS state interrupt mask (csf_state_irq_mask_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsStateIrqMask {
+        /// Host interrupt disabled.
+        Disabled = 0,
+        /// Host interrupt enabled.
+        /// This interrupt mask enables interrupts for all 3 bits of the STATUS field,
+        /// and therefore triggers on any value change.
+        Enabled = 7,
+    }
+
+    impl TryFrom<Bounded<u32, 3>> for CsStateIrqMask {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 3>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(CsStateIrqMask::Disabled),
+                7 => Ok(CsStateIrqMask::Enabled),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsStateIrqMask> for Bounded<u32, 3> {
+        fn from(mask: CsStateIrqMask) -> Self {
+            Bounded::try_new(mask as u32).unwrap()
+        }
+    }
+
+    /// CS scoreboard wait source (cs_sb_wait_source_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsSbWaitSource {
+        /// Not waiting for scoreboards.
+        None = 0x0,
+        /// WAIT instruction.
+        /// The SB_MASK field shows which scoreboard entries the WAIT instruction is waiting for.
+        Wait = 0x8,
+    }
+
+    impl TryFrom<Bounded<u32, 4>> for CsSbWaitSource {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 4>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0x0 => Ok(CsSbWaitSource::None),
+                0x8 => Ok(CsSbWaitSource::Wait),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsSbWaitSource> for Bounded<u32, 4> {
+        fn from(source: CsSbWaitSource) -> Self {
+            Bounded::try_new(source as u32).unwrap()
+        }
+    }
+
+    /// CS wait condition (csf_wait_condition_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsWaitCondition {
+        /// Sync Object <= Comparison Register.
+        Le = 0,
+        /// Sync Object > Comparison Register.
+        Gt = 1,
+    }
+
+    impl TryFrom<Bounded<u32, 4>> for CsWaitCondition {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 4>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(CsWaitCondition::Le),
+                1 => Ok(CsWaitCondition::Gt),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsWaitCondition> for Bounded<u32, 4> {
+        fn from(condition: CsWaitCondition) -> Self {
+            Bounded::try_new(condition as u32).unwrap()
+        }
+    }
+
+    /// CS blocked reason (cs_blocked_reason_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsBlockedReason {
+        /// The command stream is not blocked.
+        Unblocked = 0,
+        /// Blocked on scoreboards in some way.
+        /// See CS_STATUS_WAIT for further information.
+        SbWait = 1,
+        /// Blocked on PROGRESS_WAIT instruction.
+        ProgressWait = 2,
+        /// Blocked on a SYNC_WAIT32 or SYNC_WAIT64 instruction.
+        /// See CS_STATUS_WAIT, CS_STATUS_WAIT_SYNC_POINTER and CS_STATUS_WAIT_SYNC_VALUE for
+        /// more information.
+        SyncWait = 3,
+        /// Blocked awaiting storage for a deferred instruction.
+        Deferred = 4,
+        /// Blocked awaiting resource allocation.
+        /// See CS_STATUS_REQ_RESOURCE for more information.
+        Resource = 5,
+        /// Blocked awaiting completion of a synchronous FLUSH_CACHE2 instruction.
+        Flush = 6,
+    }
+
+    impl TryFrom<Bounded<u32, 4>> for CsBlockedReason {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 4>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(CsBlockedReason::Unblocked),
+                1 => Ok(CsBlockedReason::SbWait),
+                2 => Ok(CsBlockedReason::ProgressWait),
+                3 => Ok(CsBlockedReason::SyncWait),
+                4 => Ok(CsBlockedReason::Deferred),
+                5 => Ok(CsBlockedReason::Resource),
+                6 => Ok(CsBlockedReason::Flush),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsBlockedReason> for Bounded<u32, 4> {
+        fn from(reason: CsBlockedReason) -> Self {
+            Bounded::try_new(reason as u32).unwrap()
+        }
+    }
+
+    /// CS_FAULT exception type (restricted subset of exception_type_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsFaultExceptionType {
+        /// No error.
+        Ok = 0x00,
+        /// Shader program executed a KABOOM instruction.
+        Kaboom = 0x05,
+        /// Iterator terminated.
+        CsResourceTerminated = 0x0F,
+        /// Command stream bus error.
+        CsBusFault = 0x48,
+        /// A fault has been inherited.
+        CsInheritFault = 0x4B,
+        /// Shader invalid Program Counter.
+        InstrInvalidPc = 0x50,
+        /// Shader invalid instruction.
+        InstrInvalidEnc = 0x51,
+        /// Shader barrier failure.
+        InstrBarrierFault = 0x55,
+        /// Invalid descriptor.
+        DataInvalidFault = 0x58,
+        /// Tile out of bounds.
+        TileRangeFault = 0x59,
+        /// Address out of bounds.
+        AddrRangeFault = 0x5A,
+        /// No detailed error information available.
+        ImpreciseFault = 0x5B,
+        /// Firmware error.
+        ResourceEvictionTimeout = 0x69,
+    }
+
+    impl TryFrom<Bounded<u32, 8>> for CsFaultExceptionType {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0x00 => Ok(CsFaultExceptionType::Ok),
+                0x05 => Ok(CsFaultExceptionType::Kaboom),
+                0x0F => Ok(CsFaultExceptionType::CsResourceTerminated),
+                0x48 => Ok(CsFaultExceptionType::CsBusFault),
+                0x4B => Ok(CsFaultExceptionType::CsInheritFault),
+                0x50 => Ok(CsFaultExceptionType::InstrInvalidPc),
+                0x51 => Ok(CsFaultExceptionType::InstrInvalidEnc),
+                0x55 => Ok(CsFaultExceptionType::InstrBarrierFault),
+                0x58 => Ok(CsFaultExceptionType::DataInvalidFault),
+                0x59 => Ok(CsFaultExceptionType::TileRangeFault),
+                0x5A => Ok(CsFaultExceptionType::AddrRangeFault),
+                0x5B => Ok(CsFaultExceptionType::ImpreciseFault),
+                0x69 => Ok(CsFaultExceptionType::ResourceEvictionTimeout),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsFaultExceptionType> for Bounded<u32, 8> {
+        fn from(exc_type: CsFaultExceptionType) -> Self {
+            Bounded::try_new(exc_type as u32).unwrap()
+        }
+    }
+
+    /// CS_FATAL exception type (restricted subset of exception_type_t in spec).
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(super) enum CsFatalExceptionType {
+        /// No error.
+        Ok = 0x00,
+        /// Command stream config invalid.
+        CsConfigFault = 0x40,
+        /// No endpoints available.
+        CsEndpointFault = 0x44,
+        /// Command stream bus error.
+        CsBusFault = 0x48,
+        /// Command stream invalid instruction.
+        CsInvalidInstruction = 0x49,
+        /// Command stream call stack overflow.
+        CsCallStackOverflow = 0x4A,
+        /// Firmware error.
+        FirmwareInternalError = 0x68,
+    }
+
+    impl TryFrom<Bounded<u32, 8>> for CsFatalExceptionType {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0x00 => Ok(CsFatalExceptionType::Ok),
+                0x40 => Ok(CsFatalExceptionType::CsConfigFault),
+                0x44 => Ok(CsFatalExceptionType::CsEndpointFault),
+                0x48 => Ok(CsFatalExceptionType::CsBusFault),
+                0x49 => Ok(CsFatalExceptionType::CsInvalidInstruction),
+                0x4A => Ok(CsFatalExceptionType::CsCallStackOverflow),
+                0x68 => Ok(CsFatalExceptionType::FirmwareInternalError),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CsFatalExceptionType> for Bounded<u32, 8> {
+        fn from(exc_type: CsFatalExceptionType) -> Self {
+            Bounded::try_new(exc_type as u32).unwrap()
+        }
+    }
+
+    /// STREAM_CONTROL_BLOCK - CS interface control and capabilities.
+    ///
+    /// This defines the register layout for a single CS interface control block.
+    /// Each CS's control block is accessed by calculating its runtime offset.
+    pub(super) mod control {
+        use kernel::register;
+        register! {
+            /// CS features.
+            pub STREAM_FEATURES(u32) @ 0x00 {
+                /// Number of work registers.
+                7:0 work_registers;
+                /// Number of scoreboards.
+                15:8 scoreboards;
+                /// Compute jobs are supported.
+                16:16 compute => bool;
+                /// Fragment jobs are supported.
+                17:17 fragment => bool;
+                /// Tiler jobs are supported.
+                18:18 tiler => bool;
+            }
+
+            /// MCU virtual address of CS_KERNEL_INPUT_BLOCK.
+            pub STREAM_INPUT_VA(u32) @ 0x04 {
+                31:0 value;
+            }
+
+            /// MCU virtual address of CS_KERNEL_OUTPUT_BLOCK.
+            pub STREAM_OUTPUT_VA(u32) @ 0x08 {
+                31:0 value;
+            }
+        }
+    }
+
+    /// CS_KERNEL_INPUT_BLOCK.
+    pub(super) mod input {
+        use super::{
+            CsState,
+            CsStateIrqMask, //
+        };
+        use kernel::register;
+
+        // Command stream control, kernel input area.
+        register! {
+            /// Command stream request flags.
+            pub CS_REQ(u32) @ 0x00 {
+                /// Requested command stream state.
+                2:0 state ?=> CsState;
+                /// Enable extract events.
+                4:4 extract_event => bool;
+                /// Enable idle events for sync/wait.
+                8:8 idle_sync_wait => bool;
+                /// Enable idle events for protected mode pending.
+                9:9 idle_protm_pend => bool;
+                /// Enable idle events for empty ring buffer.
+                10:10 idle_empty => bool;
+                /// Enable idle events for resource requests.
+                11:11 idle_resource_req => bool;
+                /// Clear tiler-out-of-memory notification.
+                26:26 tiler_oom => bool;
+                /// Clear protected mode pending notification.
+                27:27 protm_pend => bool;
+                /// Clear fatal error notification.
+                30:30 fatal => bool;
+                /// Clear fault notification.
+                31:31 fault => bool;
+            }
+
+            /// Command stream configuration.
+            pub CS_CONFIG(u32) @ 0x04 {
+                3:0 priority;
+                15:8 user_doorbell;
+            }
+
+            /// Command stream interrupt mask.
+            pub CS_ACK_IRQ_MASK(u32) @ 0x0C {
+                /// CS state change event.
+                2:0 state ?=> CsStateIrqMask;
+                /// Extract event.
+                4:4 extract_event => bool;
+                /// Tiler out of memory.
+                26:26 tiler_oom => bool;
+                /// Protected mode pending.
+                27:27 protm_pend => bool;
+                /// Non-recoverable error.
+                30:30 fatal => bool;
+                /// Recoverable error.
+                31:31 fault => bool;
+            }
+
+            /// Base pointer for the ring buffer.
+            pub CS_BASE(u64) @ 0x10 {
+                63:0 pointer;
+            }
+
+            /// Size of the ring buffer.
+            pub CS_SIZE(u32) @ 0x18 {
+                31:0 size;
+            }
+
+            /// Pointer to start of heap chunk list.
+            pub CS_TILER_HEAP_START(u64) @ 0x20 {
+                63:0 pointer;
+            }
+
+            /// Pointer to end of heap chunk list.
+            pub CS_TILER_HEAP_END(u64) @ 0x28 {
+                63:0 pointer;
+            }
+
+            /// CS user mode input page address.
+            pub CS_USER_INPUT(u64) @ 0x30 {
+                63:0 pointer;
+            }
+
+            /// CS user mode output page address.
+            pub CS_USER_OUTPUT(u64) @ 0x38 {
+                63:0 pointer;
+            }
+
+            /// Instrumentation buffer configuration.
+            pub CS_INSTR_CONFIG(u32) @ 0x40 {
+                3:0 jasid;
+                7:4 event_size;
+                23:16 event_state;
+            }
+
+            /// Instrumentation buffer size.
+            pub CS_INSTR_BUFFER_SIZE(u32) @ 0x44 {
+                31:0 size;
+            }
+
+            /// Instrumentation buffer base pointer.
+            pub CS_INSTR_BUFFER_BASE(u64) @ 0x48 {
+                63:0 pointer;
+            }
+
+            /// Instrumentation buffer pointer to insert offset.
+            pub CS_INSTR_BUFFER_OFFSET_POINTER(u64) @ 0x50 {
+                63:0 pointer;
+            }
+        }
+    }
+
+    /// CS_KERNEL_OUTPUT_BLOCK.
+    pub(super) mod output {
+        use super::{
+            CsBlockedReason,
+            CsFatalExceptionType,
+            CsFaultExceptionType,
+            CsSbWaitSource,
+            CsState,
+            CsWaitCondition, //
+        };
+        use kernel::register;
+
+        // Command stream control, kernel output area.
+        register! {
+            /// Command stream acknowledge flags.
+            pub CS_ACK(u32) @ 0x00 {
+                /// Current command stream state.
+                2:0 state ?=> CsState;
+                /// Extract event notification.
+                4:4 extract_event => bool;
+                /// Tiler out of memory notification.
+                26:26 tiler_oom => bool;
+                /// Stalled waiting for protected mode.
+                27:27 protm_pend => bool;
+                /// Unrecoverable error notification.
+                30:30 fatal => bool;
+                /// Recoverable error notification.
+                31:31 fault => bool;
+            }
+
+            /// Program pointer current value.
+            pub CS_STATUS_CMD_PTR(u64) @ 0x40 {
+                /// Program Counter current value.
+                63:0 pointer;
+            }
+
+            /// Wait condition status register.
+            pub CS_STATUS_WAIT(u32) @ 0x48 {
+                /// Waiting for scoreboard entry.
+                15:0 sb_mask;
+                /// Source of scoreboard wait status, if any.
+                19:16 sb_source ?=> CsSbWaitSource;
+                /// SYNC_WAIT condition.
+                27:24 sync_wait_condition ?=> CsWaitCondition;
+                /// Waiting for PROGRESS_WAIT instruction.
+                28:28 progress_wait => bool;
+                /// Waiting for protected execution.
+                29:29 protm_pend => bool;
+                /// Size of sync object waited for.
+                30:30 sync_wait_size => bool;
+                /// Waiting for SYNC_WAIT instruction.
+                31:31 sync_wait => bool;
+            }
+
+            /// Indicates the resources requested by the command stream.
+            pub CS_STATUS_REQ_RESOURCE(u32) @ 0x4C {
+                /// Compute resources requested.
+                0:0 compute_requested => bool;
+                /// Fragment resources requested.
+                1:1 fragment_requested => bool;
+                /// Tiler resources requested.
+                2:2 tiler_requested => bool;
+                /// IDVS resources requested.
+                3:3 idvs_requested => bool;
+                /// Compute resources granted.
+                16:16 compute_granted => bool;
+                /// Fragment resources granted.
+                17:17 fragment_granted => bool;
+                /// Tiler resources granted.
+                18:18 tiler_granted => bool;
+                /// IDVS resources granted.
+                19:19 idvs_granted => bool;
+            }
+
+            /// Sync object pointer.
+            pub CS_STATUS_WAIT_SYNC_POINTER(u64) @ 0x50 {
+                /// Sync object address.
+                63:0 pointer;
+            }
+
+            /// Sync object test value, low half.
+            pub CS_STATUS_WAIT_SYNC_VALUE(u32) @ 0x58 {
+                /// Sync object test value.
+                31:0 value;
+            }
+
+            /// Scoreboard status.
+            pub CS_STATUS_SCOREBOARDS(u32) @ 0x5C {
+                /// Which scoreboard entries are non-zero.
+                15:0 nonzero;
+            }
+
+            /// Blocked reason.
+            pub CS_STATUS_BLOCKED_REASON(u32) @ 0x60 {
+                3:0 reason ?=> CsBlockedReason;
+            }
+
+            /// Sync object test value, high half.
+            pub CS_STATUS_WAIT_SYNC_VALUE_HI(u32) @ 0x64 {
+                /// Sync object test value.
+                31:0 value;
+            }
+
+            /// Recoverable fault information.
+            pub CS_FAULT(u32) @ 0x80 {
+                /// Exception type.
+                7:0 exception_type ?=> CsFaultExceptionType;
+                /// Exception specific data.
+                31:8 exception_data;
+            }
+
+            /// Unrecoverable fault information.
+            pub CS_FATAL(u32) @ 0x84 {
+                /// Exception type.
+                7:0 exception_type ?=> CsFatalExceptionType;
+                /// Exception specific data.
+                31:8 exception_data;
+            }
+
+            /// Additional information about a recoverable fault.
+            pub CS_FAULT_INFO(u64) @ 0x88 {
+                /// Exception specific data.
+                63:0 exception_data;
+            }
+
+            /// Additional information about a non-recoverable fault.
+            pub CS_FATAL_INFO(u64) @ 0x90 {
+                /// Exception specific data.
+                63:0 exception_data;
+            }
+
+            /// Number of vertex/tiling operations started.
+            pub CS_HEAP_VT_START(u32) @ 0xC0 {
+                31:0 value;
+            }
+
+            /// Number of vertex/tiling operations completed.
+            pub CS_HEAP_VT_END(u32) @ 0xC4 {
+                31:0 value;
+            }
+
+            /// Number of fragment completed.
+            pub CS_HEAP_FRAG_END(u32) @ 0xCC {
+                31:0 value;
+            }
+
+            /// Heap context address.
+            pub CS_HEAP_ADDRESS(u64) @ 0xD0 {
+                63:0 pointer;
+            }
+        }
+    }
+}
+
+use cs::*;
+use csg::*;
+use glb::{
+    control::*,
+    *, //
+};
+
+/// State of the global interface.
+enum GlobalInterfaceState {
+    /// Interface is not yet initialized.
+    Disabled,
+    /// Interface is initialized and operational.
+    Enabled(EnabledGlobalInterface),
+}
+
+/// When enabled, the Global Interface has control,
+/// input, and output system memory interfaces, as well as
+/// the discovered CSG interfaces.
+#[expect(dead_code)]
+struct EnabledGlobalInterface {
+    /// Control block interface - provides version, features, and CSG discovery.
+    glb_control: FwInterface<GLB_CONTROL_BLOCK_SIZE>,
+    /// Input block interface - driver writes requests here.
+    glb_input: FwInterface<GLB_INPUT_BLOCK_SIZE>,
+    /// Output block interface - firmware writes acknowledgements here.
+    glb_output: FwInterface<GLB_OUTPUT_BLOCK_SIZE>,
+    /// Runtime stride between CSG control blocks (read from GLB_GROUP_STRIDE).
+    csg_stride: usize,
+    /// Number of CSG interfaces reported by hardware.
+    csg_num: usize,
+    /// Discovered CSG interfaces.
+    csg: KVec<CsgInterface>,
+}
+
+/// Global CSF Interface
+///
+/// The CSF controls operations that are common to all CSs.
+pub(super) struct GlobalInterface {
+    /// Current interface state (Disabled or Enabled).
+    state: GlobalInterfaceState,
+}
+
+impl GlobalInterface {
+    /// Creates a new CSF global interface, initially disabled.
+    pub(super) fn new() -> Result<Self> {
+        Ok(Self {
+            state: GlobalInterfaceState::Disabled,
+        })
+    }
+
+    /// Enables the global interface and discovers the CSG interfaces.
+    ///
+    /// This reads the firmware's control block to set up the global input/output
+    /// interfaces; it configures timers and shader core allocation; and it discovers
+    /// available CSG interfaces.
+    pub(crate) fn enable(&mut self, shared_section: &Section) -> Result {
+        let vmap = shared_section.mem.bo.owned_vmap::<0>()?;
+        let va_range = shared_section.mem.va_range();
+
+        let glb_control =
+            FwInterface::<GLB_CONTROL_BLOCK_SIZE>::new(&vmap, &va_range, va_range.start)?;
+
+        let version = glb_control.read(GLB_VERSION);
+        if version.major().get() == 0 {
+            pr_err!("CSF interface version is 0. Firmware may have failed to boot.\n");
+            return Err(EINVAL);
+        }
+        pr_info!(
+            "CSF interface version: {}.{}.{}\n",
+            version.major().get(),
+            version.minor().get(),
+            version.patch().get()
+        );
+
+        let input_va = glb_control.read(GLB_INPUT_VA);
+        let glb_input = FwInterface::<GLB_INPUT_BLOCK_SIZE>::new(
+            &vmap,
+            &va_range,
+            input_va.value().get().into(),
+        )?;
+
+        let output_va = glb_control.read(GLB_OUTPUT_VA);
+        let glb_output = FwInterface::<GLB_OUTPUT_BLOCK_SIZE>::new(
+            &vmap,
+            &va_range,
+            output_va.value().get().into(),
+        )?;
+
+        // Read how many CSG interfaces exist.
+        let csg_num = glb_control.read(GLB_GROUP_NUM).value().get();
+
+        // Read the stride between CSG control blocks.
+        let csg_stride = glb_control.read(GLB_GROUP_STRIDE).value().get() as usize;
+
+        if csg_stride < CSG_CONTROL_BLOCK_SIZE {
+            pr_err!(
+                "CSG stride {} is smaller than control block size {}\n",
+                csg_stride,
+                CSG_CONTROL_BLOCK_SIZE
+            );
+            return Err(EINVAL);
+        }
+
+        // Validate the CSG number reported.
+        if csg_num as usize > super::MAX_CSG {
+            pr_err!(
+                "Too many CSGs: hardware reports {}, max supported {}\n",
+                csg_num,
+                super::MAX_CSG
+            );
+            return Err(EINVAL);
+        }
+
+        let enabled = EnabledGlobalInterface {
+            glb_control,
+            glb_input,
+            glb_output,
+            csg_stride,
+            csg_num: csg_num as usize,
+            csg: KVec::with_capacity(csg_num as usize, GFP_KERNEL)?,
+        };
+
+        self.state = GlobalInterfaceState::Enabled(enabled);
+        self.init_csg(shared_section)?;
+        Ok(())
+    }
+
+    /// Initialize CSG interfaces.
+    ///
+    /// This uses the previously read CSG count to create and enable each CSG interface.
+    fn init_csg(&mut self, shared_section: &Section) -> Result {
+        let enabled = match &mut self.state {
+            GlobalInterfaceState::Enabled(e) => e,
+            GlobalInterfaceState::Disabled => return Err(EINVAL),
+        };
+
+        for csg_idx in 0..enabled.csg_num {
+            // Create and enable the CSG interface.
+            let mut csg = CsgInterface::new(csg_idx)?;
+            csg.enable(shared_section, csg_idx, enabled.csg_stride)?;
+
+            enabled.csg.push(csg, GFP_KERNEL)?;
+        }
+
+        Ok(())
+    }
+}
+
+/// State of a CSG interface.
+enum CsgInterfaceState {
+    /// Interface is not yet initialized.
+    Disabled,
+    /// Interface is initialized and operational.
+    Enabled(EnabledCsgInterface),
+}
+
+/// When enabled, a CSG Interface has control, input, and output system memory interfaces.
+struct EnabledCsgInterface {
+    /// Control block interface - provides CSG capabilities and configuration.
+    #[expect(dead_code)]
+    csg_control: FwInterface<CSG_CONTROL_BLOCK_SIZE>,
+    /// Input block interface - driver writes CSG requests here.
+    #[expect(dead_code)]
+    csg_input: FwInterface<CSG_INPUT_BLOCK_SIZE>,
+    /// Output block interface - firmware writes CSG acknowledgements here.
+    #[expect(dead_code)]
+    csg_output: FwInterface<CSG_OUTPUT_BLOCK_SIZE>,
+    /// Runtime stride between CS control blocks (read from GROUP_STREAM_STRIDE).
+    cs_stride: usize,
+    /// Number of CS interfaces reported by hardware for this CSG.
+    cs_num: usize,
+    /// Discovered CS interfaces.
+    cs: KVec<CsInterface>,
+}
+
+/// Command Stream Group Interface
+///
+/// The CSG interface controls operations for a specific CSG.
+pub(crate) struct CsgInterface {
+    /// Current interface state (Disabled or Enabled).
+    state: CsgInterfaceState,
+    /// CSG identifier/index number.
+    #[expect(dead_code)]
+    csg_idx: usize,
+}
+
+impl CsgInterface {
+    /// Creates a new disabled CSG interface.
+    pub(super) fn new(csg_idx: usize) -> Result<Self> {
+        Ok(Self {
+            state: CsgInterfaceState::Disabled,
+            csg_idx,
+        })
+    }
+
+    /// Enables the CSG interface.
+    ///
+    /// This calculates the runtime offset of this CSG's control block and creates
+    /// a bounded interface to access it. It then reads the input/output interface
+    /// addresses from the CSG control block.
+    fn enable(&mut self, shared_section: &Section, csg_idx: usize, csg_stride: usize) -> Result {
+        use csg::control::{
+            GROUP_INPUT_VA,
+            GROUP_OUTPUT_VA,
+            GROUP_STREAM_NUM,
+            GROUP_STREAM_STRIDE, //
+        };
+        use kernel::io::Io;
+
+        let vmap = shared_section.mem.bo.owned_vmap::<0>()?;
+        let va_range = shared_section.mem.va_range();
+
+        // Calculate the runtime offset for this CSG's control block.
+        // The CSG control blocks start at CSG_GROUP_CONTROL_OFFSET from the GLB control block,
+        // with each CSG spaced by csg_stride bytes.
+        let csg_control_offset = CSG_GROUP_CONTROL_OFFSET + csg_idx * csg_stride;
+
+        // The CSG control block's MCU virtual address is relative to the shared section start.
+        let csg_control_va = va_range.start + csg_control_offset as u64;
+
+        // Create a bounded interface for this CSG's control block at the calculated address.
+        let csg_control =
+            FwInterface::<CSG_CONTROL_BLOCK_SIZE>::new(&vmap, &va_range, csg_control_va)?;
+
+        // Read the input and output VAs from the CSG control block.
+        let input_va = csg_control.read(GROUP_INPUT_VA).value().get();
+        let csg_input =
+            FwInterface::<CSG_INPUT_BLOCK_SIZE>::new(&vmap, &va_range, input_va.into())?;
+
+        let output_va = csg_control.read(GROUP_OUTPUT_VA).value().get();
+        let csg_output =
+            FwInterface::<CSG_OUTPUT_BLOCK_SIZE>::new(&vmap, &va_range, output_va.into())?;
+
+        // Read the runtime stride between CS control blocks.
+        let cs_stride = csg_control.read(GROUP_STREAM_STRIDE).value().get() as usize;
+
+        if cs_stride < CS_CONTROL_BLOCK_SIZE {
+            pr_err!(
+                "CS stride {} is smaller than control block size {}\n",
+                cs_stride,
+                CS_CONTROL_BLOCK_SIZE
+            );
+            return Err(EINVAL);
+        }
+
+        // Read how many CS interfaces exist for this CSG.
+        let cs_num = csg_control.read(GROUP_STREAM_NUM).value().get();
+
+        // Validate that the hardware doesn't report more CS than we support.
+        if cs_num as usize > super::MAX_CS {
+            pr_err!(
+                "Too many CS: hardware reports {}, max supported {}\n",
+                cs_num,
+                super::MAX_CS
+            );
+            return Err(EINVAL);
+        }
+
+        let enabled = EnabledCsgInterface {
+            csg_control,
+            csg_input,
+            csg_output,
+            cs_stride,
+            cs_num: cs_num as usize,
+            cs: KVec::with_capacity(cs_num as usize, GFP_KERNEL)?,
+        };
+
+        self.state = CsgInterfaceState::Enabled(enabled);
+        self.init_cs(shared_section, csg_control_offset)?;
+        Ok(())
+    }
+
+    /// Initialize and discover CS interfaces.
+    ///
+    /// This uses the previously read CS count to create and enable each CS interface.
+    fn init_cs(&mut self, shared_section: &Section, csg_control_offset: usize) -> Result {
+        let enabled = match &mut self.state {
+            CsgInterfaceState::Enabled(e) => e,
+            CsgInterfaceState::Disabled => return Err(EINVAL),
+        };
+
+        for cs_idx in 0..enabled.cs_num {
+            // Create and enable the CS interface.
+            let mut cs = CsInterface::new(cs_idx)?;
+            cs.enable(
+                shared_section,
+                csg_control_offset,
+                cs_idx,
+                enabled.cs_stride,
+            )?;
+
+            enabled.cs.push(cs, GFP_KERNEL)?;
+        }
+
+        Ok(())
+    }
+}
+
+/// State of a CS interface.
+enum CsInterfaceState {
+    /// Interface is not yet initialized.
+    Disabled,
+    /// Interface is initialized and operational.
+    #[expect(dead_code)]
+    Enabled(EnabledCsInterface),
+}
+
+/// When enabled, a CS Interface has control, input, and output system memory interfaces.
+struct EnabledCsInterface {
+    /// Control block interface - provides CS capabilities and configuration.
+    #[expect(dead_code)]
+    cs_control: FwInterface<CS_CONTROL_BLOCK_SIZE>,
+    /// Input block interface - driver writes CS requests here.
+    #[expect(dead_code)]
+    cs_input: FwInterface<CS_KERNEL_INPUT_BLOCK_SIZE>,
+    /// Output block interface - firmware writes CS acknowledgements here.
+    #[expect(dead_code)]
+    cs_output: FwInterface<CS_KERNEL_OUTPUT_BLOCK_SIZE>,
+}
+
+/// Command Stream Interface
+///
+/// The CS interface controls operations for a specific CS.
+pub(crate) struct CsInterface {
+    /// Current interface state (Disabled or Enabled).
+    state: CsInterfaceState,
+    /// CS identifier/index number.
+    #[expect(dead_code)]
+    cs_idx: usize,
+}
+
+impl CsInterface {
+    /// Creates a new disabled CS interface.
+    pub(super) fn new(cs_idx: usize) -> Result<Self> {
+        Ok(Self {
+            state: CsInterfaceState::Disabled,
+            cs_idx,
+        })
+    }
+
+    /// Enables the CS interface.
+    ///
+    /// This calculates the runtime offset of this CS's control block and creates
+    /// a bounded interface to access it. It then reads the input/output interface
+    /// addresses from the CS control block.
+    fn enable(
+        &mut self,
+        shared_section: &Section,
+        csg_control_offset: usize,
+        cs_idx: usize,
+        cs_stride: usize,
+    ) -> Result {
+        use cs::control::{
+            STREAM_INPUT_VA,
+            STREAM_OUTPUT_VA, //
+        };
+        use kernel::io::Io;
+
+        let vmap = shared_section.mem.bo.owned_vmap::<0>()?;
+        let va_range = shared_section.mem.va_range();
+
+        // Calculate the runtime offset for this CS's control block.
+        let cs_control_offset = CS_CONTROL_OFFSET + cs_idx * cs_stride;
+
+        // The CS control block's MCU virtual address is relative to the shared section start.
+        let cs_control_va = va_range.start + csg_control_offset as u64 + cs_control_offset as u64;
+
+        // Create a bounded interface for this CS's control block at the calculated address.
+        let cs_control =
+            FwInterface::<CS_CONTROL_BLOCK_SIZE>::new(&vmap, &va_range, cs_control_va)?;
+
+        // Read the input and output VAs from the CS control block.
+        let input_va = cs_control.read(STREAM_INPUT_VA).value().get();
+        let cs_input =
+            FwInterface::<CS_KERNEL_INPUT_BLOCK_SIZE>::new(&vmap, &va_range, input_va.into())?;
+
+        let output_va = cs_control.read(STREAM_OUTPUT_VA).value().get();
+        let cs_output =
+            FwInterface::<CS_KERNEL_OUTPUT_BLOCK_SIZE>::new(&vmap, &va_range, output_va.into())?;
+
+        let enabled = EnabledCsInterface {
+            cs_control,
+            cs_input,
+            cs_output,
+        };
+
+        self.state = CsInterfaceState::Enabled(enabled);
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 4ec373e0bcfa..606d446aafd9 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -151,6 +151,11 @@ pub(crate) fn new<Ctx: DeviceContext>(
             va_range: va..(va + size),
         })
     }
+
+    /// Returns the GPU virtual address range occupied by this buffer.
+    pub(crate) fn va_range(&self) -> Range<u64> {
+        self.va_range.clone()
+    }
 }
 
 impl Drop for KernelBo {

-- 
2.53.0

