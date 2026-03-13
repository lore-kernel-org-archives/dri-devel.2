Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FB2105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B32B10E027;
	Fri, 13 Mar 2026 14:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Kt8jVkPf";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3A810E027
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773413837; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Nby/xzI670tYxlLgthn7pcRoq6hbAjsDb0cpaTetyuZaIuthlpVX7h8JZUcGnKXHJebm4vP58pp/WDtfsz38D+iI827z/gSRYmWXwhVdno3Tb64zcu7JXqgDfyT/CXSmFPUr1c+J9B5+iShKgtHXtDQVRgMR5O5eCc7vifuu/d8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773413837;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Z4WG56oUcuu9VIK21sSTkqgnVdbzzdfg5Q0Ed/8VRBg=; 
 b=Nqv3BpQc/S0jwV9oBeRTJmQh/WfvSisWqye7S4gAw+sTEPw/GK2VW55azUrqzIteZIyMiKh6rdB8Gj3UgSLMXvxW6KZi7nKcyRIAyaVCiAVAb+Q2xv66gcb4AEJBTxmpgqJJhlKJDIYDmHbB53VtkzNE9Gv/23gRZDrkKowiC6Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773413837; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=Z4WG56oUcuu9VIK21sSTkqgnVdbzzdfg5Q0Ed/8VRBg=;
 b=Kt8jVkPfr3EY18f3fyrIRdHOt/lQ07MvcQGjFFAfZrFT/tLrNeKrfaNWDTcWTNRC
 LOSRH42qnkMQJ1jMdgQFW7U3sxeZJklYdzyac730FnRD/URl4b2PXVDgPnu/0NNdvzy
 PFUQ9cwU/5R8Upxp/4bouMCkUrR1Y94pc67106so=
Received: by mx.zohomail.com with SMTPS id 1773413833949805.4851047988343;
 Fri, 13 Mar 2026 07:57:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260313091646.16938-5-work@onurozkan.dev>
Date: Fri, 13 Mar 2026 11:56:58 -0300
Cc: linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E3CDC4F-A17E-4B31-89F7-FA1B96248CCD@collabora.com>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
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



> On 13 Mar 2026, at 06:16, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Move Tyr reset logic into a new reset module and add async reset work.
>=20
> This adds:
> - ResetHandle with internal controller state
> - a dedicated ordered reset workqueue
> - a pending flag to avoid duplicate queued resets
> - run_reset() as the shared synchronous reset helper
>=20
> Probe now calls reset::run_reset() before normal init. Driver data now
> keeps ResetHandle so reset work is drained before clocks and =
regulators
> are dropped.
>=20
> Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> drivers/gpu/drm/tyr/driver.rs |  40 +++-----
> drivers/gpu/drm/tyr/reset.rs  | 180 ++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/tyr.rs    |   1 +
> 3 files changed, 192 insertions(+), 29 deletions(-)
> create mode 100644 drivers/gpu/drm/tyr/reset.rs
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index f7951804e4e0..c80238a21ff2 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -6,11 +6,8 @@
>         OptionalClk, //
>     },
>     device::{
> -        Bound,
> -        Core,
> -        Device, //
> +        Core, //
>     },
> -    devres::Devres,
>     dma::{
>         Device as DmaDevice,
>         DmaMask, //
> @@ -22,10 +19,7 @@
>         Registered,
>         UnregisteredDevice, //
>     },
> -    io::poll,
> -    new_mutex,
> -    of,
> -    platform,
> +    new_mutex, of, platform,
>     prelude::*,
>     regulator,
>     regulator::Regulator,
> @@ -35,17 +29,15 @@
>         Arc,
>         Mutex, //
>     },
> -    time, //
> };
>=20
> use crate::{
>     file::TyrDrmFileData,
>     fw::Firmware,
>     gem::BoData,
> -    gpu,
>     gpu::GpuInfo,
>     mmu::Mmu,
> -    regs, //
> +    reset, //
> };
>=20
> pub(crate) type IoMem =3D kernel::io::mem::IoMem<SZ_2M>;
> @@ -62,6 +54,11 @@ pub(crate) struct TyrPlatformDriverData {
>=20
> #[pin_data]
> pub(crate) struct TyrDrmDeviceData {
> +    // `ResetHandle::drop()` drains queued/running works and this =
must happen
> +    // before clocks/regulators are dropped. So keep this field =
before them to
> +    // ensure the correct drop order.
> +    pub(crate) reset: reset::ResetHandle,
> +
>     pub(crate) pdev: ARef<platform::Device>,
>=20
>     pub(crate) fw: Arc<Firmware>,
> @@ -90,22 +87,6 @@ unsafe impl Send for TyrDrmDeviceData {}
> // SAFETY: This will be removed in a future patch.
> unsafe impl Sync for TyrDrmDeviceData {}
>=20
> -fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> =
Result {
> -    // Clear any stale reset-complete IRQ state before issuing a new =
soft reset.
> -    regs::GPU_IRQ_CLEAR.write(dev, iomem, =
regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED)?;
> -    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> -
> -    poll::read_poll_timeout(
> -        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> -        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED !=3D =
0,
> -        time::Delta::from_millis(1),
> -        time::Delta::from_millis(100),
> -    )
> -    .inspect_err(|_| dev_err!(dev, "GPU reset failed."))?;
> -
> -    Ok(())
> -}
> -
> kernel::of_device_table!(
>     OF_TABLE,
>     MODULE_OF_TABLE,
> @@ -138,8 +119,7 @@ fn probe(
>         let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;
>         let iomem =3D Arc::pin_init(request.iomap_sized::<SZ_2M>(), =
GFP_KERNEL)?;
>=20
> -        issue_soft_reset(pdev.as_ref(), &iomem)?;
> -        gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> +        reset::run_reset(pdev.as_ref(), &iomem)?;
>=20
>         let gpu_info =3D GpuInfo::new(pdev.as_ref(), &iomem)?;
>         gpu_info.log(pdev);
> @@ -153,6 +133,7 @@ fn probe(
>=20
>         let uninit_ddev =3D =
UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref())?;
>         let platform: ARef<platform::Device> =3D pdev.into();
> +        let reset =3D reset::ResetHandle::new(platform.clone(), =
iomem.clone())?;
>=20
>         let mmu =3D Mmu::new(pdev, iomem.as_arc_borrow(), &gpu_info)?;
>=20
> @@ -178,6 +159,7 @@ fn probe(
>                     _mali: mali_regulator,
>                     _sram: sram_regulator,
>                 }),
> +                reset,
>                 gpu_info,
>         });
>         let ddev =3D Registration::new_foreign_owned(uninit_ddev, =
pdev.as_ref(), data, 0)?;
> diff --git a/drivers/gpu/drm/tyr/reset.rs =
b/drivers/gpu/drm/tyr/reset.rs
> new file mode 100644
> index 000000000000..29dfae98b0dd
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/reset.rs
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Provides asynchronous reset handling for the Tyr DRM driver via
> +//! [`ResetHandle`], which runs reset work on a dedicated ordered
> +//! workqueue and avoids duplicate pending resets.
> +
> +use kernel::{
> +    device::{
> +        Bound,
> +        Device, //
> +    },
> +    devres::Devres,
> +    io::poll,
> +    platform,
> +    prelude::*,
> +    sync::{
> +        aref::ARef,
> +        atomic::{
> +            Acquire,
> +            Atomic,
> +            Relaxed,
> +            Release, //
> +        },
> +        Arc,
> +    },
> +    time,
> +    workqueue::{
> +        self,
> +        Work, //
> +    },
> +};
> +
> +use crate::{
> +    driver::IoMem,
> +    gpu,
> +    regs, //
> +};
> +
> +/// Manages asynchronous GPU reset handling and ensures only a single =
reset
> +/// work is pending at a time.
> +#[pin_data]
> +struct Controller {
> +    /// Platform device reference needed for reset operations and =
logging.
> +    pdev: ARef<platform::Device>,
> +    /// Mapped register space needed for reset operations.
> +    iomem: Arc<Devres<IoMem>>,
> +    /// Atomic flag for controlling the scheduling pending state.
> +    pending: Atomic<bool>,
> +    /// Dedicated ordered workqueue for reset operations.
> +    wq: workqueue::OrderedQueue,
> +    /// Work item backing async reset processing.
> +    #[pin]
> +    work: Work<Controller>,
> +}
> +
> +kernel::impl_has_work! {
> +    impl HasWork<Controller> for Controller { self.work }
> +}
> +
> +impl workqueue::WorkItem for Controller {
> +    type Pointer =3D Arc<Self>;
> +
> +    fn run(this: Arc<Self>) {
> +        this.reset_work();
> +    }
> +}
> +
> +impl Controller {
> +    /// Creates a [`Controller`] instance.
> +    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) =
-> Result<Arc<Self>> {
> +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", 0)?;
> +
> +        Arc::pin_init(
> +            try_pin_init!(Self {
> +                pdev,
> +                iomem,
> +                pending: Atomic::new(false),
> +                wq,
> +                work <- kernel::new_work!("tyr::reset"),
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +
> +    /// Processes one scheduled reset request.
> +    ///
> +    /// Panthor reference:
> +    /// - =
drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
> +    fn reset_work(self: &Arc<Self>) {
> +        dev_info!(self.pdev.as_ref(), "GPU reset work is =
started.\n");
> +
> +        // SAFETY: `Controller` is part of driver-private data and =
only exists
> +        // while the platform device is bound.
> +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };
> +        if let Err(e) =3D run_reset(pdev, &self.iomem) {
> +            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\n", =
e);
> +        } else {
> +            dev_info!(self.pdev.as_ref(), "GPU reset work is =
done.\n");
> +        }

Can we have more descriptive strings here? A user cares little for
implementation details such as =E2=80=9Creset work=E2=80=9D, what they =
care about is
that the hardware is undergoing a reset.

> +
> +        self.pending.store(false, Release);
> +    }
> +}
> +
> +/// Reset handle that shuts down pending work gracefully on drop.
> +pub(crate) struct ResetHandle(Arc<Controller>);
> +

Why is this an Arc? There seems to be a single owner?

> +impl ResetHandle {
> +    /// Creates a [`ResetHandle`] instance.
> +    pub(crate) fn new(pdev: ARef<platform::Device>, iomem: =
Arc<Devres<IoMem>>) -> Result<Self> {
> +        Ok(Self(Controller::new(pdev, iomem)?))
> +    }
> +
> +    /// Schedules reset work.
> +    #[expect(dead_code)]
> +    pub(crate) fn schedule(&self) {
> +        // TODO: Similar to `panthor_device_schedule_reset()` in =
Panthor, add a
> +        // power management check once Tyr supports it.
> +
> +        // Keep only one reset request running or queued. If one is =
already pending,
> +        // we ignore new schedule requests.
> +        if self.0.pending.cmpxchg(false, true, Relaxed).is_ok()
> +            && self.0.wq.enqueue(self.0.clone()).is_err()
> +        {
> +            self.0.pending.store(false, Release);
> +        }
> +    }
> +
> +    /// Returns true if a reset is queued or in progress.
> +    ///
> +    /// Note that the state can change immediately after the return.
> +    #[inline]
> +    #[expect(dead_code)]
> +    pub(crate) fn is_pending(&self) -> bool {
> +        self.0.pending.load(Acquire)
> +    }

> +}
> +
> +impl Drop for ResetHandle {
> +    fn drop(&mut self) {
> +        // Drain queued/running work and block future queueing =
attempts for this
> +        // work item before clocks/regulators are torn down.
> +        // SAFETY: drop executes in a sleepable context.
> +        unsafe { self.0.work.disable_sync() };
> +    }
> +}
> +
> +/// Issues a soft reset command and waits for reset-complete IRQ =
status.
> +fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> =
Result {
> +    // Clear any stale reset-complete IRQ state before issuing a new =
soft reset.
> +    regs::GPU_IRQ_CLEAR.write(dev, iomem, =
regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED)?;
> +    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> +
> +    poll::read_poll_timeout(
> +        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> +        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED !=3D =
0,
> +        time::Delta::from_millis(1),
> +        time::Delta::from_millis(100),
> +    )
> +    .inspect_err(|_| dev_err!(dev, "GPU reset failed."))?;
> +
> +    Ok(())
> +}
> +
> +/// Runs one synchronous GPU reset pass.
> +///
> +/// Its visibility is `pub(super)` only so the probe path can run an
> +/// initial reset; it is not part of this module's public API.
> +///
> +/// On success, the GPU is left in a state suitable for =
reinitialization.
> +///
> +/// The reset sequence is as follows:
> +/// 1. Trigger a GPU soft reset.
> +/// 2. Wait for the reset-complete IRQ status.
> +/// 3. Power L2 back on.
> +pub(super) fn run_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) =
-> Result {
> +    issue_soft_reset(dev, iomem)?;
> +    gpu::l2_power_on(dev, iomem)?;
> +    Ok(())
> +}
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 18b0668bb217..d0349bc49f27 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -14,6 +14,7 @@
> mod gpu;
> mod mmu;
> mod regs;
> +mod reset;
> mod slot;
> mod vm;
>=20
> --=20
> 2.51.2
>=20


