Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC792C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 23:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB7E10E167;
	Thu, 16 Jul 2026 23:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Y+Olfq9d";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AF510E167
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 23:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784244301; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KE9AX3R+PTxki3oWYrfntP4xlKmT5D8+I3D1+1Z3Jk1ny+ajYxg5AYR2PL82+BLhunpP2R8h2hcsxheWKslIX92NrN/VgBuCX63Y1PTEV8DWkHb4soDMl6ftWHcqj9osnXg3Cfrg7mEbvS2aSwBk3Lsu9lEyggsObyWksPco8C8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784244301;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DvBvySc1rQpq2lAiotdWjXLeccea/ywgANh2LzDlO5E=; 
 b=YCkQaOGI3dlTOaFyzH5k8oxN2G4gp6RXNbHbXd2VBWJa3kb7US0kmuNTuO7cQHeyq8w/Sz9pt4RwndYaHpNL6gfCc+sSbiv0MmcGem8s42Dt7vP2cEG5n517tSzCz6H+sBfkn9f2EtqLnwgQD1whFSxqjYRsmafGB6Uo6rm2zcM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784244301; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=DvBvySc1rQpq2lAiotdWjXLeccea/ywgANh2LzDlO5E=;
 b=Y+Olfq9dZIWG4m9x7kWh650bd3AJXJXn4PB4LgblX2dNc2jqQYsWsoDzuKnUOWhR
 j6LNXd2DqUaMJafSFFNyh5vVD6phxzmzMNyiEIvgSARaEBMpCSq4Ag42Y82qkS3dgIN
 MyvGsLmJ8JpZT0aoTr7opDuCiceD0ICdI2goqon8=
Received: by mx.zohomail.com with SMTPS id 1784244299252370.26915127919085;
 Thu, 16 Jul 2026 16:24:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 3/7] drm/tyr: add Memory Management Unit (MMU) support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260709-fw-boot-b4-v6-3-ca391e1a4108@collabora.com>
Date: Thu, 16 Jul 2026 20:24:41 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 samitolvanen@google.com, acourbot@nvidia.com, alvin.sun@linux.dev,
 laura.nao@collabora.com, work@onurozkan.dev, beata.michalska@arm.com,
 steven.price@arm.com, lyude@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE2B96EF-5FDF-4215-85C1-2F94EE3BFD06@collabora.com>
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
 <20260709-fw-boot-b4-v6-3-ca391e1a4108@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 9 Jul 2026, at 18:36, Deborah Brouwer =
<deborah.brouwer@collabora.com> wrote:
>=20
> From: Boris Brezillon <boris.brezillon@collabora.com>
>=20
> Add Memory Management Unit (MMU) support in Tyr. The MMU module wraps =
a
> SlotManager instance to allocate MMU address-space slots for use by
> virtual memory (VM) address spaces. The MMU's SlotManager uses an
> AddressSpaceManager to handle the hardware-specific callbacks. For
> example, the AddressSpaceManager activates and evicts VMs from slots =
by
> writing commands to the MMU registers.
>=20
> Add an implementation block for the MMU's MEMATTR register to provide
> a method for translating the Memory Attribute Indirection Register =
(MAIR)
> format from the pagetable configuration to a format understood by the =
MMU.
>=20
> Create an mmu instance during probe, it will be used by subsequent =
patches
> in this series.
>=20
> Wrap the iomem stored in TyrDrmRegistrationData in an Arc. The iomem
> is stored in the mmu through its AddressSpaceManager. In anticipation
> of the iomem also being stored in the firmware object, set up shared
> ownership of the iomem now.
>=20
> Update Kconfig to add the new MMU and IOMMU dependencies required
> by this MMU module.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/Kconfig              |   3 +
> drivers/gpu/drm/tyr/driver.rs            |  13 +-
> drivers/gpu/drm/tyr/mmu.rs               | 103 +++++++
> drivers/gpu/drm/tyr/mmu/address_space.rs | 484 =
+++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/regs.rs              | 121 ++++++++
> drivers/gpu/drm/tyr/tyr.rs               |   1 +
> 6 files changed, 722 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
> index 51a68ef8212c..61a2fd6f961a 100644
> --- a/drivers/gpu/drm/tyr/Kconfig
> +++ b/drivers/gpu/drm/tyr/Kconfig
> @@ -5,9 +5,12 @@ config DRM_TYR
> depends on DRM=3Dy
> depends on RUST
> depends on ARM || ARM64 || COMPILE_TEST
> + depends on MMU
> depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
> depends on COMMON_CLK
> + depends on IOMMU_SUPPORT
> default n
> + select IOMMU_IO_PGTABLE_LPAE
> select RUST_DRM_GEM_SHMEM_HELPER
> help
>  Rust DRM driver for ARM Mali CSF-based GPUs.
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index 46ce5c41e310..74b55a389754 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -28,7 +28,10 @@
>     regulator,
>     regulator::Regulator,
>     sizes::SZ_2M,
> -    sync::Mutex,
> +    sync::{
> +        Arc,
> +        Mutex, //
> +    },
>     time, //
> };
>=20
> @@ -37,6 +40,7 @@
>     gem::BoData,
>     gpu,
>     gpu::GpuInfo,
> +    mmu::Mmu,
>     regs::gpu_control::*, //
> };
>=20
> @@ -70,7 +74,7 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
>     regulators: Mutex<Regulators>,
>=20
>     /// GPU MMIO register mapping.
> -    pub(crate) iomem: IoMem<'bound>,
> +    pub(crate) iomem: Arc<IoMem<'bound>>,
>=20
>     /// GPU information read from hardware during probe.
>     pub(crate) gpu_info: GpuInfo,
> @@ -121,7 +125,8 @@ fn probe<'bound>(
>         let sram_regulator =3D =
Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
>=20
>         let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;
> -        let iomem =3D request.iomap_sized::<SZ_2M>()?;
> +
> +        let iomem =3D Arc::new(request.iomap_sized::<SZ_2M>()?, =
GFP_KERNEL)?;
>=20
>         issue_soft_reset(pdev.as_ref(), &iomem)?;
>         gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> @@ -139,6 +144,8 @@ fn probe<'bound>(
>=20
>         let unreg_dev =3D =
drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
>=20
> +        let _mmu =3D Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
> +
>         let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
>                 pdev,
>                 clks <- new_mutex!(Clocks {
> diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
> new file mode 100644
> index 000000000000..c0341557d730
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/mmu.rs
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Memory Management Unit (MMU) module.
> +//!
> +//! The GPU MMU provides a limited number of memory address spaces =
for use by command streams.
> +//! The MMU translates virtual addresses to physical addresses and =
manages memory configuration
> +//! and access permissions.
> +//!
> +//! This MMU module is essentially a locked wrapper around a =
[`SlotManager`] instance.
> +//! The [`SlotManager`] manages the assignment of virtual address =
spaces to hardware address-space
> +//! (AS) slots. MMU commands such as updates and flushes are carried =
out by the
> +//! [`AddressSpaceManager`] which actually writes to the MMU =
registers.
> +#![allow(dead_code)]
> +
> +use core::ops::Range;
> +
> +use kernel::{
> +    new_mutex,
> +    prelude::*,
> +    sync::{
> +        Arc,
> +        ArcBorrow,
> +        Mutex, //
> +    }, //
> +};
> +
> +use crate::{
> +    driver::IoMem,
> +    gpu::GpuInfo,
> +    mmu::address_space::{
> +        AddressSpaceManager,
> +        VmAsData, //
> +    },
> +    regs::{
> +        gpu_control::AS_PRESENT,
> +        MAX_AS, //
> +    },
> +    slot::SlotManager, //
> +};
> +
> +pub(crate) mod address_space;
> +
> +pub(crate) type AsSlotManager<'bound> =3D =
SlotManager<AddressSpaceManager<'bound>, MAX_AS>;
> +
> +/// Locked wrapper for carrying out virtual memory (VM) operations on =
the MMU.
> +#[pin_data]
> +pub(crate) struct Mmu<'bound> {
> +    /// Slot Manager instance used to allocate hardware slots and =
write to MMU registers.
> +    #[pin]
> +    pub(crate) as_manager: Mutex<AsSlotManager<'bound>>,
> +}
> +
> +impl<'bound> Mmu<'bound> {
> +    /// Create an MMU component for this device.
> +    pub(crate) fn new(
> +        iomem: ArcBorrow<'_, IoMem<'bound>>,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<Arc<Mmu<'bound>>> {
> +        let present =3D =
AS_PRESENT::from_raw(gpu_info.as_present).present().get();
> +        let slot_count =3D present.count_ones().try_into()?;
> +
> +        let as_manager =3D AddressSpaceManager::new(iomem.into(), =
present)?;
> +        let mmu_init =3D try_pin_init!(Self{
> +            as_manager <- new_mutex!(SlotManager::new(as_manager, =
slot_count)?),
> +        });
> +        Arc::pin_init(mmu_init, GFP_KERNEL)
> +    }
> +
> +    /// Assign a VM to an AS slot, provide a translation table,
> +    /// and update the MMU to make the VM resident.
> +    pub(crate) fn activate_vm(&self, vm: ArcBorrow<'_, =
VmAsData<'bound>>) -> Result {
> +        self.as_manager.lock().activate_vm(vm)
> +    }
> +
> +    /// Evict a VM from its AS slot and flush the MMU.
> +    pub(crate) fn deactivate_vm(&self, vm: &VmAsData<'bound>) -> =
Result {
> +        self.as_manager.lock().deactivate_vm(vm)
> +    }
> +
> +    /// Flush MMU translation caches after a VM update.
> +    pub(crate) fn flush_vm(&self, vm: &VmAsData<'bound>) -> Result {
> +        self.as_manager.lock().flush_vm(vm)
> +    }
> +
> +    /// Flags the start of a VM update.
> +    ///
> +    /// If the VM is resident, any GPU access on the memory range =
being
> +    /// updated will be blocked until `Mmu::end_vm_update()` is =
called.
> +    /// This guarantees the atomicity of a VM update.
> +    /// If the VM is not resident, this is a NOP.
> +    pub(crate) fn start_vm_update(&self, vm: &VmAsData<'bound>, =
region: &Range<u64>) -> Result {
> +        self.as_manager.lock().start_vm_update(vm, region)
> +    }
> +
> +    /// Flags the end of a VM update.
> +    ///
> +    /// If the VM is resident, this will let GPU accesses on the =
updated
> +    /// range go through, in case any of them were blocked.
> +    /// If the VM is not resident, this is a NOP.
> +    pub(crate) fn end_vm_update(&self, vm: &VmAsData<'bound>) -> =
Result {
> +        self.as_manager.lock().end_vm_update(vm)
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs =
b/drivers/gpu/drm/tyr/mmu/address_space.rs
> new file mode 100644
> index 000000000000..a97f44774576
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
> @@ -0,0 +1,484 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Address space module.
> +//!
> +//! This module handles the hardware interaction for MMU operations =
through
> +//! MMIO register access.
> +//!
> +
> +use core::ops::Range;
> +
> +use kernel::{
> +    device::{
> +        Bound,
> +        Device, //
> +    }, //
> +    error::Result,
> +    io::{
> +        poll,
> +        register::Array,
> +        Io, //
> +    },
> +    iommu::pgtable::{
> +        Config,
> +        IoPageTable,
> +        ARM64LPAES1, //
> +    },
> +    prelude::*,
> +    sizes::{
> +        SZ_2M,
> +        SZ_4K, //
> +    },
> +    sync::{
> +        Arc,
> +        ArcBorrow,
> +        LockedBy, //
> +    },
> +    time::Delta, //
> +};
> +
> +use crate::{
> +    driver::IoMem,
> +    mmu::{
> +        AsSlotManager,
> +        Mmu, //
> +    },
> +    regs::{
> +        mmu_control::mmu_as_control,
> +        mmu_control::mmu_as_control::*,
> +        MAX_AS, //
> +    },
> +    slot::{
> +        Seat,
> +        SlotOperations, //
> +    }, //
> +};
> +
> +/// Address space configuration values to be written to MMU =
registers.
> +#[derive(Clone, Copy)]
> +struct AddressSpaceConfig {
> +    /// Translation configuration. Configures how the MMU walks the =
page table for this
> +    /// address space.
> +    transcfg: u64,
> +
> +    /// Translation table base address. The address of the page =
table.
> +    transtab: u64,
> +
> +    /// Memory attributes such as cacheability.
> +    memattr: u64,
> +}
> +
> +/// Virtual memory (VM) address space data for use in MMU operations.
> +#[pin_data]
> +pub(crate) struct VmAsData<'bound> {
> +    /// The address space seat tracks this VM's binding to a hardware =
address space slot.
> +    /// Uses [`LockedBy`] to ensure safe concurrent access to the =
slot assignment state,
> +    /// protected by the [`AsSlotManager`] lock.
> +    as_seat: LockedBy<Seat, AsSlotManager<'bound>>,
> +
> +    /// Virtual address bits for this address space.
> +    va_bits: u8,
> +
> +    /// The page table which maps GPU virtual addresses to physical =
addresses for this VM.
> +    #[pin]
> +    pub(crate) page_table: IoPageTable<'bound, ARM64LPAES1>,
> +}
> +
> +impl<'bound> VmAsData<'bound> {
> +    /// Creates VM address space data by initializing all of its =
fields.
> +    pub(crate) fn new<'a>(
> +        mmu: &'a Mmu<'bound>,
> +        pdev: &'bound Device<Bound>,
> +        va_bits: u32,
> +        pa_bits: u32,
> +    ) -> impl pin_init::PinInit<VmAsData<'bound>, Error> + 'a {
> +        let pt_config =3D Config {
> +            quirks: 0,
> +            pgsize_bitmap: SZ_4K | SZ_2M,
> +            ias: va_bits,
> +            oas: pa_bits,
> +            coherent_walk: false,
> +        };
> +
> +        let page_table_init =3D IoPageTable::new(pdev, pt_config);
> +
> +        try_pin_init!(Self {
> +            as_seat: LockedBy::new(&mmu.as_manager, Seat::NoSeat),
> +            va_bits: va_bits as u8,
> +            page_table <- page_table_init,
> +        }? Error)
> +    }
> +
> +    /// Computes the hardware configuration for this address space.
> +    fn as_config(&self) -> Result<AddressSpaceConfig> {
> +        let pt =3D &self.page_table;
> +        // The hardware computes the valid input address range as:
> +        //   INA_BITS_VALID =3D min(HW_INA_BITS, 55 - INA_BITS)
> +        // To configure our desired va_bits, we solve for INA_BITS:
> +        //   INA_BITS =3D 55 - va_bits
> +        // This assumes HW_INA_BITS (hardware capability) >=3D =
va_bits.
> +        let ina_bits_field_value =3D 55 - self.va_bits;
> +        let ina_bits =3D match ina_bits_field_value {
> +            7 =3D> mmu_as_control::InaBits::Bits48,
> +            8 =3D> mmu_as_control::InaBits::Bits47,
> +            9 =3D> mmu_as_control::InaBits::Bits46,
> +            10 =3D> mmu_as_control::InaBits::Bits45,
> +            11 =3D> mmu_as_control::InaBits::Bits44,
> +            12 =3D> mmu_as_control::InaBits::Bits43,
> +            13 =3D> mmu_as_control::InaBits::Bits42,
> +            14 =3D> mmu_as_control::InaBits::Bits41,
> +            15 =3D> mmu_as_control::InaBits::Bits40,
> +            16 =3D> mmu_as_control::InaBits::Bits39,
> +            17 =3D> mmu_as_control::InaBits::Bits38,
> +            18 =3D> mmu_as_control::InaBits::Bits37,
> +            19 =3D> mmu_as_control::InaBits::Bits36,
> +            20 =3D> mmu_as_control::InaBits::Bits35,
> +            21 =3D> mmu_as_control::InaBits::Bits34,
> +            22 =3D> mmu_as_control::InaBits::Bits33,
> +            23 =3D> mmu_as_control::InaBits::Bits32,
> +            24 =3D> mmu_as_control::InaBits::Bits31,
> +            25 =3D> mmu_as_control::InaBits::Bits30,
> +            26 =3D> mmu_as_control::InaBits::Bits29,
> +            27 =3D> mmu_as_control::InaBits::Bits28,
> +            28 =3D> mmu_as_control::InaBits::Bits27,
> +            29 =3D> mmu_as_control::InaBits::Bits26,
> +            30 =3D> mmu_as_control::InaBits::Bits25,
> +            _ =3D> return Err(EINVAL),

Would this work?

let field =3D 55u64.checked_sub(self.va_bits.into()).ok_or(EINVAL)?;
let ina_bits =3D match =
InaBits::try_from(Bounded::try_new(field).ok_or(EINVAL)?)? {
    InaBits::Reset =3D> return Err(EINVAL),
    bits =3D> bits,
};



> +        };
> +
> +        let transcfg =3D mmu_as_control::TRANSCFG::zeroed()
> +            .with_ptw_memattr(mmu_as_control::PtwMemattr::WriteBack)
> +            .with_r_allocate(true)
> +            .with_mode(mmu_as_control::AddressSpaceMode::Aarch64_4K)
> +            .with_ina_bits(ina_bits)
> +            .into_raw();
> +
> +        Ok(AddressSpaceConfig {
> +            transcfg,
> +            // SAFETY: The caller must ensure that the address space =
is evicted
> +            // and cleaned up before the `VmAsData` is dropped.
> +            transtab: unsafe { pt.ttbr() },

We need to say why this is safe instead ^

> +            memattr: MEMATTR::from_mair(pt.mair()).into_raw(),
> +        })
> +    }
> +}
> +
> +/// Coordinates all hardware-level address space operations through =
MMIO register
> +/// operations including enabling, disabling, flushing, and updating =
address spaces.
> +pub(crate) struct AddressSpaceManager<'bound> {
> +    /// Memory-mapped I/O region for GPU register access.
> +    iomem: Arc<IoMem<'bound>>,
> +
> +    /// Bitmask of present address space slots from GPU_AS_PRESENT =
register.
> +    as_present: u32,

Throughout this whole patch, we treat AS=E2=80=99s as usize. I wonder if =
we would benefit
from using Bounded instead? This is a mere question.

> +}
> +
> +impl<'bound> AddressSpaceManager<'bound> {
> +    /// Creates a new address space manager.
> +    ///
> +    /// Initializes the manager with references to the platform =
device and
> +    /// I/O memory region, along with the bitmask of available AS =
slots.
> +    pub(super) fn new(
> +        iomem: Arc<IoMem<'bound>>,
> +        as_present: u32,
> +    ) -> Result<AddressSpaceManager<'bound>> {
> +        Ok(Self { iomem, as_present })
> +    }
> +
> +    /// Validates that an AS slot number is within range and present =
in hardware.
> +    ///
> +    /// Checks that the slot index is less than [`MAX_AS`] and that
> +    /// the corresponding bit is set in the `as_present` mask read =
from the GPU.
> +    ///
> +    /// Returns [`EINVAL`] if the slot is out of range or not present =
in hardware.
> +    fn validate_as_slot(&self, as_nr: usize) -> Result {
> +        if as_nr >=3D MAX_AS {
> +            pr_err!("AS slot {} out of valid range (max {})\n", =
as_nr, MAX_AS);
> +            return Err(EINVAL);

^ This comparison would come for free with Bounded

> +        }
> +
> +        if (self.as_present & (1 << as_nr)) =3D=3D 0 {

^ But not this one, as it=E2=80=99s a runtime check :/

> +            pr_err!(
> +                "AS slot {} not present in hardware =
(AS_PRESENT=3D{:#x})\n",
> +                as_nr,
> +                self.as_present
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(())
> +    }
> +
> +    /// Waits for an AS slot to become ready (not active).
> +    ///
> +    /// Returns an error if polling times out after 10ms or if =
register access fails.
> +    fn as_wait_ready(&self, as_nr: usize) -> Result {
> +        let io =3D &*self.iomem;
> +        let op =3D || {
> +            let status_reg =3D STATUS::try_at(as_nr).ok_or(EINVAL)?;
> +            Ok(io.read(status_reg))
> +        };
> +        let cond =3D |status: &STATUS| -> bool { !status.active_ext() =
};
> +        poll::read_poll_timeout(op, cond, Delta::from_millis(0), =
Delta::from_millis(10))?;
> +
> +        Ok(())
> +    }
> +
> +    /// Sends a command to an AS slot.
> +    ///
> +    /// Returns an error if waiting for ready times out or if =
register write fails.
> +    fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> =
Result {
> +        self.as_wait_ready(as_nr)?;
> +        let io =3D &*self.iomem;
> +        let command_reg =3D COMMAND::try_at(as_nr).ok_or(EINVAL)?;
> +        io.write(command_reg, COMMAND::zeroed().with_command(cmd));
> +        Ok(())
> +    }
> +
> +    /// Sends a command to an AS slot and waits for completion.
> +    ///
> +    /// Returns an error if sending the command fails or if waiting =
for completion times out.
> +    fn as_send_cmd_and_wait(&mut self, as_nr: usize, cmd: MmuCommand) =
-> Result {
> +        self.as_send_cmd(as_nr, cmd)?;
> +        self.as_wait_ready(as_nr)?;
> +        Ok(())
> +    }
> +
> +    /// Enables an AS slot with the provided configuration.
> +    ///
> +    /// Returns an error if the slot is invalid or if register =
writes/commands fail.
> +    fn as_enable(&mut self, as_nr: usize, as_config: =
&AddressSpaceConfig) -> Result {
> +        self.validate_as_slot(as_nr)?;
> +
> +        let io =3D &*self.iomem;
> +
> +        let transtab =3D as_config.transtab;
> +        io.write(
> +            TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSTAB_LO::from_raw(transtab as u32),
> +        );
> +        io.write(
> +            TRANSTAB_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSTAB_HI::from_raw((transtab >> 32) as u32),
> +        );
> +
> +        let transcfg =3D as_config.transcfg;
> +        io.write(
> +            TRANSCFG_LO::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSCFG_LO::from_raw(transcfg as u32),
> +        );
> +        io.write(
> +            TRANSCFG_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
> +        );
> +
> +        let memattr =3D as_config.memattr;
> +        io.write(
> +            MEMATTR_LO::try_at(as_nr).ok_or(EINVAL)?,
> +            MEMATTR_LO::from_raw(memattr as u32),
> +        );
> +        io.write(
> +            MEMATTR_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            MEMATTR_HI::from_raw((memattr >> 32) as u32),
> +        );
> +
> +        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
> +
> +        Ok(())
> +    }
> +
> +    /// Disables an AS slot and clears its configuration.
> +    ///
> +    /// Returns an error if the slot is invalid or if register =
writes/commands fail.
> +    fn as_disable(&mut self, as_nr: usize) -> Result {
> +        self.validate_as_slot(as_nr)?;
> +
> +        // Flush AS before disabling
> +        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushMem)?;
> +
> +        let io =3D &*self.iomem;
> +
> +        io.write(
> +            TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSTAB_LO::from_raw(0),
> +        );
> +        io.write(
> +            TRANSTAB_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSTAB_HI::from_raw(0),
> +        );
> +
> +        io.write(
> +            MEMATTR_LO::try_at(as_nr).ok_or(EINVAL)?,
> +            MEMATTR_LO::from_raw(0),
> +        );
> +        io.write(
> +            MEMATTR_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            MEMATTR_HI::from_raw(0),
> +        );
> +
> +        let transcfg =3D TRANSCFG::zeroed()
> +            .with_mode(AddressSpaceMode::Unmapped)
> +            .into_raw();
> +
> +        io.write(
> +            TRANSCFG_LO::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSCFG_LO::from_raw(transcfg as u32),
> +        );
> +        io.write(
> +            TRANSCFG_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
> +        );
> +
> +        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
> +
> +        Ok(())
> +    }
> +
> +    /// Locks a region of the translation tables for an atomic =
update.
> +    ///
> +    /// Programs the MMU LOCKADDR register for the given address =
space and issues

Can we link to this?

> +    /// the lock command. The hardware rounds the requested range up =
to a
> +    /// power-of-two region aligned to its size.
> +    ///
> +    /// Returns an error if the slot is invalid or if register =
writes/commands fail.
> +    fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) =
-> Result {
> +        self.validate_as_slot(as_nr)?;
> +
> +        // The lock operates on full 64-byte cache lines of =
translation table entries.
> +        // Since each translation table entry (TTE) is 8 bytes, a =
cache line has 8 TTEs.
> +        // Since each TTE maps one page, the minimum locked region =
size will be 8 pages.
> +        //
> +        // With 4KiB pages (Aarch64_4K mode), the minimum locked =
region is 32KiB.
> +        let lock_region_min_size: u64 =3D 32 * 1024;
> +
> +        // Count the number of trailing zero bits (zeros at the =
right/least-significant
> +        // end of the binary representation). For a power-of-two =
value, this equals the
> +        // base-2 exponent (e.g., 32 KiB =3D 2^15 =E2=86=92 15).
> +        let lock_region_min_size_log2 =3D =
lock_region_min_size.trailing_zeros() as u8;
> +
> +        // XOR the first and last addresses to identify which bits =
differ between them.
> +        // The highest set bit in the result determines the exponent =
of the smallest
> +        // power-of-two region that can contain both addresses.
> +        //
> +        // Example:
> +        //   addr_xor =3D 0x1000 ^ 0x2FFF =3D 0x3FFF
> +        //   highest set bit in 0x3FFF is bit 13
> +        //   minimum region size =3D 2^(13 + 1) =3D 16 KiB
> +        let addr_xor =3D region.start ^ (region.end - 1);
> +        let region_size_log2 =3D 64 - addr_xor.leading_zeros() as u8;
> +
> +        let lock_region_log2 =3D core::cmp::max(region_size_log2, =
lock_region_min_size_log2);
> +
> +        // Align the LOCKADDR base address down to the lock region =
size (1 << lock_region_log2).
> +        //
> +        // The MMU ignores the low lock_region_log2 bits of LOCKADDR =
base, so ensure
> +        // they are cleared in software to avoid ambiguity.
> +        let lockaddr_base =3D region.start & !((1u64 << =
lock_region_log2) - 1);
> +
> +        // The LOCKADDR size field encodes the lock region size as =
log2(size) - 1,
> +        // per the hardware definition. For example, a 32 KiB region =
is encoded as 14
> +        // because log2(32 KiB) =3D 15.
> +        let lockaddr_size =3D lock_region_log2 - 1;
> +
> +        let io =3D &*self.iomem;
> +
> +        let lockaddr_val =3D LOCKADDR::zeroed()
> +            .try_with_size(lockaddr_size)?
> +            .try_with_base(lockaddr_base)?
> +            .into_raw();
> +
> +        io.write(
> +            LOCKADDR_LO::try_at(as_nr).ok_or(EINVAL)?,
> +            LOCKADDR_LO::from_raw(lockaddr_val as u32),
> +        );
> +        io.write(
> +            LOCKADDR_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            LOCKADDR_HI::from_raw((lockaddr_val >> 32) as u32),
> +        );
> +
> +        self.as_send_cmd(as_nr, MmuCommand::Lock)
> +    }
> +
> +    /// Completes an atomic translation table update.
> +    ///
> +    /// Returns an error if the slot is invalid or if the flush =
command fails.
> +    fn as_end_update(&mut self, as_nr: usize) -> Result {
> +        self.validate_as_slot(as_nr)?;
> +        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushPt)?;
> +        Ok(())
> +    }
> +
> +    /// Flushes the translation table cache for an AS slot.
> +    ///
> +    /// Returns an error if the slot is invalid or if the flush =
command fails.
> +    fn as_flush(&mut self, as_nr: usize) -> Result {
> +        self.validate_as_slot(as_nr)?;
> +        self.as_send_cmd(as_nr, MmuCommand::FlushPt)
> +    }
> +}
> +
> +impl<'bound> SlotOperations for AddressSpaceManager<'bound> {
> +    /// VM address space data associated with a hardware slot.
> +    type SlotData =3D Arc<VmAsData<'bound>>;
> +
> +    /// Activates an address space in a hardware slot.
> +    fn activate(&mut self, slot_idx: usize, slot_data: =
&Self::SlotData) -> Result {
> +        let as_config =3D slot_data.as_config()?;
> +        self.as_enable(slot_idx, &as_config)
> +    }
> +
> +    /// Evicts an address space from a hardware slot.
> +    fn evict(&mut self, slot_idx: usize, _slot_data: &Self::SlotData) =
-> Result {
> +        self.as_flush(slot_idx)?;
> +        self.as_disable(slot_idx)?;
> +        Ok(())
> +    }
> +}
> +
> +impl<'bound> AsSlotManager<'bound> {
> +    /// Locks a region for translation table updates if the VM has an =
active slot.
> +    pub(super) fn start_vm_update(&mut self, vm: &VmAsData<'bound>, =
region: &Range<u64>) -> Result {
> +        let seat =3D vm.as_seat.access(self);
> +        match seat.slot() {
> +            Some(slot) =3D> {
> +                let as_nr =3D slot as usize;
> +                self.as_start_update(as_nr, region)
> +            }
> +            _ =3D> Ok(()),
> +        }
> +    }
> +
> +    /// Completes translation table updates and unlocks the region.
> +    pub(super) fn end_vm_update(&mut self, vm: &VmAsData<'bound>) -> =
Result {
> +        let seat =3D vm.as_seat.access(self);
> +        match seat.slot() {
> +            Some(slot) =3D> {
> +                let as_nr =3D slot as usize;
> +                self.as_end_update(as_nr)
> +            }
> +            _ =3D> Ok(()),
> +        }
> +    }
> +
> +    /// Flushes the translation table cache if the VM has an active =
slot.
> +    pub(super) fn flush_vm(&mut self, vm: &VmAsData<'bound>) -> =
Result {
> +        let seat =3D vm.as_seat.access(self);
> +        match seat.slot() {
> +            Some(slot) =3D> {
> +                let as_nr =3D slot as usize;
> +                self.as_flush(as_nr)
> +            }
> +            _ =3D> Ok(()),
> +        }
> +    }
> +
> +    /// Activates a VM by assigning it to a hardware slot.
> +    pub(super) fn activate_vm(&mut self, vm: ArcBorrow<'_, =
VmAsData<'bound>>) -> Result {
> +        self.activate(&vm.as_seat, vm.into())
> +    }
> +
> +    /// Deactivates a VM by evicting it from its hardware slot.
> +    pub(super) fn deactivate_vm(&mut self, vm: &VmAsData<'bound>) -> =
Result {
> +        self.evict(&vm.as_seat)
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 831357a8ef87..c4f6b1596b31 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -45,6 +45,8 @@ pub(crate) fn read_u64_no_tearing(lo_read: impl Fn() =
-> u32, hi_read: impl Fn()
>     }
> }
>=20
> +pub(crate) use mmu_control::mmu_as_control::MAX_AS;
> +
> /// These registers correspond to the GPU_CONTROL register page.
> /// They are involved in GPU configuration and control.
> pub(crate) mod gpu_control {
> @@ -965,6 +967,8 @@ pub(crate) mod mmu_as_control {
>             register, //
>         };
>=20
> +        use pin_init::Zeroable;
> +
>         /// Maximum number of hardware address space slots.
>         /// The actual number of slots available is usually lower.
>         pub(crate) const MAX_AS: usize =3D 16;
> @@ -1158,7 +1162,124 @@ fn from(val: MMU_MEMATTR_STAGE1) -> Self {
>             pub(crate) MEMATTR_HI(u32)[MAX_AS, stride =3D STRIDE] @ =
0x240c {
>                 31:0 value;
>             }
> +        }
> +
> +        impl MEMATTR {
> +            ///
> +            /// In the ARM Architecture Reference Manual, the MAIR =
encoding for Normal memory
> +            /// uses the format `0bxxRW` where:
> +            /// - `W` (bit 0) =3D Write-Allocate policy
> +            /// - `R` (bit 1) =3D Read-Allocate policy
> +            ///   E.g., `0b0011` would allow both read and write =
allocation on a cache miss.
> +            ///
> +            /// ARM MAIR Write-Allocate bit (bit 0 of a cache policy =
nibble).
> +            const ARM_MAIR_WRITE_ALLOCATE: u8 =3D 0x1;
> +            /// ARM MAIR Read-Allocate bit (bit 1 of a cache policy =
nibble).
> +            const ARM_MAIR_READ_ALLOCATE: u8 =3D 0x2;
> +            /// ARM MAIR Write-back bit (bit 2 of a cache policy =
nibble).
> +            const ARM_MAIR_WRITE_BACK: u8 =3D 0x4;
> +            /// Mask for the inner cache policy nibble in MAIR =
attribute bytes.
> +            const ARM_MAIR_INNER_MASK: u8 =3D 0x0f;
> +
> +            /// Check if a MAIR attribute byte represents device =
memory.
> +            ///
> +            /// Device memory (memory-mapped I/O, registers) cannot =
be cached and must
> +            /// be mapped as GPU `NonCacheable`.
> +            fn is_device_memory(mair_attr: u8) -> bool {
> +                // In AArch64 MAIR, device memory has bits [1:0] of =
outer nibble =3D 0.
> +                let outer =3D mair_attr >> 4;
> +                (outer & 0x3) =3D=3D 0
> +            }
> +
> +            /// Check if normal memory is fully write-back cacheable.
> +            ///
> +            /// ARM MAIR has two cache policy levels (outer [7:4] and =
inner [3:0]).
> +            /// For memory to be truly write-back, BOTH levels must =
have the write-back bit set.
> +            /// If only one level is write-back, treat it as =
non-cacheable for GPU purposes.
> +            fn is_writeback_cacheable(mair_attr: u8) -> bool {
> +                let outer =3D mair_attr >> 4;
> +                let inner =3D mair_attr & Self::ARM_MAIR_INNER_MASK;
> +
> +                (outer & Self::ARM_MAIR_WRITE_BACK) !=3D 0 && (inner =
& Self::ARM_MAIR_WRITE_BACK) !=3D 0
> +            }
> +
> +            // Helper to encode a MEMATTR attribute from its =
individual fields.
> +            fn encode_attribute(
> +                alloc_w: bool,
> +                alloc_r: bool,
> +                alloc_sel: AllocPolicySelect,
> +                coherency: Coherency,
> +                memory_type: MemoryType,
> +            ) -> MMU_MEMATTR_STAGE1 {
> +                MMU_MEMATTR_STAGE1::zeroed()
> +                    .with_alloc_w(alloc_w)
> +                    .with_alloc_r(alloc_r)
> +                    .with_alloc_sel(alloc_sel)
> +                    .with_coherency(coherency)
> +                    .with_memory_type(memory_type)
> +            }
> +
> +            /// Convert one MAIR attribute byte into a MEMATTR =
attribute.
> +            // TODO: Add a `coherent` parameter like panthor's =
mair_to_memattr().
> +            // For now, assume a non-coherent system and always =
encode write-back
> +            // memory with MidgardInnerDomain coherency.
> +            fn attribute_from_mair(mair_attr: u8) -> =
MMU_MEMATTR_STAGE1 {
> +                // Device memory or non-write-back normal memory
> +                if Self::is_device_memory(mair_attr) || =
!Self::is_writeback_cacheable(mair_attr) {
> +                    return Self::encode_attribute(
> +                        false,
> +                        false,
> +                        AllocPolicySelect::Alloc,
> +                        Coherency::MidgardInnerDomain,
> +                        MemoryType::NonCacheable,
> +                    );
> +                }
> +
> +                // Write-back cacheable normal memory
> +                let inner: u8 =3D mair_attr & =
Self::ARM_MAIR_INNER_MASK;
> +                Self::encode_attribute(
> +                    (inner & Self::ARM_MAIR_WRITE_ALLOCATE) !=3D 0,
> +                    (inner & Self::ARM_MAIR_READ_ALLOCATE) !=3D 0,
> +                    AllocPolicySelect::Alloc,
> +                    Coherency::MidgardInnerDomain,
> +                    MemoryType::WriteBack,
> +                )
> +            }
> +
> +            /// Write one converted MAIR attribute into a =
corresponding MEMATTR slot.
> +            fn with_encoded_attribute(self, index: usize, attr: =
MMU_MEMATTR_STAGE1) -> Self {
> +                debug_assert!(index < 8);
> +
> +                let shift =3D index * 8;
> +                let mask =3D !(0xffu64 << shift);
> +                let raw =3D (self.into_raw() & mask) | =
((u64::from(attr.into_raw())) << shift);
> +
> +                Self::from_raw(raw)
> +            }
>=20
> +            /// Convert an AArch64 MAIR value into the GPU MEMATTR =
register encoding.
> +            ///
> +            /// Both MAIR and MEMATTR are 64-bit values with eight =
8-bit memory
> +            /// attribute entries, but the bits do not map directly. =
The GPU MEMATTR encoding
> +            /// is  less detailed than the MAIR encoding, so MAIR is =
converted to MEMATTR
> +            /// conservatively as follows:
> +            ///
> +            /// 1. Device memory, or Normal Memory that is not =
write-back cacheable, is encoded
> +            ///    as GPU `NonCacheable`
> +            ///
> +            /// 2. Normal memory that is write-back cacheable is =
encoded as GPU `WriteBack`,
> +            ///    and the inner allocation hints are preserved.
> +            pub(crate) fn from_mair(mair: u64) -> Self {
> +                mair.to_le_bytes()
> +                    .into_iter()
> +                    .enumerate()
> +                    .fold(Self::zeroed(), |acc, (i, attr)| {
> +                        acc.with_encoded_attribute(i, =
Self::attribute_from_mair(attr))
> +                    })
> +            }
> +        }
> +
> +        register! {
>             /// Lock region address for each address space.
>             pub(crate) LOCKADDR(u64)[MAX_AS, stride =3D STRIDE] @ =
0x2410 {
>                 /// Lock region size.
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 7c9a8063b3b9..79045d0135a8 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -11,6 +11,7 @@
> mod file;
> mod gem;
> mod gpu;
> +mod mmu;
> mod regs;
> mod slot;
>=20
>=20
> --=20
> 2.54.0
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
