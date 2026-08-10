Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8627CC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29AE10E226;
	Mon, 10 Aug 2026 19:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gZq4JobU";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE9610E226
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 19:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786391064; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZF9oieHeIvguz3pnMLalQfyadGpaDb8unoH6AEGCmCr1qDZzWiQupY2yQ77zpluRrVrwH/S5L60ZbgmOCu4/gu0CAwItuqvWpIFrN2B8v/0jvs7ArFJSyg5sRxeP78KDw9BnN3NxsWnyHyU32J2FWVNHqHCdrVvx4rRsfWlJEhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786391064;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eCab/uT9KJN/2TZlesbWm5916OwbrlQbMToTdiqP76E=; 
 b=kIbEPAfWIvNwm6P3CLNjlf/wqGcKn4JfP7BTIuQg2oq87JSC0MvW6e2OYSNrMoE1eYgfHgmZ0uPeEphwB70p6DxBU9Hw4WlVsQJ198S1hzGvtqQ5lbHCo8uOooCXlE2okHwE3fW8hGDysHzaaGMyj/RO3978kqwMsyERrB9lclM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786391064; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=eCab/uT9KJN/2TZlesbWm5916OwbrlQbMToTdiqP76E=;
 b=gZq4JobUjU/Zs6ZszOA38fI6OpxDlqrfakcRtgzgn2hBOv5z51o9VYhOSyrQXJBE
 mXiz1SvxIBOt3wHDzuael9Smjz5X0BkN8UPOnXGbEEoB04M2+dYDPiULB2J9luPHfMQ
 NCCE17VAuuBb6eacZKLW+2PwhuGCFd5pCopldZpg=
Received: by mx.zohomail.com with SMTPS id 1786391062231666.155087564166;
 Mon, 10 Aug 2026 12:44:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 3/3] drm/tyr: add GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260708114358.957305-4-work@onurozkan.dev>
Date: Mon, 10 Aug 2026 16:44:03 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <D388C501-9903-44A7-BFD9-3BFD91502FAC@collabora.com>
References: <20260708114358.957305-1-work@onurozkan.dev>
 <20260708114358.957305-4-work@onurozkan.dev>
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

Hi Onur,

As I said on the cover letter, I'd rather keep the 'bound design for =
now,
leaving the door open to the Devres approach that we will eventually =
need in
the future.

I've left a few comments inline.

> On 8 Jul 2026, at 08:43, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Add support for scheduling GPU resets on a dedicated workqueue. Track
> the reset state to avoid queueing another reset while one is already
> pending or in progress.
>=20
> Use an SRCU based gate to block new hardware access once a reset is
> scheduled and wait for current users before starting it. Run the
> pre_reset() and post_reset() hooks around the reset sequence so driver
> components can prepare for a reset and restore their state afterwards.
>=20
> Model the reset stages with a typestate pattern where each operation
> consumes the current state and returns the next one. This keeps the
> pre_reset(), GPU reset and post_reset() calls in order and prevents a
> stage from being called twice accidentally.
>=20
> Stop new reset requests during teardown and drain any queued or =
running
> reset work before releasing the device resources.
>=20
> Also move the existing synchronous reset sequence into the reset =
module
> and use it for both the initial reset and scheduled resets.
>=20
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/28
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> drivers/gpu/drm/tyr/driver.rs        |  42 ++--
> drivers/gpu/drm/tyr/reset.rs         | 323 +++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/reset/hw_gate.rs | 298 ++++++++++++++++++++++++
> drivers/gpu/drm/tyr/tyr.rs           |   1 +
> 4 files changed, 636 insertions(+), 28 deletions(-)
> create mode 100644 drivers/gpu/drm/tyr/reset.rs
> create mode 100644 drivers/gpu/drm/tyr/reset/hw_gate.rs
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index 90d6cd988cd2..bd613ab7e05c 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -8,7 +8,6 @@
>     device::{
>         Bound,
>         Core,
> -        Device,
>         DeviceContext, //
>     },
>     dma::{
> @@ -17,13 +16,9 @@
>     },
>     drm,
>     drm::ioctl,
> -    io::{
> -        poll,
> -        Io, //
> -    },
>     new_mutex,
>     of,
> -    platform,
> +    platform, //
>     prelude::*,
>     regulator,
>     regulator::Regulator,
> @@ -33,7 +28,6 @@
>         Arc,
>         Mutex, //
>     },
> -    time,
>     types::ForLt, //
> };
>=20
> @@ -41,10 +35,10 @@
>     file::TyrDrmFileData,
>     fw::Firmware,
>     gem::BoData,
> -    gpu,
>     gpu::GpuInfo,
>     mmu::Mmu,
> -    regs::gpu_control::*, //
> +    regs::gpu_control::*,
> +    reset, //
> };
>=20
> pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
> @@ -67,6 +61,11 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
>     /// Parent platform device.
>     pub(crate) pdev: &'bound platform::Device<Bound>,
>=20
> +    // `ResetHandle::drop()` drains queued/running works and this =
must happen
> +    // before clocks/regulators are dropped. So keep this field =
before them to
> +    // ensure the correct drop order.
> +    pub(crate) reset: reset::ResetHandle<'bound>,
> +
>     /// Firmware sections.
>     pub(crate) fw: Arc<Firmware<'bound>>,
>=20
> @@ -85,23 +84,6 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
>     pub(crate) gpu_info: GpuInfo,
> }
>=20
> -fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
> -    // Clear any stale reset IRQ state before issuing a new soft =
reset.
> -    =
iomem.write_reg(GPU_IRQ_CLEAR::zeroed().with_reset_completed(true));
> -
> -    iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> -
> -    poll::read_poll_timeout(
> -        || Ok(iomem.read(GPU_IRQ_RAWSTAT)),
> -        |status| status.reset_completed(),
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
> @@ -136,8 +118,7 @@ fn probe<'bound>(
>=20
>         let iomem =3D Arc::new(request.iomap_sized::<SZ_2M>()?, =
GFP_KERNEL)?;
>=20
> -        issue_soft_reset(pdev.as_ref(), &iomem)?;
> -        gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> +        reset::run_reset(pdev.as_ref(), &iomem)?;
>=20
>         let gpu_info =3D GpuInfo::new(&iomem);
>         gpu_info.log(pdev.as_ref());
> @@ -152,6 +133,10 @@ fn probe<'bound>(
>=20
>         let unreg_dev =3D =
drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
>=20
> +        // SAFETY: `ResetHandle` is stored in registration data =
created with `new_with_lt`
> +        // and is dropped before the borrowed device and MMIO =
references expire.
> +        let reset =3D unsafe { reset::ResetHandle::new(pdev, =
iomem.as_arc_borrow())? };
> +
>         let mmu =3D Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
>=20
>         let firmware =3D Firmware::new(
> @@ -167,6 +152,7 @@ fn probe<'bound>(
>=20
>         let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
>                 pdev,
> +                reset,
>                 fw: firmware,
>                 clks <- new_mutex!(Clocks {
>                     core: core_clk,
> diff --git a/drivers/gpu/drm/tyr/reset.rs =
b/drivers/gpu/drm/tyr/reset.rs
> new file mode 100644
> index 000000000000..6132e5cbbf75
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/reset.rs
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Provides asynchronous reset handling for the Tyr DRM driver via =
[`ResetHandle`]
> +//! which runs reset work on a dedicated ordered workqueue and avoids =
duplicate
> +//! pending resets.
> +//!
> +//! # High-level Execution Flow
> +//!
> +//! ```text
> +//!                       queued
> +//! +------+  schedule()  +------------+              +---------+
> +//! | Idle |------------->| Enqueueing |------------->| Pending |
> +//! +------+              +------------+              +---------+
> +//!                             |                           |
> +//!                             | queue failed              | =
reset_work()
> +//!                             v                           v
> +//!                          +------+                  +------------+
> +//!                          | Idle |                  | InProgress |
> +//!                          +------+                  +------------+
> +//!                                                        |
> +//!                                                        | reset =
done
> +//!                                                        v
> +//!                                                     +------+
> +//!                                                     | Idle |
> +//!                                                     +------+
> +//!
> +//! Teardown:
> +//!
> +//!   - Idle/Pending/InProgress -> ShuttingDown
> +//!   - Enqueueing -> wait for schedule() to publish Pending or roll =
back to Idle.
> +//! ```
> +
> +mod hw_gate;
> +
> +use hw_gate::HwGate;
> +
> +use kernel::{
> +    device::{
> +        Bound,
> +        Device, //
> +    },
> +    io::{
> +        poll,
> +        Io, //
> +    },
> +    platform,
> +    prelude::*,
> +    sync::{
> +        atomic::AtomicType,
> +        Arc,
> +        ArcBorrow, //
> +    },
> +    time,
> +    workqueue::{
> +        self,
> +        ScopedQueue,
> +        Work, //
> +    },
> +};
> +
> +use crate::{
> +    driver::IoMem,
> +    gpu,
> +    regs::gpu_control::*, //
> +};
> +
> +/// Lifecycle state of the reset worker.
> +#[derive(Clone, Copy, Debug, PartialEq, Eq)]
> +#[repr(i32)]
> +enum ResetState {
> +    /// Hardware is available and no reset request exists.
> +    Idle =3D 0,
> +    /// `schedule()` has reserved a reset but has not returned from =
queueing the
> +    /// work item yet.
> +    Enqueueing =3D 1,

I don=E2=80=99t think we need the =E2=80=9CEnqueueing=E2=80=9D state. =
More on this below.

> +    /// Reset work item is queued and waiting to be claimed by the =
worker.
> +    Pending =3D 2,
> +    /// Worker has claimed the request and is resetting hardware.
> +    InProgress =3D 3,
> +    /// Teardown has started and no new hardware access or reset =
request may start.
> +    ShuttingDown =3D 4,
> +}
> +
> +// SAFETY: `ResetState` and `i32` have the same size and alignment, =
and are
> +// round-trip transmutable.
> +unsafe impl AtomicType for ResetState {
> +    type Repr =3D i32;
> +}
> +
> +/// Trait for the reset-managed hardware.
> +///
> +/// [`ActiveHwState`] groups the hardware blocks that implement this =
trait
> +/// and defines their pre-reset and post-reset hook sequence.
> +///
> +/// Once reset scheduling flips the gate out of [`ResetState::Idle`], =
the reset
> +/// worker first drains any pre-existing SRCU readers before running =
pre_reset()
> +/// and post_reset() hooks.
> +///
> +/// `pre_reset()` is infallible and returning `Err` from =
`post_reset()` is treated
> +/// as a reset-cycle failure.
> +pub(crate) trait Resettable: Send + Sync {

I know this was actually suggested to you, but after seeing the =
downstream
implementation not using a trait, I think I'd rather go with something =
simpler
for now, i.e.: not having Resettable right now. Nothing precludes us =
from
having a follow up patch refactoring the implementation with a trait if =
need
be. I'd feel more confortable with such a follow up than having =
ActiveHwState
as it currently is.


> +    /// Called before the reset sequence starts and the hardware is =
reset.
> +    ///
> +    /// Before this is called, the reset worker waits for all =
pre-existing
> +    /// hardware accesses to complete.
> +    fn pre_reset(&self);
> +
> +    /// Called after the hardware reset completes.
> +    ///
> +    /// `reset_failed` is `true` if an earlier stage in the current =
reset cycle
> +    /// has already failed. Returning `Err` fails the entire cycle.
> +    fn post_reset(&self, reset_failed: bool) -> Result;
> +}
> +
> +/// Reset-managed hardware state coordinated by [`HwGate`].
> +///
> +/// Groups the driver components that must quiesce before a GPU reset =
and resume
> +/// afterwards. The [`Resettable`] implementation defines the =
pre-reset and post-reset
> +/// hook sequence for those components.
> +struct ActiveHwState {
> +    // mmu: Arc<Mmu>,
> +}
> +
> +impl Resettable for ActiveHwState {
> +    fn pre_reset(&self) {
> +        // self.mmu.pre_reset();
> +    }
> +
> +    fn post_reset(&self, _reset_failed: bool) -> Result {
> +        // self.mmu.post_reset()?;
> +        Ok(())
> +    }
> +}
> +
> +/// Internal reset orchestrator that owns the gate and work item.
> +#[pin_data]
> +struct Controller<'bound> {
> +    /// Parent platform device.
> +    pdev: &'bound platform::Device<Bound>,
> +    /// Mapped register space needed for reset operations.
> +    iomem: Arc<IoMem<'bound>>,
> +    /// Access gate for reset managed hardware users.
> +    #[pin]
> +    hw: HwGate<ActiveHwState>,
> +    /// Work item backing async reset processing.
> +    #[pin]
> +    work: Work<Controller<'bound>>,
> +}
> +
> +kernel::impl_has_work! {
> +    impl{'bound} HasWork<Controller<'bound>> for Controller<'bound> { =
self.work }
> +}
> +
> +impl<'bound> workqueue::WorkItem for Controller<'bound> {
> +    type Pointer =3D Arc<Self>;
> +
> +    fn run(this: Arc<Self>) {
> +        this.reset_work();
> +    }
> +}
> +
> +impl<'bound> Controller<'bound> {
> +    /// Creates an [`Arc<Controller>`] ready for use.
> +    fn new(
> +        pdev: &'bound platform::Device<Bound>,
> +        iomem: ArcBorrow<'_, IoMem<'bound>>,
> +    ) -> Result<Arc<Self>> {
> +        Arc::pin_init(
> +            try_pin_init!(Self {
> +                pdev,
> +                iomem: iomem.into(),
> +                hw <- HwGate::new(ActiveHwState {}),
> +                work <- kernel::new_work!("tyr::reset"),
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +
> +    /// Processes one scheduled reset request.
> +    ///
> +    /// If the pending reset cannot be claimed, the worker returns =
immediately.
> +    ///
> +    /// It first claims [`ResetState::Pending`] or =
[`ResetState::Enqueueing`],
> +    /// then waits for earlier hardware accesses to complete before =
running the
> +    /// pre-reset hook. After that it issues the hardware reset, runs =
the
> +    /// post-reset hooks and finally returns the gate to =
[`ResetState::Idle`].
> +    ///
> +    /// Panthor reference:
> +    /// - =
drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
> +    fn reset_work(self: &Arc<Self>) {
> +        let Some(resetting) =3D self.hw.start_reset() else {
> +            // Another reset is already pending or in progress, so we =
skip this one.
> +            return;
> +        };
> +
> +        dev_info!(self.pdev, "Starting GPU reset.\n");
> +
> +        // Wait for all hardware accesses that started before reset =
became
> +        // visible to finish before running the reset callbacks.
> +        //
> +        // TODO: If these state transitions ever become fallible, =
make sure failures do not
> +        // leave the gate in `InProgress`.
> +        let quiesced =3D resetting.synchronize().pre_reset();
> +
> +        let (finishing, reset_result) =3D quiesced.run(|| =
run_reset(self.pdev.as_ref(), &self.iomem));
> +        let reset_failed =3D reset_result.is_err();
> +
> +        if let Err(e) =3D &reset_result {
> +            dev_err!(self.pdev, "GPU reset failed: {:?}\n", e);
> +        }
> +
> +        let (_done, post_reset_result) =3D =
finishing.post_reset(reset_failed);
> +        let cycle_failed =3D reset_failed || =
post_reset_result.is_err();
> +
> +        if let Err(e) =3D post_reset_result {
> +            dev_err!(self.pdev, "GPU post-reset failed: {:?}\n", e);
> +
> +            // TODO: Unplug the GPU.
> +            // There is no API for unplugging the GPU and this is =
unreachable
> +            // for now since there are no hardware users for reset =
API.
> +        }
> +
> +        if cycle_failed {
> +            dev_err!(self.pdev, "GPU reset cycle failed.\n");
> +        } else {
> +            dev_info!(self.pdev, "GPU reset completed.\n");
> +        }
> +    }
> +}
> +
> +/// User-facing handle for scheduling resets.
> +///
> +/// Dropping the handle drains any queued or in-flight reset work to =
ensure a
> +/// clean teardown before clocks and regulators are released.
> +pub(crate) struct ResetHandle<'bound> {
> +    controller: Arc<Controller<'bound>>,
> +    wq: ScopedQueue<'bound>,
> +}
> +
> +impl<'bound> ResetHandle<'bound> {
> +    /// Creates [`ResetHandle`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned handle must not be leaked or otherwise prevented =
from
> +    /// running [`Drop`], since it owns work that may borrow from =
`'bound`.
> +    pub(crate) unsafe fn new(
> +        pdev: &'bound platform::Device<Bound>,
> +        iomem: ArcBorrow<'_, IoMem<'bound>>,
> +    ) -> Result<Self> {
> +        Ok(Self {
> +            controller: Controller::new(pdev, iomem)?,
> +            // SAFETY: The caller guarantees the handle is dropped.
> +            wq: unsafe { ScopedQueue::new(c"tyr-reset-wq")? },
> +        })
> +    }
> +
> +    /// Schedules a GPU reset on the dedicated workqueue.
> +    ///
> +    /// If a reset is already pending or in progress the call is a =
no-op.
> +    #[expect(dead_code)]
> +    pub(crate) fn schedule(&self) {


As I said on the cover letter, the watchdog would be the perfect initial =
user
for this, yet there is no delayed work support in ScopedQueue IIUC. I =
think
this would delay things a little bit. I think it's ok to merge this =
infrastructure
anyways because:

a) This will clearly be invoked from the watchdog when there is delayed =
work
support.

b) We will also be able to trigger this once Alvin's debugfs series =
land, which
will also be useful.



> +        // TODO: Similar to `panthor_device_schedule_reset()` in =
Panthor, add a
> +        // power management check once Tyr supports it.
> +
> +        // Keep only one reset request running or queued. If one is =
already pending,
> +        // we ignore new schedule requests.
> +        if self.controller.hw.begin_reset() {
> +            if self.wq.enqueue(self.controller.clone()).is_err() {
> +                // Roll back the reservation made by `begin_reset()`.
> +                self.controller.hw.cancel_reset();
> +            } else {
> +                self.controller.hw.finish_enqueue();
> +            }
> +        }
> +    }

I think this can simplify a bit, since enqueue failing means the item is
already enqueued, so "reserved but not yet queued" shouldn't really be a =
state.
This also seems to be what the downstream code converged to.

In practical terms, this means switching from "idle" to "pending"
unconditionally right before enqueue().

As a plus, this seems to also remove cancel_reset() and the cpu_relax() =
loop in
begin_teardown().

> +}
> +
> +impl<'bound> Drop for ResetHandle<'bound> {
> +    fn drop(&mut self) {
> +        // Stop new reset requests before draining queued/running =
work.
> +        self.controller.hw.begin_teardown();
> +
> +        // Not required for safety because `wq` will drain on drop, =
but keep
> +        // cancellation of `controller.work` explicit before fields =
are dropped.
> +        let _ =3D self.controller.work.cancel_sync();
> +    }
> +}
> +
> +/// Issues a soft reset command and waits for reset-complete IRQ =
status.
> +fn issue_soft_reset<'bound>(dev: &'bound Device<Bound>, io: =
&IoMem<'bound>) -> Result {
> +    // Clear any stale reset-complete IRQ state before issuing a new =
soft reset.
> +    io.write_reg(GPU_IRQ_CLEAR::zeroed().with_reset_completed(true));
> +
> +    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> +
> +    poll::read_poll_timeout(
> +        || Ok(io.read(GPU_IRQ_RAWSTAT)),
> +        |status| status.reset_completed(),
> +        time::Delta::from_millis(1),
> +        time::Delta::from_millis(100),
> +    )
> +    .inspect_err(|_| dev_err!(dev, "GPU reset timed out."))?;
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
> +/// The sequence is as follows:
> +///   - Trigger a GPU soft reset.
> +///   - Wait for the reset-complete IRQ status.
> +///   - Power L2 back on.
> +pub(super) fn run_reset<'bound>(dev: &'bound Device<Bound>, iomem: =
&IoMem<'bound>) -> Result {
> +    issue_soft_reset(dev, iomem)?;
> +    gpu::l2_power_on(dev, iomem)?;
> +    Ok(())
> +}
> diff --git a/drivers/gpu/drm/tyr/reset/hw_gate.rs =
b/drivers/gpu/drm/tyr/reset/hw_gate.rs
> new file mode 100644
> index 000000000000..a8e585677029
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/reset/hw_gate.rs
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! SRCU based hardware access gate.
> +//!
> +//! This module provides [`HwGate`] which is a generic, SRCU based =
gate
> +//! that serialises hardware access against asynchronous reset =
cycles.
> +
> +use super::{
> +    ResetState,
> +    Resettable, //
> +};
> +
> +use kernel::{
> +    prelude::*,
> +    processor::cpu_relax,
> +    sync::{
> +        atomic::{
> +            Acquire,
> +            Atomic,
> +            Full,
> +            Relaxed, //
> +        },
> +        srcu, Srcu,
> +    },
> +};
> +
> +use core::ops::Deref;
> +
> +macro_rules! try_change_state {
> +    ($state:expr, $from:expr, $to:expr) =3D> {
> +        $state.cmpxchg($from, $to, Full).is_ok()
> +    };
> +}
> +
> +/// A gate that coordinates hardware access with asynchronous resets.
> +#[pin_data]
> +pub(crate) struct HwGate<T: Resettable> {
> +    #[pin]
> +    srcu: Srcu,
> +    state: Atomic<ResetState>,
> +    epoch: Atomic<u64>,
> +    hw: T,
> +}
> +
> +impl<T: Resettable> HwGate<T> {
> +    /// Creates a new gate for the given `hw` in [`ResetState::Idle`] =
state.
> +    #[inline]
> +    pub(super) fn new(hw: T) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            srcu <- kernel::new_srcu!(),
> +            state: Atomic::new(ResetState::Idle),
> +            epoch: Atomic::new(0),
> +            hw,
> +        })
> +    }
> +
> +    /// Tries to acquire the hardware access guard.
> +    ///
> +    /// Returns [`EBUSY`] if a reset is pending or in progress.
> +    #[inline]
> +    pub(crate) fn try_access(&self) -> Result<HwGuard<'_, T>> {

The consensus between you and Sami seems to be removing this, IIUC?

> +        let srcu =3D self.srcu.read_lock();
> +
> +        if self.state.load(Acquire) !=3D ResetState::Idle {
> +            return Err(EBUSY);
> +        }
> +
> +        let epoch =3D self.epoch.load(Relaxed);
> +
> +        Ok(HwGuard {
> +            hw: &self.hw,
> +            epoch,
> +            _srcu: srcu,
> +        })
> +    }
> +
> +    /// Runs `callback` with [`HwGuard`], failing fast with [`EBUSY`] =
if a reset is
> +    /// pending or in progress.
> +    #[expect(dead_code)]
> +    #[inline]
> +    pub(crate) fn with_hw<R>(
> +        &self,
> +        callback: impl FnOnce(&HwGuard<'_, T>) -> Result<R>,
> +    ) -> Result<R> {
> +        let guard =3D self.try_access()?;
> +        callback(&guard)
> +    }
> +
> +    /// Reserves a reset request and transitions from =
[`ResetState::Idle`] to
> +    /// [`ResetState::Enqueueing`].
> +    ///
> +    /// Returns `true` if the transition succeeded (i.e. no reset was =
already
> +    /// scheduled).
> +    #[inline]
> +    pub(super) fn begin_reset(&self) -> bool {
> +        try_change_state!(self.state, ResetState::Idle, =
ResetState::Enqueueing)
> +    }
> +
> +    /// Marks the reset work item as queued.
> +    #[inline]
> +    pub(super) fn finish_enqueue(&self) {
> +        let _ =3D try_change_state!(self.state, =
ResetState::Enqueueing, ResetState::Pending);
> +    }
> +
> +    /// Blocks future reset scheduling and hardware access during =
teardown.
> +    #[inline]
> +    pub(super) fn begin_teardown(&self) {
> +        loop {
> +            match self.state.load(Acquire) {
> +                ResetState::Idle =3D> {
> +                    // No reset is active. Teardown can stop new =
access now.
> +                    if try_change_state!(self.state, =
ResetState::Idle, ResetState::ShuttingDown) {
> +                        return;
> +                    }
> +                }
> +                ResetState::Enqueueing =3D> {
> +                    // Wait for `schedule()` to move to `Pending` or =
back to `Idle` then
> +                    // try again.
> +                    cpu_relax()
> +                }
> +                ResetState::Pending =3D> {
> +                    // A reset is queued. Teardown blocks it from =
running.
> +                    if try_change_state!(self.state, =
ResetState::Pending, ResetState::ShuttingDown)
> +                    {
> +                        return;
> +                    }
> +                }
> +                ResetState::InProgress =3D> {
> +                    // A reset is already running. Teardown blocks =
anything that comes after it.
> +                    if try_change_state!(
> +                        self.state,
> +                        ResetState::InProgress,
> +                        ResetState::ShuttingDown
> +                    ) {
> +                        return;
> +                    }
> +                }
> +                ResetState::ShuttingDown =3D> {
> +                    // Teardown already started.
> +                    return;
> +                }
> +            }
> +        }
> +    }
> +
> +    /// Transitions from [`ResetState::Pending`] or =
[`ResetState::Enqueueing`] to
> +    /// [`ResetState::InProgress`].
> +    #[inline]
> +    pub(super) fn start_reset(&self) -> Option<Resetting<'_, T>> {
> +        (try_change_state!(self.state, ResetState::Pending, =
ResetState::InProgress)
> +            || try_change_state!(self.state, ResetState::Enqueueing, =
ResetState::InProgress))
> +        .then_some(Resetting { gate: self })
> +    }
> +
> +    /// Completes a reset cycle and publishes the next =
hardware-access epoch.
> +    ///
> +    /// This must only be called while dropping [`Done`] after the =
reset phases are completed.
> +    #[inline]
> +    fn finish_reset(&self) {
> +        // Reaching `Done` means the reset completed so advance the =
epoch. This must happen
> +        // before a successful transition to `Idle` publishes a new =
hardware-access window.
> +        self.epoch.fetch_add(1, Relaxed);
> +        let _ =3D try_change_state!(self.state, =
ResetState::InProgress, ResetState::Idle);
> +    }
> +
> +    /// Transitions from [`ResetState::Pending`] to =
[`ResetState::Idle`].
> +    #[inline]
> +    pub(super) fn cancel_reset(&self) {
> +        if !try_change_state!(self.state, ResetState::Enqueueing, =
ResetState::Idle) {
> +            let _ =3D try_change_state!(self.state, =
ResetState::Pending, ResetState::Idle);
> +        }
> +    }
> +
> +    /// Waits for all pre-existing SRCU readers to complete.
> +    ///
> +    /// This must only be called from the reset worker after the =
state has left
> +    /// [`ResetState::Idle`], so that no new readers can enter.
> +    #[inline]
> +    pub(super) fn synchronize(&self) {
> +        self.srcu.synchronize();
> +    }
> +}
> +
> +impl<T: Resettable> Resettable for HwGate<T> {
> +    fn pre_reset(&self) {
> +        self.hw.pre_reset()
> +    }
> +
> +    fn post_reset(&self, reset_failed: bool) -> Result {
> +        self.hw.post_reset(reset_failed)
> +    }
> +}
> +
> +/// Reset is in progress and existing hardware access has not been =
drained.
> +#[must_use =3D "must continue to completion"]
> +pub(super) struct Resetting<'a, T: Resettable> {
> +    gate: &'a HwGate<T>,
> +}
> +
> +/// Existing hardware access has been drained.
> +#[must_use =3D "must continue to completion"]
> +pub(super) struct Drained<'a, T: Resettable> {
> +    gate: &'a HwGate<T>,
> +}
> +
> +/// Hardware is quiesced and ready to be reset.
> +#[must_use =3D "must continue to completion"]
> +pub(super) struct Quiesced<'a, T: Resettable> {
> +    gate: &'a HwGate<T>,
> +}
> +
> +/// Hardware reset has run and post-reset work remains.
> +#[must_use =3D "must continue to completion"]
> +pub(super) struct Finishing<'a, T: Resettable> {
> +    gate: &'a HwGate<T>,
> +}
> +
> +/// Reset and post-reset work have completed.
> +///
> +/// Dropping this state completes the cycle and makes hardware =
accessible.
> +#[must_use =3D "must remain alive until completion"]
> +pub(super) struct Done<'a, T: Resettable> {
> +    gate: &'a HwGate<T>,
> +}


Same here, I think we can do without this typestate for now. It seems to =
only
be used in reset_work(). I think this is linear code that we can audit =
without
this extra machinery in place. I think this too can be a follow up patch =
if we
ever need it.

Sorry for the back and forth. I am trying to streamline things so we get =
to
merge a smaller subset that we won't regret later.


> +
> +impl<'a, T: Resettable> Resetting<'a, T> {
> +    /// Waits for all pre-existing SRCU readers to complete.
> +    #[inline]
> +    pub(super) fn synchronize(self) -> Drained<'a, T> {
> +        self.gate.synchronize();
> +        Drained { gate: self.gate }
> +    }
> +}
> +
> +impl<'a, T: Resettable> Drained<'a, T> {
> +    /// Runs the pre-reset hook after earlier hardware accesses have =
drained.
> +    #[inline]
> +    pub(super) fn pre_reset(self) -> Quiesced<'a, T> {
> +        self.gate.pre_reset();
> +        Quiesced { gate: self.gate }
> +    }
> +}
> +
> +impl<'a, T: Resettable> Quiesced<'a, T> {
> +    /// Runs the reset body while the gate is held in reset state.
> +    #[inline]
> +    pub(super) fn run(self, callback: impl FnOnce() -> Result) -> =
(Finishing<'a, T>, Result) {
> +        (Finishing { gate: self.gate }, callback())
> +    }
> +}
> +
> +impl<'a, T: Resettable> Finishing<'a, T> {
> +    /// Runs the post-reset hook and returns the final token that =
completes the cycle on drop.
> +    #[inline]
> +    pub(super) fn post_reset(self, reset_failed: bool) -> (Done<'a, =
T>, Result) {
> +        (Done { gate: self.gate }, =
self.gate.post_reset(reset_failed))
> +    }
> +}
> +
> +impl<T: Resettable> Drop for Done<'_, T> {
> +    fn drop(&mut self) {
> +        self.gate.finish_reset();
> +    }
> +}
> +
> +/// A hardware guard that is only present when the hardware is =
accessible.
> +///
> +/// Holding a [`HwGuard`] means the hardware is still in use and =
prevents
> +/// the reset path from proceeding. The reset worker waits for all =
active
> +/// guards to be dropped before it continues with the reset.
> +#[must_use =3D "the hardware guard must be kept alive while using =
reset-sensitive state"]
> +pub(crate) struct HwGuard<'a, T> {
> +    hw: &'a T,
> +    epoch: u64,
> +    _srcu: srcu::Guard<'a>,
> +}
> +
> +impl<T> HwGuard<'_, T> {
> +    /// Returns the epoch at which this guard was acquired.
> +    ///
> +    /// This is a snapshot of [`HwGate`]'s epoch counter taken when =
the guard
> +    /// was acquired. The gate increments that counter each time a =
reset cycle
> +    /// completes. Callers can compare epochs from separate access =
windows to
> +    /// detect whether a reset happened in between.
> +    #[expect(dead_code)]
> +    #[inline]
> +    pub(crate) fn epoch(&self) -> u64 {
> +        self.epoch
> +    }

I don=E2=80=99t see a user for this at the moment and in the near =
future. Can we
drop this for now?

> +}
> +
> +impl<T> Deref for HwGuard<'_, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.hw
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 3f6fe5fbeb0f..63873628c843 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -14,6 +14,7 @@
> mod gpu;
> mod mmu;
> mod regs;
> +mod reset;
> mod slot;
> mod vm;
> mod wait;
> --=20
> 2.51.2
>=20
>=20

