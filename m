Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665501061B24
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE31310E128;
	Mon, 30 Mar 2026 22:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R0ODBp58";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E43710E128;
 Mon, 30 Mar 2026 22:35:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 73AAD6014B;
 Mon, 30 Mar 2026 22:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E95C4CEF7;
 Mon, 30 Mar 2026 22:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774910104;
 bh=QetO6StuPawQghDagsc/uXrE3Hau9tBgDb54X8TE3S8=;
 h=Date:Subject:Cc:To:From:From;
 b=R0ODBp589K+/AJK42gVYKX57Ffqi8KqbYErHsePtzbAT283GJLdQ9BsOjUrCon8A3
 UJv3xn/Kib+D5su9v8+Y+5s/kQHwdGf1Yygv+/fwUp+A2riUoo8S1Pcdn1nWQm8/pE
 FwyR1RIwE1ANB8JPXqFrGVkzr1gIwd9g8yFLYa67KVptVVWwzNNalLA1XULlH13/fy
 yJEiAUb0WQcRvC4Yu1pgaiFdSRz0jmXCWPfWdpujJAdTfCpIYt01sC2PHdzpEu5gFp
 /pjhhDRHtOLaRu5EZMY7tpFmhimGkwBnBiJhvrx316y/60GWY6cKz+/uVjeC+inf7p
 G+S5veQpeWzQA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 00:35:00 +0200
Message-Id: <DHGH4BLT03BU.ZJH5U52WE8BY@kernel.org>
Subject: [GIT PULL] DRM Rust changes for v7.1-rc1
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>
From: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
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

There's quite a lot of stuff in here this time. The highlights are GPU budd=
y
and GEM shmem abstractions on the DRM core side; RPC continuation records, =
the
missing Turing pieces, exposed GSP log buffers in debugfs, and lots of gene=
ral
refactorings and improvements on the nova-core side.

Among the latter I want to highlight the generic kernel register!() macro a=
nd
the DMA improvements.

There are also quite a few external dependencies in here. Besides a few Rus=
t
core and minor workqueue changes, I took all the DMA changes through this t=
ree
for this cycle and merged a shared signed tag from the driver-core tree for
register!() and other I/O improvements.

(I plan to send an early driver-core PR to Linus for this cycle, since I al=
so
gave out two other signed tags for other trees.)

All changes have been in linux-next for at least one round -- no conflicts
expected.

- Danilo

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c=
:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/rust/kernel.git tags/drm-rust-next-202=
6-03-30

for you to fetch changes up to 7c50d748b4a635bc39802ea3f6b120e66b1b9067:

  gpu: nova-core: firmware: factor out an elf_str() function (2026-03-30 14=
:01:53 +0900)

----------------------------------------------------------------
DRM Rust changes for v7.1-rc1

- DMA:
  - Rework the DMA coherent API: introduce Coherent<T> as a generalized
    container for arbitrary types, replacing the slice-only
    CoherentAllocation<T>. Add CoherentBox for memory initialization
    before exposing a buffer to hardware (converting to Coherent when
    ready), and CoherentHandle for allocations without kernel mapping.

  - Add Coherent::init() / init_with_attrs() for one-shot initialization
    via pin-init, and from-slice constructors for both Coherent and
    CoherentBox

  - Add uaccess write_dma() for copying from DMA buffers to userspace
    and BinaryWriter support for Coherent<T>

- DRM:
  - Add GPU buddy allocator abstraction

  - Add DRM shmem GEM helper abstraction

  - Allow drm::Device to dispatch work and delayed work items to driver
    private data

  - Add impl_aref_for_gem_obj!() macro to reduce GEM refcount
    boilerplate, and introduce DriverObject::Args for constructor
    context

  - Add dma_resv_lock helper and raw_dma_resv() accessor on GEM objects

  - Clean up imports across the DRM module

- I/O:
  - Merged via a signed tag from the driver-core tree: register!() macro
    and I/O infrastructure improvements (IoCapable refactor, RelaxedMmio
    wrapper, IoLoc trait, generic accessors, write_reg /
    LocatedRegister)

- Nova (Core):
  - Fix and harden the GSP command queue: correct write pointer
    advancing, empty slot handling, and ring buffer indexing; add mutex
    locking and make Cmdq a pinned type; distinguish wait vs no-wait
    commands

  - Add support for large RPCs via continuation records, splitting
    oversized commands across multiple queue slots

  - Simplify GSP sequencer and message handling code: remove unused
    trait and Display impls, derive Debug and Zeroable where applicable,
    warn on unconsumed message data

  - Refactor Falcon firmware handling: create DMA objects lazily, add
    PIO upload support, and use the Generic Bootloader to boot FWSEC on
    Turing

  - Convert all register definitions (PMC, PBUS, PFB, GC6, FUSE, PDISP,
    Falcon) to the kernel register!() macro; add bounded_enum macro to
    define enums usable as register fields

  - Migrate all DMA usage to the new Coherent, CoherentBox, and
    CoherentHandle APIs

  - Harden firmware parsing with checked arithmetic throughout FWSEC,
    Booter, RISC-V parsing paths

  - Add debugfs support for reading GSP-RM log buffers; replace
    module_pci_driver!() with explicit module init to support
    module-level debugfs setup

  - Fix auxiliary device registration for multi-GPU systems

  - Various cleanups: import style, firmware parsing refactoring,
    framebuffer size logging

- Rust:
  - Add interop::list module providing a C linked list interface

  - Extend num::Bounded with shift operations, into_bool(), and const
    get() to support register bitfield manipulation

  - Enable the generic_arg_infer Rust feature and add EMSGSIZE error
    code

- Tyr:
  - Adopt vertical import style per kernel Rust guidelines

  - Clarify driver/device type names and use DRM device type alias
    consistently across the driver

  - Fix GPU model/version decoding in GpuInfo

- Workqueue:
  - Add ARef<T> support for work and delayed work

----------------------------------------------------------------
Alexandre Courbot (50):
      gpu: nova-core: gsp: warn if data remains after processing a message
      gpu: nova-core: gsp: remove unnecessary Display impls
      gpu: nova-core: gsp: simplify sequencer opcode parsing
      gpu: nova-core: gsp: remove unneeded sequencer trait
      gpu: nova-core: gsp: derive `Debug` on more sequencer types
      gpu: nova-core: gsp: derive Zeroable for GspStaticConfigInfo
      gpu: nova-core: use core library's CStr instead of kernel one
      gpu: nova-core: create falcon firmware DMA objects lazily
      gpu: nova-core: falcon: add constant for memory block alignment
      gpu: nova-core: falcon: rename load parameters to reflect DMA depende=
ncy
      gpu: nova-core: falcon: remove FalconFirmware's dependency on FalconD=
maLoadable
      gpu: nova-core: move brom_params and boot_addr to FalconFirmware
      gpu: nova-core: falcon: remove unwarranted safety check in dma_load
      gpu: nova-core: make Chipset::arch() const
      gpu: nova-core: add gen_bootloader firmware to ModInfoBuilder
      gpu: nova-core: firmware: add comments to justify v3 header values
      gpu: nova-core: firmware: fix and explain v2 header offsets computati=
ons
      rust: io: turn IoCapable into a functional trait
      rust: io: mem: use non-relaxed I/O ops in examples
      rust: io: provide Mmio relaxed ops through a wrapper type
      rust: io: remove legacy relaxed accessors of Mmio
      rust: pci: io: remove overloaded Io methods of ConfigSpace
      rust: io: remove overloaded Io methods of Mmio
      rust: enable the `generic_arg_infer` feature
      rust: num: add `shr` and `shl` methods to `Bounded`
      rust: num: add `into_bool` method to `Bounded`
      rust: num: make Bounded::get const
      rust: io: add IoLoc type and generic I/O accessors
      rust: io: use generic read/write accessors for primitive accesses
      rust: io: add `register!` macro
      rust: io: introduce `write_reg` and `LocatedRegister`
      sample: rust: pci: use `register!` macro
      gpu: nova-core: gsp: move Cmdq's DMA handle to a struct member
      gpu: nova-core: introduce `bounded_enum` macro
      gpu: nova-core: convert PMC registers to kernel register macro
      gpu: nova-core: convert PBUS registers to kernel register macro
      gpu: nova-core: convert PFB registers to kernel register macro
      gpu: nova-core: convert GC6 registers to kernel register macro
      gpu: nova-core: convert FUSE registers to kernel register macro
      gpu: nova-core: convert PDISP registers to kernel register macro
      gpu: nova-core: convert falcon registers to kernel register macro
      gpu: nova-core: remove `io::` qualifier to register macro invocations
      Documentation: nova: remove register abstraction task
      rust: dma: add from-slice constructors for Coherent and CoherentBox
      gpu: nova-core: firmware: riscv: use dma::Coherent
      gpu: nova-core: firmware: fwsec: use dma::Coherent
      gpu: nova-core: falcon: use dma::Coherent
      gpu: nova-core: fb: use dma::CoherentHandle
      gpu: nova-core: firmware: gsp: use dma::Coherent for signatures
      gpu: nova-core: firmware: gsp: use dma::Coherent for level0 table

Alice Ryhl (2):
      rust: workqueue: use new sync::aref path for imports
      rust: drm: use new sync::aref path for imports

Asahi Lina (2):
      rust: helpers: Add bindings/wrappers for dma_resv_lock
      rust: drm: gem: shmem: Add DRM shmem helper abstraction

Daniel Almeida (4):
      rust: workqueue: add support for ARef<T>
      rust: drm: dispatch work items to the private data
      rust: workqueue: add delayed work support for ARef<T>
      rust: drm: dispatch delayed work items to the private data

Danilo Krummrich (14):
      Merge tag 'v7.0-rc4' into drm-rust-next
      Merge tag 'rust_io-7.1-rc1' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/driver-core/driver-core into drm-rust-next
      Merge tag 'drm-misc-next-2026-03-12' into drm-rust-next
      rust: dma: use "kernel vertical" style for imports
      rust: dma: introduce dma::CoherentBox for memory initialization
      rust: dma: add Coherent:init() and Coherent::init_with_attrs()
      gpu: nova-core: use Coherent::init to initialize GspFwWprMeta
      gpu: nova-core: convert Gsp::new() to use CoherentBox
      rust: dma: remove dma::CoherentAllocation<T>
      rust: uaccess: generalize write_dma() to accept any Coherent<T>
      rust: dma: generalize BinaryWriter impl for Coherent<T>
      gpu: nova-core: use sized array for GSP log buffers
      rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from public attrs
      rust: dma: add CoherentHandle for DMA allocations without kernel mapp=
ing

Deborah Brouwer (3):
      drm/tyr: Use vertical style for imports
      drm/tyr: Clarify driver/device type names
      drm/tyr: Use DRM device type alias across driver

Eliot Courtney (19):
      gpu: nova-core: gsp: fix incorrect advancing of write pointer
      gpu: nova-core: gsp: clarify comments about invariants and pointer ro=
les
      gpu: nova-core: gsp: use empty slices instead of [0..0] ranges
      gpu: nova-core: gsp: fix improper handling of empty slot in cmdq
      gpu: nova-core: gsp: fix improper indexing in driver_read_area
      gpu: nova-core: gsp: sort `MsgFunction` variants alphabetically
      gpu: nova-core: gsp: add mechanism to wait for space on command queue
      rust: add EMSGSIZE error code
      gpu: nova-core: gsp: add checking oversized commands
      gpu: nova-core: gsp: clarify invariant on command queue
      gpu: nova-core: gsp: unconditionally call variable payload handling
      gpu: nova-core: gsp: add `size` helper to `CommandToGsp`
      gpu: nova-core: gsp: support large RPCs via continuation record
      gpu: nova-core: gsp: add tests for continuation records
      gpu: nova-core: gsp: fix stale doc comments on command queue methods
      gpu: nova-core: gsp: add `RECEIVE_TIMEOUT` constant for command queue
      gpu: nova-core: gsp: add reply/no-reply info to `CommandToGsp`
      gpu: nova-core: gsp: make `Cmdq` a pinned type
      gpu: nova-core: gsp: add mutex locking to Cmdq

Gary Guo (4):
      gpu: nova-core: remove redundant `.as_ref()` for `dev_*` print
      rust: dma: add generalized container for types other than slices
      rust: dma: add zeroed constructor to `Coherent`
      gpu: nova-core: convert to new dma::Coherent API

Joel Fernandes (9):
      gpu: nova-core: use checked arithmetic in FWSEC firmware parsing
      gpu: nova-core: use checked arithmetic in Booter signature parsing
      gpu: nova-core: use checked arithmetic in frombytes_at helper
      gpu: nova-core: use checked arithmetic in BinFirmware::data
      gpu: nova-core: use checked arithmetic in RISC-V firmware parsing
      gpu: nova-core: Kconfig: Sort select statements alphabetically
      rust: interop: Add list module for C linked list interface
      rust: gpu: Add GPU buddy allocator bindings
      MAINTAINERS: gpu: buddy: Update reviewer

John Hubbard (6):
      gpu: nova-core: fix aux device registration for multi-GPU systems
      gpu: nova-core: print FB sizes, along with ranges
      gpu: nova-core: add FbRange.len() and use it in boot.rs
      gpu: nova-core: apply the one "use" item per line policy to commands.=
rs
      gpu: nova-core: firmware: move firmware image parsing code to firmwar=
e.rs
      gpu: nova-core: firmware: factor out an elf_str() function

Lyude Paul (5):
      rust/drm: Fixup import styles
      rust/drm: Remove imports covered by prelude::*
      rust: drm: Add gem::impl_aref_for_gem_obj!
      rust: gem: Introduce DriverObject::Args
      rust: drm: gem: Add raw_dma_resv() function

Onur =C3=96zkan (1):
      drm/tyr: gpu: fix GpuInfo::log model/version decoding

Timur Tabi (8):
      gpu: nova-core: add PIO support for loading firmware images
      gpu: nova-core: use the Generic Bootloader to boot FWSEC on Turing
      rust: device: add device name method
      rust: uaccess: add write_dma() for copying from DMA buffers to usersp=
ace
      rust: dma: implement BinaryWriter for Coherent<[u8]>
      gpu: nova-core: Replace module_pci_driver! with explicit module init
      gpu: nova-core: create debugfs root in module init
      gpu: nova-core: create GSP-RM logging buffers debugfs entries

 Documentation/gpu/nova/core/todo.rst               |   76 ------
 MAINTAINERS                                        |   18 +-
 drivers/gpu/drm/Kconfig                            |    7 +
 drivers/gpu/drm/nova/gem.rs                        |    5 +-
 drivers/gpu/drm/tyr/driver.rs                      |  100 ++++----
 drivers/gpu/drm/tyr/file.rs                        |   36 +--
 drivers/gpu/drm/tyr/gem.rs                         |   18 +-
 drivers/gpu/drm/tyr/gpu.rs                         |   58 ++---
 drivers/gpu/drm/tyr/regs.rs                        |   16 +-
 drivers/gpu/drm/tyr/tyr.rs                         |    4 +-
 drivers/gpu/nova-core/Kconfig                      |    2 +-
 drivers/gpu/nova-core/dma.rs                       |   54 -----
 drivers/gpu/nova-core/driver.rs                    |   17 +-
 drivers/gpu/nova-core/falcon.rs                    |  789 ++++++++++++++++=
+++++++++++++++++++---------------------------
 drivers/gpu/nova-core/falcon/gsp.rs                |   27 ++-
 drivers/gpu/nova-core/falcon/hal.rs                |    6 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |   70 +++---
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   12 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |   17 +-
 drivers/gpu/nova-core/fb.rs                        |  101 ++++++--
 drivers/gpu/nova-core/fb/hal/ga100.rs              |   37 +--
 drivers/gpu/nova-core/fb/hal/ga102.rs              |    7 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs              |   17 +-
 drivers/gpu/nova-core/firmware.rs                  |  194 ++++++++++++----
 drivers/gpu/nova-core/firmware/booter.rs           |   87 +++----
 drivers/gpu/nova-core/firmware/fwsec.rs            |  181 +++++++--------
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  350 ++++++++++++++++=
++++++++++++
 drivers/gpu/nova-core/firmware/gsp.rs              |  118 ++--------
 drivers/gpu/nova-core/firmware/riscv.rs            |   10 +-
 drivers/gpu/nova-core/gfw.rs                       |   11 +-
 drivers/gpu/nova-core/gpu.rs                       |   66 +++---
 drivers/gpu/nova-core/gsp.rs                       |  118 ++++++----
 drivers/gpu/nova-core/gsp/boot.rs                  |   82 +++----
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  397 ++++++++++++++++=
++++++---------
 drivers/gpu/nova-core/gsp/cmdq/continuation.rs     |  307 ++++++++++++++++=
++++++++
 drivers/gpu/nova-core/gsp/commands.rs              |   23 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |  309 ++++++++++------=
---------
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   17 +-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs  |    1 +
 drivers/gpu/nova-core/gsp/sequencer.rs             |   22 +-
 drivers/gpu/nova-core/nova_core.rs                 |   54 ++++-
 drivers/gpu/nova-core/num.rs                       |   80 +++++++
 drivers/gpu/nova-core/regs.rs                      |  549 ++++++++++++++++=
+++++++++------------------
 drivers/gpu/nova-core/regs/macros.rs               |  739 ----------------=
------------------------------------------
 rust/bindings/bindings_helper.h                    |   14 ++
 rust/helpers/device.c                              |    5 +
 rust/helpers/dma-resv.c                            |   14 ++
 rust/helpers/drm.c                                 |   56 ++++-
 rust/helpers/gpu.c                                 |   17 ++
 rust/helpers/helpers.c                             |    3 +
 rust/helpers/list.c                                |   17 ++
 rust/kernel/device.rs                              |   15 +-
 rust/kernel/dma.rs                                 |  899 ++++++++++++++++=
+++++++++++++++++++++++++++++++++++++-----------------
 rust/kernel/drm/device.rs                          |   87 ++++++-
 rust/kernel/drm/driver.rs                          |   10 +-
 rust/kernel/drm/file.rs                            |    8 +-
 rust/kernel/drm/gem/mod.rs                         |  104 +++++++--
 rust/kernel/drm/gem/shmem.rs                       |  228 ++++++++++++++++=
++
 rust/kernel/error.rs                               |    1 +
 rust/kernel/gpu.rs                                 |    6 +
 rust/kernel/gpu/buddy.rs                           |  614 ++++++++++++++++=
++++++++++++++++++++++++++++++++
 rust/kernel/interop.rs                             |    9 +
 rust/kernel/interop/list.rs                        |  339 ++++++++++++++++=
+++++++++++
 rust/kernel/io.rs                                  |  780 ++++++++++++++++=
++++++++++++++++++++++-----------------------
 rust/kernel/io/mem.rs                              |   10 +-
 rust/kernel/io/register.rs                         | 1260 ++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 rust/kernel/lib.rs                                 |    8 +
 rust/kernel/num/bounded.rs                         |   70 +++++-
 rust/kernel/pci/io.rs                              |   99 +++-----
 rust/kernel/uaccess.rs                             |   91 +++++++-
 rust/kernel/workqueue.rs                           |  104 ++++++++-
 samples/rust/rust_dma.rs                           |   13 +-
 samples/rust/rust_driver_pci.rs                    |   90 ++++++--
 scripts/Makefile.build                             |    3 +-
 74 files changed, 7125 insertions(+), 3058 deletions(-)
 delete mode 100644 drivers/gpu/nova-core/dma.rs
 create mode 100644 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
 create mode 100644 drivers/gpu/nova-core/gsp/cmdq/continuation.rs
 delete mode 100644 drivers/gpu/nova-core/regs/macros.rs
 create mode 100644 rust/helpers/dma-resv.c
 create mode 100644 rust/helpers/gpu.c
 create mode 100644 rust/helpers/list.c
 create mode 100644 rust/kernel/drm/gem/shmem.rs
 create mode 100644 rust/kernel/gpu.rs
 create mode 100644 rust/kernel/gpu/buddy.rs
 create mode 100644 rust/kernel/interop.rs
 create mode 100644 rust/kernel/interop/list.rs
 create mode 100644 rust/kernel/io/register.rs
