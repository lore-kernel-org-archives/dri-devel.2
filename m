Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F1AD3941D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B3810EE63;
	Thu,  2 Apr 2026 13:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J8AJOyWB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A271B10EE63
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 13:46:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D9693600C4;
 Thu,  2 Apr 2026 13:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4ECC19424;
 Thu,  2 Apr 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775137607;
 bh=ZEjmKDIfow7ENxk7DM4IKrLgjdy9XKybDTE/ogWtzH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J8AJOyWBZ5A7mYDE9tlOIxKrcA9BY8QKtFOhLGeVU+CTmqiwbWIAPrg0DZA4DSWyI
 ioGCHACNmkjxlC52EzZQ2piNTAhyGBBuhjHecyCvHQIyVFUQLxGmMUqclkzvUdOreM
 77y0MIKAD68/1Fdt7VEiqrTlCl9T0Etd5W0GvMK73ukVESL9Pu17ztnp5kexEKECc9
 6UOGO5b1Crd2uwQeWVgza3z8oWaTr0iMNGalGBILbOsWgwnFKaKca2RvDprWjYEDvT
 LW8JGqC4BQFt9wiZvAApVE17hYh0NyHSLJBHyj5b/0inTBUT0tMyv7ZLpvRgWeSbvu
 FWX1zgaMmR/Iw==
Date: Thu, 2 Apr 2026 15:46:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Trilok Soni <tsoni@quicinc.com>,
 linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for equality
Message-ID: <ac5y636Wt7bqPUck@monoceros>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hamqz4ifmyrgsoal"
Content-Disposition: inline
In-Reply-To: <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
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


--hamqz4ifmyrgsoal
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for equality
MIME-Version: 1.0

On Tue, Feb 03, 2026 at 03:46:32PM +0000, Matthew Maurer wrote:
> This allows device drivers to check if, for example, an auxiliary
> devices is one of its children by comparing the parent field, or
> checking if a device parameter is its own device.
>=20
> Also convert existing `.as_raw() !=3D .as_raw()` to  use this new
> implementation.
>=20
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

I don't understand the implications of this patch, but it's fine for me
to be merged via the rust tree.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>


--hamqz4ifmyrgsoal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnOc0IACgkQj4D7WH0S
/k6ASwf/fRIIL3jHKKOYTcASOtVM7fzGJ0OLkDC6JblRbcNMrKJ6RmIJDyX96eYV
Zt2RmQN+twy0K15YwYiBdSWLU6yWsyomYriZo96Rd3PpM8K6Cyg2RadXLwLFvHZE
3BjQs3rgGwoaE0rdYr3Rkje5ReKIMFZF68FLh7x9xgtFVR67uDPbMnapeTQagaVX
G4l0cekgdlXUfo1xlFkYjnVPk7xkrVAzg/dT2TjYBIq76T5O6MIY9WrzXy5ifXxD
Hbie7nG7EVpLIzwaf4d1d1Jkbxny+qEhQmdIZbYht0l+EZux8H5skWnZBeLozeNK
UzKak8KjOsTAQJLy0DJvfczUV/gupA==
=cFJW
-----END PGP SIGNATURE-----

--hamqz4ifmyrgsoal--
