Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA05606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=E/tS3je4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A108810E9EA;
	Thu, 26 Nov 2026 16:33:48 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E6210E9EA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795710820;
 bh=tLux+u6vTEYaRFgKBzK8JskAeEiQ147wYTo1MXDvPpU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=E/tS3je4dVu1YnQoDd+8uvwVrfRhXrADOujXndtmAydcAwweGtqQy+/i3B6AyRZMN
 ypg4ixz5bm0R7oR/TlQBpXbuSbmmwr5X9qRY/l2jJQHNmmbjCbXghmJE6nfdM1kdU1
 cETKd2LDploKf0iloSLIcnY2HFNEqHtMLfNbFV64rCYf6GAwYWmdVhw6HtozJ8zRnz
 s7hLvYHvgPv2/z08T9kSd+l5evx1pHpVKm5RN8Sytogu00rbtv6Pwm99r+g8iJXGCm
 ZFDKS9PtWB9DqaS7Johur3n4CUupfVbwz/bibV73/L0F+MjTwBHK/MK634JGaqh8X3
 c1JQ5vAt17K/A==
Received: from [100.64.0.214] (unknown [100.64.0.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: nicolas)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 32F1117E07B5;
 Thu, 26 Nov 2026 17:33:38 +0100 (CET)
Message-ID: <6300821339d6891983af704e2044fd1ed25285f6.camel@collabora.com>
Subject: Re: [PATCH 0/7] rust: reset: add reset control abstractions
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda	
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein	 <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Detlev Casanova
 <detlev.casanova@collabora.com>
Date: Thu, 26 Nov 2026 11:33:36 -0500
In-Reply-To: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
References: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
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
 protocol="application/pgp-signature"; boundary="=-/hUEU0543EdNAHwwISi5"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--=-/hUEU0543EdNAHwwISi5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Le jeudi 26 novembre 2026 =C3=A0 13:04 -0300, Daniel Almeida a =C3=A9crit=
=C2=A0:
> This series adds a Rust abstraction for the consumer side of the reset
> controller API. A driver can get the reset lines of its device, as an
> exclusive or a shared reset control, and assert and deassert them.
>=20
> This will be used by the upcoming rkvenc driver that my colleagues
> Detlev Casanova, Nicolas Dufresne and I are working on, to recover a
> hung core of the encoder without stopping the other one. More details on
> this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
> [0]. Samsung's Rust UFS RFC [1] also uses reset lines, through an
> abstraction that it has not posted.

I don't mind being cited, but please give a heads-up, we haven't discussed =
any
of this, so I can't really comment if its a good or bad idea. On the C side=
,
shared reset don't really work today, so I'm left wondering.

Nicolas

>=20
> The abstraction follows the regulator abstraction and the clk series
> [2], with the reset state as a type parameter.
>=20
> Patch 1 adds the C helpers that patch 2 needs.
>=20
> Patch 2 adds ExclusiveResetControl, with the Unknown, Asserted and
> Deasserted states.
>=20
> Patch 3 adds ExclusiveResetControl::get_array() and
> get_array_optional(), which get all the reset lines of a device as one
> control.
>=20
> Patch 4 adds AssertedGuard, which asserts the line of an exclusive
> control in the Unknown state and deasserts it when dropped, as a
> convenience for drivers.
>=20
> Patch 5 adds SharedResetControl, with the Unknown and Deasserted states
> only, and patch 6 adds its array getters.
>=20
> Patch 7 adds ExclusiveResetControl::devm_deassert() and
> devm_deassert_optional(), for drivers that only need their line
> deasserted while they are bound.
>=20
> reset_control_reset(), the bulk API and the shared devm getters are not
> covered, and there is no guard for a Deasserted control or for a shared
> one. Nothing in the tree uses the abstraction yet.
>=20
> Patches 1 and 2 add the two new files to the RESET CONTROLLER FRAMEWORK
> entry of MAINTAINERS. Philipp, please let me know if you would rather
> have them elsewhere.
>=20
> This is based on v7.4-rc2.
>=20
> [0]: https://www.youtube.com/watch?v=3D75E15eHY7ac
> [1]: https://lore.kernel.org/r/20260912-rufs-private-v1-1-716db733e655@sa=
msung.com
> [2]: https://lore.kernel.org/r/20261013-clk-type-state-v6-0-a5e9977b3509@=
collabora.com
>=20
> ---
> Daniel Almeida (7):
>       rust: reset: add reset control helpers
>       rust: reset: add ExclusiveResetControl
>       rust: reset: add ExclusiveResetControl::get_array() and get_array_o=
ptional()
>       rust: reset: add AssertedGuard
>       rust: reset: add SharedResetControl
>       rust: reset: add SharedResetControl::get_array() and get_array_opti=
onal()
>       rust: reset: add devm_deassert() and devm_deassert_optional()
>=20
>  MAINTAINERS                     |   2 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/reset.c            |  67 ++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/reset.rs            | 870 ++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 942 insertions(+)
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261113-b4-rust-reset-ca5deca6e036
>=20
> Best regards,
> -- =20
> Daniel Almeida <daniel.almeida@collabora.com>

--=-/hUEU0543EdNAHwwISi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawhfYAAKCRDZQZRRKWBy
9PjzAPwOqaQY632vWiu5y53v91i+GrIPS5ltUGUihhnNdUe6gQEA9cpJBFdro6ud
QtTqWPkZ0+twlFg+7dBfc0PHrfZCogs=
=sZUj
-----END PGP SIGNATURE-----

--=-/hUEU0543EdNAHwwISi5--
