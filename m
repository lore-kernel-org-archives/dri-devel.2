Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E026AC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4110E10EB6F;
	Tue, 21 Jul 2026 21:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="NnYxUm5O";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC60F10EB6F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 21:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784668412; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MIK2oNBNrHEnfXc+nl5bE35WiSVXeYstuDjMSNWM8pWnqhUG0vBu89W3zRdJAt5a+Gf+FMyMFd6UWJL9rI1BaoD/IVzIQif+xW8UPysir7uWaCdDnYVDeMgxR8ozHRcbZGBovJOLbIhdS5RjzasKY/H/aISZKqwNvXmxzQuTIbc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784668412;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B5MnkAkKVPQB4CbZ3x0AqoQskLWcHWS/O8H+mC3rH6c=; 
 b=oLFRWPzsG4NLxlyO9nHY+dTFS87gpCF9rsUxtV1G7qs9Rzjj+8fnZnkKgM9hGuSnwQIKTTFUC+1Ub8VYyrKTxCsrtDqMcrT/YBi+sucKUL42Ezg7qT8TK1vXVKx+LdBdODyMetA5apZ2VIcg892M9tmb4IF1eU1ONYz42RppKfQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784668412; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=B5MnkAkKVPQB4CbZ3x0AqoQskLWcHWS/O8H+mC3rH6c=;
 b=NnYxUm5OUxHr0UoNbekAnhSnRDWTZYgpc6bP4Fnf+86fYyDpo1qPFH6wzBJgEn9f
 psF5Gw/yQ1n0z1fdieBNNm9LEFbQYVNodo5xYN3fzARLgkmDNQ2OdNGcjONFmxXr8iL
 K0+rypfsRsoK8nLRfAu3EQS1XembIjiAqPz5L/dM=
Received: by mx.zohomail.com with SMTPS id 1784668410354357.298122545111;
 Tue, 21 Jul 2026 14:13:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v7 7/7] drm/tyr: add Microcontroller Unit (MCU) booting
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260713-fw-boot-b4-v7-7-afd8dc1494dd@collabora.com>
Date: Tue, 21 Jul 2026 18:13:12 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 samitolvanen@google.com, work@onurozkan.dev, acourbot@nvidia.com,
 lyude@redhat.com, laura.nao@collabora.com, beata.michalska@arm.com,
 alvin.sun@linux.dev, steven.price@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EA774F9-500F-43B6-99D2-1447A695F467@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-7-afd8dc1494dd@collabora.com>
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
> Add a firmware module to load, parse, and map the MCU firmware =
sections
> into shared GEM memory at the required virtual addresses accessible by =
the
> GPU.
>=20
> Create a firmware instance during probe and store it inside the
> TyrDrmRegistrationData to keep it alive after probe. Use the firmware
> instance to boot the MCU.
>=20
> Remove the dead-code annotations from the MMU, VM, slot manager, and
> kernel BO code now that these paths are used by the firmware module.
>=20
> Update Kconfig to add the RUST_FW_LOADER_ABSTRACTIONS dependency
> required by this module.
>=20
> Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/Kconfig   |   1 +
> drivers/gpu/drm/tyr/driver.rs |  17 ++-
> drivers/gpu/drm/tyr/fw.rs     | 263 =
++++++++++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/gem.rs    |   3 -
> drivers/gpu/drm/tyr/tyr.rs    |   1 +
> drivers/gpu/drm/tyr/vm.rs     |   1 -
> 6 files changed, 281 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
> index 79ea4bb214de..8f13e49f11f9 100644
> --- a/drivers/gpu/drm/tyr/Kconfig
> +++ b/drivers/gpu/drm/tyr/Kconfig
> @@ -13,6 +13,7 @@ config DRM_TYR
> select IOMMU_IO_PGTABLE_LPAE
> select RUST_DRM_GEM_SHMEM_HELPER
> select RUST_DRM_GPUVM
> + select RUST_FW_LOADER_ABSTRACTIONS
> help
>  Rust DRM driver for ARM Mali CSF-based GPUs.
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index 9195c8be5203..46ba91af9aca 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -37,6 +37,7 @@
>=20
> use crate::{
>     file::TyrDrmFileData,
> +    fw::Firmware,
>     gem::Bo,
>     gpu,
>     gpu::GpuInfo,
> @@ -67,6 +68,9 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
>     /// Parent platform device.
>     pub(crate) pdev: &'bound platform::Device<Bound>,
>=20
> +    /// Firmware sections.
> +    pub(crate) fw: Firmware<'bound>,
> +
>     #[pin]
>     clks: Mutex<Clocks>,
>=20
> @@ -144,10 +148,21 @@ fn probe<'bound>(
>=20
>         let unreg_dev =3D =
drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
>=20
> -        let _mmu =3D Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
> +        let mmu =3D Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
> +
> +        let firmware =3D Firmware::new(
> +            pdev.as_ref(),
> +            iomem.clone(),
> +            &unreg_dev,
> +            mmu.as_arc_borrow(),
> +            &gpu_info,
> +        )?;
> +
> +        firmware.boot()?;
>=20
>         let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
>                 pdev,
> +                fw: firmware,
>                 clks <- new_mutex!(Clocks {
>                     core: core_clk,
>                     stacks: stacks_clk,
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> new file mode 100644
> index 000000000000..554808a792aa
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Firmware loading and management for Mali CSF GPU.
> +//!
> +//! This module handles loading the Mali GPU firmware binary, parsing =
it into sections,
> +//! and mapping those sections into the MCU's virtual address space. =
Each firmware section
> +//! has specific properties (read/write/execute permissions, cache =
modes) and must be loaded
> +//! at specific virtual addresses expected by the MCU.
> +//!
> +//! See [`Firmware`] for the main firmware management interface and =
[`Section`] for
> +//! individual firmware sections.
> +//!
> +//! [`Firmware`]: crate::fw::Firmware
> +//! [`Section`]: crate::fw::Section
> +
> +use kernel::{
> +    bits::genmask_u32,
> +    device::{
> +        Bound,
> +        Device, //
> +    },
> +    drm::{
> +        gem::BaseObject, //
> +    },
> +    impl_flags,
> +    io::{
> +        poll,
> +        Io, //
> +    },
> +    prelude::*,
> +    str::CString,
> +    sync::{
> +        Arc,
> +        ArcBorrow, //
> +    },
> +    time, //
> +};
> +
> +use crate::{
> +    driver::{
> +        IoMem,
> +        TyrDrmDevice, //
> +    },
> +    fw::parser::{
> +        FwParser,
> +        ParsedSection, //
> +    },
> +    gem,
> +    gem::{
> +        KernelBo,
> +        KernelBoVaAlloc, //
> +    },
> +    gpu::GpuInfo,
> +
> +    mmu::Mmu,
> +    regs::{
> +        gpu_control::{
> +            McuControlMode,
> +            McuStatus,
> +            GPU_ID,
> +            MCU_CONTROL,
> +            MCU_STATUS, //
> +        }, //
> +        job_control::JOB_IRQ_RAWSTAT, //
> +    },
> +    vm::Vm, //
> +};
> +
> +mod parser;
> +
> +impl_flags!(
> +    #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
> +    pub(super) struct SectionFlags(u32);
> +
> +    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +    pub(super) enum SectionFlag {
> +        Read =3D 1 << 0,
> +        Write =3D 1 << 1,
> +        Exec =3D 1 << 2,
> +        CacheModeNone =3D 0 << 3,
> +        CacheModeCached =3D 1 << 3,
> +        CacheModeUncachedCoherent =3D 2 << 3,
> +        CacheModeCachedCoherent =3D 3 << 3,
> +        Prot =3D 1 << 5,
> +        Shared =3D 1 << 30,
> +        Zero =3D 1 << 31,
> +    }
> +);

Can we please rewrite this with the bitfield macro instead?=20

I think we can use something like:

4:3 cache_mode =3D> CacheMode


> +
> +pub(super) const CACHE_MODE_MASK: SectionFlags =3D =
SectionFlags(genmask_u32(3..=3D4));
> +
> +pub(super) const CSF_MCU_SHARED_REGION_START: u32 =3D 0x04000000;
> +
> +impl SectionFlags {
> +    fn cache_mode(&self) -> SectionFlags {
> +        *self & CACHE_MODE_MASK
> +    }
> +}
> +
> +impl TryFrom<u32> for SectionFlags {
> +    type Error =3D Error;
> +
> +    fn try_from(value: u32) -> Result<Self, Self::Error> {
> +        let valid_flags =3D SectionFlags::from(SectionFlag::Read)
> +            | SectionFlags::from(SectionFlag::Write)
> +            | SectionFlags::from(SectionFlag::Exec)
> +            | CACHE_MODE_MASK
> +            | SectionFlags::from(SectionFlag::Prot)
> +            | SectionFlags::from(SectionFlag::Shared)
> +            | SectionFlags::from(SectionFlag::Zero);
> +
> +        if value & valid_flags.0 !=3D value {
> +            Err(EINVAL)
> +        } else {
> +            Ok(Self(value))
> +        }
> +    }
> +}
> +
> +/// A parsed section of the firmware binary.
> +struct Section<'bound> {
> +    // Raw firmware section data for reset purposes
> +    #[expect(dead_code)]
> +    data: KVec<u8>,
> +
> +    // Keep the BO backing this firmware section so that both the
> +    // GPU mapping and CPU mapping remain valid until the Section is =
dropped.
> +    #[expect(dead_code)]
> +    mem: gem::KernelBo<'bound>,
> +}
> +
> +/// Loaded firmware with sections mapped into MCU VM.
> +pub(crate) struct Firmware<'bound> {
> +    /// Iomem need to access registers.
> +    iomem: Arc<IoMem<'bound>>,
> +
> +    /// MCU VM.
> +    vm: Arc<Vm<'bound>>,
> +
> +    /// List of firmware sections.
> +    #[expect(dead_code)]
> +    sections: KVec<Section<'bound>>,
> +}
> +
> +impl<'bound> Drop for Firmware<'bound> {
> +    fn drop(&mut self) {
> +        // AS slots retain a VM ref, we need to kill the circular ref =
manually.
> +        self.vm.kill();
> +    }
> +}
> +
> +impl<'bound> Firmware<'bound> {
> +    fn init_section_mem(mem: &mut KernelBo<'bound>, data: &KVec<u8>) =
-> Result {
> +        if data.is_empty() {
> +            return Ok(());
> +        }
> +
> +        let vmap =3D mem.bo.vmap::<0>()?;
> +        let size =3D mem.bo.size();
> +
> +        if data.len() > size {
> +            pr_err!("fw section {} bigger than BO {}\n", data.len(), =
size);
> +            return Err(EINVAL);
> +        }
> +
> +        for (i, &byte) in data.iter().enumerate() {
> +            vmap.try_write8(byte, i)?;
> +        }
> +
> +        Ok(())
> +    }
> +
> +    fn request(ddev: &TyrDrmDevice, gpu_info: &GpuInfo) -> =
Result<kernel::firmware::Firmware> {
> +        let gpu_id =3D GPU_ID::from_raw(gpu_info.gpu_id);
> +
> +        let path =3D CString::try_from_fmt(fmt!(
> +            "arm/mali/arch{}.{}/mali_csffw.bin",
> +            gpu_id.arch_major().get(),
> +            gpu_id.arch_minor().get()
> +        ))?;
> +
> +        kernel::firmware::Firmware::request(&path, =
ddev.as_ref().as_ref())
> +    }
> +
> +    fn load(
> +        ddev: &TyrDrmDevice,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<(kernel::firmware::Firmware, KVec<ParsedSection>)> {
> +        let fw =3D Self::request(ddev, gpu_info)?;
> +        let mut parser =3D FwParser::new(fw.data());
> +
> +        let parsed_sections =3D parser.parse()?;
> +
> +        Ok((fw, parsed_sections))
> +    }
> +
> +    /// Load firmware and map sections into MCU VM.
> +    pub(crate) fn new(
> +        dev: &'bound Device<Bound>,
> +        iomem: Arc<IoMem<'bound>>,
> +        ddev: &TyrDrmDevice,
> +        mmu: ArcBorrow<'_, Mmu<'bound>>,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<Firmware<'bound>> {
> +        let vm =3D Vm::new(dev, ddev, mmu, gpu_info)?;
> +        vm.activate()?;
> +
> +        let (fw, parsed_sections) =3D Self::load(ddev, gpu_info)?;
> +        let mut sections =3D KVec::new();
> +        for parsed in parsed_sections {
> +            let size =3D (parsed.va.end - parsed.va.start) as usize;
> +            let va =3D u64::from(parsed.va.start);
> +
> +            let mut mem =3D KernelBo::new(
> +                ddev,
> +                vm.clone(),
> +                size.try_into().unwrap(),
> +                KernelBoVaAlloc::Explicit(va),
> +                parsed.vm_map_flags,
> +            )?;
> +
> +            let section_start =3D parsed.data_range.start as usize;
> +            let section_end =3D parsed.data_range.end as usize;
> +            let mut data =3D KVec::new();
> +
> +            // Ensure that the firmware slice is not out of bounds.
> +            let fw_data =3D fw.data();
> +            let bytes =3D =
fw_data.get(section_start..section_end).ok_or(EINVAL)?;
> +            data.extend_from_slice(bytes, GFP_KERNEL)?;
> +
> +            Self::init_section_mem(&mut mem, &data)?;
> +
> +            sections.push(Section { data, mem }, GFP_KERNEL)?;
> +        }
> +
> +        let firmware =3D Firmware {
> +            iomem,
> +            vm,
> +            sections,
> +        };
> +
> +        Ok(firmware)
> +    }
> +
> +    pub(crate) fn boot(&self) -> Result {
> +        let io =3D &self.iomem;
> +        =
io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto));
> +
> +        if let Err(e) =3D poll::read_poll_timeout(
> +            || Ok((io.read(MCU_STATUS), io.read(JOB_IRQ_RAWSTAT))),
> +            |(mcu_status, irq_rawstat)| {
> +                mcu_status.value() =3D=3D McuStatus::Enabled && =
irq_rawstat.glb()
> +            },
> +            time::Delta::from_millis(1),
> +            time::Delta::from_millis(100),
> +        ) {
> +            let status =3D io.read(MCU_STATUS);
> +            pr_err!("MCU failed to boot, status: {:?}", =
status.value());
> +            return Err(e);
> +        }
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 47a05a33388e..e9bf35682a47 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -72,7 +72,6 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) =
-> Result<ARef<Bo>> {
> /// An automatic VA allocation strategy will be added in the future.
> pub(crate) enum KernelBoVaAlloc {
>     /// Explicit VA address specified by the caller.
> -    #[expect(dead_code)]
>     Explicit(u64),
> }
>=20
> @@ -85,7 +84,6 @@ pub(crate) enum KernelBoVaAlloc {
> /// When dropped, the buffer is automatically unmapped from the GPU VA =
space.
> pub(crate) struct KernelBo<'bound> {
>     /// The underlying GEM buffer object.
> -    #[expect(dead_code)]
>     pub(crate) bo: ARef<Bo>,
>     /// The GPU VM this buffer is mapped into.
>     vm: Arc<Vm<'bound>>,
> @@ -99,7 +97,6 @@ impl<'bound> KernelBo<'bound> {
>     /// This function allocates a new shmem-backed GEM object and =
immediately maps
>     /// it into the specified GPU virtual memory space. The mapping is =
automatically
>     /// cleaned up when the [`KernelBo`] is dropped.
> -    #[expect(dead_code)]
>     pub(crate) fn new(
>         ddev: &TyrDrmDevice,
>         vm: Arc<Vm<'bound>>,
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 92f6885cdaae..e7ec450bdc9c 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -9,6 +9,7 @@
>=20
> mod driver;
> mod file;
> +mod fw;
> mod gem;
> mod gpu;
> mod mmu;
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 2358096afc7e..7534e68359bf 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs
> @@ -6,7 +6,6 @@
> //! the illusion of owning the entire virtual address (VA) range, =
similar to CPU virtual memory.
> //! Each virtual memory (VM) area is backed by ARM64 LPAE Stage 1 page =
tables and can be
> //! mapped into hardware address space (AS) slots for GPU execution.
> -#![expect(dead_code)]
>=20
> use core::marker::PhantomData;
> use core::ops::Range;
>=20
> --=20
> 2.54.0
>=20

Apart from the change I mentioned, this patch looks good to me.



