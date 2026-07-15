Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F2EC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4306210E1DA;
	Wed, 15 Jul 2026 17:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.b="FB92mAJ6";
	dkim-atps=neutral
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD4010E1DA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 17:20:31 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 60569240101
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
 s=1984.8680eb; t=1784136029;
 bh=ASC46HuKd+AFbjl8HVU8HORwEbJMos/+UqAA9xDMBBM=;
 h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
 MIME-Version:OpenPGP:From;
 b=FB92mAJ6kzUbmL5ubIjX7EQdJMJp/DpTpZiraUpe+nL83x/HWEfVONYu45M1hhVUH
 fnVsFeLt/w+4wzypiQUw2fpNMM7isHlqHgq/Nl478NUS9IIR2p0w3TF4/HEnywOmJV
 MbmqcQ30cFCizUqw890TpKi+wD6dStaP+ZEFqU/mwymNBtl4dkrPRiqVNQQyKfyKmn
 OAGfnD+Z0zaJBHsHoyNQZFVSVGZMLx+c5o89vsRGXhbfRHHudNvLb3dyAdyMAo1iPZ
 q7E3gpIWFh3fxIYUl4dH4fqPjC3v8I7WRxN9ODUeq4TCa8IDmCry5j3lIHRiMjhA2B
 +c8mt0DYmeBNA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4h0jcC6vcwz9rxF;
 Wed, 15 Jul 2026 19:20:27 +0200 (CEST)
Message-ID: <acd14fdd28746d37803decf664dae6b57198ea43.camel@posteo.de>
Subject: Re: [PATCH v13 1/3] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
Date: Wed, 15 Jul 2026 17:20:29 +0000
In-Reply-To: <20260712171525.A5E3F1F000E9@smtp.kernel.org>
References: <20260712-rust_serdev-v13-0-2c4060bc8e30@posteo.de>
 <20260712-rust_serdev-v13-1-2c4060bc8e30@posteo.de>
 <20260712171525.A5E3F1F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-pKXgMmoHPBXy2RAR3719"
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc;
 preference=encrypt
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


--=-pKXgMmoHPBXy2RAR3719
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-07-12 at 17:15 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] `serdev::Driver::Data` is missing a `Sync` trait bound, allowing=
 safe code to trigger Undefined Behavior via data races.
> - [High] The framework defers `serdev_device_close()` to `PrivateData::dr=
op` and fails to close the device synchronously in `remove_callback`, creat=
ing a race window that leads to NULL pointer dereferences, Use-After-Free, =
and deadlocks.
> - [High] Holding the `active` mutex across `T::probe` introduces a cyclic=
 AB-BA deadlock if a driver synchronously awaits receive data during initia=
lization.
> - [Medium] `write_all` improperly casts the `ssize_t` return value of `se=
rdev_device_write` to `i32`, which causes successful writes larger than 2GB=
 to be incorrectly treated as negative error codes.
> --
>=20
> --- Patch [1]: [PATCH v13 1/3] rust: add basic serial device bus abstract=
ions ---
> commit d3271c073101a0f9ce803c8c5d6de6e1b8618c41
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rust: add basic serial device bus abstractions
>    =20
> This commit introduces the Rust abstractions for the serial device bus AP=
I.
> It adds the serdev::Driver trait, the serdev::Device abstraction represen=
ting
> a struct serdev_device, and adapter mechanisms to register drivers with t=
he
> generic driver core.
>=20
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > new file mode 100644
> > index 0000000000000..ab5d6446b091e
> > --- /dev/null
> > +++ b/rust/kernel/serdev.rs
> [ ... ]
> > +#[pinned_drop]
> > +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        let mut active =3D self.active.lock();
> > +        if *active {
> > +            // SAFETY:
> > +            // - We have exclusive access to `self.driver`.
> > +            // - `self.driver` is guaranteed to be initialized.
> > +            unsafe { (*self.driver.get()).assume_init_drop() };
> > +            *active =3D false;
> > +        }
> > +
> > +        // SAFETY: We have exclusive access to `self.open`.
> > +        if unsafe { *self.open.get() } {
> > +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a poin=
ter to a valid
> > +            // `struct serdev_device`.
> > +            unsafe { bindings::serdev_device_close(self.sdev.as_raw())=
 };
> > +        }
> > +    }
> > +}
>=20
> [Severity: High]
> Does deferring serdev_device_close() to drop() introduce an AB-BA deadloc=
k?
>=20
> If receive_buf_callback() executes on the receive workqueue while Private=
Data
> is being dropped, the receive thread will block waiting for the 'active'
> mutex. Meanwhile, this drop() method holds the 'active' mutex and calls
> serdev_device_close(), which synchronously flushes the workqueue. This
> seems like it would cause the two threads to deadlock.
That is an issue.

>=20
> [ ... ]
> > +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -=
> kernel::ffi::c_int {
> [ ... ]
> > +            let mut active =3D private_data.active.lock();
> > +
> > +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid poi=
nter to `serdev_device`.
> > +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_ra=
w(), Self::OPS) };
> > +
> > +            // SAFETY: The serial device bus only ever calls the probe=
 callback with a valid pointer
> > +            // to a `serdev_device`.
> > +            to_result(unsafe { bindings::serdev_device_open(sdev.as_ra=
w()) })?;
> > +
> > +            // SAFETY: We have exclusive access to `private_data.open`=
.
> > +            unsafe { *private_data.open.get() =3D true };
> > +
> > +            let data =3D T::probe(sdev, info);
>=20
> [Severity: High]
> Can holding the 'active' mutex across T::probe() cause a cyclic deadlock
> during device initialization?
>=20
> If a driver sends a hardware identification command in its probe() routin=
e
> and synchronously waits for the response, the incoming data will trigger
> receive_buf_callback() on a separate thread. Because receive_buf_callback=
()
> unconditionally attempts to acquire the 'active' mutex, it will block
> forever while probe_callback() holds the mutex and waits for the receive
> data.
False positive, kinda.

It is not possbile yet, to retrieve initial device data.

>=20
> [ ... ]
> > +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) =
{
> > +        // SAFETY: The serial device bus only ever calls the remove ca=
llback with a valid pointer
> > +        // to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `remove_call=
back()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l<'_>>>() };
> > +
> > +        // SAFETY: `remove_callback` is only ever called after a succe=
ssful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<P=
rivateData<'_, T>>() };
> > +
> > +        // SAFETY: No one has exclusive access to `private_data.driver=
`.
> > +        let data =3D unsafe { &*private_data.driver.get() };
> > +        // SAFETY:
> > +        // - `private_data.driver` is pinned.
> > +        // - `remove_callback` is only ever called after a successful =
call to `probe_callback`,
> > +        //   hence it's guaranteed that `private_data.driver` was init=
ialized.
> > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_ref()) };
> > +
> > +        T::unbind(sdev, data_pinned);
> > +    }
>=20
> [Severity: High]
> Should serdev_device_close() be called synchronously in remove_callback()
> rather than waiting for PrivateData::drop?
>=20
> By not closing the device synchronously here, the device remains active
> and the receive layer can asynchronously trigger receive_buf_callback() o=
n a
> workqueue. In the unbind path, the device core subsequently invokes
> post_unbind_rust(), which clears the device's drvdata pointer.=20
>=20
> If receive_buf_callback() executes right after drvdata is cleared, it
> blindly dereferences a null pointer via drvdata_borrow().
False positive.

impl Drop for PrivateData locks the active mutex and sets its value to
false.
receive_buf_callback trys to acquire this mutex and if the value is
false, it never accesses the driver data. serdev_device_close gets
called before private data gets deallocated.

>=20
> [ ... ]
> > +pub trait Driver {
> > +    /// The type holding driver private data about each device id supp=
orted by the driver.
> > +    // TODO: Use associated_type_defaults once stabilized:
> > +    //
> > +    // ```
> > +    // type IdInfo: 'static =3D ();
> > +    // ```
> > +    type IdInfo: 'static;
> > +
> > +    /// The type of the driver's bus device private data.
> > +    type Data<'bound>: Send + 'bound;
>=20
> [Severity: High]
> Is serdev::Driver::Data missing a Sync trait bound?
>=20
> The serdev framework invokes receive_buf_callback() from the receive
> workqueue and remove_callback() from the driver core unbind context. Both
> callbacks synthesize a shared reference Pin<&T::Data> from the raw driver
> pointer without any mutual exclusion.
>=20
> Because T::Data does not require Sync, safe Rust code could use
> non-thread-safe types (e.g., core::cell::Cell) in the driver state,
> leading to data races and undefined behavior.
I suppose thats an issue too.
>=20
> [ ... ]
> > +    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<u=
size> {
> > +        // SAFETY:
> > +        // - `self.as_raw()` is guaranteed to be a pointer to a valid =
`serdev_device`.
> > +        // - `data.as_ptr()` is guaranteed to be a valid array pointer=
 with the size of
> > +        //   `data.len()`.
> > +        let ret =3D unsafe {
> > +            bindings::serdev_device_write(
> > +                self.as_raw(),
> > +                data.as_ptr(),
> > +                data.len(),
> > +                timeout.into_jiffies(),
> > +            )
> > +        };
> > +        // CAST: negative return values are guaranteed to be between `=
-MAX_ERRNO` and `-1`,
> > +        // which always fit into a `i32`.
> > +        to_result(ret as i32).map(|()| ret.unsigned_abs())
> > +    }
>=20
> [Severity: Medium]
> Does casting the ssize_t return value of serdev_device_write() to i32
> incorrectly treat large successful writes as errors?
Yes, but thats more an issue with the input not being checked than the
return type.

>=20
> If a caller passes a slice larger than 2GB (e.g., on a 64-bit architectur=
e)
> and the write succeeds, the positive isize return value will overflow
> during the 'as i32' cast, resulting in a negative number. to_result()
> will then erroneously interpret this successful return as a kernel error
> code.

--=-pKXgMmoHPBXy2RAR3719
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpXwU4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS0MMP/AmC12M4xf31dHprDstM
NKyRGB+i0MevOoT+9l44ZZp8j7yw3WUZl37USNsBeQTbhXDgT7shtCNEeN3ASa6u
FD/Y5U0lMaDvZNLp2Ttrok7pBkkWPQ/hgbwnTwLh5JxvhCmar8fdm7IC9fHvdnnT
yTVkie9M8uCkb4q682x21CLqZDDjz15rutyh5I+plAfsEa3i9GOUQUpOLlbJ1iWP
l4uDgR29+AnviPSLC1pmt0ne9q2AKjO8rTyPtUduHezfEelHnZcsvYZYyCtHtkyD
XJpR2zRMfauexzgKzG4kaqjjOQzza0wOxU0wx+OIPq3hNY+lXlyKpS+/pmVbRymd
haXbuloenWJv6OgoFnYhtiVC91ipmLjOIKoqR4THwqZgnazGrtux7ruqQgRouoeT
UXtmyHD64qwkEbRWXspu68c9CqGF1TwHoLqvzRykWHZeeWR7UOTPkIkIgHgRGVQw
FOPZkL/l04xXid/VjyvCbGuZ8nWnW/6+95xyUr9ZuaW0A8WoKqAlOqxNBCrD0QUj
8zNa0/3IN9mwdTZ2EIQ0siJHfVAEqp7HW3w9g1k6/pvPzc6FvrFxVL0um6xO7eLi
6kKlciAUKMjcceJsGWTLDJvGjJzLuuoCNxkmd8rtpdEJSzmJVhFt1sYuAIbiLsQf
v/mhYnuOU8/0nOuaNo5RQ6Nj
=ChbG
-----END PGP SIGNATURE-----

--=-pKXgMmoHPBXy2RAR3719--
