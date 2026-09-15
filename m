Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD6C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A361C10F407;
	Tue, 15 Sep 2026 10:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="l8fQXiiF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC1610F407
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469928;
 bh=LzcnKXcwCNgX2USvaqjiMB/qHLfI4sBYLEpCLxQpwNk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=l8fQXiiF9ZLoIAyyFiToQysoFnriFYM3ynj9PWZrjx7TD4ga5ulu85+oY/U6sWLuF
 g8nHNqRXjAqNFMdTFo9OXPilIFdTeYw2YVXlcseRWWw+v7BCZ2kA8j6DkMhPLhCE4o
 FihaT2mwkcsaU0G9NVtkD6Wow4Jl675qP2XoUrsdjmo+XV2OWyg0CSjHnp+b7xcRgV
 ThdT18jDFGkorPQHWCtTnnIjqq7XutgyDMmqoNW16za85RB44Cv0fkBvUoVUehAiQR
 TrZNncBZirNUCsEGo+0skrSw52T+ih4wFpWaWbn1n+NfRzv6Ea//DfX6u0Afyn/YIL
 4vuaQzbgggiAA==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A26117E0D7E;
 Tue, 15 Sep 2026 12:58:47 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Tue, 15 Sep 2026 12:57:39 +0200
Subject: [PATCH 6/9] drm/tyr: add CSF firmware interface support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-tyr-interfaces-v1-6-5d28f1f75aca@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
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
interfaces, enabling communication between the driver and the MCU
through shared memory.

Implement the global (GLB), command stream group (CSG), and command
stream (CS) interfaces. These provide access to the firmware control,
input, and output blocks and allow discovery of the available CSGs and
CSs at runtime.

Register block layouts are declared with a new `iface_layout!` macro
from `offset => field: Type` entries, so each offset is stated once and
a misplaced field results in a build error.

The interface is versioned: `GLB_VERSION` is read once at probe time to
pick a [`FwIfaces`] variant, after which the code is statically typed
for that generation's layout.

Store the global interface in the firmware state and initialize it after
firmware boot during probe.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs               |    3 +-
 drivers/gpu/drm/tyr/fw.rs                   |   96 +-
 drivers/gpu/drm/tyr/fw/interfaces.rs        | 1316 +++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/fw/interfaces/layout.rs |  152 ++++
 drivers/gpu/drm/tyr/fw/interfaces/v1.rs     | 1230 +++++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs                  |    5 -
 6 files changed, 2781 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 730b84e37a54..bf1cb32e374d 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -70,7 +70,7 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     pub(crate) pdev: &'drm platform::Device<Bound>,
 
     /// Firmware sections.
-    pub(crate) fw: Firmware<'drm>,
+    pub(crate) fw: Arc<Firmware<'drm>>,
 
     #[pin]
     clks: Mutex<Clocks>,
@@ -159,6 +159,7 @@ fn probe<'bound>(
         )?;
 
         firmware.boot()?;
+        firmware.enable_global_interface()?;
 
         let reg_data = pin_init!(TyrDrmRegistrationData {
                 pdev,
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 76d19667d23a..5abd50238ca6 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -25,13 +25,15 @@
         poll,
         Io, //
     },
+    new_mutex,
     num::Bounded,
     prelude::*,
     register,
     str::CString,
     sync::{
         Arc,
-        ArcBorrow, //
+        ArcBorrow,
+        Mutex, //
     },
     time, //
 };
@@ -42,9 +44,12 @@
         TyrDrmDevice,
         TyrRegisters, //
     },
-    fw::parser::{
-        FwParser,
-        ParsedSection, //
+    fw::{
+        interfaces::FwIfaces,
+        parser::{
+            FwParser,
+            ParsedSection, //
+        },
     },
     gem,
     gem::{
@@ -70,9 +75,21 @@
     vm::Vm, //
 };
 
+mod interfaces;
 pub(crate) mod irq;
 mod parser;
 
+/// Maximum number of CSG interfaces supported by hardware.
+const MAX_CSG: usize = 16;
+
+/// Maximum number of CS interfaces supported by hardware.
+const MAX_CS: usize = 16;
+
+/// MCU virtual address where the CSF shared memory region starts.
+///
+/// This region contains the firmware interface structures for communication between
+/// the CPU driver and MCU firmware, including the GLB_CONTROL_BLOCK at this base address.
+/// The firmware binary contains a section marked to be loaded at this address.
 pub(super) const CSF_MCU_SHARED_REGION_START: u32 = 0x04000000;
 
 #[derive(Copy, Clone, Debug, PartialEq, Eq)]
@@ -136,18 +153,18 @@ fn try_from_fw(value: u32) -> Result<Self> {
 }
 
 /// A parsed section of the firmware binary.
-struct Section<'drm> {
+pub(super) struct Section<'drm> {
     // Raw firmware section data for reset purposes
     #[expect(dead_code)]
     data: KVec<u8>,
 
     // Keep the BO backing this firmware section so that both the
     // GPU mapping and CPU mapping remain valid until the Section is dropped.
-    #[expect(dead_code)]
     mem: Arc<gem::MappedBo<'drm>>,
 }
 
 /// Loaded firmware with sections mapped into MCU VM.
+#[pin_data(PinnedDrop)]
 pub(crate) struct Firmware<'drm> {
     /// Iomem need to access registers.
     iomem: Arc<IoMem<'drm>>,
@@ -156,12 +173,16 @@ pub(crate) struct Firmware<'drm> {
     vm: Arc<Vm<'drm>>,
 
     /// List of firmware sections.
-    #[expect(dead_code)]
     sections: KVec<Section<'drm>>,
+
+    /// The global FW interface.
+    #[pin]
+    global_iface: Mutex<FwIfaces<'drm>>,
 }
 
-impl<'drm> Drop for Firmware<'drm> {
-    fn drop(&mut self) {
+#[pinned_drop]
+impl<'drm> PinnedDrop for Firmware<'drm> {
+    fn drop(self: Pin<&mut Self>) {
         // Stop the MCU before releasing its firmware mappings and memory.
         let _ = self.stop();
 
@@ -228,11 +249,12 @@ pub(crate) fn new(
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
-    ) -> Result<Firmware<'drm>> {
+    ) -> Result<Arc<Firmware<'drm>>> {
         let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
         vm.activate()?;
 
         let result = (|| {
+            let vm = &vm;
             let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
             let mut sections = KVec::new();
             for parsed in parsed_sections {
@@ -262,11 +284,15 @@ pub(crate) fn new(
                 sections.push(Section { data, mem }, GFP_KERNEL)?;
             }
 
-            Ok(Firmware {
-                iomem,
-                vm: vm.clone(),
-                sections,
-            })
+            Ok(Arc::pin_init(
+                try_pin_init!(Firmware {
+                    iomem,
+                    vm: vm.clone(),
+                    sections,
+                    global_iface <- new_mutex!(FwIfaces::new()?),
+                }),
+                GFP_KERNEL,
+            )?)
         })();
 
         if result.is_err() {
@@ -276,6 +302,21 @@ pub(crate) fn new(
         result
     }
 
+    /// Get the shared memory section containing firmware interface structures.
+    pub(crate) fn shared_section<'a>(&'a self) -> Result<&'a Section<'drm>> {
+        self.sections
+            .iter()
+            .find(|section| section.mem.va_range().start == u64::from(CSF_MCU_SHARED_REGION_START))
+            .ok_or_else(|| {
+                dev_err!(
+                    self.vm.dev(),
+                    "CSF shared section not found at 0x{:08x}\n",
+                    CSF_MCU_SHARED_REGION_START
+                );
+                EINVAL
+            })
+    }
+
     pub(crate) fn boot(&self) -> Result {
         let io = &self.iomem;
 
@@ -327,4 +368,29 @@ fn stop(&self) -> Result {
 
         Ok(())
     }
+
+    /// Enable the global interface.
+    pub(crate) fn enable_global_interface(&self) -> Result {
+        let shared_section = self.shared_section()?;
+        let version = interfaces::probe_version(&shared_section.mem)?;
+
+        // The one place that decides which firmware generation this is.
+        // Everything past this match is statically typed for its layout.
+        match version.major().get() {
+            1..=4 => match &mut *self.global_iface.lock() {
+                FwIfaces::V1(iface) => {
+                    iface.enable(shared_section)
+                }
+            },
+            0 => {
+                pr_err!("CSF interface version is 0. Firmware may have failed to boot.\n");
+                Err(ENODEV)
+            }
+            major => {
+                pr_err!("unsupported CSF interface major version {}\n", major);
+                Err(ENODEV)
+            }
+        }
+
+    }
 }
diff --git a/drivers/gpu/drm/tyr/fw/interfaces.rs b/drivers/gpu/drm/tyr/fw/interfaces.rs
new file mode 100644
index 000000000000..1cdfef2340c9
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/interfaces.rs
@@ -0,0 +1,1316 @@
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
+//! +--------------------------------------------+
+//! | GPU                                        |
+//! | +-----+ +----------------------------+     |
+//! | | MMU | |  CSF                       |     |
+//! | +-----+ | +------------+ +-----+     |     |
+//! |         | | CSHW (CEU) | | MCU |     |     |
+//! |         | +------------+ +-----+     |     |
+//! +---------+----------------------------+-----+
+//!           | +--------------------------+     |
+//!           | | Shared Memory            |     |
+//!           | | +--------+ +----+ +----+ |     |
+//!           | | |  CSG0  | |GLB | | FW | |     |
+//!           | | | +----+ | +----+ +----+ |     |
+//!           | | | |CS0 | |               |     |
+//!           | | | +----+ |               |     |
+//!           | | +--------+               |     |
+//!           | +--------------------------+     |
+//!           +--------------+---------------+---+
+//!                          |
+//!                      +---+---+
+//!                      |  Tyr  |
+//!                      +-------+
+//! ```
+//!
+//! # Firmware interface versioning
+//!
+//! Two kinds of interface change exist:
+//!
+//! - Additive: a new register appears in space that older layouts declare
+//!   reserved, and no existing register moves. Every change in the range
+//!   panthor supports (interface 1.x to 4.x, GPU architectures 10.8 to
+//!   12.8) is of this kind: `GLB_INSTR_FEATURES` was added in 1.1, the CSG
+//!   64-bit endpoint request in 4.0 and the GLB halt/state field in 4.1,
+//!   all in previously reserved space.
+//!
+//! - Breaking: registers move, so the old layout no longer matches the
+//!   firmware. This has not happened to date, but the interface does not
+//!   rule it out.
+//!
+//! Additive changes are handled as data. The v1 layout structures describe
+//! the whole 1.x-4.x family, including registers that only exist on later
+//! versions; on older firmware those offsets are reserved and read as
+//! zero. [`Caps`] is computed once at enable time from `GLB_VERSION` and
+//! gates access to such registers. A new minor version means a new boolean
+//! and its gates; the layouts and the compiled code stay the same.
+//!
+//! Breaking changes are handled as types. A new interface major gets its
+//! own layout structures (an `iface_layout!` list for each changed block,
+//! type aliases for the unchanged ones), a [`CsfIface`] implementation
+//! naming them, and a [`FwIfaces`] variant. The major version is read once
+//! at probe time ([`probe_version`]) and matched on; code past that match
+//! is typed for its layout and does not check versions again.
+//!
+//! While [`FwIfaces`] has a single variant, matches over it compile to
+//! nothing. Trait objects are not used: the set of generations is closed,
+//! so an enum can be matched exhaustively and keeps the block types
+//! static.
+//!
+//! [`GlobalInterface`] names the v1 layout types directly rather than
+//! going through the [`CsfIface`] associated types. With a single
+//! generation, a type parameter on every signature would have no benefit.
+//! The trait is unused for now; it exists to fix the shape of the
+//! conversion below, and should not be removed as dead code.
+//!
+//! To support a breaking interface major:
+//!
+//! 1. Add `vN.rs` with an `iface_layout!` declaration for each changed
+//!    block and type aliases for the rest.
+//! 2. Implement [`CsfIface`] for a new `VN` marker type.
+//! 3. Make [`GlobalInterface`] and its helpers generic over
+//!    `P: CsfIface`, replacing the concrete layout types with the
+//!    associated types. Function bodies stay as they are: they access
+//!    fields by name, and the accessors resolve the offsets against each
+//!    layout at compile time.
+//! 4. Add the `FwIfaces::VN` variant. Every match over the enum then
+//!    fails to build until the new generation is handled.
+//!
+//! This scheme depends on one invariant across generations: `GLB_VERSION`
+//! is at offset 0 of the global control block ([`VersionHeader`]), so the
+//! version can be read before the layout is known.
+//!
+
+use crate::fw::Section;
+
+mod v1;
+
+mod layout;
+
+use iface::{
+    FwInterface,
+    FwInterfaceMut,
+    IfaceBlock, //
+};
+use kernel::{
+    io::io_read,
+    prelude::*,  //
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
+    use kernel::{
+        io::{
+            IoBackend,
+            IoBase,
+            SysMem,
+            SysMemBackend, //
+        },
+        prelude::*, //
+    };
+
+    use crate::gem::{
+        MappedBoView,
+        MappedBoViewMut, //
+    };
+
+    /// Block-layout metadata the interface wrappers need beyond the type's
+    /// intrinsic size.
+    pub(super) trait IfaceBlock {
+        /// The architectural size of the block: the end of its last
+        /// register. `size_of` on the layout type may exceed this by
+        /// alignment tail padding, which no access ever touches.
+        const ARCH_SIZE: usize;
+    }
+
+    /// Firmware interface wrapper for accessing CSF shared memory regions.
+    ///
+    /// A window over a validated [`MappedBoView`], typed by the interface
+    /// block's layout structure `B`. The runtime facts (bounds, base
+    /// alignment for `B`) are established here and at view resolution; field
+    /// accesses via `io_read!`/`io_write!` are then checked entirely at
+    /// compile time against `B`'s layout.
+    pub(super) struct FwInterface<'drm, B> {
+        /// The validated window of the shared section this interface covers.
+        view: MappedBoView<'drm>,
+        _block: core::marker::PhantomData<B>,
+    }
+
+    impl<'drm, B: IfaceBlock> FwInterface<'drm, B> {
+        /// Creates a firmware interface wrapper over a resolved view.
+        ///
+        /// Fails if the view is smaller than the block layout or its CPU
+        /// address does not satisfy the layout's alignment (blocks with
+        /// 64-bit registers require 8-byte alignment; views only guarantee
+        /// 4).
+        pub(super) fn new(view: MappedBoView<'drm>) -> Result<Self> {
+            if view.len() < B::ARCH_SIZE as u64 {
+                pr_err!(
+                    "view of {} bytes is smaller than the {}-byte interface block\n",
+                    view.len(),
+                    B::ARCH_SIZE
+                );
+                return Err(EINVAL);
+            }
+
+            if view.cpu_addr() % core::mem::align_of::<B>() != 0 {
+                pr_err!(
+                    "interface block requires {}-byte alignment\n",
+                    core::mem::align_of::<B>()
+                );
+                return Err(EINVAL);
+            }
+
+            Ok(Self {
+                view,
+                _block: core::marker::PhantomData,
+            })
+        }
+    }
+
+    impl<'a, 'drm, B> IoBase<'a> for &'a FwInterface<'drm, B> {
+        type Backend = SysMemBackend;
+        type Target = B;
+
+        #[inline]
+        fn as_view(self) -> SysMem<'a, B> {
+            let view = self.view.parent_view();
+            let ptr = view
+                .as_ptr()
+                .cast::<u8>()
+                .wrapping_byte_add(self.view.cpu_offset())
+                .cast::<B>();
+
+            // SAFETY: `ptr` is a projection of `view.as_ptr()` by
+            // `cpu_offset()` bytes. Per `MappedBoView`'s invariants the
+            // window lies within the CPU mapping and the mapping covers
+            // `size_of::<B>()` bytes from its start (the resolve-time
+            // `reach`), so the typed view's full extent is valid; per
+            // `FwInterface::new()` the window holds the architectural block
+            // at `align_of::<B>()` alignment, and every field access stays
+            // within it.
+            unsafe { SysMemBackend::project_view(view, ptr) }
+        }
+    }
+
+    /// A writable firmware interface wrapper.
+    ///
+    /// Built from an exclusive [`MappedBoViewMut`], so at most one value of
+    /// this type exists per interface block: the value is the block's write
+    /// capability. Writes go through the token returned by
+    /// [`FwInterfaceMut::io`], which reborrows `&mut self`. Concurrent
+    /// writers are unrepresentable without any lock around the block.
+    ///
+    /// Reads work directly on `&Self`, like [`FwInterface`]. Writes should only
+    /// happen through [`Self::io`], but nothing stops calling `Io::write_val`
+    /// on a plain `&Self` too, since `Io` is blanket-implemented for any
+    /// `IoBase`. That gap isn't closed here; doing so needs a read-only I/O
+    /// backend variant in the kernel crate.
+    pub(super) struct FwInterfaceMut<'drm, B> {
+        /// The exclusively-claimed window this interface covers.
+        view: MappedBoViewMut<'drm>,
+        _block: core::marker::PhantomData<B>,
+    }
+
+    /// A short-lived write token derived from a `&mut FwInterfaceMut`.
+    ///
+    /// This is what `io_write!` consumes: obtaining it requires exclusive
+    /// access to the unique write capability, so the borrow checker enforces
+    /// a single writer even though the token itself is a shared view.
+    pub(super) struct IoMutToken<'a, 'drm, B>(&'a FwInterfaceMut<'drm, B>);
+
+    // Manual impls: the token is a reference wrapper and is `Copy` regardless
+    // of whether `B` is (a derive would wrongly demand `B: Copy`).
+    impl<B> Clone for IoMutToken<'_, '_, B> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<B> Copy for IoMutToken<'_, '_, B> {}
+
+    impl<'drm, B: IfaceBlock> FwInterfaceMut<'drm, B> {
+        /// Creates a writable firmware interface wrapper over an exclusive
+        /// view.
+        pub(super) fn new(view: MappedBoViewMut<'drm>) -> Result<Self> {
+            if view.len() < B::ARCH_SIZE as u64 {
+                pr_err!(
+                    "view of {} bytes is smaller than the {}-byte interface block\n",
+                    view.len(),
+                    B::ARCH_SIZE
+                );
+                return Err(EINVAL);
+            }
+
+            if view.cpu_addr() % core::mem::align_of::<B>() != 0 {
+                pr_err!(
+                    "interface block requires {}-byte alignment\n",
+                    core::mem::align_of::<B>()
+                );
+                return Err(EINVAL);
+            }
+
+            Ok(Self {
+                view,
+                _block: core::marker::PhantomData,
+            })
+        }
+
+        /// Returns the write token for this block.
+        #[expect(dead_code)]
+        pub(super) fn io(&mut self) -> IoMutToken<'_, 'drm, B> {
+            IoMutToken(self)
+        }
+    }
+
+    impl<'a, 'drm, B> IoBase<'a> for &'a FwInterfaceMut<'drm, B> {
+        type Backend = SysMemBackend;
+        type Target = B;
+
+        #[inline]
+        fn as_view(self) -> SysMem<'a, B> {
+            let view = self.view.parent_view();
+            let ptr = view
+                .as_ptr()
+                .cast::<u8>()
+                .wrapping_byte_add(self.view.cpu_offset())
+                .cast::<B>();
+
+            // SAFETY: As for `FwInterface::as_view`.
+            unsafe { SysMemBackend::project_view(view, ptr) }
+        }
+    }
+
+    impl<'a, 'drm, B> IoBase<'a> for IoMutToken<'a, 'drm, B> {
+        type Backend = SysMemBackend;
+        type Target = B;
+
+        #[inline]
+        fn as_view(self) -> SysMem<'a, B> {
+            self.0.as_view()
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
+}
+
+use v1::*;
+
+/// The per-version type profile of the CSF interface.
+///
+/// A firmware generation that breaks an interface block's layout implements
+/// this trait with its own structures, reusing every unchanged block as a
+/// type alias of the previous generation.
+///
+/// Nothing consumes this trait yet: with a single generation,
+/// [`GlobalInterface`] names the v1 types directly and a profile parameter
+/// would add nothing. Unused for now, kept so a future second generation is
+/// a drop-in addition (see "Firmware interface versioning" above).
+#[allow(dead_code)]
+pub(super) trait CsfIface {
+    /// GLB control block layout.
+    type GlbControl;
+    /// GLB input block layout.
+    type GlbInput;
+    /// GLB output block layout.
+    type GlbOutput;
+    /// CSG control block layout.
+    type CsgControl;
+    /// CSG input block layout.
+    type CsgInput;
+    /// CSG output block layout.
+    type CsgOutput;
+    /// CS control block layout.
+    type CsControl;
+    /// CS kernel input block layout.
+    type CsInput;
+    /// CS kernel output block layout.
+    type CsOutput;
+}
+
+/// Interface profile for CSF interface versions 1.x through 4.x.
+///
+/// Panthor's history shows these are layout-stable: new registers appear in
+/// reserved space and are gated by [`Caps`]; offsets never move. A future
+/// breaking major gets its own profile and [`FwIfaces`] variant.
+#[allow(dead_code)]
+pub(super) struct V1;
+
+impl CsfIface for V1 {
+    type GlbControl = GlbControlV1;
+    type GlbInput = GlbInputV1;
+    type GlbOutput = GlbOutputV1;
+    type CsgControl = CsgControlV1;
+    type CsgInput = CsgInputV1;
+    type CsgOutput = CsgOutputV1;
+    type CsControl = CsControlV1;
+    type CsInput = CsInputV1;
+    type CsOutput = CsOutputV1;
+}
+
+/// Reads the interface version before any layout has been chosen.
+///
+/// `GLB_VERSION` sits at offset 0 of the control block in every interface
+/// generation, so this read is version-invariant by construction.
+pub(super) fn probe_version(
+    mem: &kernel::sync::Arc<crate::gem::MappedBo<'_>>,
+) -> Result<GLB_VERSION> {
+    /// The version-invariant prefix of the control block.
+    #[repr(C)]
+    struct VersionHeader {
+        version: GLB_VERSION,
+    }
+
+    impl IfaceBlock for VersionHeader {
+        const ARCH_SIZE: usize = core::mem::size_of::<VersionHeader>();
+    }
+
+    let hdr = FwInterface::<VersionHeader>::new(mem.try_view(
+        mem.va_range().start.try_into()?,
+        VersionHeader::ARCH_SIZE as u64,
+        core::mem::size_of::<VersionHeader>() as u64,
+    )?)?;
+
+    Ok(io_read!(&hdr, .version))
+}
+
+/// Version-dispatched firmware interface stack.
+///
+/// The single point in the driver that knows which firmware generations
+/// exist. One variant per breaking interface major; with a single variant
+/// the matches over this enum compile to nothing. When a variant is added,
+/// every entry-point match stops compiling until it handles the new
+/// generation: the support matrix is compiler-enforced.
+pub(super) enum FwIfaces<'drm> {
+    /// Interface versions 1.x-4.x (layout-stable; see [`Caps`]).
+    V1(GlobalInterface<'drm>),
+}
+
+impl FwIfaces<'_> {
+    /// Creates the interface stack, initially disabled.
+    pub(super) fn new() -> Result<Self> {
+        Ok(Self::V1(GlobalInterface::new()?))
+    }
+}
+
+/// State of the global interface.
+enum GlobalInterfaceState<'drm> {
+    /// Interface is not yet initialized.
+    Disabled,
+    /// Interface is initialized and operational.
+    ///
+    /// The payload is only written until the CSG/CS runtime logic arrives.
+    Enabled(#[expect(dead_code)] EnabledGlobalInterface<'drm>),
+}
+
+/// Capabilities implied by the firmware-reported interface version.
+///
+/// Computed once at enable time: the single place encoding the version `>=`
+/// checks (mirroring panthor's). Registers that live in reserved space on
+/// older interfaces must be gated on these before access.
+#[derive(Clone, Copy)]
+struct Caps {
+    /// `GLB_INSTR_FEATURES` is a real register (iface >= 1.1); the offset is
+    /// reserved space before that.
+    has_instr_features: bool,
+    /// The CSG input block carries a 64-bit endpoint request register
+    /// (iface >= 4.0, panthor's `endpoint_req2`).
+    #[expect(dead_code)]
+    has_ep_req2: bool,
+    /// The GLB interface reports a halt/state field (iface >= 4.1).
+    #[expect(dead_code)]
+    has_glb_state: bool,
+}
+
+impl Caps {
+    fn new(version: GLB_VERSION) -> Self {
+        let at_least =
+            |maj: u32, min: u32| (version.major().get(), version.minor().get()) >= (maj, min);
+
+        Self {
+            has_instr_features: at_least(1, 1),
+            has_ep_req2: at_least(4, 0),
+            has_glb_state: at_least(4, 1),
+        }
+    }
+}
+
+/// When enabled, the Global Interface has control,
+/// input, and output system memory interfaces, as well as
+/// the discovered CSG interfaces.
+struct EnabledGlobalInterface<'drm> {
+    /// Control block interface - provides version, features, and CSG discovery.
+    glb_control: FwInterface<'drm, GlbControlV1>,
+    /// Input block interface - driver writes requests here.
+    #[expect(dead_code)]
+    glb_input: FwInterfaceMut<'drm, GlbInputV1>,
+    /// Output block interface - firmware writes acknowledgements here.
+    #[expect(dead_code)]
+    glb_output: FwInterface<'drm, GlbOutputV1>,
+    /// Runtime stride between CSG control blocks (read from GLB_GROUP_STRIDE).
+    csg_stride: usize,
+    /// Number of CSG interfaces reported by hardware.
+    csg_num: usize,
+    /// Discovered CSG interfaces.
+    csg: KVec<CsgInterface<'drm>>,
+    /// Version-implied capabilities, computed once at enable.
+    caps: Caps,
+}
+
+impl EnabledGlobalInterface<'_> {
+    /// Returns the instrumentation features, or a zeroed value on
+    /// interfaces predating them (the offset is reserved space there).
+    #[expect(dead_code)]
+    fn instr_features(&self) -> GLB_INSTR_FEATURES {
+        if !self.caps.has_instr_features {
+            return GLB_INSTR_FEATURES::zeroed();
+        }
+
+        io_read!(&self.glb_control, .instr_features)
+    }
+}
+
+/// Global CSF Interface
+///
+/// The CSF controls operations that are common to all CSs.
+///
+/// This is the interface stack for the 1.x-4.x family and the payload of
+/// [`FwIfaces::V1`]. It names the v1 layout types directly; version
+/// differences within the family are handled by [`Caps`], not by types.
+/// See "Firmware interface versioning" in the module documentation.
+pub(super) struct GlobalInterface<'drm> {
+    /// Current interface state (Disabled or Enabled).
+    state: GlobalInterfaceState<'drm>,
+}
+
+impl<'drm> GlobalInterface<'drm> {
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
+    pub(crate) fn enable(&mut self, shared_section: &Section<'drm>) -> Result {
+        // Drop any previous state first.
+        // This lets enable() run again after an MCU reset.
+        self.state = GlobalInterfaceState::Disabled;
+
+        let mem = &shared_section.mem;
+
+        let glb_control = FwInterface::<GlbControlV1>::new(mem.try_view(
+            mem.va_range().start.try_into()?,
+            GlbControlV1::ARCH_SIZE as u64,
+            core::mem::size_of::<GlbControlV1>() as u64,
+        )?)?;
+
+        let version = io_read!(&glb_control, .version);
+        let caps = Caps::new(version);
+        pr_info!(
+            "CSF interface version: {}.{}.{}\n",
+            version.major().get(),
+            version.minor().get(),
+            version.patch().get()
+        );
+
+        let input_va = io_read!(&glb_control, .input_va).value().get();
+        let glb_input = FwInterfaceMut::<GlbInputV1>::new(mem.try_view_mut(
+            input_va.into(),
+            GlbInputV1::ARCH_SIZE as u64,
+            core::mem::size_of::<GlbInputV1>() as u64,
+        )?)?;
+
+        let output_va = io_read!(&glb_control, .output_va).value().get();
+        let glb_output = FwInterface::<GlbOutputV1>::new(mem.try_view(
+            output_va.into(),
+            GlbOutputV1::ARCH_SIZE as u64,
+            core::mem::size_of::<GlbOutputV1>() as u64,
+        )?)?;
+
+        // Read how many CSG interfaces exist.
+        let csg_num = io_read!(&glb_control, .group_num).value().get();
+
+        // Read the stride between CSG control blocks.
+        let csg_stride = io_read!(&glb_control, .group_stride).value().get() as usize;
+
+        if csg_stride < core::mem::size_of::<CsgControlV1>() {
+            pr_err!(
+                "CSG stride {} is smaller than control block size {}\n",
+                csg_stride,
+                core::mem::size_of::<CsgControlV1>()
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
+        let mut enabled = EnabledGlobalInterface {
+            glb_control,
+            glb_input,
+            glb_output,
+            csg_stride,
+            csg_num: csg_num as usize,
+            csg: KVec::with_capacity(csg_num as usize, GFP_KERNEL)?,
+            caps,
+        };
+
+        Self::init_csg(&mut enabled, shared_section)?;
+
+        // Flip to Enabled only once CSG discovery has succeeded.
+        self.state = GlobalInterfaceState::Enabled(enabled);
+        Ok(())
+    }
+
+    /// Initialize CSG interfaces.
+    ///
+    /// This uses the previously read CSG count to create and enable each CSG interface.
+    fn init_csg(
+        enabled: &mut EnabledGlobalInterface<'drm>,
+        shared_section: &Section<'drm>,
+    ) -> Result {
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
+enum CsgInterfaceState<'drm> {
+    /// Interface is not yet initialized.
+    Disabled,
+    /// Interface is initialized and operational.
+    Enabled(#[expect(dead_code)] EnabledCsgInterface<'drm>),
+}
+
+/// When enabled, a CSG Interface has control, input, and output system memory interfaces.
+struct EnabledCsgInterface<'drm> {
+    /// Control block interface - provides CSG capabilities and configuration.
+    #[expect(dead_code)]
+    csg_control: FwInterface<'drm, CsgControlV1>,
+    /// Input block interface - driver writes CSG requests here.
+    #[expect(dead_code)]
+    csg_input: FwInterfaceMut<'drm, CsgInputV1>,
+    /// Output block interface - firmware writes CSG acknowledgements here.
+    #[expect(dead_code)]
+    csg_output: FwInterface<'drm, CsgOutputV1>,
+    /// Runtime stride between CS control blocks (read from GROUP_STREAM_STRIDE).
+    cs_stride: usize,
+    /// Number of CS interfaces reported by hardware for this CSG.
+    cs_num: usize,
+    /// Discovered CS interfaces.
+    cs: KVec<CsInterface<'drm>>,
+}
+
+/// Command Stream Group Interface
+///
+/// The CSG interface controls operations for a specific CSG.
+pub(crate) struct CsgInterface<'drm> {
+    /// Current interface state (Disabled or Enabled).
+    state: CsgInterfaceState<'drm>,
+    /// CSG identifier/index number.
+    #[expect(dead_code)]
+    csg_idx: usize,
+}
+
+impl<'drm> CsgInterface<'drm> {
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
+    fn enable(
+        &mut self,
+        shared_section: &Section<'drm>,
+        csg_idx: usize,
+        csg_stride: usize,
+    ) -> Result {
+        self.state = CsgInterfaceState::Disabled;
+
+        let mem = &shared_section.mem;
+
+        // Calculate the runtime offset for this CSG's control block.
+        // The CSG control blocks start at CSG_GROUP_CONTROL_OFFSET from the GLB control block,
+        // with each CSG spaced by csg_stride bytes.
+        let csg_control_offset = CSG_GROUP_CONTROL_OFFSET + csg_idx * csg_stride;
+
+        // The CSG control block's MCU virtual address is relative to the shared section start.
+        let csg_control_va = mem.va_range().start + csg_control_offset as u64;
+
+        // Create a bounded interface for this CSG's control block at the calculated address.
+        let csg_control = FwInterface::<CsgControlV1>::new(mem.try_view(
+            csg_control_va.try_into()?,
+            CsgControlV1::ARCH_SIZE as u64,
+            core::mem::size_of::<CsgControlV1>() as u64,
+        )?)?;
+
+        // Read the input and output VAs from the CSG control block.
+        let input_va = io_read!(&csg_control, .input_va).value().get();
+        let csg_input = FwInterfaceMut::<CsgInputV1>::new(mem.try_view_mut(
+            input_va.into(),
+            CsgInputV1::ARCH_SIZE as u64,
+            core::mem::size_of::<CsgInputV1>() as u64,
+        )?)?;
+
+        let output_va = io_read!(&csg_control, .output_va).value().get();
+        let csg_output = FwInterface::<CsgOutputV1>::new(mem.try_view(
+            output_va.into(),
+            CsgOutputV1::ARCH_SIZE as u64,
+            core::mem::size_of::<CsgOutputV1>() as u64,
+        )?)?;
+
+        // Read the runtime stride between CS control blocks.
+        let cs_stride = io_read!(&csg_control, .stream_stride).value().get() as usize;
+
+        if cs_stride < core::mem::size_of::<CsControlV1>() {
+            pr_err!(
+                "CS stride {} is smaller than control block size {}\n",
+                cs_stride,
+                core::mem::size_of::<CsControlV1>()
+            );
+            return Err(EINVAL);
+        }
+
+        // Read how many CS interfaces exist for this CSG.
+        let cs_num = io_read!(&csg_control, .stream_num).value().get();
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
+        let mut enabled = EnabledCsgInterface {
+            csg_control,
+            csg_input,
+            csg_output,
+            cs_stride,
+            cs_num: cs_num as usize,
+            cs: KVec::with_capacity(cs_num as usize, GFP_KERNEL)?,
+        };
+
+        Self::init_cs(&mut enabled, shared_section, csg_control_offset)?;
+        self.state = CsgInterfaceState::Enabled(enabled);
+        Ok(())
+    }
+
+    /// Initialize and discover CS interfaces.
+    ///
+    /// This uses the previously read CS count to create and enable each CS interface.
+    fn init_cs(
+        enabled: &mut EnabledCsgInterface<'drm>,
+        shared_section: &Section<'drm>,
+        csg_control_offset: usize,
+    ) -> Result {
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
+enum CsInterfaceState<'drm> {
+    /// Interface is not yet initialized.
+    Disabled,
+    /// Interface is initialized and operational.
+    #[expect(dead_code)]
+    Enabled(EnabledCsInterface<'drm>),
+}
+
+/// When enabled, a CS Interface has control, input, and output system memory interfaces.
+struct EnabledCsInterface<'drm> {
+    /// Control block interface - provides CS capabilities and configuration.
+    #[expect(dead_code)]
+    cs_control: FwInterface<'drm, CsControlV1>,
+    /// Input block interface - driver writes CS requests here.
+    #[expect(dead_code)]
+    cs_input: FwInterfaceMut<'drm, CsInputV1>,
+    /// Output block interface - firmware writes CS acknowledgements here.
+    #[expect(dead_code)]
+    cs_output: FwInterface<'drm, CsOutputV1>,
+}
+
+/// Command Stream Interface
+///
+/// The CS interface controls operations for a specific CS.
+pub(crate) struct CsInterface<'drm> {
+    /// Current interface state (Disabled or Enabled).
+    state: CsInterfaceState<'drm>,
+    /// CS identifier/index number.
+    #[expect(dead_code)]
+    cs_idx: usize,
+}
+
+impl<'drm> CsInterface<'drm> {
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
+        shared_section: &Section<'drm>,
+        csg_control_offset: usize,
+        cs_idx: usize,
+        cs_stride: usize,
+    ) -> Result {
+        self.state = CsInterfaceState::Disabled;
+
+        let mem = &shared_section.mem;
+
+        // Calculate the runtime offset for this CS's control block.
+        let cs_control_offset = CS_CONTROL_OFFSET + cs_idx * cs_stride;
+
+        // The CS control block's MCU virtual address is relative to the shared section start.
+        let cs_control_va =
+            mem.va_range().start + csg_control_offset as u64 + cs_control_offset as u64;
+
+        // Create a bounded interface for this CS's control block at the calculated address.
+        let cs_control = FwInterface::<CsControlV1>::new(mem.try_view(
+            cs_control_va.try_into()?,
+            CsControlV1::ARCH_SIZE as u64,
+            core::mem::size_of::<CsControlV1>() as u64,
+        )?)?;
+
+        // Read the input and output VAs from the CS control block.
+        let input_va = io_read!(&cs_control, .input_va).value().get();
+        let cs_input = FwInterfaceMut::<CsInputV1>::new(mem.try_view_mut(
+            input_va.into(),
+            CsInputV1::ARCH_SIZE as u64,
+            core::mem::size_of::<CsInputV1>() as u64,
+        )?)?;
+
+        let output_va = io_read!(&cs_control, .output_va).value().get();
+        let cs_output = FwInterface::<CsOutputV1>::new(mem.try_view(
+            output_va.into(),
+            CsOutputV1::ARCH_SIZE as u64,
+            core::mem::size_of::<CsOutputV1>() as u64,
+        )?)?;
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
diff --git a/drivers/gpu/drm/tyr/fw/interfaces/layout.rs b/drivers/gpu/drm/tyr/fw/interfaces/layout.rs
new file mode 100644
index 000000000000..a8204738ea02
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/interfaces/layout.rs
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! A declarative macro for describing firmware interface blocks.
+//!
+//! `iface_layout!` declares a `#[repr(C)]` interface-block structure from a
+//! list of `offset => field: Type` entries, so the architectural offset of
+//! every register is stated exactly once, inline with the field it places:
+//!
+//! ```text
+//! iface_layout! {
+//!     /// The GLB_CONTROL interface block, iface v1 layout.
+//!     pub(crate) struct GlbControlV1(arch_size: 0x20) {
+//!         0x00 => version: GLB_VERSION,
+//!         0x04 => features: GLB_FEATURES,
+//!         // ...
+//!     }
+//! }
+//! ```
+//!
+//! From the declared offsets the macro derives everything the handwritten
+//! form would state separately:
+//!
+//! - the reserved holes, as underscore-prefixed `[u8; N]` fields sized
+//!   `offset - (previous_offset + size_of::<PreviousType>())`;
+//! - the tail padding, up to `arch_size` rounded up to the block's natural
+//!   alignment (`size_of` may exceed the architectural size on u64-bearing
+//!   blocks);
+//! - one `offset_of!` compile-time assertion per field, plus a `size_of`
+//!   assertion for the whole block;
+//! - the block's `IfaceBlock` implementation: `ARCH_SIZE` is the
+//!   `arch_size` annotation.
+//!
+//! The assertions are not redundant with the computed padding: `repr(C)`
+//! inserts implicit padding when a declared offset under-aligns its field
+//! type (e.g. a `u64` at offset `0x14`), which silently shifts every later
+//! field; the generated assertions turn that into a build error naming the
+//! first drifting field. Overlapping or misordered offsets underflow the
+//! hole computation and fail the build on their own.
+//!
+//! Fields must be declared in ascending offset order, each with a trailing
+//! comma.
+
+/// `usize::max` is `Ord::max`, which is not const; the macro needs the
+/// maximum field alignment inside array-length expressions.
+pub(crate) const fn max(a: usize, b: usize) -> usize {
+    if a > b {
+        a
+    } else {
+        b
+    }
+}
+
+macro_rules! iface_layout {
+    (
+        $(#[$meta:meta])*
+        $vis:vis struct $name:ident(arch_size: $arch:expr) {
+            $($body:tt)*
+        }
+    ) => {
+        iface_layout! {
+            @munch
+            meta = { $(#[$meta])* }
+            vis = { $vis }
+            name = { $name }
+            arch = { $arch }
+            end = { 0 }
+            align = { 1 }
+            fields = {}
+            checks = {}
+            rest = { $($body)* }
+        }
+    };
+
+    // One field: extend the running end/alignment, emit the hole in front
+    // of the field, and queue its offset assertion.
+    (
+        @munch
+        meta = { $($meta:tt)* }
+        vis = { $vis:vis }
+        name = { $name:ident }
+        arch = { $arch:expr }
+        end = { $end:expr }
+        align = { $align:expr }
+        fields = { $($fields:tt)* }
+        checks = { $($checks:tt)* }
+        rest = {
+            $(#[$fmeta:meta])*
+            $off:expr => $fname:ident: $fty:ty,
+            $($rest:tt)*
+        }
+    ) => {
+        iface_layout! {
+            @munch
+            meta = { $($meta)* }
+            vis = { $vis }
+            name = { $name }
+            arch = { $arch }
+            end = { ($off) + ::core::mem::size_of::<$fty>() }
+            align = { $crate::fw::interfaces::layout::max($align, ::core::mem::align_of::<$fty>()) }
+            fields = {
+                $($fields)*
+                [<__pad_ $fname>]: [u8; ($off) - ($end)],
+                $(#[$fmeta])*
+                pub(crate) $fname: $fty,
+            }
+            checks = {
+                $($checks)*
+                assert!(::core::mem::offset_of!($name, $fname) == $off);
+            }
+            rest = { $($rest)* }
+        }
+    };
+
+    // All fields munched: emit the structure and its layout proof.
+    (
+        @munch
+        meta = { $($meta:tt)* }
+        vis = { $vis:vis }
+        name = { $name:ident }
+        arch = { $arch:expr }
+        end = { $end:expr }
+        align = { $align:expr }
+        fields = { $($fields:tt)* }
+        checks = { $($checks:tt)* }
+        rest = {}
+    ) => {
+        ::kernel::macros::paste! {
+            $($meta)*
+            #[repr(C)]
+            $vis struct $name {
+                $($fields)*
+                __tail: [u8; usize::div_ceil($arch, $align) * ($align) - ($end)],
+            }
+        }
+
+        // The architectural size: the end of the block's last register.
+        // `size_of` may exceed it by the alignment tail padding; bounds and
+        // write claims use ARCH_SIZE, typed-view validity uses `size_of`
+        // (see `MappedBo::resolve`).
+        impl $crate::fw::interfaces::iface::IfaceBlock for $name {
+            const ARCH_SIZE: usize = $arch;
+        }
+
+        const _: () = {
+            $($checks)*
+            assert!(
+                ::core::mem::size_of::<$name>() == usize::div_ceil($arch, $align) * ($align)
+            );
+        };
+    };
+}
+pub(crate) use iface_layout;
diff --git a/drivers/gpu/drm/tyr/fw/interfaces/v1.rs b/drivers/gpu/drm/tyr/fw/interfaces/v1.rs
new file mode 100644
index 000000000000..ca397b5d4664
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/interfaces/v1.rs
@@ -0,0 +1,1230 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Typed layouts for the CSF firmware interface blocks, version 1.
+//!
+//! Each interface block is modeled as a `#[repr(C)]` structure whose fields
+//! are `bitfield!` value types carrying the registers' bit semantics. The
+//! blocks are declared through the `iface_layout!` macro: each field carries
+//! its architectural offset inline, and the macro derives the reserved
+//! holes, the tail padding and one `offset_of!` compile-time assertion per
+//! field from those offsets. The datasheet offset column is stated exactly
+//! once, and a misplaced field is a build error.
+//!
+//! 64-bit registers are native `u64`-storage bitfields at their natural
+//! alignment: every access is a single volatile load or store, which is
+//! single-copy atomic on arm64.
+//!
+//! Blocks containing 64-bit registers have 8-byte alignment and derived
+//! tail padding where the architectural block size is not a multiple of 8;
+//! the windows resolved for them must cover the padded size.
+#![allow(dead_code)]
+
+use super::cs::{
+    CsBlockedReason,
+    CsFatalExceptionType,
+    CsFaultExceptionType,
+    CsSbWaitSource,
+    CsState,
+    CsStateIrqMask,
+    CsWaitCondition, //
+};
+use super::csg::{
+    CsgExecutionState,
+    CsgStateIrqMask, //
+};
+use super::glb::{
+    HaltStatus,
+    TimestampSource, //
+};
+use super::layout::iface_layout;
+use kernel::bitfield;
+
+// ===== GlbControlV1: GLB_CONTROL block (0x20 bytes) =====
+
+bitfield! {
+    /// Global interface version.
+    pub(crate) struct GLB_VERSION(u32) {
+        /// Patch number.
+        15:0 patch;
+        /// Minor version number.
+        23:16 minor;
+        /// Major version number.
+        31:24 major;
+    }
+}
+
+bitfield! {
+    /// Capabilities of the global CSF interface.
+    pub(crate) struct GLB_FEATURES(u32) {
+        // Suspend compute jobs supported.
+        0:0 compute_suspend => bool;
+        /// Suspend fragment jobs supported.
+        1:1 fragment_suspend => bool;
+        /// Suspend tiler jobs supported.
+        2:2 tiler_suspend => bool;
+        /// Support for multiple PROGRESS_WAIT.
+        3:3 progress_multi_wait => bool;
+    }
+}
+
+bitfield! {
+    /// MCU virtual address of the global input block.
+    pub(crate) struct GLB_INPUT_VA(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// MCU virtual address of the global output block.
+    pub(crate) struct GLB_OUTPUT_VA(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// This register contains the count of CSG interfaces supported.
+    pub(crate) struct GLB_GROUP_NUM(u32) {
+        4:0 value;
+    }
+}
+
+bitfield! {
+    /// Stride, in bytes, between each CSG interface capabilities structure.
+    pub(crate) struct GLB_GROUP_STRIDE(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Size, in bytes, of the GPU performance counters.
+    pub(crate) struct GLB_PRFCNT_SIZE(u32) {
+        /// Size of GPU hardware performance counter data.
+        15:0 hardware_size;
+        /// Size of GPU firmware performance counter data.
+        31:16 firmware_size;
+    }
+}
+
+bitfield! {
+    /// Features of instrumentation buffer used by the TRACE_POINT instruction.
+    pub(crate) struct GLB_INSTR_FEATURES(u32) {
+        /// How often the buffer offset is updated.
+        3:0 offset_update_rate;
+        /// Maximum size of each stored event
+        7:4 event_size_max;
+    }
+}
+
+iface_layout! {
+    /// The GLB_CONTROL interface block, iface v1 layout.
+    pub(crate) struct GlbControlV1(arch_size: 0x20) {
+        0x00 => version: GLB_VERSION,
+        0x04 => features: GLB_FEATURES,
+        0x08 => input_va: GLB_INPUT_VA,
+        0x0c => output_va: GLB_OUTPUT_VA,
+        0x10 => group_num: GLB_GROUP_NUM,
+        0x14 => group_stride: GLB_GROUP_STRIDE,
+        0x18 => prfcnt_size: GLB_PRFCNT_SIZE,
+        0x1c => instr_features: GLB_INSTR_FEATURES,
+    }
+}
+
+// ===== GlbInputV1: GLB_INPUT block (0x84 bytes) =====
+
+bitfield! {
+    /// Global request register.
+    ///
+    /// Tyr makes requests to the CSF by changing the value of bits in
+    /// this register.
+    pub(crate) struct GLB_REQ(u32) {
+        /// Halt the MCU.
+        0:0 halt => bool;
+        /// Update the progress timer timeout.
+        1:1 cfg_progress_timer => bool;
+        /// Update the shader core allocation mask.
+        2:2 cfg_alloc_en => bool;
+        /// Update the shader core power down timeout.
+        3:3 cfg_pwroff_timer => bool;
+        /// Switch the GPU into protected mode.
+        4:4 protm_enter => bool;
+        /// Control performance counters.
+        5:5 prfcnt_enable => bool;
+        /// Sample performance counters.
+        6:6 prfcnt_sample => bool;
+        /// Enable cycle counter and timestamp.
+        7:7 counter_enable => bool;
+        /// Check if firmware is alive.
+        8:8 ping => bool;
+        /// Update firmware configuration settings.
+        9:9 firmware_config_update => bool;
+        /// Enable idle state reporting.
+        10:10 idle_enable => bool;
+        /// Inactive compute iterator event.
+        20:20 inactive_compute => bool;
+        /// Inactive fragment iterator event.
+        21:21 inactive_fragment => bool;
+        /// Inactive tiler iterator event.
+        22:22 inactive_tiler => bool;
+        /// GPU exit protected mode event.
+        23:23 protm_exit => bool;
+        /// Performance counter buffer hit 50% threshold.
+        24:24 prfcnt_threshold => bool;
+        /// Performance counter buffer overflow.
+        25:25 prfcnt_overflow => bool;
+        /// Idle state reached.
+        26:26 idle_event => bool;
+    }
+}
+
+bitfield! {
+    /// Global acknowledge IRQ mask.
+    ///
+    /// Tyr uses this bit mask to indicate which CSF acknowledgements
+    /// it wishes to be notified about. The bit mask corresponds to
+    /// the request register which also corresponds to the CSF's ack
+    /// register in the Output block.
+    pub(crate) struct GLB_ACK_IRQ_MASK(u32) {
+        /// Halt the MCU.
+        0:0 halt => bool;
+        /// Update the progress timer timeout.
+        1:1 cfg_progress_timer => bool;
+        /// Update the shader core allocation mask.
+        2:2 cfg_alloc_en => bool;
+        /// Update the shader core power down timeout.
+        3:3 cfg_pwroff_timer => bool;
+        /// Switch the GPU into protected mode.
+        4:4 protm_enter => bool;
+        /// Control performance counters.
+        5:5 prfcnt_enable => bool;
+        /// Sample performance counters.
+        6:6 prfcnt_sample => bool;
+        /// Enable cycle counter and timestamp.
+        7:7 counter_enable => bool;
+        /// Check if firmware is alive.
+        8:8 ping => bool;
+        /// Update firmware configuration.
+        9:9 firmware_config_update => bool;
+        /// Enable idle state reporting.
+        10:10 idle_enable => bool;
+        /// Inactive compute iterator event.
+        20:20 inactive_compute => bool;
+        /// Inactive fragment iterator event.
+        21:21 inactive_fragment => bool;
+        /// Inactive tiler iterator event.
+        22:22 inactive_tiler => bool;
+        /// GPU exit protected mode event.
+        23:23 protm_exit => bool;
+        /// Performance counter buffer threshold reached.
+        24:24 prfcnt_threshold => bool;
+        /// Performance counter buffer overflow.
+        25:25 prfcnt_overflow => bool;
+        /// Idle state reached.
+        26:26 idle_event => bool;
+    }
+}
+
+bitfield! {
+    /// Global doorbell request.
+    ///
+    /// Each bit in this register is a request flag for the doorbell to
+    /// the corresponding CSG.
+    pub(crate) struct GLB_DB_REQ(u32) {
+        31:0 mask;
+    }
+}
+
+bitfield! {
+    /// Global progress timeout.
+    ///
+    /// Tyr uses this register to configure the maximum time limit without
+    /// forward progress before an interrupt or event is generated.
+    /// Timeout is given in clock cycles; a value of 0 disables the timeout.
+    pub(crate) struct GLB_PROGRESS_TIMER(u32) {
+        31:0 timeout;
+    }
+}
+
+bitfield! {
+    /// Global shader core power down timer.
+    ///
+    /// Configures the timeout for automatic shader core and tiler power domain
+    /// powerdown. A nonzero value enables the timeout; 0 disables it.
+    pub(crate) struct GLB_PWROFF_TIMER(u32) {
+        30:0 timeout;
+        31:31 timer_source => TimestampSource;
+    }
+}
+
+bitfield! {
+    /// Global shader core allocation enable mask.
+    ///
+    /// Each bit in this register controls which shader cores are
+    /// available for endpoint allocation.
+    pub(crate) struct GLB_ALLOC_EN(u64) {
+        63:0 mask;
+    }
+}
+
+bitfield! {
+    /// Configure COHERENCY_ENABLE register value to use in protected
+    /// mode execution.
+    pub(crate) struct GLB_PROTM_COHERENCY(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Performance counter address space.
+    pub(crate) struct GLB_PRFCNT_JASID(u32) {
+        3:0 jasid;
+    }
+}
+
+bitfield! {
+    /// Performance counter buffer address.
+    pub(crate) struct GLB_PRFCNT_BASE(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Performance counter buffer extract index.
+    pub(crate) struct GLB_PRFCNT_EXTRACT(u32) {
+        31:0 index;
+    }
+}
+
+bitfield! {
+    /// Performance counter configuration.
+    pub(crate) struct GLB_PRFCNT_CONFIG(u32) {
+        7:0 size;
+        9:8 set_select;
+    }
+}
+
+bitfield! {
+    /// CSG performance counting enable.
+    pub(crate) struct GLB_PRFCNT_CSG_SELECT(u32) {
+        31:0 enable;
+    }
+}
+
+bitfield! {
+    /// Performance counter enable for firmware.
+    pub(crate) struct GLB_PRFCNT_FW_EN(u32) {
+        /// Enable flags for groups of 4 counters.
+        31:0 enable;
+    }
+}
+
+bitfield! {
+    /// Performance counter enable for CSG.
+    pub(crate) struct GLB_PRFCNT_CSG_EN(u32) {
+        /// Enable flags for groups of 4 counters.
+        31:0 enable;
+    }
+}
+
+bitfield! {
+    /// Performance counter enable for CSF.
+    pub(crate) struct GLB_PRFCNT_CSF_EN(u32) {
+        /// Enable flags for groups of 4 counters.
+        31:0 enable;
+    }
+}
+
+bitfield! {
+    /// Performance counter enable for shader cores.
+    pub(crate) struct GLB_PRFCNT_SHADER_EN(u32) {
+        /// Enable flags for groups of 4 counters.
+        31:0 enable;
+    }
+}
+
+bitfield! {
+    /// Performance counter enable for tiler.
+    pub(crate) struct GLB_PRFCNT_TILER_EN(u32) {
+        /// Enable flags for groups of 4 counters.
+        31:0 enable;
+    }
+}
+
+bitfield! {
+    /// Performance counter enable for MMU/L2 cache.
+    pub(crate) struct GLB_PRFCNT_MMU_L2_EN(u32) {
+        /// Enable flags for groups of 4 counters.
+        31:0 enable;
+    }
+}
+
+bitfield! {
+    /// Global idle event timer.
+    ///
+    /// Configures the timeout for reporting that the GPU has become idle.
+    /// If the value is 0, then idleness is reported immediately.
+    pub(crate) struct GLB_IDLE_TIMER(u32) {
+        30:0 timeout;
+        31:31 timer_source => TimestampSource;
+    }
+}
+
+iface_layout! {
+    /// The GLB_INPUT interface block, iface v1 layout.
+    ///
+    /// Contains 64-bit registers, so the struct is 8-byte aligned and carries
+    /// explicit tail padding: `size_of` is 0x88, not the architectural
+    /// 0x84. Windows resolved for this block must cover 0x88 bytes.
+    pub(crate) struct GlbInputV1(arch_size: 0x84) {
+        0x00 => req: GLB_REQ,
+        0x04 => ack_irq_mask: GLB_ACK_IRQ_MASK,
+        0x08 => db_req: GLB_DB_REQ,
+        0x10 => progress_timer: GLB_PROGRESS_TIMER,
+        0x14 => pwroff_timer: GLB_PWROFF_TIMER,
+        0x18 => alloc_en: GLB_ALLOC_EN,
+        0x20 => protm_coherency: GLB_PROTM_COHERENCY,
+        0x24 => prfcnt_jasid: GLB_PRFCNT_JASID,
+        0x28 => prfcnt_base: GLB_PRFCNT_BASE,
+        0x30 => prfcnt_extract: GLB_PRFCNT_EXTRACT,
+        0x40 => prfcnt_config: GLB_PRFCNT_CONFIG,
+        0x44 => prfcnt_csg_select: GLB_PRFCNT_CSG_SELECT,
+        0x48 => prfcnt_fw_en: GLB_PRFCNT_FW_EN,
+        0x4c => prfcnt_csg_en: GLB_PRFCNT_CSG_EN,
+        0x50 => prfcnt_csf_en: GLB_PRFCNT_CSF_EN,
+        0x54 => prfcnt_shader_en: GLB_PRFCNT_SHADER_EN,
+        0x58 => prfcnt_tiler_en: GLB_PRFCNT_TILER_EN,
+        0x5c => prfcnt_mmu_l2_en: GLB_PRFCNT_MMU_L2_EN,
+        0x80 => idle_timer: GLB_IDLE_TIMER,
+    }
+}
+
+// ===== GlbOutputV1: GLB_OUTPUT block (0x1c bytes) =====
+
+bitfield! {
+    /// Global acknowledge register.
+    ///
+    /// The CSF acknowledges requests from Tyr by changing the value of
+    /// bits in this register.
+    pub(crate) struct GLB_ACK(u32) {
+        /// Update the progress timer timeout.
+        1:1 cfg_progress_timer => bool;
+        /// Update the shader core allocation mask.
+        2:2 cfg_alloc_en => bool;
+        /// Update the shader core power down timeout.
+        3:3 cfg_pwroff_timer => bool;
+        /// Switch the GPU into protected mode.
+        4:4 protm_enter => bool;
+        /// Control performance counters.
+        5:5 prfcnt_enable => bool;
+        /// Sample performance counters.
+        6:6 prfcnt_sample => bool;
+        /// Enable cycle counter and timestamp.
+        7:7 counter_enable => bool;
+        /// Check if firmware is alive.
+        8:8 ping => bool;
+        /// Update firmware configuration settings.
+        9:9 firmware_config_update => bool;
+        /// Enable idle state reporting.
+        10:10 idle_enable => bool;
+        /// Inactive compute iterator event.
+        20:20 inactive_compute => bool;
+        /// Inactive fragment iterator event.
+        21:21 inactive_fragment => bool;
+        /// Inactive tiler iterator event.
+        22:22 inactive_tiler => bool;
+        /// The GPU has exited protected mode.
+        23:23 protm_exit => bool;
+        /// Performance counter buffer hit 50% threshold.
+        24:24 prfcnt_threshold => bool;
+        /// Performance counter buffer overflow.
+        25:25 prfcnt_overflow => bool;
+        /// Idle state reached.
+        26:26 idle_event => bool;
+    }
+}
+
+bitfield! {
+    /// Global doorbell acknowledge.
+    ///
+    /// Each bit in this register is an acknowledgment flag from the
+    /// doorbell to the corresponding CSG.
+    pub(crate) struct GLB_DB_ACK(u32) {
+        31:0 mask;
+    }
+}
+
+bitfield! {
+    /// Global halt status.
+    ///
+    /// If the MCU has entered the HALT state due to a serious error, then the
+    /// firmware can write a value to this field to supply more information about
+    /// the source of the error.
+    pub(crate) struct GLB_HALT_STATUS(u32) {
+        31:0 value ?=> HaltStatus;
+    }
+}
+
+bitfield! {
+    /// Performance counter status.
+    ///
+    /// This register contains information about the last performance-counter
+    /// sample operation.
+    pub(crate) struct GLB_PRFCNT_STATUS(u32) {
+        /// Performance counter operation failed.
+        0:0 failed => bool;
+        /// Performance counter operation affected by POWER_ON.
+        1:1 power_on_transition => bool;
+        /// Performance counter operation affected by POWER_OFF.
+        2:2 power_off_transition => bool;
+        /// Performance counter operation affected by protected mode.
+        3:3 protected_session => bool;
+    }
+}
+
+bitfield! {
+    /// Performance counter buffer insert index.
+    pub(crate) struct GLB_PRFCNT_INSERT(u32) {
+        31:0 index;
+    }
+}
+
+iface_layout! {
+    /// The GLB_OUTPUT interface block, iface v1 layout.
+    pub(crate) struct GlbOutputV1(arch_size: 0x1c) {
+        0x00 => ack: GLB_ACK,
+        0x08 => db_ack: GLB_DB_ACK,
+        0x10 => halt_status: GLB_HALT_STATUS,
+        0x14 => prfcnt_status: GLB_PRFCNT_STATUS,
+        0x18 => prfcnt_insert: GLB_PRFCNT_INSERT,
+    }
+}
+
+// ===== CsgControlV1: CSG_CONTROL block (0x1c bytes) =====
+
+bitfield! {
+    /// CSG interface features.
+    ///
+    /// This register contains information about the capabilities of the CSG.
+    pub(crate) struct GROUP_FEATURES(u32) {
+        /// Suspend buffer type.
+        ///
+        /// Suspend data can be interchanged between two CSGs with the same suspend type.
+        /// Suspend type values have no specific meaning and are otherwise opaque to Tyr.
+        7:0 suspend_type;
+        /// Detailed resource tracking supported. Default is 0 (false).
+        8:8 detailed_tracking => bool;
+    }
+}
+
+bitfield! {
+    /// MCU virtual address of CSG_INPUT_BLOCK.
+    pub(crate) struct GROUP_INPUT_VA(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// MCU virtual address of CSG_OUTPUT_BLOCK.
+    pub(crate) struct GROUP_OUTPUT_VA(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Size, in bytes, required to write suspend data for a CSG buffer in unprotected mode.
+    pub(crate) struct GROUP_SUSPEND_SIZE(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Size, in bytes, required to write suspend data for a CSG buffer in protected mode.
+    pub(crate) struct GROUP_PROTM_SUSPEND_SIZE(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Number of CS interfaces supported by this CSG.
+    pub(crate) struct GROUP_STREAM_NUM(u32) {
+        5:0 value;
+    }
+}
+
+bitfield! {
+    /// Stride, in bytes, between CS interface capabilities structures.
+    pub(crate) struct GROUP_STREAM_STRIDE(u32) {
+        31:0 value;
+    }
+}
+
+iface_layout! {
+    /// The CSG_CONTROL interface block, iface v1 layout.
+    pub(crate) struct CsgControlV1(arch_size: 0x1c) {
+        0x00 => features: GROUP_FEATURES,
+        0x04 => input_va: GROUP_INPUT_VA,
+        0x08 => output_va: GROUP_OUTPUT_VA,
+        0x0c => suspend_size: GROUP_SUSPEND_SIZE,
+        0x10 => protm_suspend_size: GROUP_PROTM_SUSPEND_SIZE,
+        0x14 => stream_num: GROUP_STREAM_NUM,
+        0x18 => stream_stride: GROUP_STREAM_STRIDE,
+    }
+}
+
+// ===== CsgInputV1: CSG_INPUT block (0x54 bytes) =====
+
+bitfield! {
+    /// CSG request.
+    ///
+    /// Controls various features of the CSG through
+    /// request/acknowledge communication with CSG_ACK.
+    pub(crate) struct CSG_REQ(u32) {
+        /// Request change of Execution state.
+        2:0 state ?=> CsgExecutionState;
+        /// Request endpoint configuration update.
+        4:4 ep_cfg => bool;
+        /// Request status update.
+        5:5 status_update => bool;
+        /// Notification of sync status change.
+        28:28 sync_update => bool;
+        /// Notification of idle status.
+        29:29 idle => bool;
+        /// Notification of forward progress timeout.
+        31:31 progress_timer_event => bool;
+    }
+}
+
+bitfield! {
+    /// Global acknowledge IRQ mask.
+    ///
+    /// Controls which flags in CSG_ACK trigger a host IRQ when updated.
+    pub(crate) struct CSG_ACK_IRQ_MASK(u32) {
+        /// Execution state change event.
+        2:0 state ?=> CsgStateIrqMask;
+        /// Endpoint configuration complete event.
+        4:4 ep_cfg => bool;
+        /// Status update event.
+        5:5 status_update => bool;
+        /// Sync status change event.
+        28:28 sync_update => bool;
+        /// Idle event.
+        29:29 idle => bool;
+        /// Progress timer event.
+        31:31 progress_timer_event => bool;
+    }
+}
+
+bitfield! {
+    /// CS doorbell request.
+    ///
+    /// Each bit is a request flag for the doorbell to the corresponding CS
+    /// within this CSG. Checked when the global DOORBELL register is written.
+    pub(crate) struct CSG_DB_REQ(u32) {
+        31:0 mask;
+    }
+}
+
+bitfield! {
+    /// CS IRQ acknowledge.
+    ///
+    /// Each bit is an acknowledge flag for the IRQ to the corresponding
+    /// CS within the CSG.
+    pub(crate) struct CSG_IRQ_ACK(u32) {
+        31:0 mask;
+    }
+}
+
+bitfield! {
+    /// Allowed compute endpoints.
+    pub(crate) struct CSG_ALLOW_COMPUTE(u64) {
+        63:0 mask;
+    }
+}
+
+bitfield! {
+    /// Allowed fragment endpoints.
+    pub(crate) struct CSG_ALLOW_FRAGMENT(u64) {
+        63:0 mask;
+    }
+}
+
+bitfield! {
+    /// Allowed other endpoints.
+    pub(crate) struct CSG_ALLOW_OTHER(u32) {
+        31:0 mask;
+    }
+}
+
+bitfield! {
+    /// Endpoint allocation request.
+    ///
+    /// Configures the allowed requests for each type of endpoint for this CSG.
+    pub(crate) struct CSG_EP_REQ(u32) {
+        /// Maximum number of endpoints which can run compute jobs.
+        7:0 compute_ep;
+        /// Maximum number of endpoints which can run fragment jobs.
+        15:8 fragment_ep;
+        /// Maximum number of endpoints which can run tiler jobs.
+        19:16 tiler_ep;
+        /// Endpoint exclusively runs compute jobs.
+        20:20 exclusive_compute => bool;
+        /// Endpoint exclusively runs fragment jobs.
+        21:21 exclusive_fragment => bool;
+        /// Priority of the CSG with respect to other CSGs (higher value = higher priority).
+        31:28 priority;
+    }
+}
+
+bitfield! {
+    /// Normal mode suspend buffer address.
+    pub(crate) struct CSG_SUSPEND_BUF(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Protected mode suspend buffer address.
+    pub(crate) struct CSG_PROTM_SUSPEND_BUF(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// CSG configuration options.
+    pub(crate) struct CSG_CONFIG(u32) {
+        3:0 jasid;
+        8:8 l2c_allocate_ring => bool;
+        16:16 l2c_allocate_other => bool;
+    }
+}
+
+iface_layout! {
+    /// The CSG_INPUT interface block, iface v1 layout.
+    ///
+    /// Contains 64-bit registers, so the struct is 8-byte aligned and carries
+    /// explicit tail padding: `size_of` is 0x58, not the architectural
+    /// 0x54. Windows resolved for this block must cover 0x58 bytes.
+    pub(crate) struct CsgInputV1(arch_size: 0x54) {
+        0x00 => req: CSG_REQ,
+        0x04 => ack_irq_mask: CSG_ACK_IRQ_MASK,
+        0x08 => db_req: CSG_DB_REQ,
+        0x0c => irq_ack: CSG_IRQ_ACK,
+        0x20 => allow_compute: CSG_ALLOW_COMPUTE,
+        0x28 => allow_fragment: CSG_ALLOW_FRAGMENT,
+        0x30 => allow_other: CSG_ALLOW_OTHER,
+        0x34 => ep_req: CSG_EP_REQ,
+        0x40 => suspend_buf: CSG_SUSPEND_BUF,
+        0x48 => protm_suspend_buf: CSG_PROTM_SUSPEND_BUF,
+        0x50 => config: CSG_CONFIG,
+    }
+}
+
+// ===== CsgOutputV1: CSG_OUTPUT block (0x20 bytes) =====
+
+bitfield! {
+    /// CSG acknowledge flags.
+    ///
+    /// Interacts with CSG_REQ to control various features of the CSG
+    /// through request/acknowledge communication.
+    pub(crate) struct CSG_ACK(u32) {
+        /// Current Execution state.
+        2:0 state ?=> CsgExecutionState;
+        /// Completion of endpoint configuration.
+        4:4 ep_cfg => bool;
+        /// Completion of status update.
+        5:5 status_update => bool;
+        /// Notification of sync status change.
+        28:28 sync_update => bool;
+        /// Notification of idle status.
+        29:29 idle => bool;
+        /// Notification of forward progress timeout.
+        31:31 progress_timer_event => bool;
+    }
+}
+
+bitfield! {
+    /// CS kernel doorbell acknowledge flags.
+    ///
+    /// Each bit is an acknowledge flag for the doorbell to the corresponding
+    /// CS within this CSG. The doorbell for CSn is active when
+    /// bit n in CSG_DB_REQ and CSG_DB_ACK differ.
+    pub(crate) struct CSG_DB_ACK(u32) {
+        31:0 mask;
+    }
+}
+
+bitfield! {
+    /// CS IRQ request flags.
+    pub(crate) struct CSG_IRQ_REQ(u32) {
+        31:0 mask;
+    }
+}
+
+bitfield! {
+    /// Endpoint allocation status register.
+    ///
+    /// Provides information on the number of endpoints currently allocated
+    /// to this CSG.
+    pub(crate) struct CSG_STATUS_EP_CURRENT(u32) {
+        /// Number of compute endpoints.
+        7:0 compute_ep;
+        /// Number of fragment endpoints.
+        15:8 fragment_ep;
+        /// Number of tiler endpoints.
+        19:16 tiler_ep;
+    }
+}
+
+bitfield! {
+    /// Endpoint request status register.
+    ///
+    /// Provides information on the number of endpoints currently requested
+    /// by this CSG.
+    pub(crate) struct CSG_STATUS_EP_REQ(u32) {
+        /// Number of compute endpoints.
+        7:0 compute_ep;
+        /// Number of fragment endpoints.
+        15:8 fragment_ep;
+        /// Number of tiler endpoints.
+        19:16 tiler_ep;
+        /// Endpoint exclusively runs compute jobs.
+        20:20 exclusive_compute => bool;
+        /// Endpoint exclusively runs fragment jobs.
+        21:21 exclusive_fragment => bool;
+    }
+}
+
+bitfield! {
+    /// Overall state status register.
+    pub(crate) struct CSG_STATUS_STATE(u32) {
+        0:0 idle => bool;
+    }
+}
+
+bitfield! {
+    /// Current resource dependencies.
+    pub(crate) struct CSG_RESOURCE_DEP(u32) {
+        /// Stream using no resources.
+        0:0 none => bool;
+        /// Stream using only compute resources.
+        1:1 using_compute => bool;
+        /// Stream using only fragment resources.
+        2:2 using_fragment => bool;
+        /// Stream using compute and fragment resources.
+        3:3 using_compute_fragment => bool;
+        /// Stream using only tiler resources.
+        4:4 using_tiler => bool;
+        /// Stream using compute and tiler resources.
+        5:5 using_compute_tiler => bool;
+        /// Stream using fragment and tiler resources.
+        6:6 using_fragment_tiler => bool;
+        /// Stream using compute, fragment and tiler resources.
+        7:7 using_compute_fragment_tiler => bool;
+        /// Compute resource available.
+        16:16 avail_compute => bool;
+        /// Fragment resource available.
+        17:17 avail_fragment => bool;
+        /// Tiler resource available.
+        18:18 avail_tiler => bool;
+        /// Active compute resource request.
+        20:20 active_compute => bool;
+        /// Active fragment resource request.
+        21:21 active_fragment => bool;
+        /// Active tiler resource request.
+        22:22 active_tiler => bool;
+    }
+}
+
+iface_layout! {
+    /// The CSG_OUTPUT interface block, iface v1 layout.
+    pub(crate) struct CsgOutputV1(arch_size: 0x20) {
+        0x00 => ack: CSG_ACK,
+        0x08 => db_ack: CSG_DB_ACK,
+        0x0c => irq_req: CSG_IRQ_REQ,
+        0x10 => status_ep_current: CSG_STATUS_EP_CURRENT,
+        0x14 => status_ep_req: CSG_STATUS_EP_REQ,
+        0x18 => status_state: CSG_STATUS_STATE,
+        0x1c => resource_dep: CSG_RESOURCE_DEP,
+    }
+}
+
+// ===== CsControlV1: CS_CONTROL block (0xc bytes) =====
+
+bitfield! {
+    /// CS features.
+    pub(crate) struct STREAM_FEATURES(u32) {
+        /// Number of work registers.
+        7:0 work_registers;
+        /// Number of scoreboards.
+        15:8 scoreboards;
+        /// Compute jobs are supported.
+        16:16 compute => bool;
+        /// Fragment jobs are supported.
+        17:17 fragment => bool;
+        /// Tiler jobs are supported.
+        18:18 tiler => bool;
+    }
+}
+
+bitfield! {
+    /// MCU virtual address of CS_KERNEL_INPUT_BLOCK.
+    pub(crate) struct STREAM_INPUT_VA(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// MCU virtual address of CS_KERNEL_OUTPUT_BLOCK.
+    pub(crate) struct STREAM_OUTPUT_VA(u32) {
+        31:0 value;
+    }
+}
+
+iface_layout! {
+    /// The CS_CONTROL interface block, iface v1 layout.
+    pub(crate) struct CsControlV1(arch_size: 0xc) {
+        0x00 => features: STREAM_FEATURES,
+        0x04 => input_va: STREAM_INPUT_VA,
+        0x08 => output_va: STREAM_OUTPUT_VA,
+    }
+}
+
+// ===== CsInputV1: CS_KERNEL_INPUT block (0x58 bytes) =====
+
+bitfield! {
+    /// Command stream request flags.
+    pub(crate) struct CS_REQ(u32) {
+        /// Requested command stream state.
+        2:0 state ?=> CsState;
+        /// Enable extract events.
+        4:4 extract_event => bool;
+        /// Enable idle events for sync/wait.
+        8:8 idle_sync_wait => bool;
+        /// Enable idle events for protected mode pending.
+        9:9 idle_protm_pend => bool;
+        /// Enable idle events for empty ring buffer.
+        10:10 idle_empty => bool;
+        /// Enable idle events for resource requests.
+        11:11 idle_resource_req => bool;
+        /// Clear tiler-out-of-memory notification.
+        26:26 tiler_oom => bool;
+        /// Clear protected mode pending notification.
+        27:27 protm_pend => bool;
+        /// Clear fatal error notification.
+        30:30 fatal => bool;
+        /// Clear fault notification.
+        31:31 fault => bool;
+    }
+}
+
+bitfield! {
+    /// Command stream configuration.
+    pub(crate) struct CS_CONFIG(u32) {
+        3:0 priority;
+        15:8 user_doorbell;
+    }
+}
+
+bitfield! {
+    /// Command stream interrupt mask.
+    pub(crate) struct CS_ACK_IRQ_MASK(u32) {
+        /// CS state change event.
+        2:0 state ?=> CsStateIrqMask;
+        /// Extract event.
+        4:4 extract_event => bool;
+        /// Tiler out of memory.
+        26:26 tiler_oom => bool;
+        /// Protected mode pending.
+        27:27 protm_pend => bool;
+        /// Non-recoverable error.
+        30:30 fatal => bool;
+        /// Recoverable error.
+        31:31 fault => bool;
+    }
+}
+
+bitfield! {
+    /// Base pointer for the ring buffer.
+    pub(crate) struct CS_BASE(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Size of the ring buffer.
+    pub(crate) struct CS_SIZE(u32) {
+        31:0 size;
+    }
+}
+
+bitfield! {
+    /// Pointer to start of heap chunk list.
+    pub(crate) struct CS_TILER_HEAP_START(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Pointer to end of heap chunk list.
+    pub(crate) struct CS_TILER_HEAP_END(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// CS user mode input page address.
+    pub(crate) struct CS_USER_INPUT(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// CS user mode output page address.
+    pub(crate) struct CS_USER_OUTPUT(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Instrumentation buffer configuration.
+    pub(crate) struct CS_INSTR_CONFIG(u32) {
+        3:0 jasid;
+        7:4 event_size;
+        23:16 event_state;
+    }
+}
+
+bitfield! {
+    /// Instrumentation buffer size.
+    pub(crate) struct CS_INSTR_BUFFER_SIZE(u32) {
+        31:0 size;
+    }
+}
+
+bitfield! {
+    /// Instrumentation buffer base pointer.
+    pub(crate) struct CS_INSTR_BUFFER_BASE(u64) {
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Instrumentation buffer pointer to insert offset.
+    pub(crate) struct CS_INSTR_BUFFER_OFFSET_POINTER(u64) {
+        63:0 pointer;
+    }
+}
+
+iface_layout! {
+    /// The CS_KERNEL_INPUT interface block, iface v1 layout.
+    pub(crate) struct CsInputV1(arch_size: 0x58) {
+        0x00 => req: CS_REQ,
+        0x04 => config: CS_CONFIG,
+        0x0c => ack_irq_mask: CS_ACK_IRQ_MASK,
+        0x10 => base: CS_BASE,
+        0x18 => size: CS_SIZE,
+        0x20 => tiler_heap_start: CS_TILER_HEAP_START,
+        0x28 => tiler_heap_end: CS_TILER_HEAP_END,
+        0x30 => user_input: CS_USER_INPUT,
+        0x38 => user_output: CS_USER_OUTPUT,
+        0x40 => instr_config: CS_INSTR_CONFIG,
+        0x44 => instr_buffer_size: CS_INSTR_BUFFER_SIZE,
+        0x48 => instr_buffer_base: CS_INSTR_BUFFER_BASE,
+        0x50 => instr_buffer_offset_pointer: CS_INSTR_BUFFER_OFFSET_POINTER,
+    }
+}
+
+// ===== CsOutputV1: CS_KERNEL_OUTPUT block (0xd8 bytes) =====
+
+bitfield! {
+    /// Command stream acknowledge flags.
+    pub(crate) struct CS_ACK(u32) {
+        /// Current command stream state.
+        2:0 state ?=> CsState;
+        /// Extract event notification.
+        4:4 extract_event => bool;
+        /// Tiler out of memory notification.
+        26:26 tiler_oom => bool;
+        /// Stalled waiting for protected mode.
+        27:27 protm_pend => bool;
+        /// Unrecoverable error notification.
+        30:30 fatal => bool;
+        /// Recoverable error notification.
+        31:31 fault => bool;
+    }
+}
+
+bitfield! {
+    /// Program pointer current value.
+    pub(crate) struct CS_STATUS_CMD_PTR(u64) {
+        /// Program Counter current value.
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Wait condition status register.
+    pub(crate) struct CS_STATUS_WAIT(u32) {
+        /// Waiting for scoreboard entry.
+        15:0 sb_mask;
+        /// Source of scoreboard wait status, if any.
+        19:16 sb_source ?=> CsSbWaitSource;
+        /// SYNC_WAIT condition.
+        27:24 sync_wait_condition ?=> CsWaitCondition;
+        /// Waiting for PROGRESS_WAIT instruction.
+        28:28 progress_wait => bool;
+        /// Waiting for protected execution.
+        29:29 protm_pend => bool;
+        /// Size of sync object waited for.
+        30:30 sync_wait_size => bool;
+        /// Waiting for SYNC_WAIT instruction.
+        31:31 sync_wait => bool;
+    }
+}
+
+bitfield! {
+    /// Indicates the resources requested by the command stream.
+    pub(crate) struct CS_STATUS_REQ_RESOURCE(u32) {
+        /// Compute resources requested.
+        0:0 compute_requested => bool;
+        /// Fragment resources requested.
+        1:1 fragment_requested => bool;
+        /// Tiler resources requested.
+        2:2 tiler_requested => bool;
+        /// IDVS resources requested.
+        3:3 idvs_requested => bool;
+        /// Compute resources granted.
+        16:16 compute_granted => bool;
+        /// Fragment resources granted.
+        17:17 fragment_granted => bool;
+        /// Tiler resources granted.
+        18:18 tiler_granted => bool;
+        /// IDVS resources granted.
+        19:19 idvs_granted => bool;
+    }
+}
+
+bitfield! {
+    /// Sync object pointer.
+    pub(crate) struct CS_STATUS_WAIT_SYNC_POINTER(u64) {
+        /// Sync object address.
+        63:0 pointer;
+    }
+}
+
+bitfield! {
+    /// Sync object test value, low half.
+    pub(crate) struct CS_STATUS_WAIT_SYNC_VALUE(u32) {
+        /// Sync object test value.
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Scoreboard status.
+    pub(crate) struct CS_STATUS_SCOREBOARDS(u32) {
+        /// Which scoreboard entries are non-zero.
+        15:0 nonzero;
+    }
+}
+
+bitfield! {
+    /// Blocked reason.
+    pub(crate) struct CS_STATUS_BLOCKED_REASON(u32) {
+        3:0 reason ?=> CsBlockedReason;
+    }
+}
+
+bitfield! {
+    /// Sync object test value, high half.
+    pub(crate) struct CS_STATUS_WAIT_SYNC_VALUE_HI(u32) {
+        /// Sync object test value.
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Recoverable fault information.
+    pub(crate) struct CS_FAULT(u32) {
+        /// Exception type.
+        7:0 exception_type ?=> CsFaultExceptionType;
+        /// Exception specific data.
+        31:8 exception_data;
+    }
+}
+
+bitfield! {
+    /// Unrecoverable fault information.
+    pub(crate) struct CS_FATAL(u32) {
+        /// Exception type.
+        7:0 exception_type ?=> CsFatalExceptionType;
+        /// Exception specific data.
+        31:8 exception_data;
+    }
+}
+
+bitfield! {
+    /// Additional information about a recoverable fault.
+    pub(crate) struct CS_FAULT_INFO(u64) {
+        /// Exception specific data.
+        63:0 exception_data;
+    }
+}
+
+bitfield! {
+    /// Additional information about a non-recoverable fault.
+    pub(crate) struct CS_FATAL_INFO(u64) {
+        /// Exception specific data.
+        63:0 exception_data;
+    }
+}
+
+bitfield! {
+    /// Number of vertex/tiling operations started.
+    pub(crate) struct CS_HEAP_VT_START(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Number of vertex/tiling operations completed.
+    pub(crate) struct CS_HEAP_VT_END(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Number of fragment completed.
+    pub(crate) struct CS_HEAP_FRAG_END(u32) {
+        31:0 value;
+    }
+}
+
+bitfield! {
+    /// Heap context address.
+    pub(crate) struct CS_HEAP_ADDRESS(u64) {
+        63:0 pointer;
+    }
+}
+
+iface_layout! {
+    /// The CS_KERNEL_OUTPUT interface block, iface v1 layout.
+    pub(crate) struct CsOutputV1(arch_size: 0xd8) {
+        0x00 => ack: CS_ACK,
+        0x40 => status_cmd_ptr: CS_STATUS_CMD_PTR,
+        0x48 => status_wait: CS_STATUS_WAIT,
+        0x4c => status_req_resource: CS_STATUS_REQ_RESOURCE,
+        0x50 => status_wait_sync_pointer: CS_STATUS_WAIT_SYNC_POINTER,
+        0x58 => status_wait_sync_value: CS_STATUS_WAIT_SYNC_VALUE,
+        0x5c => status_scoreboards: CS_STATUS_SCOREBOARDS,
+        0x60 => status_blocked_reason: CS_STATUS_BLOCKED_REASON,
+        0x64 => status_wait_sync_value_hi: CS_STATUS_WAIT_SYNC_VALUE_HI,
+        0x80 => fault: CS_FAULT,
+        0x84 => fatal: CS_FATAL,
+        0x88 => fault_info: CS_FAULT_INFO,
+        0x90 => fatal_info: CS_FATAL_INFO,
+        0xc0 => heap_vt_start: CS_HEAP_VT_START,
+        0xc4 => heap_vt_end: CS_HEAP_VT_END,
+        0xcc => heap_frag_end: CS_HEAP_FRAG_END,
+        0xd0 => heap_address: CS_HEAP_ADDRESS,
+    }
+}
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 9a75344acc3b..601590c3e43d 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -325,7 +325,6 @@ fn resolve(&self, va: McuVa, len: u64, reach: u64) -> Result<Range<u64>> {
     /// Intended for blocks the firmware writes and the host only reads;
     /// read-read overlap is harmless, so these views are freely cloneable
     /// and no claim is taken.
-    #[expect(dead_code)]
     pub(crate) fn try_view(
         self: &Arc<Self>,
         va: McuVa,
@@ -427,26 +426,22 @@ pub(crate) fn gpu_va(&self) -> McuVa {
             }
 
             /// Returns the length of the window in bytes.
-            #[allow(dead_code)]
             pub(crate) fn len(&self) -> u64 {
                 self.range.end - self.range.start
             }
 
             /// Returns the window's byte offset within the CPU mapping.
-            #[allow(dead_code)]
             pub(crate) fn cpu_offset(&self) -> usize {
                 (self.range.start - self.bo.va_range().start) as usize
             }
 
             /// Returns the I/O view of the whole underlying mapping, for
             /// projection to this window.
-            #[expect(dead_code)]
             pub(crate) fn parent_view(&self) -> SysMem<'_, Region<0>> {
                 (&self.bo.vmap).as_view()
             }
 
             /// Returns the CPU address of the window's start.
-            #[expect(dead_code)]
             pub(crate) fn cpu_addr(&self) -> usize {
                 self.bo.cpu_base() + self.cpu_offset()
             }

-- 
2.39.5

