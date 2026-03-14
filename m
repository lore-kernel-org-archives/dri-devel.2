Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE80D58B1B
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C30A10E562;
	Sun, 15 Mar 2026 11:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.b="lJA8xBg7";
	dkim-atps=neutral
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1568110E4AF
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 12:08:13 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 52DAE240101
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 13:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
 t=1773490091; bh=S3UJthAAAugjlisXBsl+sY1qjPTyY1jITpkgmCyumLo=;
 h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
 MIME-Version:OpenPGP:From;
 b=lJA8xBg77DckydX647gYffMQC80ope7HX0d6hRjhuLqqeMvtw5bEWRA6uy5NmGxcG
 ACX2OYxjLX6FnkB9OqU2l+7LSmyg72ebInJX+3+3IkIFK3jTyK+1Ge4/xDz0hRoUPj
 sNr9o+6/+mjWN6FPXAJLcrC3yEV5a+uf7dTTOzDUZzLA5rCk1/AjbI9xwedz4UsSbp
 KccqxZSEmvsZ13hhQoy4BtWqGItb50iAfxxy/z/kxHMYrwrrVlyn8LHJt5YcnLXhS1
 gCRVakbxwQpG3JyMP/1KpYBfwDdHMZMGAgm12XJlP9R7mg1HhXRQG6TNc1wudkxVlj
 g2ZgpgWc4I6HQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fY0Vc391kz6tsg;
 Sat, 14 Mar 2026 13:08:08 +0100 (CET)
Message-ID: <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Kari Argillander	
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Date: Sat, 14 Mar 2026 12:08:09 +0000
In-Reply-To: <2026031422-shaded-matchbook-5078@gregkh>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
 <2026031422-shaded-matchbook-5078@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-wkFjE0NNVbaYsiwLLSt0"
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc;
 preference=encrypt
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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


--=-wkFjE0NNVbaYsiwLLSt0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-03-14 at 12:52 +0100, Greg Kroah-Hartman wrote:
> On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
> > On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
> > > > Add rust private data to `struct serdev_device`, as it is required =
by the
> > > > rust abstraction added in the following commit
> > > > (rust: add basic serial device bus abstractions).
> > >=20
> > > why is rust "special" here?  What's wrong with the existing private
> > > pointer in this structure?  Why must we add another one?
> > Because in rust, the device drvdata will be set after probe has run. In
> > serdev, once the device has been opened, it can receive data. It must
> > be opened either inside probe or before probe, because it can only be
> > configured (baudrate, flow control etc.) and data written to after it
> > has been opened. Because it can receive data before drvdata has been
> > set yet, we need to ensure it waits on data receival for the probe to
> > be finished. Otherwise this would be a null pointer dereference. To do
> > this, we need to store a `Completion` for it to wait and a `bool` in
> > case the probe exits with an error. We cannot store this data in the
> > device drvdata, because this is where the drivers drvdata goes. We also
> > cannot create a wrapper of the drivers drvdata, because
> > `Device::drvdata::<T>()` would always fail in that case. That is why we
> > need a "rust_private_data" for this abstraction to store the
> > `Completion` and `bool`.
>=20
> So why is this any different from any other bus type?  I don't see the
> "uniqueness" here that has not required this to happen for PCI or USB or
> anything else.
>=20
> What am I missing?
In Short:
In serdev, we have to handle incoming device data (serdev calls on a
function pointer we provide in advance), even in the case that the
driver hasn't completed probe yet.

>=20
> Also, all of this information MUST be in the changelog text in order for
> us to be able to accept it.  You need to say _why_ a change is needed,
> not just _what_ the change does, as you know.
Will do.

Thanks
- Markus Probst

--=-wkFjE0NNVbaYsiwLLSt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmm1T5wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSflUQAKqL5F2xWybONH+MFn+J
sxpVmDP+ubzWW/MuNzVPusCp8l044B1CFWF231mitm9i5vntajEWZjE4Ngkzim4D
cXnru1paHU48+OEvHyGZcqHpieUjthEFVwMRiD+QjBV9AyUEvUKTpHJAt2QUgRXG
emLjkDAuaTMdGUChvIwzSEnImJX5LZvneytlDlaeIBABgv6kk0wjb3/7F71nXd4H
g+Zaz5nAKB+aPQzraS+mnHmJrvlVhdJTiLUhlGyUQT3fexpFea8StZgVBtmqZMv6
C676taKQyA9xkQ/kGeQF1Snv5Osr2b9mG5n5ZgG7BSBeGfLB5NGNXWKyKVvOImJU
HCIbuEq0GTflEFEone2cw1BdWloxCZ0OtMj9GGpGSM6GJnYpHfUVQ9FFx9qU0FrW
mcnqtjFGf+0IxZfJ8NpMhetcsUA0aaX5npFKJld2oUaZdkAJ605TqLKq2CVDSYDZ
T6nvxWktGNaoyciDPoJ3PZ+JUG3mTH6uLTObIQQ8QT3gWLmjRkC5a0673IMg97pD
gzCebbQ2Eo0Q3/vVKCICKtiqiNNdWZEZyfC5G6I0IqOiYtxp0q/KIcVMAQxE9c/P
gbIyH0hOVblfCRvAIbXTxqkfDAXqhLekRgYRnWVCFIS4dHPZSzP2Amha4Nkg0OBW
qaNtTfGo3Gjpj+VAbVy7csnp
=Zdwe
-----END PGP SIGNATURE-----

--=-wkFjE0NNVbaYsiwLLSt0--
