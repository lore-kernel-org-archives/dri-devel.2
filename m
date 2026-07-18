Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB7BC4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A4610E5A1;
	Sat, 18 Jul 2026 14:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L5GFeKlu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C24710E5A1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:42:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56AF160018;
 Sat, 18 Jul 2026 14:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10AA1F000E9;
 Sat, 18 Jul 2026 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784385731;
 bh=nhF01RtOzAytIfrDRXLaFiDSXvHEx4FELfp/39YgGBI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L5GFeKlu+o97suis3NSf/oyKsHFx/ob7Zy+uRCow5f77vwnXyGSknRq6eYITdWlD3
 9YX9bljkwPCgiq1UJzxUZ28kYpyB9zTld/h8/aRx4s9AaCib1Or90AOxdAF6El/rbJ
 RBpiaTZtoDH7Pmu7q4EbtqXNBumRlcNb/SaeZkLBF2aNVGI2pPNF2FL5C5tdtxNW7h
 4nSe6Rp4hYTGimijTVoZNXRofldjuq8V+vknGe3su3VHhe3yaoZik3q/Q1GldxNFlH
 Y+OzSWC+Nszrm1PhNUx6XrAdHKfWU/+EYSAMDP5EGSiNmFobJ4eRveo5H7I9GCYa17
 CWd7J7KLyGMdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/3] rust: add basic serial device bus abstractions
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260718-rust_serdev-v15-1-208ed2e6ec15@posteo.de>
References: <20260718-rust_serdev-v15-0-208ed2e6ec15@posteo.de>
 <20260718-rust_serdev-v15-1-208ed2e6ec15@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 14:42:10 +0000
Message-Id: <20260718144210.D10AA1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Delayed device closure and improperly synchronized teardown lead t=
o race conditions, causing NULL pointer dereferences or Use-After-Free in `=
receive_buf_callback` during device unbind or probe failure.
- [High] Holding the `active` mutex across driver initialization and teardo=
wn causes deadlocks if a driver communicates synchronously with the hardwar=
e.
- [Low] Code fails to compile due to the use of an undefined type `device::=
BoundInternal` and an unavailable `drvdata_borrow` method for it.
- [Low] Small forwarding functions in the `Device` abstraction lack the req=
uired `#[inline]` annotation.
--

--- Patch [1]: [PATCH v15 1/3] rust: add basic serial device bus abstractio=
ns ---
commit 08bb3dcc665ba5840df1251ed6f1adfe75a7761a
Author: Markus Probst <markus.probst@posteo.de>

rust: add basic serial device bus abstractions

This commit introduces the basic abstractions for writing serial device bus
(serdev) drivers in Rust. It provides traits and structures representing
serdev::Driver, serdev::Device, and adapter logic to bridge the C API.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> new file mode 100644
> index 0000000000000..0fdb37cff15dd
> --- /dev/null
> +++ b/rust/kernel/serdev.rs

[ ... ]

> +#[pinned_drop]
> +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let mut active =3D self.active.lock();
> +        if *active {
> +            // SAFETY:
> +            // - We have exclusive access to `self.driver`.
> +            // - `self.driver` is guaranteed to be initialized.
> +            unsafe { (*self.driver.get()).assume_init_drop() };

[Severity: High]
Does this code introduce a deadlock? It looks like the active mutex is held
across the driver drop execution. If the driver communicates synchronously =
with
the hardware and waits for a response, it might block forever because
Adapter::receive_buf_callback() also waits on this active mutex.

> +            *active =3D false;
> +        }
> +        drop(active);
> +
> +        // SAFETY: We have exclusive access to `self.open`.
> +        if unsafe { *self.open.get() } {
> +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointe=
r to a valid
> +            // `struct serdev_device`.
> +            unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };

[Severity: High]
Could this result in a NULL pointer dereference or use-after-free? The devi=
ce
is closed here, but the driver data has already been cleared by
drvdata_obtain() in the probe error path or post_unbind_rust. This leaves a
window where the device is still active, and if data arrives,
receive_buf_callback() might blindly dereference the NULL drvdata pointer.

> +        }
> +    }
> +}

[ ... ]

> +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> =
kernel::ffi::c_int {

[ ... ]

> +            let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
> +                // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> +                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
> +            });
> +            let mut active =3D private_data.active.lock();
> +
> +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid point=
er to `serdev_device`.
> +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(=
), Self::OPS) };
> +
> +            // SAFETY: The serial device bus only ever calls the probe c=
allback with a valid pointer
> +            // to a `serdev_device`.
> +            to_result(unsafe { bindings::serdev_device_open(sdev.as_raw(=
)) })?;
> +
> +            // SAFETY: We have exclusive access to `private_data.open`.
> +            unsafe { *private_data.open.get() =3D true };
> +
> +            let data =3D T::probe(sdev, info);

[Severity: High]
Is it safe to hold the active lock across the entire driver initialization
in T::probe? If a driver needs to send a command to the serial device during
probe and wait for an acknowledgment, it will deadlock since
receive_buf_callback() unconditionally waits on this same active mutex.

> +
> +            // SAFETY: We have exclusive access to `private_data.driver`.
> +            let driver =3D unsafe { &mut *private_data.driver.get() };

[ ... ]

> +    extern "C" fn receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
> +        // SAFETY: The serial device bus only ever calls the receive buf=
 callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundInternal=
>>() };

[Severity: Low]
Will this compile when CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS is enabled?
It appears device::BoundInternal is an undefined type, as the valid contexts
in the kernel are Normal, Bound, Core, and CoreInternal.

> +
> +        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };

[Severity: Low]
Does this method exist? It seems drvdata_borrow() is only implemented for
Device<CoreInternal>, so even if BoundInternal existed, this method might n=
ot
be available.

> +        let active =3D private_data.active.lock();

[Severity: High]
Could this unconditionally block and cause a deadlock? As mentioned earlier,
if probe_callback() or PrivateData::drop() holds the active lock while
waiting for incoming data, this callback will be blocked and the workqueue
will deadlock.

> +
> +        if !*active {

[ ... ]

> +// SAFETY: Instances of `Device` are always reference-counted.
> +unsafe impl AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        self.as_ref().inc_ref();
> +    }

[Severity: Low]
this isn't a bug, but shouldn't small forwarding functions like this be
annotated with #[inline] according to the Rust coding guidelines?

> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::serdev_device_put(obj.cast().as_ptr()) }
> +    }

[Severity: Low]
this isn't a bug, but does this function also need an #[inline] annotation
for being a small forwarding function?

> +}
> +
> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
> +        // `struct serdev_device`.
> +        let dev =3D unsafe { &raw mut (*self.as_raw()).dev };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }

[Severity: Low]
this isn't a bug, but should this be annotated with #[inline] as well?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-rust_serde=
v-v15-0-208ed2e6ec15@posteo.de?part=3D1
