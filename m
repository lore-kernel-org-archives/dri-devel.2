Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E05C5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8675410E36C;
	Tue, 18 Aug 2026 10:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IW+N6zqa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA78510E36C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:31:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CBD443403;
 Tue, 18 Aug 2026 10:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91A41F00AC4;
 Tue, 18 Aug 2026 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787049104;
 bh=jFkVtkhfIN2OPkHgRPQWKQH8YUG9gSxbS0ZY6l1Jjxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IW+N6zqalf5ue6MbY/NYFy5rfNOP4ny4WrTlx29LOOroKpepb8INcoAZyP3Q38uUe
 rtn5OxDscdQn2clNV0KQXDNPKkULH0e30u/zrlme71fT4czlaDFZJWx8vXzxUypAZN
 2MvslvtAX3bdkL3XyvadtfB1LvASVFihAw7Ss3E3Y/FoF5A1wVsevOSToY0L2nTNP9
 IvNkcw0H9PhrlpQx9nmhhG0RTnpBrjaEYunS7jZE3bmtevpOpDSC5P5tYyGpUZ18rE
 ZAGgqiDhxM35f2TlqfVjHlYBVWbSEXXo6x0THZrnuOtU/c0LnM/fZK+e1I11vnCY/0
 Apn/vSXlV3EEA==
Date: Tue, 18 Aug 2026 12:31:41 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: webgeek1234@gmail.com
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Mark Brown <broonie@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
Message-ID: <aoQ0gWCmTiaWXbjW@orome>
References: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
 <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4lsigaiunpjf6ftk"
Content-Disposition: inline
In-Reply-To: <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
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


--4lsigaiunpjf6ftk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
MIME-Version: 1.0

On Mon, May 25, 2026 at 01:47:45AM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> Without dma enabled pio mode is used and flash storage such as the one
> on the p3668 module times out and cannot complete any transfers. In some
> cases, these timeouts cause hangs and cbb faults.
>=20
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Applied now, thanks.

Thierry

--4lsigaiunpjf6ftk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqENIoACgkQ3SOs138+
s6GLyBAAhq36NYEJpIF+BYwEPBGirYi9UVsxxIjMKPjUMcnKL3utg6pKPVJv7ej4
8mlXE0z14O+W2VuK/g8/45CpPrZgutUo1kkR5TxxsNEVdi06I4oCOuUcP+FfO7bj
iBuzAHgSSZsbBlQ2/Dwz2mmK5cIkzy9/zOLdgxZjdir1uft+0mRkLlxsGwlmnwf8
UDpYGNeTE/agVs594aJNnnIDsh2fvS7oym9EMeMGCFXaR0UWt0Bl/rK6C+ccOqt4
1RYUw+S5YbffBAzJOn0boRkPb8+qIExRTYWExcKK442doQRhECGi+zqV2CgYtdLd
LCQJI/jSsnCT3sx/KsplfBL1vUiB6Bl2zfaVIYgJ6vT9h6u9wFlw0hXl5Rn++iYf
dYDuav/AFVVlLAGp/YBrO21PCUNBqXJwaeFz7ngKOz28Qq4QYK61i/YuS2/u4exI
BQYIyB2yeTOqUhwFzrcigBszsPNzyPd38pZYSiJMJSHgwx+lC+ii0/alVQWkmQe8
wi9hyniJoGYCZNKDdGd8dc6j5NZXXUxo/LfkK24aiYurdGC6QsmzB1Eudv6UaH7j
C7HLIH61E7F7l5xPUVR4mxTOHOl4QFSh4+YYZJudidKV9FVg/6PTUMDo1T2T0w6C
yvHzgRBlE3Rm+yahBtBPNg13buXtNLyX9Y2NCieemreuvMZcBJ0=
=52eR
-----END PGP SIGNATURE-----

--4lsigaiunpjf6ftk--
