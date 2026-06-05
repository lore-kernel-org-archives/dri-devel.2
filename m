Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CE1CD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D4811A4CD;
	Fri,  5 Jun 2026 07:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="S7djSLL3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C2311A4CC
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780643250;
 bh=/l1CMldbbk+uHSJxS56tfJAL0WmSQnutajowXHyxMbo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S7djSLL39zsP1S/np95vTBm3uUhY45rbHqUELEKlkdR6/bdAQtHFhWdDiXswbwOA8
 NN2Dt/61VEcAuZuudSEDyW90e+X8IPLbrU3uv8msp7M+9CoyYpiDNOsoy1U/7xkvcy
 fSWT//4jA1A2A216YlyZ28RE1IezocGY0PW3LC0QVY/vS8JsTSJOUEdZUhHooOHyrZ
 LAghxhfHtXvt59RHD9vVF2s2huB3MTeOcXYUvahBVNpxQF9SzMYYW8u11G/CVR4cRX
 juC8MnugOCVqS6yRgVaDrfYZnPeSNhcFeOcQ9gH6VEaMIvxvqHv9RdDV6e8gmlecAb
 IeQXYcpHGcG6w==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CDEC017E0432;
 Fri,  5 Jun 2026 09:07:29 +0200 (CEST)
Date: Fri, 5 Jun 2026 09:07:14 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, laura.nao@collabora.com,
 samitolvanen@google.com
Subject: Re: [PATCH v2] drm/tyr: move probe resources into registration data
Message-ID: <20260605090714.2c4c7945@fedora-2.home>
In-Reply-To: <20260604-use_tyr_reg_data-v2-1-f77a1ffcf08d@collabora.com>
References: <20260604-use_tyr_reg_data-v2-1-f77a1ffcf08d@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 04 Jun 2026 16:26:12 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> Introduce TyrDrmRegistrationData to hold resources that need to stay alive
> while the DRM device is registered. This moves the parent platform device,
> clocks, regulators, MMIO mapping, firmware state, and GPU info into data
> owned by the DRM registration.
> 
> The registration data is tied to the platform device binding lifetime, so
> use Registration::new_with_lt() and store the returned Registration in the
> platform driver data.
> 
> Add initial stubs for firmware, MMU, VM, and address-space handling, to
> show the intended ownership model.

I get that it's useful to prove that things work as intended, but I'd
prefer if were submitting the working implementation instead of the
stub, since we have it. Anyway, this should at least be done in separate
commits (first the RegData with just the things we need today, then
commits to show what it would look like with real components).

> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Changes in v2:
>  - Store the parent platform device as a bound reference instead of as an ARef.
>  - Store Firmware directly instead of in an Arc.
>  - Replace manual ForLt implementation with the ForLt!() macro.
>  - Remove TyrDrmDeviceData and just pass Ok(()) to UnregisteredDevice::new().
>  - Complete firmware boot() as an example of it using iomem.
>  - Add more content to the MMU stub as well as VM, and address-space stubs
>    to show how iomem is shared.
> 
> - Link to v1: https://lore.kernel.org/r/20260603-use_tyr_reg_data-v1-1-97f64e951cf6@collabora.com
> 
> This patch applies on top of the drm lifetime series [1] and the
> full branch [2].
> 
> [1] https://lore.kernel.org/rust-for-linux/20260603011711.2077361-1-dakr@kernel.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm-lifetime
> ---
>  drivers/gpu/drm/tyr/driver.rs            | 49 ++++++++++++++----
>  drivers/gpu/drm/tyr/file.rs              | 11 ++--
>  drivers/gpu/drm/tyr/fw.rs                | 88 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tyr/mmu.rs               | 56 ++++++++++++++++++++
>  drivers/gpu/drm/tyr/mmu/address_space.rs | 63 +++++++++++++++++++++++
>  drivers/gpu/drm/tyr/tyr.rs               |  3 ++
>  drivers/gpu/drm/tyr/vm.rs                | 62 ++++++++++++++++++++++
>  7 files changed, 316 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 819f64a7573d..7f2d2e8eb7de 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -6,6 +6,7 @@
>          OptionalClk, //
>      },
>      device::{
> +        Bound,
>          Core,
>          Device,
>          DeviceContext, //
> @@ -29,6 +30,7 @@
>      sizes::SZ_2M,
>      sync::{
>          aref::ARef,
> +        Arc,
>          Mutex, //
>      },
>      time,
> @@ -37,9 +39,11 @@
>  
>  use crate::{
>      file::TyrDrmFileData,
> +    fw::Firmware,
>      gem::BoData,
>      gpu,
>      gpu::GpuInfo,
> +    mmu::Mmu,
>      regs::gpu_control::*, //
>  };
>  
> @@ -49,7 +53,6 @@
>  
>  /// Convenience type alias for the DRM device type for this driver.
>  pub(crate) type TyrDrmDevice<Ctx = drm::Registered> = drm::Device<TyrDrmDriver, Ctx>;
> -
>  pub(crate) struct TyrPlatformDriver;
>  
>  #[pin_data(PinnedDrop)]
> @@ -58,9 +61,14 @@ pub(crate) struct TyrPlatformDriverData<'bound> {
>      _reg: drm::Registration<'bound, TyrDrmDriver>,
>  }
>  
> +/// Resources kept alive by the DRM registration.
>  #[pin_data]
> -pub(crate) struct TyrDrmDeviceData {
> -    pub(crate) pdev: ARef<platform::Device>,
> +pub(crate) struct TyrDrmRegistrationData<'bound> {
> +    /// Parent platform device.
> +    pub(crate) pdev: &'bound platform::Device<Bound>,
> +
> +    /// Firmware sections.
> +    pub(crate) fw: Firmware<'bound>,
>  
>      #[pin]
>      clks: Mutex<Clocks>,
> @@ -68,6 +76,9 @@ pub(crate) struct TyrDrmDeviceData {
>      #[pin]
>      regulators: Mutex<Regulators>,
>  
> +    /// GPU MMIO register mapping.
> +    pub(crate) iomem: Arc<IoMem<'bound>>,
> +
>      /// Some information on the GPU.
>      ///
>      /// This is mainly queried by userspace, i.e.: Mesa.
> @@ -119,7 +130,7 @@ fn probe<'bound>(
>          let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
>  
>          let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
> -        let iomem = request.iomap_sized::<SZ_2M>()?;
> +        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
>  
>          issue_soft_reset(pdev.as_ref(), &iomem)?;
>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> @@ -135,10 +146,23 @@ fn probe<'bound>(
>          // other threads of execution.
>          unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
>  
> -        let platform: ARef<platform::Device> = pdev.into();
> +        let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
> +
> +        let mmu = Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
> +
> +        let firmware = Firmware::new(
> +            pdev,
> +            iomem.clone(),
> +            &unreg_dev,
> +            mmu.as_arc_borrow(),
> +            &gpu_info,
> +        )?;
> +
> +        firmware.boot()?;
>  
> -        let data = try_pin_init!(TyrDrmDeviceData {
> -                pdev: platform.clone(),
> +        let reg_data = try_pin_init!(TyrDrmRegistrationData {
> +                pdev,
> +                fw: firmware,
>                  clks <- new_mutex!(Clocks {
>                      core: core_clk,
>                      stacks: stacks_clk,
> @@ -148,11 +172,14 @@ fn probe<'bound>(
>                      _mali: mali_regulator,
>                      _sram: sram_regulator,
>                  }),
> +                iomem,
>                  gpu_info,
>          });
>  
> -        let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
> -        let reg = drm::Registration::new(pdev.as_ref(), tdev, (), 0)?;
> +        // SAFETY: `reg` is stored in the platform driver data and is not leaked or
> +        // forgotten, so it is dropped before the `'bound` registration data can become
> +        // invalid.
> +        let reg = unsafe { drm::Registration::new_with_lt(pdev.as_ref(), unreg_dev, reg_data, 0)? };
>  
>          let driver = TyrPlatformDriverData {
>              _device: reg.device().into(),
> @@ -183,8 +210,8 @@ fn drop(self: Pin<&mut Self>) {}
>  
>  #[vtable]
>  impl drm::Driver for TyrDrmDriver {
> -    type Data = TyrDrmDeviceData;
> -    type RegistrationData = ForLt!(());
> +    type Data = ();
> +    type RegistrationData = ForLt!(TyrDrmRegistrationData<'_>);
>      type File = TyrDrmFileData;
>      type Object<R: drm::DeviceContext> = drm::gem::shmem::Object<BoData, R>;
>      type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 9f53da7633ab..9baec67febc9 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -11,7 +11,8 @@
>  
>  use crate::driver::{
>      TyrDrmDevice,
> -    TyrDrmDriver, //
> +    TyrDrmDriver,
> +    TyrDrmRegistrationData, //
>  };
>  
>  #[pin_data]
> @@ -30,16 +31,16 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
>  
>  impl TyrDrmFileData {
>      pub(crate) fn dev_query(
> -        ddev: &TyrDrmDevice,
> +        _ddev: &TyrDrmDevice,
>          _pdev: &platform::Device<device::Bound>,
> -        _reg_data: &(),
> +        reg_data: &TyrDrmRegistrationData<'_>,
>          devquery: &mut uapi::drm_panthor_dev_query,
>          _file: &TyrDrmFile,
>      ) -> Result<u32> {
>          if devquery.pointer == 0 {
>              match devquery.type_ {
>                  uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
> -                    devquery.size = core::mem::size_of_val(&ddev.gpu_info) as u32;
> +                    devquery.size = core::mem::size_of_val(&reg_data.gpu_info) as u32;
>                      Ok(0)
>                  }
>                  _ => Err(EINVAL),
> @@ -53,7 +54,7 @@ pub(crate) fn dev_query(
>                      )
>                      .writer();
>  
> -                    writer.write(&ddev.gpu_info)?;
> +                    writer.write(&reg_data.gpu_info)?;
>  
>                      Ok(0)
>                  }
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> new file mode 100644
> index 000000000000..fb4b6709bce1
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Firmware loading and management for Mali CSF GPUs.
> +//!
> +//! This is currently only a lifetime/resource stub. The actual firmware parser,
> +//! section loading, MCU VM mapping, and boot sequence will be added later.
> +#![allow(dead_code)]
> +
> +use kernel::{
> +    device::Bound,
> +    drm::Uninit,
> +    io::{
> +        poll,
> +        Io, //
> +    },
> +    platform,
> +    prelude::*,
> +    sync::{
> +        Arc,
> +        ArcBorrow, //
> +    },
> +    time::Delta, //
> +};
> +
> +use crate::{
> +    driver::{
> +        IoMem,
> +        TyrDrmDevice, //
> +    },
> +    gpu::GpuInfo,
> +    mmu::Mmu,
> +    regs::gpu_control::{
> +        McuControlMode,
> +        McuStatus,
> +        MCU_CONTROL,
> +        MCU_STATUS, //
> +    },
> +    vm::Vm, //
> +};
> +
> +/// Firmware state for a bound Tyr device.
> +///
> +/// For now this only keeps the device resources alive. Later this will own the
> +/// loaded firmware sections, MCU VM mappings, and boot state.
> +pub(crate) struct Firmware<'bound> {
> +    /// Parent platform device.
> +    _pdev: &'bound platform::Device<Bound>,
> +
> +    /// MMIO mapping used for firmware/MCU register access.
> +    iomem: Arc<IoMem<'bound>>,
> +}
> +
> +impl<'bound> Firmware<'bound> {
> +    /// Create firmware state for this device.
> +    ///
> +    /// This stub only records the resources that future firmware loading code
> +    /// will need.
> +    pub(crate) fn new(
> +        pdev: &'bound platform::Device<Bound>,
> +        iomem: Arc<IoMem<'bound>>,
> +        ddev: &TyrDrmDevice<Uninit>,
> +        mmu: ArcBorrow<'_, Mmu<'bound>>,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<Firmware<'bound>> {
> +        let vm = Vm::new(pdev, ddev, mmu, gpu_info)?;
> +        vm.activate()?;
> +
> +        Ok(Firmware { _pdev: pdev, iomem })
> +    }
> +
> +    /// Boot the firmware.
> +    pub(crate) fn boot(&self) -> Result {
> +        let io = &self.iomem;
> +        io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto));
> +
> +        if let Err(e) = poll::read_poll_timeout(
> +            || Ok(io.read(MCU_STATUS)),
> +            |status| status.value() == McuStatus::Enabled,
> +            Delta::from_millis(1),
> +            Delta::from_millis(100),
> +        ) {
> +            let status = io.read(MCU_STATUS);
> +            pr_err!("MCU failed to boot, status: {:?}", status.value());
> +            return Err(e);
> +        }
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
> new file mode 100644
> index 000000000000..9e2efe342df3
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/mmu.rs
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Memory Management Unit (MMU) driver for the Tyr GPU.
> +//!
> +//! This is just a lifetime/resource stub.
> +//! The actual MMU initialization, page table management,
> +//! and GPU VM mapping will be added later.
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
> +    mmu::address_space::AddressSpaceManager,
> +    regs::gpu_control::AS_PRESENT, //
> +};
> +
> +pub(crate) mod address_space;
> +
> +#[pin_data]
> +pub(super) struct Mmu<'bound> {
> +    /// Manages the allocation of hardware MMU slots to GPU address spaces.
> +    #[pin]
> +    pub(crate) as_manager: Mutex<AddressSpaceManager<'bound>>,
> +}
> +
> +impl<'bound> Mmu<'bound> {
> +    /// Create an MMU component for this device.
> +    pub(super) fn new(
> +        iomem: ArcBorrow<'_, IoMem<'bound>>,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<Arc<Mmu<'bound>>> {
> +        let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
> +        let slot_count: usize = present.count_ones().try_into()?;
> +        pr_info!("MMU: {} address space slots present", slot_count);
> +
> +        let as_manager = AddressSpaceManager::new(iomem)?;
> +        let mmu_init = try_pin_init!(Self{
> +            as_manager <- new_mutex!(as_manager),
> +        });
> +        Arc::pin_init(mmu_init, GFP_KERNEL)
> +    }
> +
> +    /// Make a VM active.
> +    pub(crate) fn activate_vm(&self) -> Result {
> +        self.as_manager.lock().activate_vm()
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
> new file mode 100644
> index 000000000000..47534944b458
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! GPU address space management and hardware operations.
> +//!
> +//! This is just a lifetime/resource stub.
> +//! The actual GPU hardware address spaces (AS), including configuration,
> +//! command submission, and page table update regions will be added later.
> +
> +use kernel::{
> +    io::{
> +        poll,
> +        register::Array,
> +        Io, //
> +    },
> +    prelude::*,
> +    sync::{
> +        Arc, //
> +        ArcBorrow,
> +    },
> +    time::Delta, //
> +};
> +
> +use crate::{
> +    driver::IoMem,
> +    regs::mmu_control::mmu_as_control::STATUS, //
> +};
> +
> +/// Manages GPU hardware address spaces via MMIO register operations.
> +pub(crate) struct AddressSpaceManager<'bound> {
> +    /// Memory-mapped I/O region for GPU register access.
> +    iomem: Arc<IoMem<'bound>>,
> +}
> +
> +impl<'bound> AddressSpaceManager<'bound> {
> +    /// Creates a new address space manager.
> +    ///
> +    /// Initializes the manager with references to the platform device and
> +    /// I/O memory region, along with the bitmask of available AS slots.
> +    pub(super) fn new(iomem: ArcBorrow<'_, IoMem<'bound>>) -> Result<AddressSpaceManager<'bound>> {
> +        Ok(Self {
> +            iomem: iomem.into(),
> +        })
> +    }
> +
> +    pub(super) fn activate_vm(&mut self) -> Result {
> +        self.as_wait_ready(0)
> +    }
> +
> +    /// Waits for an AS slot to become ready (not active).
> +    ///
> +    /// Returns an error if polling times out after 10ms or if register access fails.
> +    fn as_wait_ready(&self, as_nr: usize) -> Result {
> +        let io = &*self.iomem;
> +        let op = || {
> +            let status_reg = STATUS::try_at(as_nr).ok_or(EINVAL)?;
> +            Ok(io.read(status_reg))
> +        };
> +        let cond = |status: &STATUS| -> bool { !status.active_ext() };
> +        poll::read_poll_timeout(op, cond, Delta::from_millis(0), Delta::from_millis(10))?;
> +
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 95cda7b0962f..ace2764c6059 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -9,9 +9,12 @@
>  
>  mod driver;
>  mod file;
> +mod fw;
>  mod gem;
>  mod gpu;
> +mod mmu;
>  mod regs;
> +mod vm;
>  
>  kernel::module_platform_driver! {
>      type: TyrPlatformDriver,
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> new file mode 100644
> index 000000000000..5ca1b773df92
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/vm.rs
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! GPU virtual memory management.
> +//!
> +//! This is just a lifetime/resource stub. The actual vm
> +//! implementation using the DRM GPUVM framework will be added later.
> +
> +use kernel::{
> +    device::Bound,
> +    drm::DeviceContext,
> +    platform,
> +    prelude::*,
> +    sync::{
> +        aref::ARef,
> +        Arc,
> +        ArcBorrow, //
> +    }, //
> +};
> +
> +use crate::{
> +    driver::TyrDrmDevice,
> +    gpu::GpuInfo,
> +    mmu::Mmu, //
> +};
> +
> +/// GPU virtual address space.
> +///
> +/// Each VM can be mapped into a hardware address space slot.
> +#[pin_data]
> +pub(crate) struct Vm<'bound> {
> +    /// MMU manager.
> +    mmu: Arc<Mmu<'bound>>,
> +    /// Platform device reference (needed to access the page table via devres).
> +    pdev: ARef<platform::Device>,
> +}
> +
> +impl<'bound> Vm<'bound> {
> +    /// Creates a new GPU virtual address space.
> +    pub(crate) fn new<Ctx: DeviceContext>(
> +        pdev: &'bound platform::Device<Bound>,
> +        _ddev: &TyrDrmDevice<Ctx>,
> +        mmu: ArcBorrow<'_, Mmu<'bound>>,
> +        _gpu_info: &GpuInfo,
> +    ) -> Result<Arc<Vm<'bound>>> {
> +        let vm = Arc::pin_init(
> +            pin_init!(Self {
> +                pdev: pdev.into(),
> +                mmu: mmu.into(),
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        Ok(vm)
> +    }
> +
> +    /// Activate the VM in a hardware address space slot.
> +    pub(crate) fn activate(&self) -> Result {
> +        self.mmu.activate_vm().inspect_err(|e| {
> +            pr_err!("Failed to activate VM: {:?}\n", e);
> +        })
> +    }
> +}
> 
> ---
> base-commit: 305b04e26f0cdff2c8c0db208dbec0d9c9984a48
> change-id: 20260603-use_tyr_reg_data-32720e66b2dd
> 
> Best regards,

