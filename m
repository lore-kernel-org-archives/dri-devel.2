Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864C606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qwXQWvlx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A387B10E9F8;
	Thu, 26 Nov 2026 18:46:57 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD9010E9F8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795718810;
 bh=15MjkrZo96Wtk7+oJJeShfMhLRx962x5eFfNDruHPYs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=qwXQWvlxAorgriUDT67rJAZK2UFFeGfNH7SV/wtVTH9C1W5nS1eY2a8IhC+qx2+7h
 tShfulZB2KOamEPgntoO2BslP+gVZ8GRQz1S1/66X+7dLhaHoYWpo6MsV1YULuqqu/
 tDVqKfymS0YvCSFDMjYWJLxkyzN1wMwQv2ONzrlOVmDpwVjeCtRpkKIuotEnbrKPiK
 T21APHxSdxkqAnLAdTVEcwkxkZ9RR1oCLqQfacIVUsFPe78Z1yxiKYSK8w8SFbIqYO
 Lhs9CoAzzR4RbV7g04DTb5k2qHUlS0TUoDWpEikNoPDIlBBuy+awLnxP9cud6B/HCY
 8/dcWeU2Ncufw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: nicolas)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EA0A717E0DCD;
 Thu, 26 Nov 2026 19:46:47 +0100 (CET)
Message-ID: <6e6bc569248e4d72a83de38b8aa83c66abc831f6.camel@collabora.com>
Subject: Re: [PATCH 0/7] rust: reset: add reset control abstractions
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein	 <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>,
 Philipp Zabel <p.zabel@pengutronix.de>, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	dri-devel@lists.freedesktop.org, Detlev
 Casanova <detlev.casanova@collabora.com>
Date: Thu, 26 Nov 2026 13:46:46 -0500
In-Reply-To: <D28A86A5-8077-49BA-B366-FF29E9E75736@collabora.com>
References: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
 <6300821339d6891983af704e2044fd1ed25285f6.camel@collabora.com>
 <299B626E-DC60-4175-9D66-2DE58BA5070A@collabora.com>
 <ffb55e45af601f0afaf5071f92e123c81de22a70.camel@collabora.com>
 <D28A86A5-8077-49BA-B366-FF29E9E75736@collabora.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-SnTR6pbYW0CfO0KFqPeH"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--=-SnTR6pbYW0CfO0KFqPeH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 26 novembre 2026 =C3=A0 15:36 -0300, Daniel Almeida a =C3=A9crit=
=C2=A0:
>=20
> > On 26 Nov 2026, at 15:11, Nicolas Dufresne <nicolas.dufresne@collabora.=
com> wrote:
> >=20
> > Le jeudi 26 novembre 2026 =C3=A0 15:02 -0300, Daniel Almeida a =C3=A9cr=
it :
> > > What does not work with shared resets on the C side?
> >=20
> > Above make sense, for shared, you need a mechanism to coordinate the re=
set. A
> > bit like the comment above you made about flushing active jobs, and hol=
ding on
> > new jobs until the reset has completed. I think for multiple instance o=
f the
> > same driver its quite feasible, but when the triggering driver have no =
clue what
> > other driver it shares with, there is nothing as far as I know to help =
with this
> > coordination, and its possibly non-trivial, specially if that was not p=
art of
> > the initial design.
> >=20
> > Nicolas
>=20
>=20
> My understanding (correct me if I am wrong?) is that this coordination is
> indeed needed, but baked into the C assert/deassert API:
>=20
> Someone on a shared line has no power to assert the line
> unconditionally, all a single consumer can say is "I'd like this line to
> be asserted". The line is only asserted when all users agree (i.e.: when
> all other users also ask for a reset).
>=20
> So if driver A wants a reset, it gets its house in order, and asks for
> it. Same for all other drivers, and it goes through when the last one
> does so. This is the de-facto coordination between consumers and it is
> not something that Rust influences one way or the other.
>=20
> Sure, B is not told that A wants a reset, and A is not told by the reset
> APIs when the reset goes through, but at least no user gets its hardware
> yanked from them all of a sudden.

Which comes back to my point, if the drivers have no back-channel, the lone=
ly
driver wanting to reset will wait forever. And the interaction with runtime=
 PM
seems a bit undefined too no? My question is if this is actually usable in
practice.

>=20
> In fact, we do enforce this even harder by making sure that one cannot
> construct a SharedResetControl<Asserted>, for the reasons above.

Maybe I'm just missing concrete examples.

Nicolas

>=20
> -- Daniel

--=-SnTR6pbYW0CfO0KFqPeH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawh+lgAKCRDZQZRRKWBy
9I8pAQDBxtsGXueaBkl3fN6Srv2E9qjon97wkLGnrGJfbcFA3wEA4SYuf5FQpGbA
iUJZwtoIA620HHS9JmbtT3AaTThrIw0=
=0emc
-----END PGP SIGNATURE-----

--=-SnTR6pbYW0CfO0KFqPeH--
