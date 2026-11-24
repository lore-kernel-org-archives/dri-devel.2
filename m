Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50D606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NWN2UAIY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A17110EF0D;
	Tue, 24 Nov 2026 17:54:49 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8E710F038
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 17:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795542870; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AqPLK2thyyeZzdMv+3QBPVqRpFEHXIVIWT19jJGPS2TSNZhqwtaEO6+T6FWxYEnLH9Hr5jQvgBRMsEJ1d1hzcLSBSvHZzO9vngr7zZMSDbri/aO0Ohb4gChq64vT5aDUleobra4aJmnNCpXlpORxDMYymHfJw40jOJyxacfrTgI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795542870;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fpAiOPwESU3SxFIsWPPgq9rtaBiS5OvuHNtlKJUrn6E=; 
 b=GfbBuk/u57p+2xSmCKZncHsNLcpv5cQ1t2U5EFm7kwOIKxQV2IXwEw3mWITKsdkjec+inoT67Kga6H0X/JphybaY7SbbL6G/Xfr3DGkbt3ZxJoM2eGpS3Y3UklRm/VAAok/nqG6YBrexMJPe97zwZiUtTpvt6IoaYm2GC6UsJOo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=NWN2UAIYTOHUea2mpFHMsbSJ1q14R4wTlekbh8/k6krPLWHePOriqUAbNzYxNYmwpCIcj2lLspALX212zEsdySLQ5wZGsLBLqo4rv8Q12xu4CiFMTghlUMMp6tm7CdFdHpOoLpIVpLq7/fxvh3g6h4TUw259Cv7UyR1AmBwHQXg=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=fpAiOPwESU3SxFIsWPPgq9rtaBiS5OvuHNtlKJUrn6E=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795542867599313.22834164371363; 
 Tue, 24 Nov 2026 09:54:27 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 2/3] drm/tyr: add TyrIrq threaded IRQ wrapper
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260728-tyr-irq-v2-v7-2-4e172e58e28c@collabora.com>
Date: Tue, 24 Nov 2026 14:54:12 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C7287DF-458B-4AF8-8AB3-B5986E3B808E@collabora.com>
References: <20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com>
 <20260728-tyr-irq-v2-v7-2-4e172e58e28c@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Laura, this mostly looks good! A few things only:


> On 23 Nov 2026, at 11:58, Laura Nao <laura.nao@collabora.com> wrote:
>=20
> Introduce a generic TyrIrq threaded IRQ wrapper along with the
> TyrIrqTrait trait describing the operations required to handle a
> Tyr interrupt source.
>=20
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
> drivers/gpu/drm/tyr/irq.rs           | 270 =
+++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/reset/hw_gate.rs |   1 -
> drivers/gpu/drm/tyr/tyr.rs           |   1 +
> 3 files changed, 271 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/irq.rs b/drivers/gpu/drm/tyr/irq.rs
> new file mode 100644
> index 000000000000..4a065c6272c5
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/irq.rs
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Threaded IRQ wrapper shared by all Tyr interrupt sources.
> +#![allow(dead_code)]
> +use core::marker::PhantomPinned;
> +
> +use kernel::{
> +    device::Bound,
> +    interrupt::LocalInterruptDisabled,
> +    irq::{
> +        Flags,
> +        IrqReturn,
> +        ThreadedHandler,
> +        ThreadedIrqReturn,
> +        ThreadedRegistration, //
> +    },
> +    platform,
> +    prelude::*,
> +    sync::{
> +        atomic::{
> +            ordering:: {
> +                Full,
> +                Release, //
> +            },
> +            Atomic,
> +            AtomicType, //
> +        },
> +        Arc,
> +        SpinLockIrq, //
> +    }, //
> +};
> +
> +use crate::{
> +    driver::IoMem,
> +    reset::HwGate, //
> +};
> +
> +/// Trait describing the operations required to service a Tyr =
interrupt source.
> +pub(crate) trait TyrIrqTrait: Sync {
> +    /// Returns the masked interrupt status.
> +    fn read_status(&self, io: &IoMem<'_>) -> u32;
> +
> +    /// Clears all bits in the mask register, disabling the interrupt =
sources.
> +    fn clear_mask(&self, io: &IoMem<'_>);
> +
> +    /// Sets the mask register to re-enable the interrupt sources.
> +    fn reenable_mask(&self, io: &IoMem<'_>);
> +
> +    /// Returns the raw interrupt status, regardless of the current =
mask.
> +    fn read_raw_status(&self, io: &IoMem<'_>) -> u32;
> +
> +    /// Clears the given bits in the interrupt status register.
> +    fn clear_status(&self, io: &IoMem<'_>, status: u32);
> +
> +    /// Returns the bitmask of interrupt sources handled by this =
instance.
> +    fn mask(&self) -> u32;
> +
> +    /// Handles the given pending, unmasked interrupt bits.
> +    fn handle(&self, status: u32);
> +}
> +
> +/// State shared between a [`TyrIrq`] and its [`TyrIrqRegistration`], =
used to
> +/// coordinate the primary handler, the threaded handler, and =
teardown.
> +#[derive(Clone, Copy, PartialEq, Eq)]
> +#[repr(i32)]
> +enum IrqState {
> +    /// Active and ready to process new events.
> +    Active =3D 0,
> +    /// A primary handler has claimed a pending event and the =
threaded handler is running, or
> +    /// about to run, to service it.
> +    Processing,
> +    // Being deregistered: the mask has been, or is being, cleared, =
and no
> +    // handler may re-enable it.
> +    Unregistering,
> +}
> +
> +// SAFETY: `IrqState` and `i32` has the same size and alignment, and =
it's round-trip
> +// transmutable to `i32`.
> +unsafe impl AtomicType for IrqState {
> +    type Repr =3D i32;
> +}
> +
> +/// A threaded IRQ wrapper shared by all Tyr interrupt sources.
> +#[pin_data]
> +pub(crate) struct TyrIrq<'a, T: TyrIrqTrait> {
> +    /// The interrupt source.
> +    irq: T,
> +    /// Shared gate that coordinates hardware access with GPU reset.
> +    hw: Arc<HwGate<'a>>,
> +    /// Current state.
> +    state: Atomic<IrqState>,
> +    #[pin]
> +    lock: SpinLockIrq<()>,

Please move IrqState inside the lock:

>    lock: SpinLockIrq<IrqState>,

Notice that Atomic<T> is gone here ^

> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +impl<'a, T: TyrIrqTrait> TyrIrq<'a, T> {
> +    /// Requests a threaded IRQ registration for `irq`, using `name` =
to look up the interrupt.
> +    /// Returns the shared [`IrqState`] alongside the registration.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must not `mem::forget()` the resulting registration =
or otherwise prevent its
> +    /// [`Drop`] implementation from running.
> +    unsafe fn request(
> +        pdev: &'a platform::Device<Bound>,
> +        name: &'static CStr,
> +        irq: T,
> +        hw: Arc<HwGate<'a>>,
> +    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + =
'a>
> +    where
> +        T: 'a,
> +    {
> +        let state =3D Atomic::new(IrqState::Active);
> +
> +        let handler =3D try_pin_init!(Self {
> +            irq,
> +            hw,
> +            state,
> +            lock <- kernel::new_spinlock_irq!(()),
> +            _pin: PhantomPinned,
> +        });
> +
> +        // SAFETY: The caller guarantees the resulting registration =
will not be leaked.
> +        let registration =3D
> +            unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, =
name, name, handler) };

I don't think we should use name twice here. The second one should =
probably be
tyr-job, tyr-mmu, tyr-gpu, etc. We should probably make this possible by =
taking
both a "irq_name" and a "name=E2=80=9D.

> +
> +        // Clear the status and unmask once the handler has been
> +        // successfully registered.
> +        Ok(registration.pin_chain(|reg| {
> +            let handler =3D reg.handler();
> +            let hw_guard =3D handler.hw.access();
> +            let io =3D hw_guard.iomem();
> +            let irq =3D &handler.irq;
> +            irq.clear_status(io, irq.mask());
> +            irq.reenable_mask(io);
> +            Ok(())
> +        }))
> +    }
> +}
> +
> +impl<T: TyrIrqTrait> ThreadedHandler for TyrIrq<'_, T> {
> +    fn handle(&self) -> ThreadedIrqReturn {
> +        // SAFETY: `handle()` is the hard IRQ handler, so interrupts =
are already
> +        // disabled.
> +        let token =3D unsafe { =
LocalInterruptDisabled::assume_disabled() };
> +        let _guard =3D self.lock.lock_with(token);

I'd rather not have this unsafe here if we can use the safe "lock()". If
interrupts are off, turning them off again is harmless. Also, AI said =
that your
unsafe comment is not true under all configs.

> +
> +        // Only proceed if still `Active`. If `Unregistering`, the =
IRQ is being
> +        // torn down and must not be handled.
> +        if self
> +            .state
> +            .cmpxchg(IrqState::Active, IrqState::Processing, Full)
> +            .is_err()
> +        {
> +            return ThreadedIrqReturn::None;
> +        }
> +
> +        let Some(hw_guard) =3D self.hw.try_access_atomic() else {
> +            let _ =3D self
> +                .state
> +                .cmpxchg(IrqState::Processing, IrqState::Active, =
Full);
> +            return ThreadedIrqReturn::None;
> +        };
> +        let io =3D hw_guard.iomem();
> +
> +        let masked_status =3D self.irq.read_status(io);
> +
> +        if masked_status =3D=3D 0 {
> +            // Go back to `Active`, unless the IRQ is being torn =
down.
> +            let _ =3D self
> +                .state
> +                .cmpxchg(IrqState::Processing, IrqState::Active, =
Full);
> +            return ThreadedIrqReturn::None;
> +        }
> +
> +        self.irq.clear_mask(io);
> +        ThreadedIrqReturn::WakeThread
> +    }
> +
> +    fn handle_threaded(&self) -> IrqReturn {
> +        let mut ret =3D IrqReturn::None;
> +
> +        loop {
> +            let hw_guard =3D self.hw.access();
> +            let io =3D hw_guard.iomem();
> +            let raw_status =3D self.irq.read_raw_status(io) & =
self.irq.mask();
> +            if raw_status =3D=3D 0 {
> +                break;
> +            }
> +            self.irq.clear_status(io, raw_status);
> +            drop(hw_guard);
> +            self.irq.handle(raw_status);
> +            ret =3D IrqReturn::Handled;
> +        }

let hw_guard =3D loop {
  ..
  if raw_status =3D=3D 0 {
    break hw_guard; <=E2=80=94 reuse this guy
  }
..
};


> +
> +        // Only re-enable the mask if still `Processing`. If =
`Unregistering`, the
> +        // IRQ is being torn down and must stay masked.
> +        let hw_guard =3D self.hw.access();
> +        let _guard =3D self.lock.lock();
> +        if self
> +            .state
> +            .cmpxchg(IrqState::Processing, IrqState::Active, Full)
> +            .is_ok()
> +        {
> +            self.irq.reenable_mask(hw_guard.iomem());
> +        }
> +
> +        ret
> +    }
> +}
> +
> +// A [`ThreadedRegistration`] for a Tyr interrupt source and its =
state.
> +
> +// Unlike a bare [`ThreadedRegistration`], dropping this type is =
always
> +// safe to do while the device remains on a shared IRQ line: its =
`Drop`
> +// implementation masks the interrupt source, and notifies teardown =
via the
> +// shared [`IrqState`], before the inner [`ThreadedRegistration`] is
> +// dropped and deregisters the handler.

// -> ///

Please mention that this must come before clocks and regulators, =
otherwise the
system will freeze when this type drops by attempting to do I/O on a =
powered
down circuit.

> +#[pin_data(PinnedDrop)]
> +pub(crate) struct TyrIrqRegistration<'a, T: TyrIrqTrait> {
> +    #[pin]
> +    registration: ThreadedRegistration<'a, TyrIrq<'a, T>>,
> +}
> +
> +#[pinned_drop]
> +impl<T: TyrIrqTrait> PinnedDrop for TyrIrqRegistration<'_, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Flag teardown and mask the interrupt source, before
> +        // `self.registration`'s own `PinnedDrop` runs next and calls =
`free_irq()`.
> +        // This prevents the hardware from asserting the interrupt =
again once it is
> +        // deregistered. `free_irq()` itself waits for any handler =
already in
> +        // flight to complete, and having already flagged =
`Unregistering`, such a
> +        // handler will not re-enable the mask (see =
`TyrIrq::handle_threaded`).
> +        let handler =3D self.registration.handler();
> +        let hw_guard =3D handler.hw.access();
> +        let _guard =3D handler.lock.lock();
> +        handler.state.store(IrqState::Unregistering, Release);
> +        handler.irq.clear_mask(hw_guard.iomem());
> +    }
> +}
> +
> +impl<'a, T: TyrIrqTrait> TyrIrqRegistration<'a, T> {
> +    /// Requests a threaded IRQ registration for `irq`, using `name` =
to look up the interrupt.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must not `mem::forget()` the resulting registration =
or otherwise prevent its
> +    /// [`Drop`] implementation from running.
> +    pub(crate) unsafe fn request(
> +        pdev: &'a platform::Device<Bound>,
> +        name: &'static CStr,
> +        irq: T,
> +        hw: Arc<HwGate<'a>>,
> +    ) -> Result<Pin<KBox<Self>>>
> +    where
> +        T: 'a,
> +    {
> +        // SAFETY: The caller guarantees the resulting registration =
will not be leaked.
> +        let registration =3D unsafe { TyrIrq::request(pdev, name, =
irq, hw) }?;
> +
> +        KBox::try_pin_init(
> +            try_pin_init!(Self {
> +                registration <- registration,
> +            }),
> +            GFP_KERNEL,
> +        )
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/reset/hw_gate.rs =
b/drivers/gpu/drm/tyr/reset/hw_gate.rs
> index 40b38f07c472..2157b4b8ba78 100644
> --- a/drivers/gpu/drm/tyr/reset/hw_gate.rs
> +++ b/drivers/gpu/drm/tyr/reset/hw_gate.rs
> @@ -76,7 +76,6 @@ pub(crate) fn access(&self) -> HwAccessGuard<'_, =
'hw> {
>     ///
>     /// Returns `None` while the reset worker owns the hardware, in =
which case
>     /// the caller must skip its hardware access.
> -    #[expect(dead_code)]
>     pub(crate) fn try_access_atomic(&self) -> Option<HwAccessGuard<'_, =
'hw>> {
>         let srcu =3D self.srcu.read_lock();
>=20
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 9d995650be81..b112cc8a5573 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -12,6 +12,7 @@
> mod fw;
> mod gem;
> mod gpu;
> +mod irq;
> mod mmu;
> mod regs;
> mod reset;
>=20
> --=20
> 2.39.5
>=20

By the way, it seems like you forgot to run rustfmt one last time at =
some
point? Unless I am mistaken, running rustfmt here produces (a small) =
diff.

=E2=80=94 Daniel

