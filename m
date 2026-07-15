Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0535DC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2876210ED57;
	Wed, 15 Jul 2026 17:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.b="Ff018Pq2";
	dkim-atps=neutral
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFEC10ED57
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 17:52:52 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 97263240103
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
 s=1984.8680eb; t=1784137970;
 bh=uppFLYZEKdPSHWk7UrhpBtU2MX2EFrENz0Run2QZ1Y0=;
 h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
 MIME-Version:OpenPGP:From;
 b=Ff018Pq27OgWyNbo+3HpCHaHhptSA/iixl04wRe+wtteKYbqCW/yP3ti/TwDifzZW
 PtTTlxWTeuqVD/P6tkICVYoaGgdY6x2LsH1lT+AkLu16PNuCK8N6W9ghnvjs6hiekd
 oGdZBYS44btgHPYixncH1XcZ77MXr7Mp3z8+iUj0CwiJftyyPEavv+BjL1HYIYwYiR
 wQlaqjR+vqDl9HbAhMFHlvlMe5qVWeS0m8eht09K6pUoxdtWajkh77CtOEg+fylJm9
 LirynwDY1jfT9ktvw20KeRbbsAjJUmLWZrfBJNGhnXP+zc0ZqYmRaRT0c8HUnj7hWM
 UziGs4OEdtMQg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4h0kKY3YKRz9rxR;
 Wed, 15 Jul 2026 19:52:49 +0200 (CEST)
Message-ID: <1a88b379490acf95826fea999084073ec75e32ed.camel@posteo.de>
Subject: Re: [PATCH v13 2/3] samples: rust: add Rust serial device bus
 sample device driver
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
Date: Wed, 15 Jul 2026 17:52:50 +0000
In-Reply-To: <20260712171942.5CE161F000E9@smtp.kernel.org>
References: <20260712-rust_serdev-v13-0-2c4060bc8e30@posteo.de>
 <20260712-rust_serdev-v13-2-2c4060bc8e30@posteo.de>
 <20260712171942.5CE161F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-N0BrJNR+DVlt3yfB9c4X"
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


--=-N0BrJNR+DVlt3yfB9c4X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-07-12 at 17:19 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] The `receive` callback issues an unbounded blocking write (`serd=
ev::Timeout::Max`), which can stall the TTY receive worker indefinitely and=
 cause kernel hangs during module unload.
> - [High] The serdev abstraction's `remove_callback` fails to drop the dri=
ver's private data, leaking memory and leaving the device open, which leads=
 to a null-pointer dereference in the receive workqueue.
> - [Medium] The driver attempts to read a non-standard "baudrate" property=
 instead of the standard "current-speed" property.
> - [Medium] The driver's probe function will fail on many valid hardware p=
latforms because it rejects inexact baud rates.
> - [Low] The commit message falsely claims the driver supports device/driv=
er name matching and omits mention of ACPI support.
> --
>=20
> --- Patch [2]: [PATCH v13 2/3] samples: rust: add Rust serial device bus =
sample device driver ---
> commit 44e3438d1218c2205d779354d11c50718f82dc2f
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> samples: rust: add Rust serial device bus sample device driver
>=20
> Add a sample Rust serial device bus device driver illustrating the usage
> of the serial device bus abstractions.
>=20
> > This drivers probes through either a match of device / driver name or a
> > match within the OF ID table.
>=20
> [Severity: Low]
> This isn't a bug, but the commit message inaccurately describes the bus m=
atching
> behavior.
>=20
> serdev_device_match() exclusively checks ACPI and OF ID tables and does n=
ot
> fall back to device/driver name matching. The implemented ACPI matching i=
s also
> omitted from the description.
>=20
> Could the commit message be updated to accurately reflect the supported
> matching mechanisms?
There is a todo comment in serdev_device_match, so I will leave it for
now.

>=20
> > diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_dri=
ver_serdev.rs
> > new file mode 100644
> > index 0000000000000..824affbf65936
> > --- /dev/null
> > +++ b/samples/rust/rust_driver_serdev.rs
> [ ... ]
> > +    fn probe<'bound>(
> > +        sdev: &'bound serdev::Device<Core<'_>>,
> > +        _info: Option<&'bound Self::IdInfo>,
> > +    ) -> impl PinInit<Self, Error> + 'bound {
> > +        let dev =3D sdev.as_ref();
> > +
> > +        dev_dbg!(dev, "Probe Rust Serial device bus device driver samp=
le.\n");
> > +
> > +        if sdev
> > +            .set_baudrate(
> > +                dev.fwnode()
> > +                    .and_then(|fwnode| fwnode.property_read(c"baudrate=
").optional())
>=20
> [Severity: Medium]
> Will this fail to read the configured speed from standard device trees?
>=20
> The driver attempts to read a non-standard "baudrate" property instead of=
 the
> standard "current-speed" property. This causes a silent fallback to the 1=
15200
> default.
>=20
> Should this use the standard "current-speed" property instead?
Just an example.

>=20
> > +                    .unwrap_or(115200),
> > +            )
> > +            .is_err()
>=20
> [Severity: Medium]
> Does strictly rejecting any Err with EINVAL cause the driver to fail prob=
e when
> an inexact baud rate is achieved?
>=20
> The bindings::serdev_device_set_baudrate() function returns the actual
> configured speed. The Rust set_baudrate() abstraction returns Err(actual_=
speed)
> if the hardware cannot exactly match the requested speed due to clock div=
iders.
Just an example.

>=20
> > +        {
> > +            return Err(EINVAL);
> > +        }
> > +        sdev.set_flow_control(false);
> > +        sdev.set_parity(serdev::Parity::None)?;
> > +
> > +        Ok(Self { sdev: sdev.into() })
> > +    }
> > +
> > +    fn receive<'bound>(
> > +        sdev: &'bound serdev::Device<Bound>,
> > +        _this: Pin<&Self>,
> > +        data: &[u8],
> > +    ) -> usize {
> > +        let _ =3D sdev.write_all(data, serdev::Timeout::Max);
>=20
> [Severity: High]
> Can this unbounded blocking write stall the TTY receive worker indefinite=
ly?
>=20
> The receive() callback executes in the TTY RX workqueue. serdev::Timeout:=
:Max
> maps to a 0 timeout in serdev_device_write(), which waits indefinitely. I=
f the
> hardware TX buffer fills up due to a slow remote device or flow control, =
the
> worker thread will block forever.
>=20
> This deadlock of the TTY RX worker leads to an unkillable task and system=
 hang
> when cancel_work_sync() is called during module unload.
Might or might not be an issue, I have to look into this. But its still
an example.

>=20
> > +        data.len()
> > +    }
> > +}
>=20
> Additionally, I noticed an issue in the underlying serdev abstraction cod=
e in
> rust/kernel/serdev.rs:
>=20
> [Severity: High]
> Does Adapter::remove_callback() in rust/kernel/serdev.rs fail to drop the
> driver's private data during unbind?
>=20
> During device unbind, remove_callback() uses drvdata_borrow() instead of
> drvdata_obtain(). This fails to take ownership of the KBox<PrivateData>,
> leaking the memory.
driver.rs should take care of dropping PrivateData, which will also
drop the underlying driver data.


>=20
> Because PrivateData::drop never runs, bindings::serdev_device_close() is =
never
> called. The C driver core then resets dev->driver_data to NULL. Because t=
he
> device is still open, incoming serial data triggers receive_buf_callback(=
),
> which calls drvdata_borrow() on the now-NULL drvdata pointer, causing a p=
anic
> when locking the mutex.
See above.


--=-N0BrJNR+DVlt3yfB9c4X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpXyOkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS/xEQAL+tJ55EoR0SO1xGsR5W
3/t2+2wm0PYNi4mH+oxDGDyqflJNllcY1AlwuJp0mfGiRlnHB02Y1HRjZnQml+rO
S8acnekNd3450i1RqVAeKsoVryJuiH5EoHXmAYLn8ZSumlZ5UI4FGgxYHY9rUB5F
K+5J1E7ZBvT4ZrU6hmYo5WUyjDWB4KPnZ7USib6KIQWVqiFdbfoV/tEOgczmcJ/A
oKzNRfrJvMDzbK1E1/zDGw17krCulMZWzu4cPunRWGuWpvjsOsOxi1E5nSxHqzT3
TFNELfgE7BvX6UAbb2h8bTiLI92dauYuNJBbZJdLeMsoonUb9vYDiis9SOZraPIQ
1Ag1SyylSe0/BSNpNLL5UAvycnOvOXY5ZRjQH8lRSkRynNiwWjvEV64lzD7jorpt
+HTYxEdj7etmQS9nCaPRzqmhPF/UvB0gqESA1HtJW7ZOqclRTRAbG95/tMQQvzBA
R/n8oqWxH+hCjMjREupJ6h+zmj5RA53n/+oAQqkaMNSqcJrbR67db9Y8BmoCfDbl
WAZv5j7sCBfvHUDXHSUF92BCye/Ee6aimKXVLq8m8e1tzm66HvkrfIXHVF7kKXzC
EzfXUFcU+Fr7lRr1LlkueCISj7/dABPbe9EP3WfqpBTnd3Lu5DwsdXs2tKHnuJyA
ZnxCSvxLpDto4clYeD6BgwZ4
=fCc8
-----END PGP SIGNATURE-----

--=-N0BrJNR+DVlt3yfB9c4X--
