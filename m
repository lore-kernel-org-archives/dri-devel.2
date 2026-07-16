Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC34C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2ED10E1DD;
	Thu, 16 Jul 2026 18:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EOBqEywD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241BF10E1DD
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 18:27:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BDAE7418EE;
 Thu, 16 Jul 2026 18:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4B21F000E9;
 Thu, 16 Jul 2026 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784226434;
 bh=aOGfx3jN2e0VB6SUEbEV3vWjHXwPPAQYU/krkLGSw4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EOBqEywDz4quZuG6Y6jfzFTxgRWaMv3CbtoxPKwzRN4ZJP/yrLYqzoM1zI0dk0Azg
 CqfZkiG0YevCIUwvN2Hy+Z6vHG+7I529nwvwOq2oZYHhSj1T1idJq4HAuIrpvxzPGN
 IfoWr9QPDbFZhanLT+V3Rp8/n6sUAa+FuXkbTkU0VdjKZZzIBjrKdaiRUZ6aBrPttt
 ReRR3fvSpmrGaR7NMro9GV1s3Vix4hwdd0vhMO6JrAMWh+vEB3zWcpJWyrZ1OHnDdm
 KwZMqth19IQr1Fb6LY5ovrAVMpQPKCsTDscEqhi8Os3B2pvR9Dt2mBC03a1HS6sYyf
 O1Z1FqfkGH4TA==
Date: Thu, 16 Jul 2026 20:27:12 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] gpu: host1x: Fix use-after-free in
 host1x_bo_clear_cached_mappings
Message-ID: <alkidFSX2nTsQviG@orome>
References: <20260603-host1x-bocache-leak-fix-v1-1-494101dbfd30@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kzuhp2nzgyamkdap"
Content-Disposition: inline
In-Reply-To: <20260603-host1x-bocache-leak-fix-v1-1-494101dbfd30@nvidia.com>
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


--kzuhp2nzgyamkdap
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] gpu: host1x: Fix use-after-free in
 host1x_bo_clear_cached_mappings
MIME-Version: 1.0

On Wed, Jun 03, 2026 at 05:37:49PM +0900, Mikko Perttunen wrote:
> __host1x_bo_unpin() drops the last reference to the mapping and frees
> it, so we can't dereference mapping afterwards. The cache itself
> outlives the mapping, so use the cache local variable instead.
>=20
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/linux-tegra/ah6ErK6f4kVudVIA@stanley.moun=
tain/T/#u
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> This is a fix for the commit
>=20
> 	'gpu: host1x: Allow entries in BO caches to be freed'
>=20
> that has already been applied by Thierry.
> ---
>  drivers/gpu/host1x/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to drm-misc-fixes, thanks.

Thierry

--kzuhp2nzgyamkdap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpZIn8ACgkQ3SOs138+
s6Eyhg//SENKmW1oTotuZfGqg+SpbhWkuzHr4s2hnvMk4AczIg2XDiehR3WyQHh3
azsMGK8VlfY6ASIYsDNVL93MXrpNNZCzx9REBy/M5gXPLu+ilGVHO/7AavEsXJyF
qsZsz0LBKJCoNomOu8hN6w77M8dJxdM8fgkt4+8KfEL/hOhthSew56QRLBLDxXuW
VfIjzIESdsxp7ZuHycU7RDFkoFBROYGvMW11eFeKynhbgOWjkwU7dmIEhck/Jy5R
DxI4FcIMCTOL9PxmyClTzEqy81rG3hbQlP4/RHSdxKLBY/fszPG5sGx7FBN+/sxE
JgHI0d+FL5+/i4BcX/9zjpgFs9fVoL8TPX3L5KivkYsWkfupyqUko83cMURCNjxZ
ri3kCpvlGpqjfpJId+B+fKJGNnl/JkNnOOkEdK1070uBtnavADV18rlozcR+/oD8
4RSB2k++HXTkdlJD/whudv7Nt/36jy7BDLfvOzChmG05iI0XPmmp9WXUQ042dX7m
y3i6i5oSrrHIwhIENileVGMh4Y/xAtlFZrgUu4Au7HvmjS3gUNGtWjCK3yS0v4Rg
PftHtA53jTnyLTS+Yg/XJMuMOS0YUAR8YTIITWyhVeaOppvrbiUWX4RINPU3SQpM
Q4sSniHL7w2MCELinhNmUyeuk96cImZb8RdQmW8ACefVW+cDYss=
=TEkN
-----END PGP SIGNATURE-----

--kzuhp2nzgyamkdap--
