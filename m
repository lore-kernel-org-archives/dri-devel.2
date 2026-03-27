Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482E510F2842
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5BB10ECFA;
	Fri, 27 Mar 2026 15:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dY4vpwP2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9A310E275
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:18:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 46FDE4427B;
 Fri, 27 Mar 2026 15:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E37BC19423;
 Fri, 27 Mar 2026 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774624725;
 bh=BRl7w35F+Nx4nZiloKXPb0hNGeT4yNF1MUfmbXxPOgc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dY4vpwP2u/TtjeDu6zGlUMDNNOaPHd8syT1LqyNCDgF3lU0qoo3T9aNlhE+hRRE+R
 xlRrvPGlVTEZvC7lIJtEnS1xu1lfyoYnL1I7sJgMTL0d0gmpiMrTWpx+eYrMs0Z+i7
 f6SYF1kSttQ6NOsymciFHYeueoeG8Ofhm5kweJi9zfGCKdPUP8NtP2B5wbVlpYwGgS
 1Qv6j0YjR6GZIYUsjKuN/DXFJG+aiC1nP7pEIkyJ/CSXSLQC/oFBATuiQ68vQZeNBA
 mnLUSrmRsEicxDAWpcLyg+EomtMecQ75m30Y2xrqO9HlkTf1OjsYBh2eZHt2fOFrVN
 uKSGde65Gjb5Q==
Date: Fri, 27 Mar 2026 16:18:42 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: tegra: transformers: add connector node
Message-ID: <acafk7munaGrCTK3@orome>
References: <20260223065500.13357-1-clamor95@gmail.com>
 <20260223065500.13357-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v4rbe2jimz4b2bgy"
Content-Disposition: inline
In-Reply-To: <20260223065500.13357-3-clamor95@gmail.com>
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


--v4rbe2jimz4b2bgy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] ARM: tegra: transformers: add connector node
MIME-Version: 1.0

On Mon, Feb 23, 2026 at 08:55:00AM +0200, Svyatoslav Ryhel wrote:
> All ASUS Transformers have micro-HDMI connector directly available. After
> Tegra HDMI got bridge/connector support, we should use connector framework
> for proper HW description.
>=20
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS TF T30
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101 T20
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201 T30
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../boot/dts/nvidia/tegra30-asus-tf600t.dts   | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)

Two things about you commit messages that I have to fixup every time:

  1. caps after the subject prefix
  2. wrap commit message at 72 characters

Both patches applied, thanks.

Thierry

--v4rbe2jimz4b2bgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnGn9IACgkQ3SOs138+
s6H8PQ//WDF56CankhI0lPuYlTAwtTyUwqBLWoyTKzs31bOKmybw9ca7lgvdRQjL
59xuW/qbfCpXHOZAK6fZqcpRRQGgMZSP0P8izSrA40CXDNKO7S34DIxD8yfv+h8/
d6cFnzQrxu/lMadP4YZ7tsujynCu+MHlYIUg44R0bdS9o9wtyc2OvlST0R9wk4J5
jGZuKn65PUA40/nu2dM+fwCD/0HloGxhrBRaYx0Pdm6O32MwuVT5Yx7kAN7KnPKC
OjGrq4Rxe8bt4XUCjM48aPZVAeHn0sh/hWBmxC98HneYwpzOnAx3bF7CU2m7RWpZ
Nl+5ojqdg49r0opy3eQFTEES4NHlPI9M52nmOTS9KCIzJacRtmZ7pzQC/dLgykPv
eSo1d5kte1xC75zDPqZp8QrZ+MSb7kealA/r0Zudy5cXd/DEhVl7dNjgzrW4+No4
HM5TveOG23D432Gn0R7doqg1RdfiawmnRioRjzI4GmFRypt/XvfoXXo1LqfUkTil
LiKoOqsrGw27IRoXwbZTQW37PB69fP+rPA/lQYGXjhHXJG/NmtRP+HbxJtxdwOoF
21wS+ps27eEpVpoUGb93+wSdDt9tnrhOMtXVWWPfYmfhNyGviFou5y7OTI/BPblC
roQZdXXlWmDulr42xacXH78uwNtTQye1TS2s+VaE5XgdBATv9HU=
=pX+M
-----END PGP SIGNATURE-----

--v4rbe2jimz4b2bgy--
