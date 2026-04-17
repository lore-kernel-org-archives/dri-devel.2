Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3A8F4368D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C4910EA17;
	Fri, 17 Apr 2026 11:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZFMFYZf0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C40B10EA17
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 11:00:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E4026012A;
 Fri, 17 Apr 2026 11:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43440C19425;
 Fri, 17 Apr 2026 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776423604;
 bh=R3sQwuUL9lgxVct/Vxl6PTaKIe98221a3QegCmhibzw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZFMFYZf0W31/boqDoKkcj+d/wPaB9YwsgBj4+G0j+O9B7p793NDaf09zGTE52FnDn
 VslJMxtbKrxzCoqOc40OQeZoyJymXdjGIenSg+QT9ECh6okIX5SColMTRRN0qlJmPF
 FewtCVyy4UAbqQnWiTCaJYas+Toa1DkoWG7Dq/Z7V1cnrsPS+CFR95/8zjDNSUCnRO
 9H/FrDVyUiZMUQDbXweC7FGc81eVNKi8j7jI2Owl71+ZohAhKAi3REZZkKXOGk1PI1
 t4oO51Cd28L6ryFr+AZMYWdkTuhHAaKrQ5R9P0zwfGryavjrMA3ChW7fbeGs8n3w20
 3SaEDxLxPhn0g==
Date: Fri, 17 Apr 2026 11:59:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
Message-ID: <5a0b7de0-3bfe-4e71-9e0e-3d9396e1d9d5@sirena.org.uk>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VLmRQ1k2zFsSA7iR"
Content-Disposition: inline
In-Reply-To: <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
X-Cookie: Uh-oh!!  I'm having TOO MUCH FUN!!
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


--VLmRQ1k2zFsSA7iR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 07:55:57AM +0200, Miguel Ojeda wrote:
> On Fri, Apr 17, 2026 at 12:19=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:

> > So, in order to not motivate workarounds, starting from the next cycle,=
 the
> > drm-rust-next branch will be open for new features at all times.

> > Consequently, all patches applied to drm-rust-next after -rc6 do not ta=
rget the
> > upcoming merge window, but the next one.

> I think that for branches going into linux-next, in general, new
> material is not meant to be added until the merge window closes, e.g.
> from last -next:

>     The merge window is open, so please to not addd any v7.1 material
>     to your linux-next included branches until after the merge window clo=
ses.

> Some things do target future merge windows (e.g. Rust itself was such
> a case for a long time), so it may be fine when adding it before the
> merge window opens, but I think the idea is mostly to avoid too much
> movement during the merge window to avoid interfering with other
> maintainers finishing their trees for Linus etc.

> But not sure how flexible this is -- Cc'ing Mark.

Yes, the idea is that at the end of the merge window -next should only
have a few fixes in it since everything should've been sent to Linus.
This also applies to things being added after you've sent your pulls to
the DRM core maintainers, if something isn't going to go in during the
merge window you shouldn't be adding it to -next. =20

For the most part nobody's actually checking that other than the reports
I send to Linus highlighting which trees have the most commits in -next
so if you're not disruptive the chances are nobody will notice but you
shouldn't do it.  As Miguel says it's trying to avoid causing issues for
other people, plus the general concept of -next is that it's covering
what's currently scheduled to go into Linus' tree.

Of course, nothing stops you maintaining a branch which isn't in -next
and is open all the time and that won't have any wider impact.

--VLmRQ1k2zFsSA7iR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmniEqsACgkQJNaLcl1U
h9Cwbgf/SeM+1u2oEbqfWp7OMKk+1V/N/Jnw0XeozlmS6jRDPegqQTK+PVIMdIwy
I5FqKQsDYYj3RnGT0UJVg8xjkqNJ5HbgIFlrejwZ4IsDOMQg7Om+DV10AB0vE8RA
ydC0ijnfBRXW1hNJ5+rOXfXEuy/eWnFvM61V901tjOhUjApDfAz+Z3/oMzsGFVyd
ThJxpiqJZOILDKvvhoZ8Zv5nWazM9fkjkarbnkPAGnwPnwp8wBt+vvM1zvtD3LSL
cVWmWraKy5rFhQ3ivMR30FFHWCkLRwCj7HE0N0Bp0R3qP8qIQ0P4UK+N9VpBndRw
5i6z5dJcIco0pFhlhmVe3rb4wLxFMQ==
=BVky
-----END PGP SIGNATURE-----

--VLmRQ1k2zFsSA7iR--
