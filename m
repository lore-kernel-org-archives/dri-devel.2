Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F32ECD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A0910F1FE;
	Thu, 28 May 2026 13:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="krMe+hDI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996FF10F1FE
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:55:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF6B46054B;
 Thu, 28 May 2026 13:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCDE1F000E9;
 Thu, 28 May 2026 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779976551;
 bh=6vXPVOsgWJMM4xrGhIeE6c8yPIwKd9SKDcBi/TmrvTw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=krMe+hDI0k9sbghVoiLGVOwcK9PzH2Oji+omKBOfs2qZIHWFUHWpjCFusrOE+R7Rm
 Z86V/veOCDKJy1bDb4MBcSQhKjkLJ+BZLeEAiVeCCCniEH4BrMFqIVCc1DZWKaxDtA
 UPddp6sWbpkGYXruj594LPFqROj5zUHkiAE3tGfXpWnoAmtV8ZV2d2n18+t50Rs6pi
 EJaK3+Ej7ltewTWUnyyQ/AAq2PXzEsGqm8yjTGVxfMxS/V9t1qbk/5a6cUKOpOOcyn
 4fQbsbwYK/hC7JMvKFqmnMA64/og0XQIm2ZrNX0OSIRCH0H3zOKcsbZD3/f5oouDj0
 ybEUnjlE+TmzQ==
Date: Thu, 28 May 2026 15:55:49 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Thierry Reding <treding@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: mipi: Fix device_node reference leak in
 tegra_mipi_request()
Message-ID: <ahhJVgM4pd4ecg91@orome>
References: <20260416-mipi-v1-1-9c027175abdf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pvbclnvudjorxwsj"
Content-Disposition: inline
In-Reply-To: <20260416-mipi-v1-1-9c027175abdf@gmail.com>
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


--pvbclnvudjorxwsj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] gpu: host1x: mipi: Fix device_node reference leak in
 tegra_mipi_request()
MIME-Version: 1.0

On Thu, Apr 16, 2026 at 08:09:29PM +0800, Felix Gu wrote:
> In tegra_mipi_request(), when provider.np is not equal with args.np, it
> returns without calling of_node_put(args.np), causing a reference leak.
>=20
> Convert to use the existing goto out pattern to ensure proper cleanup.
>=20
> Fixes: 767598d447aa ("gpu: host1x: mipi: Update tegra_mipi_request() to b=
e node based")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/gpu/host1x/mipi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--pvbclnvudjorxwsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYSWUACgkQ3SOs138+
s6E1pBAAvwZ+6ixhY6mxhy34Sq0OmRin0E4x4zq33ntGAeuBL3NJPSm9mI29/K+0
USC61+B/1QD9FUy+mXqZNQeyIi0i1k8oqpLbCyVqUjpJmAT/CUXK1BHwCRUR6UKZ
VUC4zumFZNh7a54zazhp/pIbn3fdJmauDypbxs2CXonrb3XomcwSuswdvCLkxEXc
0vv/0YMTVGAChnXAPChpDv0MaT3JSaGVZ559QhWZDOPMYGWCkCwV5n+pps+gWsqu
GFSyKo3itYAxz+0Zo7uoqHppxvKkX0LxewCoCH41e/kaHR5fCsJawT2VKd8vXVjS
2sYN1bZCQh5u51OqHIt8IVnCpNhvPdo9W77LKOpuLNvSArceIV3sZeKTHuvQ4UzP
fY4Fj80j/OvSuSpEDpCnfqPI189jX39BFm9aTvtdBLzVuGV4bLZQeYq542bGd2EA
dIZauDZaZL4R8Aci1ikmho5UsAjVJswlfoyjA68mzOgcU5OkrJ/ZOlZFWclF3cGO
IBqslRnCbTo7VXF8MCiloThQW2bGCj6Krc9Uc36RcJV2B6nmYEmrc1mtRQQbrR/H
vs0rBUEqLuID3oxvwIvSFp+YJlDyweWfLqowk/fELigCyM/ysu/SStirLl3e/Dye
dimS2hkKSV4/KpfII7uEHKD6x2gooknc54wp4x2V8Bwy19hd8Sw=
=nyJ1
-----END PGP SIGNATURE-----

--pvbclnvudjorxwsj--
