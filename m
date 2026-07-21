Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE6AC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599B810E230;
	Tue, 21 Jul 2026 12:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XGFVgezt";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA37410E230
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784638541; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QT+4q16JFmbdxYpDrcZ3BM1DbZ3DzzZo/+Tmgin1Fmq/cvyIpSdIkRmhazt/7BNQLahMAbUwUJhe2oc1A6QdNy/MxCG/v2d8nyo0RAajEi0LDjIx13hUwrk9p7Vu6ttH1ionPDQaBcZGKhzLCjFhRMGWYpMaF0kWXMhjKx6jlDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784638541;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1Ii1Ex0pAS4rMrXK6sB394KYstbEQFpERpAQVeRDnuM=; 
 b=WLez0x0MFWOFjbhKBy98DxUOJz8SLE6er34M1VJ3BJf8o8zCR5/UQ8YTGpllDNjogjzxZZ2VKCvQk1YP6QuUDzMPJPqcCg/X6yYFyU4qYnY3Vum8q9BUt4rVtKAJzpwFWEqW0CzFs3X+UFfScGjLkaMqkQ4fT1kQYo2saJR+02U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784638541; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=1Ii1Ex0pAS4rMrXK6sB394KYstbEQFpERpAQVeRDnuM=;
 b=XGFVgeztcwyGREtG6TUbVmaEL5scc+xPH0U67fESdlNfHtcPF2Ei1IZArlS632hc
 TfJh4tbwUDaLVOqLGO675cR/aRWvSRSnTDc8Ij2yqiGystRDe3crlDRktqQTA/7J4SP
 mOzGcjPtH8bWZrFZBx9XqE2U5nyy+ba+B3Z7E1d4=
Received: by mx.zohomail.com with SMTPS id 1784638537888771.3905608271614;
 Tue, 21 Jul 2026 05:55:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v7 4/7] drm/tyr: add GPU virtual memory (VM) support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260713-fw-boot-b4-v7-4-afd8dc1494dd@collabora.com>
Date: Tue, 21 Jul 2026 09:55:18 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 samitolvanen@google.com, work@onurozkan.dev, acourbot@nvidia.com,
 lyude@redhat.com, laura.nao@collabora.com, beata.michalska@arm.com,
 alvin.sun@linux.dev, steven.price@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0CC97E4D-4D6B-4733-870B-35030714D99B@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-4-afd8dc1494dd@collabora.com>
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



> On 14 Jul 2026, at 00:18, Deborah Brouwer =
<deborah.brouwer@collabora.com> wrote:
>=20
> From: Boris Brezillon <boris.brezillon@collabora.com>
>=20
> Add GPU virtual address space management using the DRM GPUVM =
framework.
> Each virtual memory (VM) space is backed by ARM64 LPAE Stage 1 page =
tables
> and can be mapped into hardware address space (AS) slots for GPU =
execution.
>=20
> The implementation provides memory isolation and virtual address
> allocation. VMs support mapping GEM buffer objects with configurable
> protection flags (readonly, noexec, uncached) and handle both 4KB and =
2MB
> page sizes. A new_dummy_object() helper is provided to create a dummy =
GEM
> object for use as a GPUVM root.
>=20
> The vm module integrates with the MMU for address space activation and
> provides map/unmap/remap operations with page table synchronization.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/Kconfig   |   1 +
> drivers/gpu/drm/tyr/driver.rs |   4 +-
> drivers/gpu/drm/tyr/gem.rs    |  26 +-
> drivers/gpu/drm/tyr/mmu.rs    |   1 -
> drivers/gpu/drm/tyr/tyr.rs    |   1 +
> drivers/gpu/drm/tyr/vm.rs     | 811 =
++++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 839 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
> index 61a2fd6f961a..79ea4bb214de 100644
> --- a/drivers/gpu/drm/tyr/Kconfig
> +++ b/drivers/gpu/drm/tyr/Kconfig
> @@ -12,6 +12,7 @@ config DRM_TYR
> default n
> select IOMMU_IO_PGTABLE_LPAE
> select RUST_DRM_GEM_SHMEM_HELPER
> + select RUST_DRM_GPUVM
> help
>  Rust DRM driver for ARM Mali CSF-based GPUs.
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index 74b55a389754..9195c8be5203 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -37,7 +37,7 @@
>=20
> use crate::{
>     file::TyrDrmFileData,
> -    gem::BoData,
> +    gem::Bo,
>     gpu,
>     gpu::GpuInfo,
>     mmu::Mmu,
> @@ -194,7 +194,7 @@ impl drm::Driver for TyrDrmDriver {
>     type Data =3D ();
>     type RegistrationData<'bound> =3D TyrDrmRegistrationData<'bound>;
>     type File =3D TyrDrmFileData;
> -    type Object =3D drm::gem::shmem::Object<BoData>;
> +    type Object =3D Bo;
>     type ParentDevice<Ctx: DeviceContext> =3D platform::Device<Ctx>;
>=20
>     const INFO: drm::DriverInfo =3D INFO;
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 1640a161754b..c28be61a01bb 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -5,8 +5,12 @@
> //! DRM's GEM subsystem with shmem backing.
>=20
> use kernel::{
> -    drm::gem,
> -    prelude::*, //
> +    drm::gem::{
> +        self,
> +        shmem, //
> +    },
> +    prelude::*,
> +    sync::aref::ARef, //
> };
>=20
> use crate::driver::{
> @@ -34,3 +38,21 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: =
BoCreateArgs) -> impl PinInit<Se
>         try_pin_init!(Self { flags: args.flags })
>     }
> }
> +
> +/// Type alias for Tyr GEM buffer objects.
> +pub(crate) type Bo =3D gem::shmem::Object<BoData>;
> +
> +/// Creates a dummy GEM object to serve as the root of a GPUVM.
> +pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> =
Result<ARef<Bo>> {
> +    let bo =3D Bo::new(
> +        ddev,
> +        4096,
> +        shmem::ObjectConfig {
> +            map_wc: true,
> +            parent_resv_obj: None,
> +        },
> +        BoCreateArgs { flags: 0 },
> +    )?;
> +
> +    Ok(bo)
> +}
> diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
> index beae87c816e5..0ed20e03569c 100644
> --- a/drivers/gpu/drm/tyr/mmu.rs
> +++ b/drivers/gpu/drm/tyr/mmu.rs
> @@ -10,7 +10,6 @@
> //! The [`SlotManager`] manages the assignment of virtual address =
spaces to hardware address-space
> //! (AS) slots. MMU commands such as updates and flushes are carried =
out by the
> //! [`AddressSpaceManager`] which actually writes to the MMU =
registers.
> -#![expect(dead_code)]
>=20
> use core::ops::Range;
>=20
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 79045d0135a8..92f6885cdaae 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -14,6 +14,7 @@
> mod mmu;
> mod regs;
> mod slot;
> +mod vm;
>=20
> kernel::module_platform_driver! {
>     type: TyrPlatformDriver,
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> new file mode 100644
> index 000000000000..2358096afc7e
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/vm.rs
> @@ -0,0 +1,811 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! GPU virtual memory management using the DRM GPUVM framework.
> +//!
> +//! This module manages GPU virtual address spaces, providing memory =
isolation and
> +//! the illusion of owning the entire virtual address (VA) range, =
similar to CPU virtual memory.
> +//! Each virtual memory (VM) area is backed by ARM64 LPAE Stage 1 =
page tables and can be
> +//! mapped into hardware address space (AS) slots for GPU execution.
> +#![expect(dead_code)]
> +
> +use core::marker::PhantomData;
> +use core::ops::Range;
> +
> +use kernel::{
> +    device::{
> +        Bound,
> +        Device, //
> +    },
> +    drm::{
> +        gpuvm::{
> +            DriverGpuVm,
> +            GpuVaAlloc,
> +            GpuVm,
> +            GpuVmBo,
> +            OpMap,
> +            OpMapRequest,
> +            OpMapped,
> +            OpRemap,
> +            OpRemapped,
> +            OpUnmap,
> +            OpUnmapped,
> +            UniqueRefGpuVm, //
> +        }, //
> +    },
> +    fmt,
> +    impl_flags,
> +    iommu::pgtable::{
> +        prot,
> +        IoPageTable,
> +        ARM64LPAES1, //
> +    },
> +    new_mutex,
> +    prelude::*,
> +    sizes::{
> +        SZ_1G,
> +        SZ_2M,
> +        SZ_4K, //
> +    },
> +    sync::{
> +        aref::ARef,
> +        Arc,
> +        ArcBorrow,
> +        Mutex, //
> +    },
> +    uapi, //
> +};
> +
> +use crate::{
> +    driver::{
> +        TyrDrmDevice,
> +        TyrDrmDriver, //
> +    },
> +    gem,
> +    gem::Bo,
> +    gpu::GpuInfo,
> +    mmu::{
> +        address_space::VmAsData,
> +        Mmu, //
> +    },
> +    regs::gpu_control::MMU_FEATURES,
> +};
> +
> +impl_flags!(
> +    /// Flags controlling virtual memory mapping behavior.
> +    ///
> +    /// These flags control access permissions and caching behavior =
for GPU virtual
> +    /// memory mappings.
> +    #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
> +    pub(crate) struct VmMapFlags(u32);
> +
> +    /// Individual flags that can be combined in [`VmMapFlags`].
> +    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +    pub(crate) enum VmFlag {
> +        /// Map as read-only.
> +        Readonly =3D =
uapi::drm_panthor_vm_bind_op_flags_DRM_PANTHOR_VM_BIND_OP_MAP_READONLY =
as u32,
> +        /// Map as non-executable.
> +        Noexec =3D =
uapi::drm_panthor_vm_bind_op_flags_DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC as =
u32,
> +        /// Map as uncached.
> +        Uncached =3D =
uapi::drm_panthor_vm_bind_op_flags_DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED =
as u32,
> +    }
> +);
> +
> +impl VmMapFlags {
> +    /// Convert the flags to `pgtable::prot`.
> +    fn to_prot(self) -> u32 {
> +        let mut prot =3D 0;
> +
> +        if self.contains(VmFlag::Readonly) {
> +            prot |=3D prot::READ;
> +        } else {
> +            prot |=3D prot::READ | prot::WRITE;
> +        }
> +
> +        if self.contains(VmFlag::Noexec) {
> +            prot |=3D prot::NOEXEC;
> +        }
> +
> +        if !self.contains(VmFlag::Uncached) {
> +            prot |=3D prot::CACHE;
> +        }
> +
> +        prot
> +    }
> +}
> +
> +impl fmt::Display for VmMapFlags {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        let mut first =3D true;
> +
> +        if self.contains(VmFlag::Readonly) {
> +            write!(f, "READONLY")?;
> +            first =3D false;
> +        }
> +        if self.contains(VmFlag::Noexec) {
> +            if !first {
> +                write!(f, " | ")?;
> +            }
> +            write!(f, "NOEXEC")?;
> +            first =3D false;
> +        }
> +
> +        if self.contains(VmFlag::Uncached) {
> +            if !first {
> +                write!(f, " | ")?;
> +            }
> +            write!(f, "UNCACHED")?;
> +        }
> +
> +        Ok(())
> +    }
> +}
> +
> +impl TryFrom<u32> for VmMapFlags {
> +    type Error =3D Error;
> +
> +    fn try_from(value: u32) -> Result<Self, Self::Error> {
> +        let valid =3D VmFlag::Readonly as u32 | VmFlag::Noexec as u32 =
| VmFlag::Uncached as u32;
> +
> +        if value & !valid !=3D 0 {
> +            pr_err!("Invalid VM map flags: {:#x}\n", value);
> +            return Err(EINVAL);
> +        }
> +        Ok(Self(value))
> +    }
> +}
> +
> +/// Arguments for a virtual memory map operation.
> +struct VmMapArgs<'bound> {
> +    /// Access permissions and caching behavior for the mapping.
> +    flags: VmMapFlags,
> +    /// GEM buffer object registered with the GPUVM framework.
> +    vm_bo: ARef<GpuVmBo<GpuVmData<'bound>>>,
> +    /// Offset in bytes from the start of the buffer object.
> +    bo_offset: u64,
> +}
> +
> +/// Type of virtual memory operation.
> +enum VmOpType<'bound> {
> +    /// Map a GEM buffer object into the virtual address space.
> +    Map(VmMapArgs<'bound>),
> +    /// Unmap a region from the virtual address space.
> +    Unmap,
> +}
> +
> +/// Preallocated resources needed to execute a VM operation.
> +///
> +/// VM operations may require allocating new GPUVA objects to track =
mappings.
> +/// To avoid allocation failures during the operation, preallocate =
the
> +/// maximum number of GPUVAs that might be needed.
> +struct VmOpResources<'bound> {
> +    /// Preallocated GPUVA objects for remap operations.
> +    ///
> +    /// Partial unmap requests or map requests overlapping existing =
mappings
> +    /// will trigger a remap call, which needs to register up to =
three VA
> +    /// objects (one for the new mapping, and two for the previous =
and next
> +    /// mappings).
> +    preallocated_gpuvas: [Option<GpuVaAlloc<GpuVmData<'bound>>>; 3],
> +}
> +
> +/// Request to execute a virtual memory operation.
> +struct VmOpRequest<'bound> {
> +    /// Request type.
> +    op_type: VmOpType<'bound>,
> +
> +    /// Region of the virtual address space covered by this request.
> +    region: Range<u64>,
> +}
> +
> +/// Arguments for a page table map operation.
> +struct PtMapArgs {
> +    /// Memory protection flags describing allowed accesses for this =
mapping.
> +    ///
> +    /// This is directly derived from [`VmMapFlags`] via =
[`VmMapFlags::to_prot`].
> +    prot: u32,
> +}
> +
> +/// Type of page table operation.
> +enum PtOpType {
> +    /// Map pages into the page table.
> +    Map(PtMapArgs),
> +    /// Unmap pages from the page table.
> +    Unmap,
> +}
> +
> +/// Context for updating the GPU page table.
> +///
> +/// This context is created when beginning a page table update =
operation and
> +/// automatically flushes changes when dropped. It ensures that the
> +/// Memory Management Unit (MMU) state is properly managed and =
Translation
> +/// Lookaside Buffer (TLB) entries are flushed.
> +pub(crate) struct PtUpdateContext<'ctx, 'bound> {
> +    /// Device used for DMA-mapping GEM shmem SG tables.
> +    dev: &'ctx Device<Bound>,
> +
> +    /// Page table.
> +    pt: &'ctx IoPageTable<'bound, ARM64LPAES1>,
> +
> +    /// MMU manager.
> +    mmu: &'ctx Mmu<'bound>,
> +
> +    /// Reference to the address space data to pass to the MMU =
functions.
> +    as_data: &'ctx VmAsData<'bound>,
> +
> +    /// Region of the virtual address space covered by this request.
> +    region: Range<u64>,
> +
> +    /// Operation type.
> +    op_type: PtOpType,
> +
> +    /// Preallocated resources that can be used when executing the =
request.
> +    resources: &'ctx mut VmOpResources<'bound>,
> +}
> +
> +impl<'ctx, 'bound> PtUpdateContext<'ctx, 'bound> {
> +    /// Creates a new page table update context.
> +    ///
> +    /// This prepares the MMU for a page table update.
> +    /// The context will automatically flush the TLB and
> +    /// complete the update when dropped.
> +    fn new(
> +        dev: &'ctx Device<Bound>,
> +        pt: &'ctx IoPageTable<'bound, ARM64LPAES1>,
> +        mmu: &'ctx Mmu<'bound>,
> +        as_data: &'ctx VmAsData<'bound>,
> +        region: Range<u64>,
> +        op_type: PtOpType,
> +        resources: &'ctx mut VmOpResources<'bound>,
> +    ) -> Result<PtUpdateContext<'ctx, 'bound>> {
> +        mmu.start_vm_update(as_data, &region)?;
> +
> +        Ok(Self {
> +            dev,
> +            pt,
> +            mmu,
> +            as_data,
> +            region,
> +            op_type,
> +            resources,
> +        })
> +    }
> +
> +    /// Finds one of our pre-allocated VAs.
> +    ///
> +    /// It is a logic error to call this more than three times for a =
given
> +    /// PtUpdateContext.
> +    fn preallocated_gpuva(&mut self) -> =
Result<GpuVaAlloc<GpuVmData<'bound>>> {
> +        self.resources
> +            .preallocated_gpuvas
> +            .iter_mut()
> +            .find_map(|f| f.take())
> +            .ok_or(EINVAL)
> +    }
> +}
> +
> +impl Drop for PtUpdateContext<'_, '_> {
> +    fn drop(&mut self) {
> +        if let Err(e) =3D self.mmu.end_vm_update(self.as_data) {
> +            pr_err!("Failed to end VM update {:?}\n", e);
> +        }
> +
> +        if let Err(e) =3D self.mmu.flush_vm(self.as_data) {
> +            pr_err!("Failed to flush VM {:?}\n", e);
> +        }
> +    }
> +}
> +
> +/// Driver implementation for the GPUVM framework.
> +///
> +/// Implements [`DriverGpuVm`] to provide VM operation callbacks =
(map, unmap, remap)
> +/// and associated types for buffer objects, virtual addresses, and =
contexts.
> +pub(crate) struct GpuVmData<'bound> {
> +    _phantom: PhantomData<&'bound ()>,
> +}
> +
> +/// GPU virtual address space.
> +///
> +/// Each VM can be mapped into a hardware address space slot.
> +#[pin_data]
> +pub(crate) struct Vm<'bound> {
> +    /// Data referenced by an AS when the VM is active
> +    as_data: Arc<VmAsData<'bound>>,
> +    /// MMU manager.
> +    mmu: Arc<Mmu<'bound>>,
> +    /// Parent device used for DMA mapping and page-table operations.
> +    dev: &'bound Device<Bound>,
> +    /// DRM GPUVM core for managing virtual address space.
> +    #[pin]
> +    gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'bound>>>,
> +    /// Non-core part of the GPUVM. Can be used for stuff that =
doesn't modify the
> +    /// internal mapping tree, like GpuVm::obtain()
> +    gpuvm: ARef<GpuVm<GpuVmData<'bound>>>,
> +    /// VA range for this VM.
> +    va_range: Range<u64>,
> +}
> +
> +impl<'bound> Vm<'bound> {
> +    /// Creates a new GPU virtual address space.
> +    ///
> +    /// The VM is initialized with a page table configured according =
to the GPU's
> +    /// address translation capabilities and registered with the =
GPUVM framework.
> +    pub(crate) fn new(
> +        dev: &'bound Device<Bound>,
> +        ddev: &TyrDrmDevice,
> +        mmu: ArcBorrow<'_, Mmu<'bound>>,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<Arc<Vm<'bound>>> {
> +        let mmu_features =3D =
MMU_FEATURES::from_raw(gpu_info.mmu_features);
> +        let va_bits =3D mmu_features.va_bits().get();
> +        let pa_bits =3D mmu_features.pa_bits().get();
> +
> +        let range =3D 0..(1u64 << va_bits);
> +        let reserve_range =3D 0..0u64;
> +
> +        // dummy_obj is used to initialize the GPUVM tree.
> +        let dummy_obj =3D gem::new_dummy_object(ddev).inspect_err(|e| =
{
> +            pr_err!("Failed to create dummy GEM object: {:?}\n", e);
> +        })?;
> +
> +        let gpuvm_unique =3D GpuVm::new::<Error, _>(
> +            c"Tyr::GpuVm",
> +            ddev,
> +            &*dummy_obj,
> +            range.clone(),
> +            reserve_range,
> +            GpuVmData::<'bound> {
> +                _phantom: PhantomData::<&()>,
> +            },
> +        )
> +        .inspect_err(|e| {
> +            pr_err!("Failed to create GpuVm: {:?}\n", e);
> +        })?;
> +        let gpuvm =3D ARef::from(&*gpuvm_unique);
> +
> +        let as_data =3D Arc::pin_init(VmAsData::new(&mmu, dev, =
va_bits, pa_bits), GFP_KERNEL)?;
> +
> +        let vm =3D Arc::pin_init(
> +            pin_init!(Self{
> +                as_data,
> +                dev,
> +                mmu: mmu.into(),
> +                gpuvm,
> +                gpuvm_unique <- new_mutex!(gpuvm_unique),
> +                va_range: range,
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        Ok(vm)
> +    }
> +
> +    /// Activate the VM in a hardware address space slot.
> +    pub(crate) fn activate(&self) -> Result {
> +        self.mmu
> +            .activate_vm(self.as_data.as_arc_borrow())
> +            .inspect_err(|e| {
> +                pr_err!("Failed to activate VM: {:?}\n", e);
> +            })
> +    }
> +
> +    /// Deactivate the VM by evicting it from its address space slot.
> +    fn deactivate(&self) -> Result {
> +        self.mmu.deactivate_vm(&self.as_data).inspect_err(|e| {
> +            pr_err!("Failed to deactivate VM: {:?}\n", e);
> +        })
> +    }
> +
> +    /// Kills the VM by deactivating it and unmapping all regions.
> +    pub(crate) fn kill(&self) {
> +        // TODO: Turn the VM into a state where it can't be used.
> +        let _ =3D self.deactivate().inspect_err(|e| {
> +            pr_err!("Failed to deactivate VM: {:?}\n", e);
> +        });
> +        let _ =3D self
> +            .unmap_range(self.va_range.start, self.va_range.end - =
self.va_range.start)
> +            .inspect_err(|e| {
> +                pr_err!("Failed to unmap range during deactivate: =
{:?}\n", e);
> +            });
> +    }
> +
> +    /// Executes a virtual memory operation.
> +    ///
> +    /// This handles both map and unmap operations by coordinating =
between the
> +    /// GPUVM framework and the hardware page table.
> +    fn exec_op<'a>(
> +        &self,
> +        gpuvm_unique: &mut UniqueRefGpuVm<GpuVmData<'bound>>,
> +        req: VmOpRequest<'bound>,
> +        resources: &'a mut VmOpResources<'bound>,
> +    ) -> Result {
> +        let pt =3D &self.as_data.page_table;
> +
> +        match req.op_type {
> +            VmOpType::Map(args) =3D> {
> +                let mut pt_upd =3D PtUpdateContext::new(
> +                    self.dev,
> +                    pt,
> +                    &self.mmu,
> +                    &self.as_data,
> +                    req.region,
> +                    PtOpType::Map(PtMapArgs {
> +                        prot: args.flags.to_prot(),
> +                    }),
> +                    resources,
> +                )?;
> +
> +                gpuvm_unique.sm_map(OpMapRequest {
> +                    addr: pt_upd.region.start,
> +                    range: pt_upd.region.end - pt_upd.region.start,
> +                    gem_offset: args.bo_offset,
> +                    vm_bo: &args.vm_bo,
> +                    context: &mut pt_upd,
> +                })
> +                //PtUpdateContext drops here flushing the page table
> +            }
> +            VmOpType::Unmap =3D> {
> +                let mut pt_upd =3D PtUpdateContext::new(
> +                    self.dev,
> +                    pt,
> +                    &self.mmu,
> +                    &self.as_data,
> +                    req.region,
> +                    PtOpType::Unmap,
> +                    resources,
> +                )?;
> +
> +                gpuvm_unique.sm_unmap(
> +                    pt_upd.region.start,
> +                    pt_upd.region.end - pt_upd.region.start,
> +                    &mut pt_upd,
> +                )
> +                //PtUpdateContext drops here flushing the page table
> +            }
> +        }
> +    }
> +
> +    /// Maps a GEM buffer object range into the VM at the specified =
virtual address.
> +    ///
> +    /// This creates a mapping from GPU virtual address `va` to the =
physical pages
> +    /// backing the GEM object, starting at `bo_offset` bytes into =
the object and
> +    /// spanning `size` bytes. The mapping respects the access =
permissions and
> +    /// caching behavior specified in `flags`.
> +    pub(crate) fn map_bo_range(
> +        &self,
> +        bo: &Bo,
> +        bo_offset: u64,
> +        size: u64,
> +        va: u64,
> +        flags: VmMapFlags,
> +    ) -> Result {
> +        let req =3D VmOpRequest {
> +            op_type: VmOpType::Map(VmMapArgs {
> +                vm_bo: self.gpuvm.obtain(bo, ())?,
> +                flags,
> +                bo_offset,
> +            }),
> +            region: va..(va + size),
> +        };
> +        let mut resources =3D VmOpResources {
> +            preallocated_gpuvas: [
> +                =
Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +                =
Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +                =
Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +            ],
> +        };
> +        {
> +            let mut gpuvm_unique =3D self.gpuvm_unique.lock();
> +            self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut =
resources)?;
> +        }
> +        // We flush the defer cleanup list now. Things will be =
different in
> +        // the asynchronous VM_BIND path, where we want the cleanup =
to
> +        // happen outside the DMA signalling path.
> +        self.gpuvm.deferred_cleanup();
> +        Ok(())
> +    }
> +
> +    /// Unmaps a virtual address range from the VM.
> +    ///
> +    /// This removes any existing mappings in the specified range, =
freeing the
> +    /// virtual address space for reuse.
> +    pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
> +        let req =3D VmOpRequest {
> +            op_type: VmOpType::Unmap,
> +            region: va..(va + size),
> +        };
> +        let mut resources =3D VmOpResources {
> +            preallocated_gpuvas: [
> +                =
Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +                =
Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +                None,
> +            ],
> +        };
> +        {
> +            let mut gpuvm_unique =3D self.gpuvm_unique.lock();
> +            self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut =
resources)?;
> +        }
> +        // We flush the defer cleanup list now. Things will be =
different in
> +        // the asynchronous VM_BIND path, where we want the cleanup =
to
> +        // happen outside the DMA signalling path.
> +        self.gpuvm.deferred_cleanup();
> +        Ok(())
> +    }
> +}
> +
> +impl<'bound> DriverGpuVm for GpuVmData<'bound> {
> +    type Driver =3D TyrDrmDriver;
> +    type Object =3D Bo;
> +    type VmBoData =3D ();
> +    type VaData =3D ();
> +    type SmContext<'ctx>
> +        =3D PtUpdateContext<'ctx, 'bound>
> +    where
> +        Self: 'ctx;
> +
> +    /// Indicates that a new mapping should be created.
> +    fn sm_step_map<'op>(
> +        &mut self,
> +        op: OpMap<'op, Self>,
> +        context: &mut Self::SmContext<'_>,
> +    ) -> Result<OpMapped<'op, Self>, Error> {
> +        let start_iova =3D op.addr();
> +        let mut iova =3D start_iova;
> +        let mut bytes_left_to_map =3D op.length();
> +        let mut gem_offset =3D op.gem_offset();
> +        let sgt =3D op.obj().sg_table(context.dev).inspect_err(|e| {
> +            pr_err!("Failed to get sg_table: {:?}\n", e);
> +        })?;
> +        let prot =3D match &context.op_type {
> +            PtOpType::Map(args) =3D> args.prot,
> +            _ =3D> {
> +                return Err(EINVAL);
> +            }
> +        };
> +
> +        for sgt_entry in sgt.iter() {
> +            // Expressly convert to u64 to work with arm 32-bit =
builds.
> +            #[allow(clippy::useless_conversion)]
> +            let mut paddr =3D u64::from(sgt_entry.dma_address());
> +            #[allow(clippy::useless_conversion)]
> +            let mut sgt_entry_length =3D =
u64::from(sgt_entry.dma_len());
> +
> +            if bytes_left_to_map =3D=3D 0 {
> +                break;
> +            }
> +
> +            if gem_offset > 0 {
> +                // Skip the entire SGT entry if the gem_offset =
exceeds its length.
> +                let skip =3D u64::min(sgt_entry_length, gem_offset);
> +                paddr +=3D skip;
> +                sgt_entry_length -=3D skip;
> +                gem_offset -=3D skip;
> +            }
> +
> +            if sgt_entry_length =3D=3D 0 {
> +                continue;
> +            }
> +
> +            if gem_offset !=3D 0 {
> +                pr_err!("Invalid gem_offset {} in page table =
mapping.\n", gem_offset);
> +                return Err(EINVAL);
> +            }
> +            let len =3D u64::min(sgt_entry_length, =
bytes_left_to_map);
> +
> +            let segment_mapped =3D match pt_map(context.pt, iova, =
paddr, len, prot) {
> +                Ok(segment_mapped) =3D> segment_mapped,
> +                Err(e) =3D> {
> +                    // clean up any successful mappings from previous =
SGT entries.
> +                    let total_mapped =3D iova - start_iova;
> +                    if total_mapped > 0 {
> +                        let _ =3D pt_unmap(context.pt, =
start_iova..(start_iova + total_mapped));
> +                    }
> +                    return Err(e);
> +                }
> +            };
> +
> +            // Since there could be a partial mapping, only advance =
by the actual amount mapped
> +            bytes_left_to_map -=3D segment_mapped;
> +            iova +=3D segment_mapped;
> +        }

I think this code doesn=E2=80=99t really guarantee that =
bytes_left_to_map =3D=3D 0
here. Iow, there is no guarantee that the size of the SG table and the =
size of
the requested mapping match, and in that case, the requested region is
allocated on the interval tree even though it's not 100% mapped.

I would add an early check like this:

    // The object must back the whole window this op maps.
    let end =3D op.gem_offset().checked_add(op.length()).ok_or(EINVAL)?;
    if end > op.obj().size() as u64 {
        return Err(EINVAL);
    }

And also check for bytes_to_map =3D=3D 0 at the end of the loop.

> +
> +        let gpuva =3D context.preallocated_gpuva()?;
> +        let op =3D op.insert(gpuva, pin_init::init_zeroed());
> +
> +        Ok(op)
> +    }
> +
> +    /// Indicates that an existing mapping should be removed.
> +    fn sm_step_unmap<'op>(
> +        &mut self,
> +        op: OpUnmap<'op, Self>,
> +        context: &mut Self::SmContext<'_>,
> +    ) -> Result<OpUnmapped<'op, Self>, Error> {
> +        let start_iova =3D op.va().addr();
> +        let length =3D op.va().length();
> +
> +        let region =3D start_iova..(start_iova + length);
> +        pt_unmap(context.pt, region.clone()).inspect_err(|e| {
> +            pr_err!(
> +                "Failed to unmap region {:#x}..{:#x}: {:?}\n",
> +                region.start,
> +                region.end,
> +                e
> +            );
> +        })?;
> +
> +        let (op_unmapped, _va_removed) =3D op.remove();
> +
> +        Ok(op_unmapped)
> +    }
> +
> +    /// Indicates that an existing mapping should be split up.
> +    fn sm_step_remap<'op>(
> +        &mut self,
> +        op: OpRemap<'op, Self>,
> +        context: &mut Self::SmContext<'_>,
> +    ) -> Result<OpRemapped<'op, Self>, Error> {
> +        let unmap_start =3D if let Some(prev) =3D op.prev() {
> +            prev.addr() + prev.length()
> +        } else {
> +            op.va_to_unmap().addr()
> +        };
> +
> +        let unmap_end =3D if let Some(next) =3D op.next() {
> +            next.addr()
> +        } else {
> +            op.va_to_unmap().addr() + op.va_to_unmap().length()
> +        };
> +
> +        let unmap_length =3D unmap_end - unmap_start;
> +
> +        if unmap_length > 0 {
> +            let region =3D unmap_start..(unmap_start + unmap_length);
> +            pt_unmap(context.pt, region.clone()).inspect_err(|e| {
> +                pr_err!(
> +                    "Failed to unmap remap region {:#x}..{:#x}: =
{:?}\n",
> +                    region.start,
> +                    region.end,
> +                    e
> +                );
> +            })?;
> +        }
> +
> +        let prev_va =3D context.preallocated_gpuva()?;
> +        let next_va =3D context.preallocated_gpuva()?;
> +
> +        let (op_remapped, _remap_ret) =3D op.remap(
> +            [prev_va, next_va],
> +            pin_init::init_zeroed(),
> +            pin_init::init_zeroed(),
> +        );
> +
> +        Ok(op_remapped)
> +    }
> +}
> +
> +/// This function selects the largest supported block size (currently =
4KB or 2MB)
> +/// that can be used for a mapping at the given address and size, =
respecting alignment constraints.
> +///
> +/// We can map multiple pages at once but we can't exceed the size of =
the
> +/// table entry itself. So, if mapping 4KB pages, figure out how many =
pages
> +/// can be mapped before we hit the 2MB boundary. Or, if mapping 2MB =
pages,
> +/// figure out how many pages can be mapped before hitting the 1GB =
boundary
> +/// Returns the page size (4KB or 2MB) and the number of pages that =
can be mapped at that size.
> +fn get_pgsize(addr: u64, size: u64) -> (u64, u64) {
> +    // Get the distance to the next boundary of 2MB block
> +    let blk_offset_2m =3D addr.wrapping_neg() % (SZ_2M as u64);
> +
> +    // Use 4K blocks if the address is not 2MB aligned, or we have =
less than 2MB to map
> +    if blk_offset_2m !=3D 0 || size < SZ_2M as u64 {
> +        let pgcount =3D if blk_offset_2m =3D=3D 0 {
> +            size / SZ_4K as u64
> +        } else {
> +            u64::min(blk_offset_2m, size) / SZ_4K as u64
> +        };
> +        return (SZ_4K as u64, pgcount);
> +    }
> +
> +    let blk_offset_1g =3D addr.wrapping_neg() % (SZ_1G as u64);
> +    let blk_offset =3D if blk_offset_1g =3D=3D 0 {
> +        SZ_1G as u64
> +    } else {
> +        blk_offset_1g
> +    };
> +    let pgcount =3D u64::min(blk_offset, size) / SZ_2M as u64;
> +
> +    (SZ_2M as u64, pgcount)
> +}
> +
> +/// Maps a physical address range into the page table at the =
specified virtual address.
> +///
> +/// This function maps `len` bytes of physical memory starting at =
`paddr` to the
> +/// virtual address `iova`, using the protection flags specified in =
`prot`. It
> +/// automatically selects optimal page sizes to minimize page table =
overhead.
> +///
> +/// If the mapping fails partway through, all successfully mapped =
pages are
> +/// unmapped before returning an error.
> +///
> +/// Returns the number of bytes successfully mapped.
> +fn pt_map(
> +    pt: &IoPageTable<'_, ARM64LPAES1>,
> +    iova: u64,
> +    paddr: u64,
> +    len: u64,
> +    prot: u32,
> +) -> Result<u64> {
> +    let mut segment_mapped =3D 0u64;
> +    while segment_mapped < len {
> +        let remaining =3D len - segment_mapped;
> +        let curr_iova =3D iova + segment_mapped;
> +        let curr_paddr =3D paddr + segment_mapped;
> +
> +        let (pgsize, pgcount) =3D get_pgsize(curr_iova | curr_paddr, =
remaining);
> +
> +        // SAFETY:
> +        // No other io-pgtable operation can currently access this =
range because Tyr holds
> +        // the gpuvm_unique mutex for the entire sm_map() operation.
> +        // The addresses being mapped won't overlap any existing =
mappings in this
> +        // page table because drm_gpuvm_sm_map() checks each =
requested mapping and either unmaps
> +        // or remaps any overlap before creating the new mapping.
> +        let (mapped, result) =3D unsafe {
> +            pt.map_pages(
> +                curr_iova as usize,
> +                (curr_paddr as usize).try_into().unwrap(),
> +                pgsize as usize,
> +                pgcount as usize,
> +                prot,
> +                GFP_KERNEL,
> +            )
> +        };
> +
> +        if let Err(e) =3D result {
> +            pr_err!("pt.map_pages failed at iova {:#x}: {:?}\n", =
curr_iova, e);
> +            if segment_mapped > 0 {
> +                let _ =3D pt_unmap(pt, iova..(iova + =
segment_mapped));
> +            }
> +            return Err(e);
> +        }
> +
> +        if mapped =3D=3D 0 {
> +            pr_err!("Failed to map any pages at iova {:#x}\n", =
curr_iova);
> +            if segment_mapped > 0 {
> +                let _ =3D pt_unmap(pt, iova..(iova + =
segment_mapped));
> +            }
> +            return Err(ENOMEM);
> +        }
> +
> +        segment_mapped +=3D mapped as u64;
> +    }
> +
> +    Ok(segment_mapped)
> +}
> +
> +/// Unmaps a virtual address range from the page table.
> +///
> +/// This function removes all page table entries in the specified =
range,
> +/// automatically handling different page sizes that may be present.
> +fn pt_unmap(pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>) -> =
Result {
> +    let mut iova =3D range.start;
> +    let mut bytes_left_to_unmap =3D range.end - range.start;
> +
> +    while bytes_left_to_unmap > 0 {
> +        let (pgsize, pgcount) =3D get_pgsize(iova, =
bytes_left_to_unmap);
> +
> +        // SAFETY:
> +        // No other io-pgtable operation can currently access this =
range because Tyr holds
> +        // the gpuvm_unique mutex for the entire sm_unmap() =
operation.
> +        // We know that this page table has one or more consecutive =
mappings
> +        // starting at `iova` with the total size of `pgcount * =
pgsize` because
> +        // gpuvm callbacks provide exactly the range that was =
previously mapped.
> +        let unmapped =3D unsafe { pt.unmap_pages(iova as usize, =
pgsize as usize, pgcount as usize) };
> +
> +        if unmapped =3D=3D 0 {
> +            pr_err!("Failed to unmap any bytes at iova {:#x}\n", =
iova);
> +            return Err(EINVAL);
> +        }
> +
> +        bytes_left_to_unmap -=3D unmapped as u64;
> +        iova +=3D unmapped as u64;
> +    }
> +
> +    Ok(())
> +}
>=20
> --=20
> 2.54.0
>=20

