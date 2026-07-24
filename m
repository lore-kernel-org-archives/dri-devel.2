Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A5C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A3E10F404;
	Fri, 24 Jul 2026 15:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kL0RyUkw";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294CE10F404
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784905458; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=H1E3n3R8sf26g0+aygR/vK80xv7IaOa6P6lmxDVNMSMWha2wff4O12augY/luXeg0SuWJ2z2uL8gwZ2+sh59krxtudDckDrzM0vDMwyRxzDrp1PV8ozA1geNM3MevjYbARmHStexYuTN1274V+UUl2KhqTa0V/q7s8r4jQOb9kU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784905458;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pL4Vw0YM8bz3DuAOgTuwWCWcxTirgKaQSwICvuC3kmU=; 
 b=lZByapP4xB9twwmECv0BHV0VqjKUwUL7W0lHYu9vQY6HL3j+d22qs6zgFUr0KQtGBK05kgCN2yLgnmMPmkNgcc/pq04GqeTgf8jHBqOTYKXEtVre97J1HsUT7u4UZKnN8mnnhjs8ubyTqUyFYQT05LMNIMY+P+yxIpQAGQiRya0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784905458; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=pL4Vw0YM8bz3DuAOgTuwWCWcxTirgKaQSwICvuC3kmU=;
 b=kL0RyUkwaf/1TUFFYtT3KDu94Z8Hl3TxBU4uS5XDH1T+ekWRorZ98BtZpjZXoi9k
 bpxSHyJa8x+8u+3e44PECy37M0uSos0NakuQhTapWa7RWOI3d3M3o1K3lN2hLCDcunY
 +5Hds8Nlvs5Mf389Ap4dLwMvTx8MKwAZW991ywfA=
Received: by mx.zohomail.com with SMTPS id 17849054570631012.0241019890751;
 Fri, 24 Jul 2026 08:04:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v9 7/7] drm/tyr: add Microcontroller Unit (MCU) booting
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260722-fw-boot-b4-v9-7-8669d2a02590@collabora.com>
Date: Fri, 24 Jul 2026 12:03:57 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, samitolvanen@google.com, lyude@redhat.com,
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev,
 laura.nao@collabora.com, beata.michalska@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6D66D5F-87C0-4C22-8BCA-2DB827CB75A3@collabora.com>
References: <20260722-fw-boot-b4-v9-0-8669d2a02590@collabora.com>
 <20260722-fw-boot-b4-v9-7-8669d2a02590@collabora.com>
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



> On 22 Jul 2026, at 20:54, Deborah Brouwer =
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
> drivers/gpu/drm/tyr/driver.rs |  23 ++-
> drivers/gpu/drm/tyr/fw.rs     | 321 =
++++++++++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/gem.rs    |   3 -
> drivers/gpu/drm/tyr/tyr.rs    |   1 +
> drivers/gpu/drm/tyr/vm.rs     |   1 -
> 6 files changed, 341 insertions(+), 9 deletions(-)
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
> index b6528d8cd3ce..8f87fd5b772a 100644
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
> -        let _mmu =3D Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), =
&gpu_info)?;
> +        let mmu =3D Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), =
&gpu_info)?;
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
> -        let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
> +        let reg_data =3D pin_init!(TyrDrmRegistrationData {
>                 pdev,
> +                fw: firmware,
>                 clks <- new_mutex!(Clocks {
>                     core: core_clk,
>                     stacks: stacks_clk,
> @@ -167,9 +182,7 @@ fn probe<'bound>(
>=20
>         let driver =3D TyrPlatformDriverData { _reg: reg };
>=20
> -        // We need this to be dev_info!() because dev_dbg!() does not =
work at
> -        // all in Rust for now, and we need to see whether probe =
succeeded.
> -        dev_info!(pdev, "Tyr initialized correctly.\n");
> +        dev_dbg!(pdev, "Tyr initialized correctly.");
>         Ok(driver)
>     }
> }
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> new file mode 100644
> index 000000000000..df11647023c2
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -0,0 +1,321 @@
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
> +    device::{
> +        Bound,
> +        Device, //
> +    },
> +    drm::{
> +        gem::BaseObject, //
> +    },
> +    io::{
> +        poll,
> +        Io, //
> +    },
> +    num::Bounded,
> +    prelude::*,
> +    register,
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
> +        job_control::{
> +            JOB_IRQ_CLEAR,
> +            JOB_IRQ_RAWSTAT, //
> +        }, //
> +    },
> +    vm::Vm, //
> +};
> +
> +mod parser;
> +
> +pub(super) const CSF_MCU_SHARED_REGION_START: u32 =3D 0x04000000;
> +
> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> +#[repr(u8)]
> +pub(super) enum CacheMode {
> +    None =3D 0,
> +    Cached =3D 1,
> +    UncachedCoherent =3D 2,
> +    CachedCoherent =3D 3,
> +}
> +
> +impl From<Bounded<u32, 2>> for CacheMode {
> +    fn from(value: Bounded<u32, 2>) -> Self {
> +        match value.get() {
> +            0 =3D> Self::None,
> +            1 =3D> Self::Cached,
> +            2 =3D> Self::UncachedCoherent,
> +            3 =3D> Self::CachedCoherent,
> +            _ =3D> unreachable!(),
> +        }
> +    }
> +}
> +
> +impl From<CacheMode> for Bounded<u32, 2> {
> +    fn from(value: CacheMode) -> Self {
> +        Bounded::try_new(value as u32).unwrap()
> +    }
> +}
> +
> +register! {
> +     #[allow(non_upper_case_globals)]
> +    pub(super) SectionFlags(u32) @ 0x0 {
> +        0:0 read =3D> bool;
> +        1:1 write =3D> bool;
> +        2:2 exec =3D> bool;
> +        4:3 cache_mode =3D> CacheMode;
> +        5:5 prot =3D> bool;
> +        30:30 shared =3D> bool;
> +        31:31 zero =3D> bool;
> +    }
> +}
> +
> +impl SectionFlags {
> +    const VALID_MASK: u32 =3D Self::READ_MASK
> +        | Self::WRITE_MASK
> +        | Self::EXEC_MASK
> +        | Self::CACHE_MODE_MASK
> +        | Self::PROT_MASK
> +        | Self::SHARED_MASK
> +        | Self::ZERO_MASK;
> +
> +    fn try_from_fw(value: u32) -> Result<Self> {
> +        if value & !Self::VALID_MASK !=3D 0 {
> +            Err(EINVAL)
> +        } else {
> +            Ok(Self::from_raw(value))
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
> +        // Stop the MCU before releasing its firmware mappings and =
memory.
> +        let _ =3D self.stop();
> +
> +        // AS slots retain a VM ref, we need to kill the circular ref =
manually.
> +        self.vm.kill();
> +    }
> +}
> +
> +impl<'bound> Firmware<'bound> {
> +    fn init_section_mem(dev: &Device, mem: &mut KernelBo<'bound>, =
data: &KVec<u8>) -> Result {
> +        if data.is_empty() {
> +            return Ok(());
> +        }
> +
> +        let vmap =3D mem.bo().vmap::<0>()?;
> +        let size =3D mem.bo().size();
> +
> +        if data.len() > size {
> +            dev_err!(dev, "fw section {} bigger than BO {}", =
data.len(), size);
> +            return Err(EINVAL);
> +        }
> +
> +        for (i, &byte) in data.iter().enumerate() {
> +            vmap.try_write8(byte, i)?;

Can this use vmap.copy_from_slice() instead?

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
> +        dev: &Device,
> +        ddev: &TyrDrmDevice,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<(kernel::firmware::Firmware, KVec<ParsedSection>)> {
> +        let fw =3D Self::request(ddev, gpu_info)?;
> +        let mut parser =3D FwParser::new(dev, fw.data());
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
> +        let result =3D (|| {
> +            let (fw, parsed_sections) =3D Self::load(dev, ddev, =
gpu_info)?;
> +            let mut sections =3D KVec::new();
> +            for parsed in parsed_sections {
> +                let size =3D =
u64::from(parsed.va.end.checked_sub(parsed.va.start).ok_or(EINVAL)?);
> +
> +                let va =3D u64::from(parsed.va.start);
> +
> +                let mut mem =3D KernelBo::new(
> +                    ddev,
> +                    vm.clone(),
> +                    size,
> +                    KernelBoVaAlloc::Explicit(va),
> +                    parsed.vm_map_flags,
> +                )?;
> +
> +                let section_start =3D parsed.data_range.start as =
usize;
> +                let section_end =3D parsed.data_range.end as usize;
> +                let mut data =3D KVec::new();
> +
> +                // Ensure that the firmware slice is not out of =
bounds.
> +                let fw_data =3D fw.data();
> +                let bytes =3D =
fw_data.get(section_start..section_end).ok_or(EINVAL)?;
> +                data.extend_from_slice(bytes, GFP_KERNEL)?;
> +
> +                Self::init_section_mem(dev, &mut mem, &data)?;
> +
> +                sections.push(Section { data, mem }, GFP_KERNEL)?;
> +            }
> +
> +            Ok(Firmware {
> +                iomem,
> +                vm: vm.clone(),
> +                sections,
> +            })
> +        })();
> +
> +        if result.is_err() {
> +            vm.kill();
> +        }
> +
> +        result
> +    }
> +
> +    pub(crate) fn boot(&self) -> Result {
> +        let io =3D &self.iomem;
> +
> +        // Discard any stale global interrupt.
> +        io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true));
> +
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
> +            dev_err!(
> +                self.vm.dev(),
> +                "MCU failed to boot, status: {:?}",
> +                status.value()
> +            );
> +            return Err(e);
> +        }
> +
> +        io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true));
> +
> +        Ok(())
> +    }
> +
> +    fn stop(&self) -> Result {
> +        let io =3D &self.iomem;
> +        =
io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Disable));
> +
> +        if let Err(e) =3D poll::read_poll_timeout(
> +            || Ok(io.read(MCU_STATUS)),
> +            |status| status.value() =3D=3D McuStatus::Disabled,
> +            time::Delta::from_micros(10),
> +            time::Delta::from_millis(100),
> +        ) {
> +            let status =3D io.read(MCU_STATUS);
> +            dev_err!(
> +                self.vm.dev(),
> +                "MCU failed to stop, status: {:?}",
> +                status.value()
> +            );
> +            return Err(e);
> +        }
> +
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index b371299028d6..342d3303a0c0 100644
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
> @@ -98,7 +97,6 @@ impl<'bound> KernelBo<'bound> {
>     /// This function allocates a new shmem-backed GEM object and =
immediately maps
>     /// it into the specified GPU virtual memory space. The mapping is =
automatically
>     /// cleaned up when the [`KernelBo`] is dropped.
> -    #[expect(dead_code)]
>     pub(crate) fn new(
>         ddev: &TyrDrmDevice,
>         vm: Arc<Vm<'bound>>,
> @@ -135,7 +133,6 @@ pub(crate) fn new(
>         })
>     }
>=20
> -    #[expect(dead_code)]
>     pub(crate) fn bo(&self) -> &Bo {
>         &self.bo
>     }
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
> index c113820b5505..418f98ab07fb 100644
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
> 2.55.0
>=20

