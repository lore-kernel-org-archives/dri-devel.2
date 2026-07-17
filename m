Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950F8C44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F357610E460;
	Fri, 17 Jul 2026 12:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.b="PTsh/p+B";
	dkim-atps=neutral
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B0310E460
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:44:34 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id E2550240027
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
 s=1984.8680eb; t=1784292271;
 bh=abPdoOUFQSBZ0mgf079GN5791uddHrYYyno9NzhDNbY=;
 h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
 MIME-Version:OpenPGP:From;
 b=PTsh/p+BnC+I8/LXTQtm/E61Fn4pD7PFyUTIolNzjlQgTlvL96AJDj6kv+5MwM/Rn
 Q2UbXMJ/SCNtHN1vzsAB8VksGzbCof9/Dl9dk676a8A3LUf987C6/RThrWMnLgSESs
 4savzAhW5CyWn0RUpqDvwtX1rtPFdD637UxLG+XWh9WDUs2mfe77f98LfhwS8lptwT
 iSRLnfcuF1SxNFHHvPsAsYM1uktTbwirPUnVRWWSIPrV4UAX2WaJl2KozGw95UPWGe
 WkhPPteWC6AFCSBwvklrPy0Q9n4V7cfY/Muu2U8G0NaCxCKXkDdZ6bn6QJ5MUpIYPI
 QO65qpHz/JKxw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4h1qNr29c7z9rxQ;
 Fri, 17 Jul 2026 14:44:28 +0200 (CEST)
Message-ID: <1eccdade507cfae491f7499de9dd456e749b32a5.camel@posteo.de>
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring	
 <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda	
 <ojeda@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Kari Argillander
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Date: Fri, 17 Jul 2026 12:44:30 +0000
In-Reply-To: <DK0UB4AMYUM9.4T90577F6VAI@kernel.org>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
 <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
 <2026071719-afflicted-eleven-1be9@gregkh>
 <DK0U1G9NCIS9.228MIUKBL4KEL@garyguo.net>
 <DK0UB4AMYUM9.4T90577F6VAI@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-VJkVDyYhqZZv1lb03UMz"
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


--=-VJkVDyYhqZZv1lb03UMz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-17 at 14:20 +0200, Danilo Krummrich wrote:
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 0ffcef1849d2..a1161dd9f37f 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -174,7 +174,8 @@ extern "C" fn probe_callback(sdev: *mut bindings::ser=
dev_device) -> kernel::ffi:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: `sdev` is =
valid for the duration of `probe_callback()`.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let sdev =3D unsafe { &*=
sdev.cast::<Device<device::CoreInternal<'_>>>() };
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let info =3D <Self as driver:=
:Adapter>::id_info(sdev.as_ref());
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `sdev` has been ma=
tched by the serial device bus via its device ID table.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let info =3D unsafe { <Self a=
s driver::Adapter>::id_info(sdev.as_ref()) };
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_result(|| {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sdev.as_ref().set_drvdata(try_pin_init!(PrivateData::<T> {
> @@ -334,7 +335,6 @@ macro_rules! module_serdev_device_driver {
> =C2=A0///
> =C2=A0/// kernel::of_device_table!(
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0 OF_TABLE,
> -///=C2=A0=C2=A0=C2=A0=C2=A0 MODULE_OF_TABLE,
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0 <MyDriver as serdev::Driver>::IdInfo,
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0 [
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (of::DeviceId::=
new(c"test,device"), ())
> @@ -343,7 +343,6 @@ macro_rules! module_serdev_device_driver {
> =C2=A0///
> =C2=A0/// kernel::acpi_device_table!(
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_TABLE,
> -///=C2=A0=C2=A0=C2=A0=C2=A0 MODULE_ACPI_TABLE,
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0 <MyDriver as serdev::Driver>::IdInfo,
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0 [
> =C2=A0///=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (acpi::DeviceId=
::new(c"LNUXBEEF"), ())
> diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_drive=
r_serdev.rs
> index a12b1412db30..51b4898cd855 100644
> --- a/samples/rust/rust_driver_serdev.rs
> +++ b/samples/rust/rust_driver_serdev.rs
> @@ -20,14 +20,12 @@ struct SampleDriver {
>=20
> =C2=A0kernel::of_device_table!(
> =C2=A0=C2=A0=C2=A0=C2=A0 OF_TABLE,
> -=C2=A0=C2=A0=C2=A0 MODULE_OF_TABLE,
> =C2=A0=C2=A0=C2=A0=C2=A0 <SampleDriver as serdev::Driver>::IdInfo,
> =C2=A0=C2=A0=C2=A0=C2=A0 [(of::DeviceId::new(c"test,rust_driver_serdev"),=
 ())]
> =C2=A0);
>=20
> =C2=A0kernel::acpi_device_table!(
> =C2=A0=C2=A0=C2=A0=C2=A0 ACPI_TABLE,
> -=C2=A0=C2=A0=C2=A0 MODULE_ACPI_TABLE,
> =C2=A0=C2=A0=C2=A0=C2=A0 <SampleDriver as serdev::Driver>::IdInfo,
> =C2=A0=C2=A0=C2=A0=C2=A0 [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
> =C2=A0);
Not sure if necessary for a conflict resolution, but

Reviewed-by: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst


--=-VJkVDyYhqZZv1lb03UMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpaI6YbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS+wUQALYoni5vQ2Czo26EJVRf
J5TBRI6jcBCZE0BY+EaF0HPtgsihN+sJGTYp7Q45jiJ2+bKXXslsRXX4DX0RutmE
KwwuGGKhsD07jqZct7GM7sSStTFXmMgErgt67oWuui/1CriwcMsIPxy4BzUf29/I
ub8J7X9X8ixHWEHm8teg7RNhHS7Ss3Oayb4l01vZMT/ySeYbXmXFaEE/lMLQkxwi
tbuvc62dLQ2DHNyy7bKGRLjbeeHbFTdeZAD7HGbL27hjBCI26k19acOmel3klzbG
dNGBz5bLxQruACDeZdhcvW57D2QE1lfwQKduDH+tNF+GJitsH5etG2d7GAoOufg4
rJIZqDbBc9qZeOJHdaru8o1OiPl0UKGU7eLbirGnldEhWFdzXAivsG6/OxLGX1em
0DEPUHv7Q8HensihCOyMqm+KHodFpDCwCbyqKWgloa3niq5j35qDEmvWMyqNRJYJ
XQ1HCxKsOpdxoBWWQ8Unltx3QROjLIu9744wZT3JiAiB6PD6UDAwJPnkAWOed3kY
K19XI+M5h8yHMK/EgFil3gG/I3OJSirrECrSUBRqbXfJqnVwuKRbLe0ptoE8EyVn
Bf11OPwoA+P6xZV7XYneuvkgiEKxeekt37nqfcXlT/x7E/urFYFNKBYKdnhT7AYW
QZOz2yhqd91xN2BJzIM55EUx
=WO7R
-----END PGP SIGNATURE-----

--=-VJkVDyYhqZZv1lb03UMz--
