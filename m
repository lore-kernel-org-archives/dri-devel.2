Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE1CCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DF211297F;
	Thu,  4 Jun 2026 19:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hk1h3nwh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F74112984
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:25:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4ACD60052;
 Thu,  4 Jun 2026 19:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE991F00893;
 Thu,  4 Jun 2026 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780601126;
 bh=XuRt05ql2fEOSmCRNGF9Qz4vXAYJJhLjReGRhqF3JXg=;
 h=Date:Subject:Cc:To:From;
 b=Hk1h3nwhYBUgsSp2ez/I0SZau8OlHTJUGvkUAiPVe7OVN9edU2jVOWGS6HQXhIBKS
 ED1l6+Jb4N0UoZN9vBnbWL+J/cO4rVDO0WD8h5hn83wg1bbMRSCQayrBH6daad6TAk
 N6k07FfkN8PNNaz35y2C376EyVXPxppQ4N2IxWT1p6JAwAFBpXTACgxKwjl1hppxLm
 Jl+Earfcfy4nKcPwqK1h+TmIkWMopAJT9RrTmoyu364PkxbBkkgDf39O0nNh/zhpQM
 XYV1aFWnaQCwFCDCZBs9ClK8HQ+QryxvLHzQ6Z2X6BhbcmemioNi1LPNPKQo+dA8V9
 kHP4+hch+V/pg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 21:25:22 +0200
Message-Id: <DJ0IF39U9ETK.PCCUO7ZEQ4S0@kernel.org>
Subject: [GIT PULL] DRM Rust changes for v7.2-rc1
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
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

The highlights are a GPUVM immediate mode abstraction and DRM device specif=
ic
DeviceContext type state on the DRM side; Hopper/Blackwell enablement, prop=
er
driver unload, GA100 support, and VBIOS hardening on the nova-core side; an=
d
typed register definitions for Tyr.

There is one external dependency: a shared signed tag from the driver-core =
tree
for Higher-Ranked Lifetime Types (HRT). Nova depends on HRT for its device
resource handling, and Tyr also adopts it in this cycle.

(I plan to send an early driver-core PR to Linus for this cycle.)

- Danilo

The following changes since commit bed29492d413349e5b13f21936655064cdb63c91=
:

  Merge v7.1-rc5 into drm-next (2026-05-28 09:58:36 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/rust/kernel.git tags/drm-rust-next-202=
6-06-04

for you to fetch changes up to 99676aed1fec109d62822e21a06760eb098dc5f4:

  gpu: nova-core: move lifetime to `Bar0` (2026-06-03 22:10:51 +0200)

----------------------------------------------------------------
DRM Rust changes for v7.2-rc1

- Driver Core (shared via signed tag dd-lifetimes-7.2-rc1):

  - Introduce Higher-Ranked Lifetime Types (HRT) for Rust device
    drivers, allowing driver structs to hold device resources like
    pci::Bar and IoMem directly with a lifetime tied to the binding
    scope, removing the need for Devres indirection and ARef<Device>.

  - Replace drvdata() with scoped registration data on the auxiliary
    bus, using the new ForLt trait to thread lifetimes through
    registrations. Remove drvdata() and driver_type.

- DRM:

  - Add GPUVM immediate mode abstraction for Rust GPU drivers:
    - In immediate mode, GPU virtual address space state is updated
      during job execution (in the DMA fence signalling critical path),
      keeping the GPUVM and the GPU's address space always in sync.

    - Provide GpuVm, GpuVa, and GpuVmBo types for managing address
      spaces, virtual mappings, and GEM object backing respectively.

    - Provide split-merge map/unmap operations that handle partial
      overlaps with existing mappings.

    - drm_exec integration for dma_resv locking and GEM object
      validation based on the external/evicted object lists are not
      yet covered and planned as follow-up work.

  - Introduce DeviceContext type state for drm::Device, allowing
    drivers to restrict operations to contexts where the device is
    guaranteed to be registered (or not yet registered) with userspace.

  - Add FEAT_RENDER flag to the Driver trait for render node support.

- Nova:

  - Hopper/Blackwell enablement:
    - Add GPU identification and architecture-based HAL selection for
      Hopper (GH100) and Blackwell (GB100, GB202).

    - Implement the FSP (Foundation Security Processor) boot path used by
      Hopper and Blackwell, including FSP falcon engine support, EMEM
      operations, MCTP/NVDM message infrastructure, and FSP Chain of
      Trust boot with GSP lockdown release.

    - Add support for 32-bit firmware images and auto-detection of
      firmware image format.

    - Add architecture-specific framebuffer, sysmem flush, PCI config
      mirror, DMA mask, and WPR/non-WPR heap sizing.

  - GSP boot and unload:
    - Refactor the GSP boot process into a chipset-specific HAL,
      keeping the SEC2 and FSP boot paths separated cleanly.

    - Implement proper driver unload: send UNLOADING_GUEST_DRIVER
      command, run Booter Unloader and FWSEC-SB upon unbinding, and run
      the unload bundle on Gsp::boot() failure. This removes the need
      for a manual GPU reset between driver unbind and re-probe.

  - GA100 support:
    - Add support for the GA100 GPU, including IFR header detection and
      skipping, correct fwsignature selection, conditional FRTS boot,
      and documentation of the IFR header layout.

  - VBIOS hardening and refactoring:
    - Harden VBIOS parsing with checked arithmetic, bounds-checked
      accesses, and FromBytes-based structure reads throughout the FWSEC
      and Falcon data paths. Simplify the overall VBIOS module
      structure.

  - HRT adoption:
    - Use lifetime-parameterized pci::Bar directly, replacing the
      Arc<Devres<Bar0>> indirection. Replace ARef<Device> with &'bound
      Device in SysmemFlush and the GSP sequencer. Separate the driver
      type from driver data.

  - Misc:
    - Rename module names to kebab-case (nova-drm, nova-core).

    - Require little-endian in Kconfig, making the existing assumption
      explicit.

- Tyr:

  - Define comprehensive typed register blocks for GPU_CONTROL,
    JOB_CONTROL, MMU_CONTROL (including per-address-space registers),
    and DOORBELL_BLOCK using the kernel register!() macro. This replaces
    manual bit manipulation with typed register and field accessors.

  - Add shmem-backed GEM objects and set DMA mask based on GPU physical
    address width.

  - Adopt HRT: separate driver type from driver data, and use IoMem
    directly instead of Devres for register access during probe.

  - Move clock cleanup into a Drop implementation.

----------------------------------------------------------------
Alexandre Courbot (8):
      gpu: nova-core: remove unneeded get_gsp_info proxy function
      gpu: nova-core: do not import firmware commands into GSP command modu=
le
      gpu: nova-core: gsp: shuffle boot code a bit to keep chipset-specific=
 parts close
      gpu: nova-core: gsp: move chipset-specific parts of the boot process =
into a HAL
      gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloadin=
g
      gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding
      gpu: nova-core: gsp: run the unload bundle if Gsp::boot() fails
      gpu: nova-core: gsp: enable FSP boot path

Alice Ryhl (6):
      drm/gpuvm: take refcount on DRM device
      rust: gpuvm: add GpuVm::obtain()
      rust: gpuvm: add GpuVa struct
      rust: gpuvm: add GpuVmCore::sm_unmap()
      rust: gpuvm: add GpuVmCore::sm_map()
      drm/gpuvm: rust: add RUST_DRM_GPUVM option to Kconfig

Alvin Sun (1):
      drm/tyr: use shmem GEM object type in TyrDrmDriver

Asahi Lina (1):
      rust: drm: add base GPUVM immediate mode abstraction

Beata Michalska (1):
      drm/tyr: set DMA mask using GPU physical address

Boris Brezillon (1):
      drm/tyr: rename TyrObject to BoData

Cheng-Yang Chou (2):
      gpu: nova, nova-core: Rename to kebab-case
      gpu: nova: Use module names consistently

Daniel Almeida (1):
      drm/tyr: Use register! macro for GPU_CONTROL

Danilo Krummrich (33):
      rust: alloc: add Box::zeroed()
      rust: auxiliary: add registration data to auxiliary devices
      rust: driver core: remove drvdata() and driver_type
      rust: pci: use 'static lifetime for PCI BAR resource names
      rust: driver: decouple driver private data from driver type
      rust: driver core: drop drvdata before devres release
      rust: pci: implement Sync for Device<Bound>
      rust: platform: implement Sync for Device<Bound>
      rust: auxiliary: implement Sync for Device<Bound>
      rust: usb: implement Sync for Device<Bound>
      rust: device: implement Sync for Device<Bound>
      rust: device: make Core and CoreInternal lifetime-parameterized
      rust: pci: make Driver trait lifetime-parameterized
      rust: platform: make Driver trait lifetime-parameterized
      rust: auxiliary: make Driver trait lifetime-parameterized
      rust: usb: make Driver trait lifetime-parameterized
      rust: i2c: make Driver trait lifetime-parameterized
      rust: driver: update module documentation for GAT-based Data type
      rust: pci: make Bar lifetime-parameterized
      rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
      samples: rust: rust_driver_pci: use HRT lifetime for Bar
      gpu: nova-core: separate driver type from driver data
      rust: auxiliary: generalize Registration over ForLt
      samples: rust: rust_driver_auxiliary: showcase lifetime-bound registr=
ation data
      Merge remote-tracking branch 'drm/drm-next' into drm-rust-next
      Merge tag 'dd-lifetimes-7.2-rc1' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/driver-core/driver-core into drm-rust-next
      gpu: nova-core: use lifetime for Bar
      gpu: nova-core: unregister sysmem flush page from Drop
      gpu: nova-core: replace ARef<Device> with &'bound Device in SysmemFlu=
sh
      gpu: nova-core: gsp: replace ARef<Device> with &'a Device in sequence=
r
      gpu: nova: separate driver type from driver data
      drm/tyr: separate driver type from driver data
      drm/tyr: use IoMem directly instead of Devres

Deborah Brouwer (7):
      drm/tyr: Print GPU_ID without filtering
      drm/tyr: Use register! macro for JOB_CONTROL
      drm/tyr: Use register! macro for MMU_CONTROL
      drm/tyr: Remove custom register struct
      drm/tyr: Add DOORBELL_BLOCK registers
      drm/tyr: move clock cleanup into Clocks Drop impl
      drm/tyr: add shmem backing for GEM objects

Eliot Courtney (25):
      gpu: nova-core: simplify and_then with condition to filter
      gpu: nova: require little endian
      gpu: nova-core: vbios: stop scanning at BIOS_MAX_SCAN_LEN
      gpu: nova-core: vbios: use checked arithmetic for bios image range en=
d
      gpu: nova-core: vbios: avoid reading too far in read_more_at_offset
      gpu: nova-core: vbios: read BitToken using FromBytes
      gpu: nova-core: vbios: use checked ops and accesses in `FwSecBiosImag=
e::ucode`
      gpu: nova-core: vbios: use checked access in `FwSecBiosImage::header`
      gpu: nova-core: vbios: use checked accesses in `setup_falcon_data`
      gpu: nova-core: vbios: drop unused falcon_data_offset from FwSecBiosB=
uilder
      gpu: nova-core: vbios: keep PmuLookupTable local in setup_falcon_data
      gpu: nova-core: vbios: compute FWSEC-relative Falcon data offset
      gpu: nova-core: vbios: simplify setup_falcon_data
      gpu: nova-core: vbios: read PMU lookup entries using FromBytes
      gpu: nova-core: vbios: store PMU lookup entries in a KVVec
      gpu: nova-core: vbios: construct `FwSecBiosImage` directly from BIOS =
images
      gpu: nova-core: vbios: use the first PCI-AT image
      gpu: nova-core: vbios: use single logical block for the FWSEC section
      gpu: nova-core: vbios: use let-else in Vbios::new
      gpu: nova-core: vbios: remove unnecessary fields in PciRomHeader
      gpu: nova-core: vbios: drop unused image wrappers
      gpu: nova-core: vbios: drop redundant TryFrom import
      gpu: nova-core: vbios: move constants and functions to be associated
      gpu: nova-core: vbios: remove unused rom_header field
      gpu: nova-core: add non-sec2 unload path

Gary Guo (4):
      rust: alloc: remove `'static` bound on `ForeignOwnable`
      rust: driver: move 'static bounds to constructor
      rust: types: add `ForLt` trait for higher-ranked lifetime support
      gpu: nova-core: move lifetime to `Bar0`

John Hubbard (29):
      gpu: nova-core: use SizeConstants trait for u64 size constants
      gpu: nova-core: make WPR heap sizing fallible
      gpu: nova-core: factor .fwsignature* selection into a new find_gsp_si=
gs_section()
      gpu: nova-core: use GPU Architecture to simplify HAL selections
      gpu: nova-core: Hopper/Blackwell: basic GPU identification
      gpu: nova-core: add Copy/Clone to Spec and Revision
      gpu: nova-core: move GFW boot wait into a GPU HAL
      gpu: nova-core: Hopper/Blackwell: skip GFW boot waiting
      gpu: nova-core: refactor SEC2 booter loading into BooterFirmware::run=
()
      gpu: nova-core: set DMA mask width based on GPU architecture
      gpu: nova-core: Hopper/Blackwell: new location for PCI config mirror
      gpu: nova-core: Blackwell: compute PMU-reserved framebuffer size
      gpu: nova-core: Hopper/Blackwell: larger non-WPR heap
      gpu: nova-core: Hopper/Blackwell: larger WPR2 (GSP) heap
      gpu: nova-core: Blackwell: use correct sysmem flush registers
      gpu: nova-core: don't assume 64-bit firmware images
      gpu: nova-core: add support for 32-bit firmware images
      gpu: nova-core: add auto-detection of 32-bit, 64-bit firmware images
      gpu: nova-core: Hopper/Blackwell: add FSP falcon engine stub
      gpu: nova-core: Hopper/Blackwell: add FMC firmware image
      gpu: nova-core: Hopper/Blackwell: add FSP secure boot completion wait=
ing
      gpu: nova-core: Hopper/Blackwell: add FMC signature extraction
      gpu: nova-core: Hopper/Blackwell: add FSP falcon EMEM operations
      gpu: nova-core: Hopper/Blackwell: add FSP message infrastructure
      gpu: nova-core: add MCTP/NVDM protocol types for firmware communicati=
on
      gpu: nova-core: Hopper/Blackwell: add FSP send/receive messaging
      gpu: nova-core: Hopper/Blackwell: select FSP Chain of Trust version
      gpu: nova-core: Hopper/Blackwell: add FSP Chain of Trust boot
      gpu: nova-core: Hopper/Blackwell: add GSP lockdown release polling

Laura Nao (1):
      rust: drm: add FEAT_RENDER flag for render node support

Lyude Paul (5):
      rust: drm: gem: s/device::Device/Device/ for shmem.rs
      drm/gem/shmem: Introduce __drm_gem_shmem_free_sgt_locked()
      rust/drm: Introduce DeviceContext
      rust/drm/gem: Add DriverAllocImpl type alias
      rust/drm/gem: Use DeviceContext with GEM objects

Timur Tabi (8):
      gpu: nova-core: program_brom cannot fail
      Documentation: gpu: nova: document the IFR header layout
      gpu: nova-core: use correct fwsignature for GA100
      gpu: nova-core: do not consider 0xBB77 as a valid PCI ROM header sign=
ature
      gpu: nova-core: only boot FRTS if its region is allocated
      gpu: nova-core: add FbHal::frts_size() for GA100 support
      gpu: nova-core: skip the IFR header if present
      gpu: nova-core: enable GA100

 Documentation/gpu/nova/core/vbios.rst              |   65 +++-
 MAINTAINERS                                        |    2 +
 drivers/base/base.h                                |   16 -
 drivers/base/dd.c                                  |    2 +-
 drivers/cpufreq/rcpufreq_dt.rs                     |    9 +-
 drivers/gpu/drm/Kconfig                            |    7 +
 drivers/gpu/drm/drm_gem_shmem_helper.c             |   32 +-
 drivers/gpu/drm/drm_gpuvm.c                        |    6 +-
 drivers/gpu/drm/nova/Kconfig                       |    3 +-
 drivers/gpu/drm/nova/Makefile                      |    3 +-
 drivers/gpu/drm/nova/driver.rs                     |   28 +-
 drivers/gpu/drm/nova/gem.rs                        |   15 +-
 drivers/gpu/drm/nova/nova.rs                       |    2 +-
 drivers/gpu/drm/tyr/Kconfig                        |    1 +
 drivers/gpu/drm/tyr/driver.rs                      |   91 +++---
 drivers/gpu/drm/tyr/gem.rs                         |   33 +-
 drivers/gpu/drm/tyr/gpu.rs                         |  180 ++++-------
 drivers/gpu/drm/tyr/regs.rs                        | 1745 ++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++------
 drivers/gpu/drm/tyr/tyr.rs                         |    4 +-
 drivers/gpu/nova-core/Kconfig                      |    3 +-
 drivers/gpu/nova-core/Makefile                     |    3 +-
 drivers/gpu/nova-core/driver.rs                    |   75 ++---
 drivers/gpu/nova-core/falcon.rs                    |   49 +--
 drivers/gpu/nova-core/falcon/fsp.rs                |  171 ++++++++++
 drivers/gpu/nova-core/falcon/gsp.rs                |   23 +-
 drivers/gpu/nova-core/falcon/hal.rs                |   34 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |   22 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   14 +-
 drivers/gpu/nova-core/fb.rs                        |   66 ++--
 drivers/gpu/nova-core/fb/hal.rs                    |   41 ++-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |   29 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |   23 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  122 +++++++
 drivers/gpu/nova-core/fb/hal/gb202.rs              |   95 ++++++
 drivers/gpu/nova-core/fb/hal/gh100.rs              |   50 +++
 drivers/gpu/nova-core/fb/hal/tu102.rs              |   44 ++-
 drivers/gpu/nova-core/firmware.rs                  |  197 ++++++++++--
 drivers/gpu/nova-core/firmware/booter.rs           |   34 +-
 drivers/gpu/nova-core/firmware/fsp.rs              |  128 ++++++++
 drivers/gpu/nova-core/firmware/fwsec.rs            |    5 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |    2 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |   34 +-
 drivers/gpu/nova-core/fsp.rs                       |  320 ++++++++++++++++=
++
 drivers/gpu/nova-core/fsp/hal.rs                   |   32 ++
 drivers/gpu/nova-core/fsp/hal/gb100.rs             |   23 ++
 drivers/gpu/nova-core/fsp/hal/gb202.rs             |   27 ++
 drivers/gpu/nova-core/fsp/hal/gh100.rs             |   32 ++
 drivers/gpu/nova-core/gfw.rs                       |   76 -----
 drivers/gpu/nova-core/gpu.rs                       |  119 +++++--
 drivers/gpu/nova-core/gpu/hal.rs                   |   39 +++
 drivers/gpu/nova-core/gpu/hal/gh100.rs             |   34 ++
 drivers/gpu/nova-core/gpu/hal/tu102.rs             |  100 ++++++
 drivers/gpu/nova-core/gsp.rs                       |    5 +
 drivers/gpu/nova-core/gsp/boot.rs                  |  300 +++++++++-------=
-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   10 +-
 drivers/gpu/nova-core/gsp/commands.rs              |   78 +++--
 drivers/gpu/nova-core/gsp/fw.rs                    |  121 +++++--
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   60 +++-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs  |   94 ++++++
 drivers/gpu/nova-core/gsp/hal.rs                   |   94 ++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |  192 +++++++++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |  349 ++++++++++++++++=
++++
 drivers/gpu/nova-core/gsp/sequencer.rs             |   15 +-
 drivers/gpu/nova-core/mctp.rs                      |   88 +++++
 drivers/gpu/nova-core/nova_core.rs                 |    9 +-
 drivers/gpu/nova-core/regs.rs                      |  136 +++++++-
 drivers/gpu/nova-core/vbios.rs                     |  632 ++++++++++++++++=
--------------------
 drivers/pwm/pwm_th1520.rs                          |   13 +-
 include/drm/drm_gem_shmem_helper.h                 |    1 +
 include/linux/auxiliary_bus.h                      |    4 +
 include/linux/device/driver.h                      |    4 +-
 rust/Makefile                                      |    1 +
 rust/bindings/bindings_helper.h                    |    1 +
 rust/helpers/drm_gpuvm.c                           |   26 ++
 rust/helpers/helpers.c                             |    1 +
 rust/kernel/alloc/kbox.rs                          |   46 ++-
 rust/kernel/auxiliary.rs                           |  285 ++++++++++++----=
-
 rust/kernel/cpufreq.rs                             |    9 +-
 rust/kernel/device.rs                              |  121 +++----
 rust/kernel/devres.rs                              |    2 +-
 rust/kernel/dma.rs                                 |    2 +-
 rust/kernel/driver.rs                              |   41 ++-
 rust/kernel/drm/device.rs                          |  252 +++++++++++----
 rust/kernel/drm/driver.rs                          |   49 ++-
 rust/kernel/drm/gem/mod.rs                         |   72 +++--
 rust/kernel/drm/gem/shmem.rs                       |   61 ++--
 rust/kernel/drm/gpuvm/mod.rs                       |  328 ++++++++++++++++=
+++
 rust/kernel/drm/gpuvm/sm_ops.rs                    |  429 ++++++++++++++++=
+++++++++
 rust/kernel/drm/gpuvm/va.rs                        |  168 ++++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs                     |  249 ++++++++++++++
 rust/kernel/drm/mod.rs                             |    5 +
 rust/kernel/i2c.rs                                 |   61 ++--
 rust/kernel/io/mem.rs                              |  121 +++----
 rust/kernel/pci.rs                                 |   51 +--
 rust/kernel/pci/id.rs                              |    2 +-
 rust/kernel/pci/io.rs                              |   54 ++--
 rust/kernel/platform.rs                            |   52 +--
 rust/kernel/types.rs                               |   12 +-
 rust/kernel/types/for_lt.rs                        |  122 +++++++
 rust/kernel/usb.rs                                 |   57 ++--
 rust/macros/for_lt.rs                              |  248 ++++++++++++++
 rust/macros/lib.rs                                 |   13 +
 samples/rust/rust_debugfs.rs                       |   11 +-
 samples/rust/rust_dma.rs                           |    6 +-
 samples/rust/rust_driver_auxiliary.rs              |   79 +++--
 samples/rust/rust_driver_i2c.rs                    |   13 +-
 samples/rust/rust_driver_pci.rs                    |   90 +++---
 samples/rust/rust_driver_platform.rs               |    9 +-
 samples/rust/rust_driver_usb.rs                    |   15 +-
 samples/rust/rust_i2c_client.rs                    |   14 +-
 samples/rust/rust_soc.rs                           |    9 +-
 111 files changed, 7909 insertions(+), 1793 deletions(-)
 create mode 100644 drivers/gpu/nova-core/falcon/fsp.rs
 create mode 100644 drivers/gpu/nova-core/fb/hal/gb100.rs
 create mode 100644 drivers/gpu/nova-core/fb/hal/gb202.rs
 create mode 100644 drivers/gpu/nova-core/fb/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/firmware/fsp.rs
 create mode 100644 drivers/gpu/nova-core/fsp.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal/gb100.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal/gb202.rs
 create mode 100644 drivers/gpu/nova-core/fsp/hal/gh100.rs
 delete mode 100644 drivers/gpu/nova-core/gfw.rs
 create mode 100644 drivers/gpu/nova-core/gpu/hal.rs
 create mode 100644 drivers/gpu/nova-core/gpu/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/gpu/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal/gh100.rs
 create mode 100644 drivers/gpu/nova-core/gsp/hal/tu102.rs
 create mode 100644 drivers/gpu/nova-core/mctp.rs
 create mode 100644 rust/helpers/drm_gpuvm.c
 create mode 100644 rust/kernel/drm/gpuvm/mod.rs
 create mode 100644 rust/kernel/drm/gpuvm/sm_ops.rs
 create mode 100644 rust/kernel/drm/gpuvm/va.rs
 create mode 100644 rust/kernel/drm/gpuvm/vm_bo.rs
 create mode 100644 rust/kernel/types/for_lt.rs
 create mode 100644 rust/macros/for_lt.rs
