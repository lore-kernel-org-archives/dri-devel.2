Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC456CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C700D10E6A2;
	Mon, 12 Oct 2026 21:56:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DA610F2E5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:56:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20994601E4;
 Mon, 12 Oct 2026 21:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DA41F0089B;
 Mon, 12 Oct 2026 21:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791842200;
 bh=M+IJG2U4CeSv8MsUsauANPoR18MwnQB7+rfIUvqSwlI=;
 h=Date:Subject:Cc:To:From;
 b=fjnfqSu04UbgVqRUWHyX73QZ2s3slB8YbYK4uSatGFs099GRHWvqwQyb//99lkG8i
 Ued6PxJHwIAgwuIBpAx+HnWwfDZvYy7oAEhlSCGWzC+aR52R7QHluHzT5nN9kz/XUU
 YnsbxH/kaU0nHl2TP/SCuEfCF/Z9VoXqkGO95OZ23uXaI0UgizxDEIa6UT8gIBwQcG
 eEUa5hs0iP4qaPe9TWa1fRRzgZz+jH937OvZJt2lR7+vhmFZUIyxiow4tW1Vhi6tir
 r1EYoNAzQGrbyJU65lI5Obbea13VZoy7GnekM6v3ofn/c1//D/OX8fKA9TH7T7JTPs
 bo7/dHHZCrIow==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 23:56:37 +0200
Message-Id: <DM371PN4TBJT.3LY1B0EYWSI4@kernel.org>
Subject: [GIT PULL] DRM Rust changes for v7.4-rc1
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
To: "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>
From: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
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

Hi Dave and Sima,

Please pull these DRM Rust changes.

The highlights are DMA fence abstractions on the DRM side; a cross-module N=
ova
API with an extensible INFO ioctl, GPU memory management with MMU v2/v3 pag=
e
tables, BAR1 VRAM access, and GIN interrupt-driven GSP event handling for N=
ova;
and minor Tyr fixes.

There are two external dependencies: shared signed tags from the driver-cor=
e
tree for the register!() proc-macro rework and for DMA bound-lifetime
enforcement.

(I plan to send an early driver-core PR to Linus for this cycle.)

Thanks,
Danilo

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935=
:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/rust/kernel.git tags/drm-rust-next-202=
6-10-11

for you to fetch changes up to d511064b2e732b7152a542d589d07a4814c1b674:

  rust: drm: Remove unused flags argument from Registration::new() (2026-10=
-10 23:25:27 +0200)

----------------------------------------------------------------
DRM Rust changes for v7.4-rc1

- Cross-subsystem:

  - I/O (shared from driver-core tree via signed tag rust-io-7.4-rc1):

    - Reimplement register!() as a procedural macro, require matching
      base types for register access, and replace relative registers
      with typed I/O projections. Convert Nova, Tyr and the PCI sample

    - Add AsRepr/AsReprMut conversions for I/O on compatible wrapper
      types and transmute helpers with deferred size checks

  - DMA (shared from driver-core tree via signed tag rust-dma-7.4-rc1):

    - Tie Coherent, CoherentBox and CoherentHandle to the device's bound
      lifetime, and allow scoped debugfs files backed by non-'static
      data

  - Allow auxiliary registration-data closures to return covariant
    sub-fields and add UserSliceWriter::write_truncated()

  - Implement Send and Sync for MapleTree

  - Add PCI resource_flags() and IORESOURCE_MEM_64, and convert PCI IRQ
    flags to impl_flags!()

  - Add I/O view cast() with compile-time size and alignment checks

- DRM:

  - Add Rust dma_fence abstractions with separate producer (DriverFence)
    and consumer (Fence) types, per-context sequencing, signal callbacks
    and preallocation. Additional backend operations remain follow-up
    work.

  - Initialize DRM registrations and their data in place, removing a
    separate allocation

  - Drop the unused flags argument from drm::Registration::new()

- Nova:

  - UAPI and Cross Module API:
    - Add NovaCoreApi and a lifetime-bound handle for auxiliary child
      drivers, carried in nova-drm registration data
    - Expose a render node and extensible INFO ioctl reporting GPU
      architecture, opaque chip ID, usable VRAM and VRAM BAR sizes,
      full and short GPU names, and GID, with size discovery and
      truncation to the userspace buffer size
    - Move BAR-size queries into GPU info, removing GETPARAM and
      changing the UAPI

  - PRAMIN access:
    - Add typed CPU access to VRAM through the movable 1 MiB BAR0
      PRAMIN window, with per-architecture support from Turing through
      Blackwell
    - Add GpuMm centralized memory manager, VramAddress type, aperture
      documentation and optional probe-time self-tests under
      CONFIG_NOVA_CORE_SELFTESTS

  - GPU virtual memory and BAR1:
    - Add VRAM buddy allocation, TLB flushing, MMU v2/v3 page-table
      types with trait-based generics (PteOps, PdeOps, DualPdeOps,
      MmuConfig) and a generic walker
    - Add maple-tree virtual address tracking and multi-page mapping,
      separating allocation from mapping execution
    - Add CPU access to mapped VRAM through BAR1 and memory-management
      self-tests; handle 64-bit BAR0 when locating BAR1

  - GPU interrupts and GSP events:
    - Add GIN (GPU Interrupt and Notification) interrupt-tree support
      with MSI-X, MSI fallback and per-architecture rearming
    - Drain GSP events between commands via a threaded SWGEN0 handler
    - Report OS errors, robust-channel notifications and unknown
      messages without aborting command waits; hold the queue lock and
      use one deadline per wait
    - Disable GSP event interrupts on persistent falcon faults or
      drain errors
    - Add a delivery/rearm self-test, interrupt-tree KUnit coverage
      and interrupt-controller documentation

  - GSP messaging fixes:
    - Queue setup RPCs before GSP-RM boot
    - Correct DMA barriers in both queue directions

  - Firmware and transport:
    - Extract a reusable radix3 buffer mapper; zero-pad page-table
      levels to whole pages to prevent booter reads of stale padding
    - Correct GSP-FMC naming and boot-flow documentation
    - Set MCTP header version 1 for FSP messages and retain the
      command queue's BAR0 reference

  - Resource handling:
    - Replace unnecessary BarUser reference counting with in-place
      ownership and borrowed access; consolidate probe initialization
    - Declare an unlimited DMA maximum segment size

- Tyr:

  - Use bitfield!() for firmware section flags and memory attributes
    that do not describe registers

  - Zero unsupported and newly added GPU-info fields, and limit the
    doorbell array to 17 entries to fit the mapped register region

----------------------------------------------------------------
Alexandre Courbot (2):
      gpu: nova-core: fix incorrect naming/framing of GSP-FMC firmware
      gpu: nova-core: fix warning with NOVA_CORE_SELFTESTS disabled

Alistair Popple (14):
      rust: auxiliary: let registration_data_with() closures return covaria=
nt sub-fields
      gpu: nova-core: Add public driver API to nova-core
      drm: nova: Add DRM registration data
      drm: nova: Add GPU architecture enum to nova-drm UAPI
      drm: nova: Add chipid enum to nova-drm UAPI
      rust: uaccess: add UserSliceWriter::write_truncated()
      drm: nova: Add an info ioctl
      drm: nova: Add usable VRAM size to GPU info
      drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
      drm: nova: Expose a render node
      drm: nova: Report GPU name in GPU info
      drm: nova: Report GPU short name in GPU info
      drm: nova: Report GPU GID in GPU info
      gpu: nova-core: Use bar1_resource_index() in NovaCoreApi::bar1_size()

Antonin Malzieu Ridolfi (1):
      gpu: nova-core: Extract PMC registers definitions

Danilo Krummrich (15):
      Merge tag 'v7.3-rc1' into drm-rust-next
      rust: debugfs: drop 'static bound from ScopedDir file creation method=
s
      rust: dma: tie CoherentHandle to the device's bound lifetime
      samples: rust_dma: separate driver type from driver data
      rust: dma: tie Coherent and CoherentBox to the device's bound lifetim=
e
      Merge tag 'rust-io-7.4-rc1' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/driver-core/driver-core into drm-rust-next
      Merge tag 'rust-dma-7.4-rc1' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/driver-core/driver-core into drm-rust-next
      gpu: nova-core: align Bar1 alias with Bar0
      gpu: nova-core: remove unnecessary Arc around BarUser
      gpu: nova-core: mm: get rid of Arc<BarUser> in BarUserAccess
      gpu: nova-core: mm: fix lifetime name in BarUser
      gpu: nova-core: use a single try_pin_init!() block in probe()
      drm: nova: Move VRAM BAR size query to GPU info
      rust: drm: Return impl PinInit from drm::Registration::new()
      rust: drm: Remove unused flags argument from Registration::new()

Deborah Brouwer (3):
      drm/tyr: gpu_info: zero out new/unused fields
      MAINTAINERS: add rust-for-linux list for Tyr
      drm/tyr: reduce size of doorbell array

Edwin Peer (1):
      rust: dma_fence: gate abstractions on CONFIG_DMA_SHARED_BUFFER

Eliot Courtney (3):
      gpu: nova-core: mm: Implement Alignable and Debug for VramAddress
      gpu: nova-core: mm: Add the memory management HAL
      gpu: nova-core: Add self-test assertion macros and config option

Gary Guo (20):
      gpu: nova-core: fix barrier usage in CPU->GSP messaging path
      gpu: nova-core: fix barrier usage in GSP->CPU messaging path
      rust: io: register: reimplement as proc macro
      rust: mem: add `transmute` with deferred size check
      rust: mem: add `AsRepr` and `AsReprMut`
      rust: io: perform conversions using `AsRepr`
      rust: io: support register projections
      rust: io: register: allow explicit base type specification
      gpu: nova-core: specify base type for registers
      drm/tyr: specify base type for registers
      samples: rust: pci: specify base type for registers
      rust: io: register: make register have a typed base
      rust: io: register: support fixed offset register without bitfield
      gpu: nova-core: use projection for PFALCON and PFALCON2 registers
      gpu: nova-core: convert hshub0 from relative register to projection
      rust: io: register: remove relative registers
      rust: io: register: remove `Register` trait and cleanup macro
      rust: io: register: unify handling of register with/without bitfields
      rust: io: add static `cast()` method for views
      drm/tyr: use `bitfield!` instead of `register!` for non-registers

Joel Fernandes (25):
      gpu: nova-core: mm: Add VramAddress type
      gpu: nova-core: mm: Add PRAMIN window registers
      gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRA=
M
      docs: gpu: nova-core: Document the PRAMIN aperture mechanism
      gpu: nova-core: mm: Add GpuMm centralized memory manager
      gpu: nova-core: mm: Add PRAMIN aperture self-tests
      rust: maple_tree: implement Send and Sync for MapleTree
      rust: pci: add resource_flags accessor
      gpu: nova-core: mm: Add common types for virtual memory management
      gpu: nova-core: mm: Add buddy allocator and TLB to GpuMm
      gpu: nova-core: mm: Add common types for all page table formats
      gpu: nova-core: mm: pagetable: Add PteOps trait
      gpu: nova-core: mm: pagetable: Add PdeOps trait
      gpu: nova-core: mm: pagetable: Add DualPdeOps trait
      gpu: nova-core: mm: Add MMU v2 page table types
      gpu: nova-core: mm: Add MMU v3 page table types
      gpu: nova-core: mm: pagetable: Add MmuConfig trait
      gpu: nova-core: mm: Add page table walker for MMU v2/v3
      gpu: nova-core: mm: Add Virtual Memory Manager
      gpu: nova-core: mm: Add virtual address range tracking to VMM
      gpu: nova-core: mm: Add multi-page mapping API to VMM
      gpu: nova-core: Add BAR1 aperture type and size constant
      gpu: nova-core: mm: Add BAR1 user interface
      gpu: nova-core: mm: Add BAR1 memory management self-tests
      gpu: nova-core: add the GIN interrupt tree and allocate its vectors

John Hubbard (22):
      gpu: nova-core: gsp: fix a broken doc link on GspMessage
      gpu: nova-core: extract radix3 page table into its own module
      gpu: nova-core: generalize radix3 buffer names
      gpu: nova-core: revise radix3 documentation and comments
      gpu: nova-core: zero-pad radix3 page table levels to page boundary
      gpu: nova-core: rename the FbRanges elf field to fw_image
      gpu: nova-core: set MCTP transport header version to 1
      gpu: nova-core: gsp: give the command queue its own BAR0 mapping
      gpu: nova-core: restore the "Probe Nova Core GPU driver" debug print
      rust: pci: declare IrqType and IrqTypes with impl_flags
      gpu: nova-core: add the GIN vector, leaf and subtree types
      gpu: nova-core: add the GIN CPU interrupt tree and MSI EOI registers
      gpu: nova-core: add the per-architecture GIN CPU interrupt HAL
      gpu: nova-core: move wait for GFW boot code to associated function
      gpu: nova-core: add an interrupt delivery self-test
      gpu: nova-core: log GSP events instead of discarding them
      gpu: nova-core: return ENOMSG for an unmatched GSP message
      gpu: nova-core: bound a GSP wait by a single deadline
      gpu: nova-core: add the falcon interrupt registers and HAL methods
      gpu: nova-core: service GSP events from the SWGEN0 interrupt
      gpu: nova-core: add KUnit tests for the interrupt tree
      gpu: nova-core: document the GIN interrupt controller and GSP events

Manuel Ebner (1):
      Documentation: nova: Fix bracket

Matteo Kloiber (1):
      gpu: nova-core: declare unlimited DMA max segment size

Philipp Stanner (2):
      rust: Add dma_fence abstractions
      MAINTAINERS: Add entry for Rust dma-buf

Thorsten Blum (2):
      gpu: nova-core: gsp: use KVVec::zeroed() for payload buffers
      gpu: nova-core: fsp: use KVec::zeroed() in recv_msg()

Timur Tabi (1):
      gpu: nova-core: write initial RPCs before booting GSP-RM

 Documentation/gpu/nova/core/fsp.rst                   |    2 +
 Documentation/gpu/nova/core/interrupts.rst            |  603 +++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++
 Documentation/gpu/nova/core/pramin.rst                |  128 ++++++++++++
 Documentation/gpu/nova/core/todo.rst                  |    2 +-
 Documentation/gpu/nova/index.rst                      |    2 +
 MAINTAINERS                                           |    7 +
 drivers/gpu/drm/nova/driver.rs                        |   37 +++-
 drivers/gpu/drm/nova/file.rs                          |  127 +++++++++---
 drivers/gpu/drm/tyr/driver.rs                         |  138 ++++++-------
 drivers/gpu/drm/tyr/fw.rs                             |    7 +-
 drivers/gpu/drm/tyr/gpu.rs                            |    6 +-
 drivers/gpu/drm/tyr/regs.rs                           |   57 +++++-
 drivers/gpu/nova-core/Kconfig                         |   15 ++
 drivers/gpu/nova-core/api.rs                          |   73 +++++++
 drivers/gpu/nova-core/driver.rs                       |  125 +++++++++---
 drivers/gpu/nova-core/falcon.rs                       |  164 +++++++------=
---
 drivers/gpu/nova-core/falcon/fsp.rs                   |   67 ++++---
 drivers/gpu/nova-core/falcon/gsp.rs                   |   98 +++++++---
 drivers/gpu/nova-core/falcon/hal.rs                   |   22 ++-
 drivers/gpu/nova-core/falcon/hal/ga102.rs             |   76 ++++----
 drivers/gpu/nova-core/falcon/hal/tu102.rs             |   55 +++++-
 drivers/gpu/nova-core/falcon/sec2.rs                  |   37 ++--
 drivers/gpu/nova-core/fb.rs                           |   22 +--
 drivers/gpu/nova-core/fb/hal/gb100.rs                 |   59 +++---
 drivers/gpu/nova-core/fb/regs.rs                      |   34 +++-
 drivers/gpu/nova-core/firmware.rs                     |    3 +-
 drivers/gpu/nova-core/firmware/booter.rs              |    2 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs    |   30 ++-
 drivers/gpu/nova-core/firmware/gsp.rs                 |  117 ++---------
 drivers/gpu/nova-core/firmware/{fsp.rs =3D> gsp_fmc.rs} |   59 +++---
 drivers/gpu/nova-core/firmware/radix3.rs              |  144 +++++++++++++=
+
 drivers/gpu/nova-core/firmware/riscv.rs               |    8 +-
 drivers/gpu/nova-core/fsp.rs                          |   45 +++--
 drivers/gpu/nova-core/gpu.rs                          |  354 +++++++++++++=
+++++++++++++-------
 drivers/gpu/nova-core/gpu/regs.rs                     |   86 ++++++++
 drivers/gpu/nova-core/gsp.rs                          |   39 ++--
 drivers/gpu/nova-core/gsp/boot.rs                     |   26 ++-
 drivers/gpu/nova-core/gsp/cmdq.rs                     |  264 +++++++++++++=
+++++-------
 drivers/gpu/nova-core/gsp/cmdq/continuation.rs        |    6 +-
 drivers/gpu/nova-core/gsp/commands.rs                 |   48 +++--
 drivers/gpu/nova-core/gsp/fw.rs                       |   18 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs              |   28 +++
 drivers/gpu/nova-core/gsp/hal.rs                      |   16 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs                |   16 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs                |   41 ++--
 drivers/gpu/nova-core/gsp/regs.rs                     |    9 +-
 drivers/gpu/nova-core/gsp/sequencer.rs                |   14 +-
 drivers/gpu/nova-core/irq.rs                          |   29 +++
 drivers/gpu/nova-core/irq/doorbell_test.rs            |  251 +++++++++++++=
+++++++++++
 drivers/gpu/nova-core/irq/gsp.rs                      |  195 +++++++++++++=
++++++
 drivers/gpu/nova-core/irq/hal.rs                      |   67 +++++++
 drivers/gpu/nova-core/irq/hal/gh100.rs                |   40 ++++
 drivers/gpu/nova-core/irq/hal/tu102.rs                |   43 ++++
 drivers/gpu/nova-core/irq/interrupt_tree.rs           |  682 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/irq/regs.rs                     |   88 +++++++++
 drivers/gpu/nova-core/mctp.rs                         |   16 +-
 drivers/gpu/nova-core/mm.rs                           |  335 +++++++++++++=
+++++++++++++++++++
 drivers/gpu/nova-core/mm/bar_user.rs                  |  420 +++++++++++++=
+++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal.rs                       |   56 ++++++
 drivers/gpu/nova-core/mm/hal/gb100.rs                 |   35 ++++
 drivers/gpu/nova-core/mm/hal/gh100.rs                 |   35 ++++
 drivers/gpu/nova-core/mm/hal/tu102.rs                 |   37 ++++
 drivers/gpu/nova-core/mm/pagetable.rs                 |  424 +++++++++++++=
+++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/map.rs             |  345 +++++++++++++=
++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/ver2.rs            |  275 +++++++++++++=
+++++++++++++
 drivers/gpu/nova-core/mm/pagetable/ver3.rs            |  421 +++++++++++++=
+++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/walk.rs            |  244 +++++++++++++=
++++++++++
 drivers/gpu/nova-core/mm/pramin.rs                    |  312 +++++++++++++=
+++++++++++++++++
 drivers/gpu/nova-core/mm/regs.rs                      |   70 +++++++
 drivers/gpu/nova-core/mm/tlb.rs                       |  120 ++++++++++++
 drivers/gpu/nova-core/mm/vmm.rs                       |  346 +++++++++++++=
++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs                    |    5 +
 drivers/gpu/nova-core/num.rs                          |    2 +-
 drivers/gpu/nova-core/regs.rs                         |  326 +++++++++++++=
+++++++-----------
 drivers/gpu/nova-core/selftest.rs                     |   64 ++++++
 drivers/gpu/nova-core/vbios.rs                        |   11 +-
 include/uapi/drm/nova_drm.h                           |  146 ++++++++++++-=
-
 rust/bindings/bindings_helper.h                       |    1 +
 rust/helpers/dma_fence.c                              |   49 +++++
 rust/helpers/helpers.c                                |    1 +
 rust/helpers/pci.c                                    |    6 +
 rust/kernel/auxiliary.rs                              |   17 +-
 rust/kernel/bitfield.rs                               |    9 +
 rust/kernel/debugfs.rs                                |   26 +--
 rust/kernel/debugfs/entry.rs                          |    4 +-
 rust/kernel/debugfs/file_ops.rs                       |   29 ++-
 rust/kernel/device_id.rs                              |    3 +-
 rust/kernel/dma.rs                                    |  141 +++++++------=
-
 rust/kernel/dma_buf/dma_fence.rs                      | 1022 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 rust/kernel/dma_buf/mod.rs                            |   14 ++
 rust/kernel/drm/driver.rs                             |   77 ++++----
 rust/kernel/io.rs                                     |  220 +++++++++++++=
++------
 rust/kernel/io/register.rs                            |  759 +++++++++++++=
+++-------------------------------------------------------
 rust/kernel/io/resource.rs                            |    8 +
 rust/kernel/lib.rs                                    |    3 +
 rust/kernel/maple_tree.rs                             |   30 ++-
 rust/kernel/mem.rs                                    |  234 +++++++++++++=
+++++++++
 rust/kernel/pci.rs                                    |   14 ++
 rust/kernel/pci/irq.rs                                |   68 ++-----
 rust/kernel/sync/atomic.rs                            |    4 +-
 rust/kernel/uaccess.rs                                |   18 +-
 rust/macros/io/mod.rs                                 |    3 +
 rust/macros/io/register.rs                            |  296 +++++++++++++=
+++++++++++++++
 rust/macros/lib.rs                                    |    9 +
 samples/rust/rust_dma.rs                              |   30 +--
 samples/rust/rust_driver_pci.rs                       |    4 +
 106 files changed, 10046 insertions(+), 1829 deletions(-)
 create mode 100644 Documentation/gpu/nova/core/interrupts.rst
 create mode 100644 Documentation/gpu/nova/core/pramin.rst
 create mode 100644 drivers/gpu/nova-core/api.rs
 rename drivers/gpu/nova-core/firmware/{fsp.rs =3D> gsp_fmc.rs} (67%)
 create mode 100644 drivers/gpu/nova-core/firmware/radix3.rs
 create mode 100644 drivers/gpu/nova-core/gpu/regs.rs
 create mode 100644 drivers/gpu/nova-core/irq.rs
 create mode 100644 drivers/gpu/nova-core/irq/doorbell_test.rs
 create mode 100644 drivers/gpu/nova-core/irq/gsp.rs
 create mode 100644 drivers/gpu/nova-core/irq/hal.rs
 create mode 100644 drivers/gpu/nova-core/irq/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/irq/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/irq/interrupt_tree.rs
 create mode 100644 drivers/gpu/nova-core/irq/regs.rs
 create mode 100644 drivers/gpu/nova-core/mm.rs
 create mode 100644 drivers/gpu/nova-core/mm/bar_user.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal/gb100.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/mm/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/map.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver2.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver3.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/walk.rs
 create mode 100644 drivers/gpu/nova-core/mm/pramin.rs
 create mode 100644 drivers/gpu/nova-core/mm/regs.rs
 create mode 100644 drivers/gpu/nova-core/mm/tlb.rs
 create mode 100644 drivers/gpu/nova-core/mm/vmm.rs
 create mode 100644 drivers/gpu/nova-core/selftest.rs
 create mode 100644 rust/helpers/dma_fence.c
 create mode 100644 rust/kernel/dma_buf/dma_fence.rs
 create mode 100644 rust/kernel/dma_buf/mod.rs
 create mode 100644 rust/kernel/mem.rs
 create mode 100644 rust/macros/io/mod.rs
 create mode 100644 rust/macros/io/register.rs
