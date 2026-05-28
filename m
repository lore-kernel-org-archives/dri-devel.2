Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB24CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 12:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CC710F0E5;
	Thu, 28 May 2026 12:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="la8OcLun";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FE410F0E5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:18:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1E4440A52;
 Thu, 28 May 2026 12:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101921F00A3A;
 Thu, 28 May 2026 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779970723;
 bh=NH11+mJ5bBQa4zeUL8bXacM3mVoV8R1CnRHTZPVPpQs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=la8OcLunEi/rFDWmMjDsmibajjd+8SxW1wGBQ6LeuvDpbtJzgVxhPdS7EluHg8blO
 mA/zSPvFIi1wKHO47EiavI+V1MdqRqUqolTM9a4d3bLrnngRNsAJEt0YZ2F8G/H7qU
 G0FOuomBkpOaXjMe9CEJ2d6mVyHmXgHNx4B+Ro8jHabpDLXDpOMA18afhPQCH5d5to
 ILLejknUZR6ykny7YQoJCJ0js2fnKKyb9Z2Gc78FIN7IhzgpMKvFp7rHyNqMhpyIyL
 UdB2bbcMIZTSppv/5VPjWzVR6QVWw+duyyDT62tNeBJOF3+64nkcneXvVOQJWP89Kr
 ZEjS44wvcBouA==
Date: Thu, 28 May 2026 14:18:41 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Tanmay Patil <tanmayp@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gpu: host1x: syncpt_wait micro-optimizations
Message-ID: <ahgylxp4s04sb3DL@orome>
References: <20260514103153.766343-1-tanmayp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bmct6mf4goicw7er"
Content-Disposition: inline
In-Reply-To: <20260514103153.766343-1-tanmayp@nvidia.com>
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


--bmct6mf4goicw7er
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] gpu: host1x: syncpt_wait micro-optimizations
MIME-Version: 1.0

On Thu, May 14, 2026 at 10:31:51AM +0000, Tanmay Patil wrote:
> This series reduces the latency in host1x syncpoint wait path.
>=20
> Patch 1 removes redundant MMIO reads in host1x_syncpt_wait().
> Patch 2 skips the host1x_intr_update_hw_state() call in the ISR
> when no fences remain.
>=20
> Measured syncpoint wait latency (50000 samples):
>   Average latency:   12.2 us  -> 9.4 us
>   99.99 pct latency: 62.96 us -> 36.58 us
>=20
> Tanmay Patil (2):
>   gpu: host1x: skip redundant syncpoint loads in host1x_syncpt_wait()
>   gpu: host1x: skip redundant HW state update

Both patches applied, thanks.

Thierry

--bmct6mf4goicw7er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYMqAACgkQ3SOs138+
s6Gx+hAAlMUMKg7XBweWXj+62BodkNm8kvFz8QbKkWhemaU0odj362AXOdZtcnyA
ccBkH/AduHZzArbUsk4WnGl9tDEWDeMkIb28j9iKxKpg1XVL0Okoz3YG8vI07CT0
9y1mLC6dvFwiHfY6cIkkUjByw5RaoIlArV6Myddq9cL9I5/hLTfWIFqaYstJr9Bb
7xUcTVdYNYYfavIpkoHkw/MeroJbGCOPQxzomvx0rhoj/2FH9+iZgmXRKAHHop9a
TPs9pvAur7/uVuwo9RSUfWy9mT2PmXMdFE69nGd8e5O1mWQccBaC7DMViiqFoAoz
2YLeO6ydl9kEdgsgolr032RwP80I7VSKl9hW+kvJ6P33Wo8XaHh/txBjuIXMtgS4
Y9SvBKdMbu5H5BJSumUy3yIdkV5hgz9vDFIn5A3/0FowH78dm5bt2WL1u+rIZhgG
PMKXFFmzLr4ioHYDpxDhtPS6D3Xm00dh2ZRU6/5MFPxEVGfkoBLIbqAKXh8j7TgL
JpXz7OZkatpsCFPTApo4IGOiporZn4w3sWbicBBdu0W+EI4mbyMVXPzPHrVad+yS
qKruoFnZD33E+FWAZS1IBRGXoqBJbsa3JAGfh5wjPQ687WR2RcIvNJw7N/q1Ambh
UOqvHsr4onb7YKoQsboVPJ+Q+kQnTimIksp59XiTXo42EutvTTw=
=AsN2
-----END PGP SIGNATURE-----

--bmct6mf4goicw7er--
