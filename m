Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1B1C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 17:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1240510E283;
	Sun, 12 Jul 2026 17:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M9U3kKJh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34EF10E283
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 17:15:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F008E4024E;
 Sun, 12 Jul 2026 17:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E3F1F000E9;
 Sun, 12 Jul 2026 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783876525;
 bh=e+AQFnZVR9/lh4OG8N1eP0DIwuByipDjMU88vJla5p0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M9U3kKJhvtGqcysAsvbFzB69Q4CKxUqsQuOA/+wO+0HIOn2HTVz090GNzf1PYZPtm
 9nI4LelLlyIw+4vtwcYj8JvEtWcepwWnl3k9x3EoCthVlDo+rpXajOfYz94dxqdsnP
 rh6Ni6WxlVcIR58yDe/3Wo38ucMvEuvUUUGamwO3n+jo+P62Y/aiTjfC/E6tjOdzfY
 c4Xo0511U0oHjIFiQkRSqw0UltVt0PRWq8T1LfnY95X0+yp8T0x9BbieHzw9/HOlwL
 GCZYAtJvygZJKItfhzY31LB8MpzjRKWbHqtu97ZD3NnLigtGN/LozDcTMkdUTQ72Us
 Os10nzMiyYeDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/3] rust: add basic serial device bus abstractions
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260712-rust_serdev-v13-1-2c4060bc8e30@posteo.de>
References: <20260712-rust_serdev-v13-0-2c4060bc8e30@posteo.de>
 <20260712-rust_serdev-v13-1-2c4060bc8e30@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 17:15:25 +0000
Message-Id: <20260712171525.A5E3F1F000E9@smtp.kernel.org>
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
- [High] `serdev::Driver::Data` is missing a `Sync` trait bound, allowing s=
afe code to trigger Undefined Behavior via data races.
- [High] The framework defers `serdev_device_close()` to `PrivateData::drop=
` and fails to close the device synchronously in `remove_callback`, creatin=
g a race window that leads to NULL pointer dereferences, Use-After-Free, an=
d deadlocks.
- [High] Holding the `active` mutex across `T::probe` introduces a cyclic A=
B-BA deadlock if a driver synchronously awaits receive data during initiali=
zation.
- [Medium] `write_all` improperly casts the `ssize_t` return value of `serd=
ev_device_write` to `i32`, which causes successful writes larger than 2GB t=
o be incorrectly treated as negative error codes.
--

--- Patch [1]: [PATCH v13 1/3] rust: add basic serial device bus abstractio=
ns ---
commit d3271c073101a0f9ce803c8c5d6de6e1b8618c41
Author: Markus Probst <markus.probst@posteo.de>

rust: add basic serial device bus abstractions
   =20
This commit introduces the Rust abstractions for the serial device bus API.
It adds the serdev::Driver trait, the serdev::Device abstraction representi=
ng
a struct serdev_device, and adapter mechanisms to register drivers with the
generic driver core.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> new file mode 100644
> index 0000000000000..ab5d6446b091e
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
> +            *active =3D false;
> +        }
> +
> +        // SAFETY: We have exclusive access to `self.open`.
> +        if unsafe { *self.open.get() } {
> +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointe=
r to a valid
> +            // `struct serdev_device`.
> +            unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
> +        }
> +    }
> +}

[Severity: High]
Does deferring serdev_device_close() to drop() introduce an AB-BA deadlock?

If receive_buf_callback() executes on the receive workqueue while PrivateDa=
ta
is being dropped, the receive thread will block waiting for the 'active'
mutex. Meanwhile, this drop() method holds the 'active' mutex and calls
serdev_device_close(), which synchronously flushes the workqueue. This
seems like it would cause the two threads to deadlock.

[ ... ]
> +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> =
kernel::ffi::c_int {
[ ... ]
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
Can holding the 'active' mutex across T::probe() cause a cyclic deadlock
during device initialization?

If a driver sends a hardware identification command in its probe() routine
and synchronously waits for the response, the incoming data will trigger
receive_buf_callback() on a separate thread. Because receive_buf_callback()
unconditionally attempts to acquire the 'active' mutex, it will block
forever while probe_callback() holds the mutex and waits for the receive
data.

[ ... ]
> +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
> +        // SAFETY: The serial device bus only ever calls the remove call=
back with a valid pointer
> +        // to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `remove_callba=
ck()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> +
> +        // SAFETY: `remove_callback` is only ever called after a success=
ful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> +
> +        // SAFETY: No one has exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &*private_data.driver.get() };
> +        // SAFETY:
> +        // - `private_data.driver` is pinned.
> +        // - `remove_callback` is only ever called after a successful ca=
ll to `probe_callback`,
> +        //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +
> +        T::unbind(sdev, data_pinned);
> +    }

[Severity: High]
Should serdev_device_close() be called synchronously in remove_callback()
rather than waiting for PrivateData::drop?

By not closing the device synchronously here, the device remains active
and the receive layer can asynchronously trigger receive_buf_callback() on a
workqueue. In the unbind path, the device core subsequently invokes
post_unbind_rust(), which clears the device's drvdata pointer.=20

If receive_buf_callback() executes right after drvdata is cleared, it
blindly dereferences a null pointer via drvdata_borrow().

[ ... ]
> +pub trait Driver {
> +    /// The type holding driver private data about each device id suppor=
ted by the driver.
> +    // TODO: Use associated_type_defaults once stabilized:
> +    //
> +    // ```
> +    // type IdInfo: 'static =3D ();
> +    // ```
> +    type IdInfo: 'static;
> +
> +    /// The type of the driver's bus device private data.
> +    type Data<'bound>: Send + 'bound;

[Severity: High]
Is serdev::Driver::Data missing a Sync trait bound?

The serdev framework invokes receive_buf_callback() from the receive
workqueue and remove_callback() from the driver core unbind context. Both
callbacks synthesize a shared reference Pin<&T::Data> from the raw driver
pointer without any mutual exclusion.

Because T::Data does not require Sync, safe Rust code could use
non-thread-safe types (e.g., core::cell::Cell) in the driver state,
leading to data races and undefined behavior.

[ ... ]
> +    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usi=
ze> {
> +        // SAFETY:
> +        // - `self.as_raw()` is guaranteed to be a pointer to a valid `s=
erdev_device`.
> +        // - `data.as_ptr()` is guaranteed to be a valid array pointer w=
ith the size of
> +        //   `data.len()`.
> +        let ret =3D unsafe {
> +            bindings::serdev_device_write(
> +                self.as_raw(),
> +                data.as_ptr(),
> +                data.len(),
> +                timeout.into_jiffies(),
> +            )
> +        };
> +        // CAST: negative return values are guaranteed to be between `-M=
AX_ERRNO` and `-1`,
> +        // which always fit into a `i32`.
> +        to_result(ret as i32).map(|()| ret.unsigned_abs())
> +    }

[Severity: Medium]
Does casting the ssize_t return value of serdev_device_write() to i32
incorrectly treat large successful writes as errors?

If a caller passes a slice larger than 2GB (e.g., on a 64-bit architecture)
and the write succeeds, the positive isize return value will overflow
during the 'as i32' cast, resulting in a negative number. to_result()
will then erroneously interpret this successful return as a kernel error
code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-rust_serde=
v-v13-0-2c4060bc8e30@posteo.de?part=3D1
