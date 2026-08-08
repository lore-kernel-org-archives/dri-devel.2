Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FEEC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 17:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5815810E049;
	Sat,  8 Aug 2026 17:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kLYN33hB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CD910E049
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 17:33:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC1E26001A;
 Sat,  8 Aug 2026 17:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873EC1F000E9;
 Sat,  8 Aug 2026 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786210414;
 bh=jUPfLya9+9tPaU14qwKQ5d92X2MmZaMjBPmpRnAx+ws=;
 h=Date:Subject:Cc:To:From;
 b=kLYN33hBAxDeYQtlWN5mfitoB2M8cITo7t5kd3Ggudzbd9C+tCyMYr4iwVlpHMRWT
 iN+ry7ZjHo3IDUkBavpdAZrJ64dzEcQL7kdnwSJLdSMoXnZ4V1uW9DwN5/Oz2Eqsmw
 3KlBAC5JDa7sb0jn3geuNT8t5Z7vl9yNW3Iuus5us8wgF9r4Tm0CFuUojY4FS3M+1E
 5RD5a7SofHS7SXpKbbVudqBVbXhFSXMp3uMrlPcWPVT2sEQSrF03mGAnlICU8QEMJR
 uYjhzgH/G9X6RCyEgYYfZf5K9dMbj9wmlZydD7QNzm5n8C9yBzK9+ae1qgDJyxu/xG
 IxyzMmJ9wdXMw==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Aug 2026 19:33:31 +0200
Message-Id: <DKJQQUOS0PVO.3JPR3MYK4PDVZ@kernel.org>
Subject: [GIT PULL] DRM Rust changes for v7.3-rc1
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
To: "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>
From: "Danilo Krummrich" <dakr@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

The highlights are RegistrationData and RegistrationGuard to capture device
lifetime-annotated resources and references and make them available in ioct=
ls on
the DRM side; TLV firmware images, vGPU boot support, and GSP boot process
consolidation for nova-core; and firmware loading with MCU boot for Tyr.

Note: The TLV firmware series requires a development firmware not in
linux-firmware [1].

There is one external dependency: a shared signed tag from the driver-core =
tree
for I/O type generalization and projection.

(I plan to send an early driver-core PR to Linus for this cycle.)

Thanks,
Danilo

[1] https://github.com/ttabi/linux-firmware-nova

The following changes since commit ea97ab2759506d9a818ffed1009bde01062b4091=
:

  Merge tag 'drm-misc-next-2026-07-24' of https://gitlab.freedesktop.org/dr=
m/misc/kernel into drm-next (2026-07-25 06:13:51 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/rust/kernel.git tags/drm-rust-next-202=
6-08-08

for you to fetch changes up to 4c9ba407018e8deb06dbc643112bac8f40404f95:

  gpu: nova-core: falcon: use I/O projection to check transfer bounds (2026=
-08-06 22:55:58 +0200)

----------------------------------------------------------------
DRM Rust changes for v7.3-rc1

- I/O (shared from driver-core tree via signed tag rust-io-7.3-rc1):

  - Rework of I/O types: make I/O regions typed (with a
    dynamically-sized Region type for the existing untyped case), create
    view types representing subregions of a mapped I/O region, and add
    io_project!() for safely creating subviews.

  - Split Io into a base trait (IoBase) and an extension trait (Io) with
    a blanket implementation, preventing implementers from overriding
    provided methods that unsafe code relies on.

  - Add a SysMem backend for shared system memory with volatile access,
    and make Coherent implement Io via an I/O view type.  Add copying
    methods (memcpy_{from,to}io).

  - Replace dma_read!/dma_write! with io_read!/io_write!; drop the old
    macros.

- DRM:

  - RegistrationGuard and RegistrationData:
    - Rework DeviceContext typestates: rename Uninit to Normal, add an
      Ioctl context, restrict AlwaysRefCounted to Normal for both Device
      and GEM Object, and establish a Deref chain from Registered to
      Normal.

    - Introduce RegistrationGuard, a guard representing a
      drm_dev_enter/exit SRCU critical section that proves the DRM
      device is registered, which implies the parent bus device is still
      bound.

    - Add RegistrationData as a GAT on drm::Driver. The data does not
      outlive driver unbind, so it can capture lifetime-annotated device
      resources and references. Accessible through the guard via a
      closure with HRTB lifetime.

    - Wrap ioctl dispatch in RegistrationGuard (returning ENODEV if
      unplugged) and pass registration data to handlers.

    - Add Driver::ParentDevice associated type.

  - Fix unbounded lifetimes in ioctl handler arguments.

  - Fix a race in drm_dev_register() where a partial failure allowed
    in-flight ioctls to proceed while the error path tore down
    resources.

  - GEM shmem: add DmaResvGuard helper, vmap functions, and sg_table()
    accessor.

  - GPUVM: require Send + Sync for the driver's associated data,
    implement Send and Sync for GpuVaAlloc and GpuVmBo, add SmContext
    lifetime bound, update DriverGpuVm for DeviceContext.

- Nova:

  - nova-core / nova-drm cross-crate dependency:
    - Build nova-core and nova-drm from drivers/gpu/Makefile for build
      ordering, export nova-core Rust symbols for nova-drm. Workaround
      until the build system supports Rust cross-crate dependencies
      natively.

  - GSP boot process consolidation:
    - Introduce GspBootContext to bundle common boot parameters,
      replacing per-argument threading. Separate context and GPU
      lifetimes to support mutable borrows of GPU subdevices.

    - Turn FWSEC execution into a HAL method, make FWSEC bootloader
      usage a property of the TU102 HAL (GA102+ gets its own instance
      with it disabled). Move firmware file selection to the GSP HAL.

    - Store the Fsp instance in Gpu (lifetime tied to the GPU, not just
      a single boot invocation). Move GSP state and unload bundle into a
      pinned subobject for reliable teardown on partial init failure.

  - Boot GSP with vGPU enabled:
    - Add PRC (Product Reconfiguration Control) protocol to query device
      configuration from the FSP. Read vGPU mode, detect and store vGPU
      state.
    - Set RMSetSriovMode registry entry and reserve the larger WPR2 heap
      required when vGPU is enabled.
    - Build SetRegistry entries dynamically.

  - TLV firmware image format:
    - Add a TLV (type-length-value) parser for the new firmware image
      format. TLV files use unversioned filenames with a .tlv suffix,
      start with "NVFW" magic, and contain tagged blocks with 4-byte
      aligned payloads.
    - Transition all firmware loading (booter, gsp, gen_bootloader, fsp)
      to TLV images.
    - Note: this requires a development firmware not in linux-firmware
      [1]; this is temporary and serves the transition to r615.

  - Hopper/Blackwell fixes and cleanups:
    - Correct FRTS vidmem offset calculation, split FbLayout into FSP
      and non-FSP versions, fix Blackwell flush address composition, use
      absolute FBHUB0 flush registers on Blackwell, use correct sysmem
      flush registers on Hopper.
    - Harden FSP messaging: limit receive allocation size, catch bogus
      queue pointers, ensure DMA allocation lifetimes for FMC boot and
      LibOS, wait for RISC-V HALTED on unload.

  - I/O projection adoption:
    - Use io_project!() for PTE array, message queues, and Falcon DMA
      transfer bounds checking.

  - Misc:
    - Keep unloading if FWSEC-SB fails during Turing/Ampere GSP reset.
    - Don't declare booter firmware for FSP chipsets.
    - Fix packed registry table size.
    - Extract and display usable FB regions from GSP.
    - Store bar and dev directly in Falcon, simplifying the API.
    - Parse VBIOS structs via zerocopy.
    - Convert to kernel bitfield macro, remove local one.
    - Move register definitions into sub-modules.
    - Add FSP and PRC protocol documentation.

- Tyr:

  - Firmware loading and MCU boot:
    - Add a generic slot manager for dynamically allocating limited
      hardware slots to software seats, with lazy eviction under
      contention.
    - Add MMU support wrapping the slot manager for address-space slot
      allocation, with MAIR-to-MEMATTR translation.
    - Add GPU virtual memory (VM) support using drm_gpuvm with ARM64
      LPAE Stage 1 page tables and 4KB/2MB page sizes.
    - Add a kernel buffer object type for internal driver allocations.
    - Add a parser for the Mali CSF firmware binary format.
    - Add MCU booting: load, parse, and map firmware sections into VM,
      then boot the MCU at probe().

- Cross-subsystem:

  - Add faux::Device type with AsBusDevice support. Allow retrieving a
    bound Device from a Registration.

  - Add device lifetime to IoPageTable.

  - Add Vec::zeroed method.

  - Add firmware::request_into_buf() to load firmware into a
    caller-provided buffer.

  - Rename dma_handle to dma_address in the DMA abstraction.

  - Change pci_sriov_get_totalvfs() return type to unsigned int; add
    Rust helper.

[1] https://github.com/ttabi/linux-firmware-nova

----------------------------------------------------------------
Alexandre Courbot (26):
      gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB fails
      gpu: nova-core: move GSP unload state to a pinned Gpu subobject
      gpu: nova-core: move GPU static information acquisition to a GSP meth=
od
      gpu: build nova-core and nova-drm from drivers/gpu/Makefile
      gpu: nova-core: export Rust symbols for nova-drm
      gpu: nova-core: emit Rust metadata for nova-drm
      gpu: drm: nova: depend on nova-core and use its symbols
      gpu: nova-core: convert to kernel bitfield macro
      gpu: nova-core: remove local bitfield macro
      gpu: nova: fix rust-analyzer generation
      gpu: nova-core: gsp: sequencer: use GspBootContext
      gpu: nova-core: gsp: sequencer: do not store sequence into GspSequenc=
er
      gpu: nova-core: gsp: replace BootUnloadGuard with local handlers
      gpu: nova-core: gsp: pass GspBootContext to unload methods
      gpu: nova-core: gsp: centralize missing unload bundle warnings
      gpu: nova-core: gsp: fold TU102 unload bundle construction into HAL m=
ethod
      gpu: nova-core: gsp: turn FWSEC execution into HAL method
      gpu: nova-core: gsp: make use of FWSEC bootloader a property of the T=
U102 HAL
      gpu: nova-core: avoid repeated calls to pci::Device::as_ref
      gpu: nova-core: gsp: pass GspBootContext mutably
      gpu: nova-core: gsp: separate context and GPU lifetimes in GspBootCon=
text
      gpu: nova-core: store Fsp instance in Gpu
      gpu: nova-core: fix packed registry table size
      gpu: nova-core: falcon: remove unnecessary check
      rust: dma: rename dma_handle to dma_address
      gpu: nova-core: falcon: use I/O projection to check transfer bounds

Antonin Malzieu Ridolfi (5):
      gpu: nova-core: gsp: Move gsp register definition into gsp module
      gpu: nova-core: fb: Move PDISP register definition
      gpu: nova-core: Add function to query WPR2 range
      gpu: nova-core: Move PFB registers definitions
      gpu: nova-core: Move one PBUS register definition

Boris Brezillon (4):
      rust: drm: gpuvm: add SmContext lifetime bound
      drm/tyr: add a generic slot manager
      drm/tyr: add Memory Management Unit (MMU) support
      drm/tyr: add GPU virtual memory (VM) support

Daniel Almeida (1):
      drm/tyr: add parser for firmware binary

Danilo Krummrich (23):
      Merge tag 'v7.2-rc1' into drm-rust-next
      rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
      rust: drm: rename Uninit DeviceContext to Normal
      rust: faux: add Device type with AsBusDevice support
      rust: drm: Add Driver::ParentDevice associated type
      rust: drm: change default DeviceContext to Normal
      rust: drm: restrict AlwaysRefCounted to Normal Device context
      rust: drm: restrict AlwaysRefCounted to Normal GEM Object context
      rust: drm/gem: remove DeviceContext from shmem::Object
      rust: drm: split Deref for Device context typestates
      rust: drm: pin ioctl Device reference to Normal context
      rust: drm: add Ioctl device context typestate
      rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical sect=
ions
      rust: drm: Wrap ioctl dispatch in RegistrationGuard
      rust: drm: return ParentDevice from Device AsRef
      rust: drm: add AsRef<ParentDevice<Bound>> for Device<Registered>
      drm: fix race between partial drm_dev_register() failure and ioctl
      rust: drm: Add RegistrationData to drm::Driver
      rust: drm: Pass registration data to ioctl handlers
      drm: nova: Use drm::Device<Registered> to access the parent bus devic=
e
      Merge patch series "rust: drm: Higher-Ranked Lifetime private data"
      Merge tag 'rust-io-7.3-rc1' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/driver-core/driver-core into drm-rust-next
      Merge remote-tracking branch 'drm/drm-next' into drm-rust-next

Deborah Brouwer (5):
      rust: drm: gpuvm: update DriverGpuVm for DeviceContext
      rust: iommu: add device lifetime to IoPageTable
      drm/tyr: add resources to RegistrationData
      drm/tyr: add a kernel buffer object
      drm/tyr: add Microcontroller Unit (MCU) booting

Eliot Courtney (14):
      gpu: nova-core: falcon: gsp: move PRIV target mask constants
      gpu: nova-core: fsp: move FMC firmware loading into wait_secure_boot
      gpu: nova-core: move GSP firmware files decision to GSP HAL
      gpu: nova-core: fsp: limit FSP receive message allocation size
      gpu: nova-core: fsp: catch bogus queue pointer issues
      gpu: nova-core: gsp: ensure lifetime for FMC boot DMA allocations
      gpu: nova-core: gsp: ensure LibOS DMA allocation lives long enough
      gpu: nova-core: correct RISC-V HALTED field
      gpu: nova-core: wait for RISC-V HALTED on FSP unload
      gpu: nova-core: correct FRTS vidmem offset calculation
      gpu: nova-core: rename heap size field
      gpu: nova-core: return non-WPR heap size as u64 from HALs
      gpu: nova-core: split FbLayout into FSP and non-FSP versions
      gpu: nova-core: pass WPR metadata ownership to FmcBootArgs

Gary Guo (24):
      gpu: nova-core: remove imports available from prelude
      gpu: nova-core: use `c"literal"` instead of `c_str!()`
      drm/tyr: remove imports available from prelude
      gpu: nova-core: remove `#[allow(non_snake_case)]`
      rust: io: add dynamically-sized `Region` type
      rust: io: add missing safety requirement in `IoCapable` methods
      rust: io: restrict untyped IO access and `register!` to `Region`
      rust: io: implement `Io` on reference types instead
      rust: io: generalize `MmioRaw` to pointer to arbitrary type
      rust: io: rename `Mmio` to `MmioOwned`
      rust: io: implement `Mmio` as view type
      rust: pci: io: make `ConfigSpace` a view
      rust: io: use view types instead of addresses for `Io`
      pwm: th1520: remove unnecessary `deref`
      rust: io: remove `MmioOwned`
      rust: io: move `Io` methods to extension trait
      rust: io: add projection macro and methods
      rust: io: implement a view type for `Coherent`
      rust: io: add `read_val` and `write_val` functions on `Io`
      gpu: nova-core: use I/O projection for cleaner encapsulation
      rust: dma: drop `dma_read!` and `dma_write!` API
      rust: io: add copying methods
      rust: io: implement `IoSysMap`
      rust: drm: fix non-const `read8` in unit test

Joel Fernandes (1):
      gpu: nova-core: gsp: Extract and display usable FB regions from GSP

John Hubbard (6):
      gpu: nova-core: don't declare booter firmware for FSP chipsets
      gpu: nova-core: clean up FSP FRTS comments
      gpu: nova-core: Blackwell: use absolute FBHUB0 flush registers
      gpu: nova-core: Hopper: use correct sysmem flush registers
      gpu: nova-core: fb: fix Blackwell flush address composition
      gpu: nova-core: fb: remove duplicated SysmemFlush doc link

Laura Nao (1):
      rust: io: add I/O backend for system memory with volatile access

Lyude Paul (5):
      rust: drm: gem: shmem: Fix Default implementation for ObjectConfig
      rust: drm: gem: shmem: Add DmaResvGuard helper
      rust: drm: gem: shmem: Add vmap functions
      rust: drm: gem: Introduce shmem::Object::sg_table()
      rust: faux: Allow retrieving a bound Device

Nicol=C3=A1s Antinori (1):
      gpu: nova-core: vbios: parse structs via zerocopy

Sami Tolvanen (2):
      rust: drm: gpuvm: require Send + Sync for the driver's associated dat=
a
      rust: drm: gpuvm: implement Send and Sync for GpuVaAlloc and GpuVmBo

Tim Kovalenko (1):
      gpu: nova-core: falcon: store bar and dev in falcon

Timur Tabi (8):
      rust: alloc: add Vec::zeroed method
      rust: firmware: add request_into_buf()
      gpu: nova-core: add TLV parser for firmware files
      gpu: nova-core: transition booter to TLV images
      gpu: nova-core: transition gsp to TLV images
      gpu: nova-core: transition gen_bootloader to TLV images
      gpu: nova-core: transition fsp to TLV images
      gpu: nova-core: update firmware module info for TLV images

Yilin Chen (1):
      rust: drm: fix GEM object pointer safety docs

Younes Akhouayri (1):
      rust: drm: Fix typo in FEAT_RENDER documentation

Zhi Wang (12):
      gpu: nova-core: factor out common FSP message header
      gpu: nova-core: return FSP response buffer to caller
      gpu: nova-core: add FSP and PRC protocol documentation
      gpu: nova-core: consolidate GSP boot parameters into GspBootContext
      gpu: nova-core: fsp: rename FSP response header type
      gpu: nova-core: build SetRegistry entries dynamically
      PCI/IOV: Return unsigned int from pci_sriov_get_totalvfs()
      rust: pci: add sriov_get_totalvfs() helper
      gpu: nova-core: read vGPU mode from FSP via PRC protocol
      gpu: nova-core: detect and store vGPU state
      gpu: nova-core: set RMSetSriovMode for vGPU
      gpu: nova-core: reserve vGPU WPR2 heap

 Documentation/gpu/nova/core/fsp.rst                |  142 ++++++++++
 Documentation/gpu/nova/core/tlv.rst                |  184 +++++++++++++
 Documentation/gpu/nova/index.rst                   |    2 +
 drivers/gpu/Makefile                               |   58 +++-
 drivers/gpu/drm/Makefile                           |    2 +-
 drivers/gpu/drm/drm_drv.c                          |   34 ++-
 drivers/gpu/drm/nova/Makefile                      |    5 +-
 drivers/gpu/drm/nova/driver.rs                     |   38 +--
 drivers/gpu/drm/nova/file.rs                       |   22 +-
 drivers/gpu/drm/nova/gem.rs                        |   18 +-
 drivers/gpu/drm/tyr/Kconfig                        |    5 +
 drivers/gpu/drm/tyr/driver.rs                      |   81 ++++--
 drivers/gpu/drm/tyr/file.rs                        |   15 +-
 drivers/gpu/drm/tyr/fw.rs                          |  321 ++++++++++++++++=
+++++
 drivers/gpu/drm/tyr/fw/parser.rs                   |  588 ++++++++++++++++=
+++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs                         |  141 +++++++++-
 drivers/gpu/drm/tyr/mmu.rs                         |  120 ++++++++
 drivers/gpu/drm/tyr/mmu/address_space.rs           |  511 ++++++++++++++++=
++++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs                        |  149 +++++++++-
 drivers/gpu/drm/tyr/slot.rs                        |  404 ++++++++++++++++=
+++++++++++
 drivers/gpu/drm/tyr/tyr.rs                         |    4 +
 drivers/gpu/drm/tyr/vm.rs                          |  950 ++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/.gitignore                   |    1 +
 drivers/gpu/nova-core/Makefile                     |    5 +-
 drivers/gpu/nova-core/bitfield.rs                  |  329 ----------------=
------
 drivers/gpu/nova-core/falcon.rs                    |  272 ++++++++--------=
--
 drivers/gpu/nova-core/falcon/fsp.rs                |   65 +++--
 drivers/gpu/nova-core/falcon/gsp.rs                |   32 ++-
 drivers/gpu/nova-core/falcon/hal.rs                |   19 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |   36 ++-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   28 +-
 drivers/gpu/nova-core/fb.rs                        |  104 +++++--
 drivers/gpu/nova-core/fb/hal.rs                    |    2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |   10 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |    2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   11 +-
 drivers/gpu/nova-core/fb/hal/gb202.rs              |   39 +--
 drivers/gpu/nova-core/fb/hal/gh100.rs              |   37 ++-
 drivers/gpu/nova-core/fb/hal/tu102.rs              |   14 +-
 drivers/gpu/nova-core/fb/regs.rs                   |  155 +++++++++++
 drivers/gpu/nova-core/firmware.rs                  |  329 ++--------------=
------
 drivers/gpu/nova-core/firmware/booter.rs           |  350 +++++-----------=
-------
 drivers/gpu/nova-core/firmware/fsp.rs              |   88 +++---
 drivers/gpu/nova-core/firmware/fwsec.rs            |   24 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   95 ++-----
 drivers/gpu/nova-core/firmware/gsp.rs              |   65 ++---
 drivers/gpu/nova-core/firmware/riscv.rs            |   75 ++---
 drivers/gpu/nova-core/firmware/tlv.rs              |  262 ++++++++++++++++=
++
 drivers/gpu/nova-core/fsp.rs                       |  362 ++++++++++++++++=
+++-----
 drivers/gpu/nova-core/fsp/hal.rs                   |    4 +
 drivers/gpu/nova-core/fsp/hal/gb100.rs             |    6 +
 drivers/gpu/nova-core/fsp/hal/gb202.rs             |    9 +-
 drivers/gpu/nova-core/fsp/hal/gh100.rs             |    9 +-
 drivers/gpu/nova-core/gpu.rs                       |  189 +++++++++----
 drivers/gpu/nova-core/gsp.rs                       |  101 ++++---
 drivers/gpu/nova-core/gsp/boot.rs                  |  150 +++-------
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   75 ++---
 drivers/gpu/nova-core/gsp/commands.rs              |   90 +++---
 drivers/gpu/nova-core/gsp/fw.rs                    |  201 +++++++-------
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   42 ++-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs  |    1 +
 drivers/gpu/nova-core/gsp/hal.rs                   |   72 +++--
 drivers/gpu/nova-core/gsp/hal/ga102.rs             |   14 +
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |  122 ++++----
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |  390 +++++++++++++---=
----------
 drivers/gpu/nova-core/gsp/regs.rs                  |   22 ++
 drivers/gpu/nova-core/gsp/sequencer.rs             |  112 ++++----
 drivers/gpu/nova-core/mctp.rs                      |   88 +++---
 drivers/gpu/nova-core/nova_core.rs                 |    6 +-
 drivers/gpu/nova-core/nova_core_exports.c          |   15 +
 drivers/gpu/nova-core/regs.rs                      |  148 +---------
 drivers/gpu/nova-core/vbios.rs                     |   64 ++---
 drivers/gpu/nova-core/vgpu.rs                      |   91 ++++++
 drivers/gpu/nova-core/vgpu/hal.rs                  |   25 ++
 drivers/gpu/nova-core/vgpu/hal/gb202.rs            |   15 +
 drivers/gpu/nova-core/vgpu/hal/tu102.rs            |   15 +
 drivers/pci/iov.c                                  |    2 +-
 drivers/pwm/pwm_th1520.rs                          |    7 +-
 include/linux/pci.h                                |    4 +-
 rust/helpers/io.c                                  |   13 +
 rust/helpers/pci.c                                 |    8 +
 rust/kernel/alloc/kvec.rs                          |   27 ++
 rust/kernel/devres.rs                              |   24 +-
 rust/kernel/dma.rs                                 |  333 ++++++++++++----=
------
 rust/kernel/drm/device.rs                          |  291 +++++++++++++---=
---
 rust/kernel/drm/driver.rs                          |  113 +++++---
 rust/kernel/drm/gem/mod.rs                         |  103 ++++---
 rust/kernel/drm/gem/shmem.rs                       |  594 ++++++++++++++++=
+++++++++++++++++++----
 rust/kernel/drm/gpuvm/mod.rs                       |   36 ++-
 rust/kernel/drm/gpuvm/sm_ops.rs                    |    4 +-
 rust/kernel/drm/gpuvm/va.rs                        |    8 +
 rust/kernel/drm/gpuvm/vm_bo.rs                     |    9 +
 rust/kernel/drm/ioctl.rs                           |   56 +++-
 rust/kernel/drm/mod.rs                             |    4 +-
 rust/kernel/faux.rs                                |   81 +++++-
 rust/kernel/firmware.rs                            |   46 +++-
 rust/kernel/io.rs                                  | 1502 ++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------=
--------
 rust/kernel/io/mem.rs                              |   29 +-
 rust/kernel/io/poll.rs                             |    6 +-
 rust/kernel/io/register.rs                         |   44 +--
 rust/kernel/iommu/pgtable.rs                       |   32 +--
 rust/kernel/lib.rs                                 |    3 +
 rust/kernel/pci.rs                                 |   14 +-
 rust/kernel/pci/io.rs                              |  168 ++++++-----
 rust/kernel/ptr.rs                                 |   12 +
 samples/rust/rust_dma.rs                           |   12 +-
 samples/rust/rust_driver_faux.rs                   |    3 +-
 107 files changed, 8794 insertions(+), 3475 deletions(-)
 create mode 100644 Documentation/gpu/nova/core/fsp.rst
 create mode 100644 Documentation/gpu/nova/core/tlv.rst
 create mode 100644 drivers/gpu/drm/tyr/fw.rs
 create mode 100644 drivers/gpu/drm/tyr/fw/parser.rs
 create mode 100644 drivers/gpu/drm/tyr/mmu.rs
 create mode 100644 drivers/gpu/drm/tyr/mmu/address_space.rs
 create mode 100644 drivers/gpu/drm/tyr/slot.rs
 create mode 100644 drivers/gpu/drm/tyr/vm.rs
 create mode 100644 drivers/gpu/nova-core/.gitignore
 delete mode 100644 drivers/gpu/nova-core/bitfield.rs
 create mode 100644 drivers/gpu/nova-core/fb/regs.rs
 create mode 100644 drivers/gpu/nova-core/firmware/tlv.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal/ga102.rs
 create mode 100644 drivers/gpu/nova-core/gsp/regs.rs
 create mode 100644 drivers/gpu/nova-core/nova_core_exports.c
 create mode 100644 drivers/gpu/nova-core/vgpu.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/hal.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/hal/gb202.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/hal/tu102.rs
