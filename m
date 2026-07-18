Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4546EC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 15:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC3B10E1E5;
	Sat, 18 Jul 2026 15:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RmtAxm7u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 977AB10E1E5
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 15:48:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BD77436A3;
 Sat, 18 Jul 2026 15:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40EC1F000E9;
 Sat, 18 Jul 2026 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784389711;
 bh=6zcIrcBa5MxYBfWQUH/bEdc6hGtiSk+93tpHDQJjRYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RmtAxm7uqZxqjxSj2qEUMDOv99tgtJSbdOzW19XacE37kqdUFQ32RaoCXZPIxY0Lj
 wCSGd9NnqI8WE2yNm/LJwlYLtFHarGxx0qyjgANb4DwtCDYevDmcD1T2Gv+4HvDV8i
 coWFMes1czxl8jLCjfinNvdXUODVLOWFzj+CP7vdEbZvRKfkDl/GgklEIy8pbOsOt/
 bCRzAfCL7mls2YNy9VC8ypOiDc+smO8bs83h2ZVQg+JwS7qJ8IDnhdDKRjoLrDfZTq
 xCYKBpmCaJs5v1v6OZH0XsBhd7Eiv6MSmT6MQe9Ap8OKhK2/8U2EzaWSVid3ykPhHD
 2A0Xcg0RIGWeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 1/3] rust: add basic serial device bus abstractions
To: "Markus Probst" <markus.probst@posteo.de>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260718-rust_serdev-v16-1-5809384d2e1b@posteo.de>
References: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
 <20260718-rust_serdev-v16-1-5809384d2e1b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 15:48:30 +0000
Message-Id: <20260718154830.C40EC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Structural deadlock in `probe_callback` prevents synchronous bidir=
ectional I/O during driver initialization.
- [High] Race condition between `drvdata` unlinking and `serdev_device_clos=
e` leads to Null Pointer Dereference in `receive_buf_callback`.
- [High] `Device` communication methods are restricted to `Device<Bound>`, =
breaking `probe` initialization.
- [High] `core::slice::from_raw_parts` is called with a potentially NULL po=
inter when `length` is 0.
- [Medium] Incomplete `Send` and `Sync` implementations restrict `ARef<Devi=
ce<Ctx>>` cross-thread usage.
- [Low] Using `select` on a visible `menuconfig` symbol forces its value an=
d violates Kconfig guidelines.
--

--- Patch [1]: [PATCH v16 1/3] rust: add basic serial device bus abstractio=
ns ---
commit d5709e842e68663c0c3e7182a96d6618f31e84b5
Author: Markus Probst <markus.probst@posteo.de>
rust: add basic serial device bus abstractions

This commit implements the basic Rust abstractions for the serial device
bus. It introduces the Driver trait and Device representation to allow
writing serdev device drivers in Rust.

> --- a/drivers/tty/serdev/Kconfig
> +++ b/drivers/tty/serdev/Kconfig
> @@ -9,6 +9,13 @@ menuconfig SERIAL_DEV_BUS
> =20
>  	  Note that you typically also want to enable TTY port controller suppo=
rt.
> =20
> +config RUST_SERIAL_DEV_BUS_ABSTRACTIONS
> +	bool "Rust Serial device bus abstractions"
> +	depends on RUST
> +	select SERIAL_DEV_BUS

[Severity: Low]
Is it intended to use select on a user-visible menuconfig symbol?

SERIAL_DEV_BUS is a user-visible tristate. Using select here forcefully
coerces SERIAL_DEV_BUS to y when the abstraction is enabled, which prevents
building the serdev subsystem as a module. Kconfig guidelines generally
recommend using depends on for visible symbols instead of select.

[ ... ]

> --- /dev/null
> +++ b/rust/kernel/serdev.rs
> @@ -0,0 +1,605 @@
[ ... ]
> +/// #[vtable]
> +/// impl serdev::Driver for MyDriver {
> +///     type IdInfo =3D ();
> +///     type Data<'bound> =3D Self;
> +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&O=
F_TABLE);
> +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Som=
e(&ACPI_TABLE);
> +///
> +///     fn probe<'bound>(
> +///         sdev: &'bound serdev::Device<Core<'_>>,
> +///         _id_info: Option<&'bound Self::IdInfo>,
> +///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +///         sdev.set_baudrate(115200);

[Severity: High]
Will this documentation example compile?

The Driver probe callback provides a Device parameter with the Core context,
but serial communication methods like set_baudrate are exclusively
implemented on Device with the Bound context.

Because the types differ, calling set_baudrate on the Core device during
probe will result in a compilation error.

Furthermore, PrivateData expects the device reference to have the Bound
context, but probe_callback casts it to CoreInternal, which causes an
internal type mismatch during the PrivateData initialization.

[ ... ]
> +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> =
kernel::ffi::c_int {
[ ... ]
> +            // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> +            let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
> +            let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
> +                // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> +                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
> +            });

[Severity: High]
Does this error cleanup path introduce a race condition leading to a null
pointer dereference?

If an error occurs in Adapter::probe_callback, the ScopeGuard runs and
calls drvdata_obtain, which unlinks the driver data from the device by
setting dev->driver_data to NULL.

However, the device remains open until PrivateData::drop subsequently calls
serdev_device_close. If serial data arrives in this window,
receive_buf_callback executes:

rust/kernel/serdev.rs:Adapter::receive_buf_callback() {
    ...
    let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateDat=
a<'_, T>>() };
    let active =3D private_data.active.lock();
    ...
}

The callback will blindly read the now-NULL dev->driver_data and create a
Rust reference to NULL. When private_data.active.lock() is called, the
kernel will crash with a null pointer dereference.

The device should probably be closed synchronously before unlinking the
driver data.

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
Can this sequence cause a deadlock during driver initialization?

In Adapter::probe_callback, the private_data.active mutex is locked and
held across the entire execution of T::probe. If a driver attempts
synchronous bidirectional I/O (like writing a query command and waiting
for a response) during probe, the system might deadlock.

When the hardware responds, the RX workqueue thread triggers
Adapter::receive_buf_callback, which unconditionally attempts to lock
the exact same private_data.active mutex before forwarding data. Because
the mutex is held by the sleeping probe thread, receive_buf_callback blocks
indefinitely, stalling the RX workqueue, and T::probe will wait forever
for a response.

[ ... ]
> +    extern "C" fn receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
[ ... ]
> +        // SAFETY: No one has exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &*private_data.driver.get() };
> +        // SAFETY:
> +        // - `private_data.driver` is pinned.
> +        // - `receive_buf_callback` is only ever called after a successf=
ul call to `probe_callback`,
> +        //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
> +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };

[Severity: High]
Can core::slice::from_raw_parts be called with a null pointer here?

The C serdev core and underlying TTY layer might signal empty events or
flushes by passing a NULL buffer with a length of 0. In Rust, calling
core::slice::from_raw_parts with a NULL pointer is immediate undefined
behavior, regardless of whether the length is zero, because the standard
library requires the pointer to be non-NULL and aligned.

Could a check like if buf.is_null() or if length =3D=3D 0 be added before
creating the slice?

[ ... ]
> +// SAFETY: A `Device` is always reference-counted and can be released fr=
om any thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` can be shared among threads because all methods of `=
Device`
> +// (i.e. `Device<Normal>) are thread safe.
> +unsafe impl Sync for Device {}
> +
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct serdev_dev=
ice` is the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

[Severity: Medium]
Does the Device type with the Bound context need a Send implementation?

The trait implementations unsafe impl Send for Device {} and
unsafe impl Sync for Device {} implicitly apply only to Device with the
Normal context due to the default generic parameter.

While unsafe impl Sync for Device with Bound context was explicitly added,
Send is missing. This means a Device with the Bound context is not Send,
so it cannot be moved across thread boundaries, stored in standard
thread-safe driver state, or safely passed to workqueues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-rust_serde=
v-v16-0-5809384d2e1b@posteo.de?part=3D1
