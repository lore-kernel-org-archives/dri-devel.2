Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1BB1098786
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615FE10E942;
	Fri, 20 Mar 2026 14:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZMpCaTCc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C366810E20A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 14:04:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E2E1438F1;
 Fri, 20 Mar 2026 14:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119AAC2BCAF;
 Fri, 20 Mar 2026 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774015463;
 bh=p4oP3nyURCAzcweQTVMBiIvnJn7aASK0lOUGX1gwh2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZMpCaTCcDUGPNLeH+GDoGa+cMCxTkW2ksessdvoPR24IciQ8DCcOWd1l6O032ZG7J
 019mKluSNWDtQ5xXVjvIQxGhelTyjpuVcEKZE77xx3E7T2Gfj4A9XpBe+5W4NENsyT
 1/LJ2GI/XvBiVXLujRSTBOwi1C9d3M2dIl2NUKHLspaYooFPUIpTy3WV4eJgGnh+TD
 21HfZVGJoDbMeN+ozbrwItFPB6nxqC8lUlHt0Khj7bq4NquJ0d/mVmAson2ALNh0Ut
 PhGqbDb8QAdCeqIhtr1Ha8vsfWixdjo62dNoFN+4a1LOjh9NnyHVZtAZYQ+SP48Abj
 5UvJhME/aRzlw==
Date: Fri, 20 Mar 2026 15:04:20 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v7 05/15] gpu: host1x: convert MIPI to use operation
 function pointers
Message-ID: <ab1TTxuq3XxaWRCw@orome>
References: <20260303084239.15007-1-clamor95@gmail.com>
 <20260303084239.15007-6-clamor95@gmail.com>
 <31e56301-2764-4d3b-bc21-555227248e5f@kernel.org>
 <10139201.lOV4Wx5bFT@senjougahara>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="np3tkwdvsekjytbb"
Content-Disposition: inline
In-Reply-To: <10139201.lOV4Wx5bFT@senjougahara>
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


--np3tkwdvsekjytbb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 05/15] gpu: host1x: convert MIPI to use operation
 function pointers
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 11:20:58AM +0900, Mikko Perttunen wrote:
> On Tuesday, March 17, 2026 10:07=E2=80=AFPM Hans Verkuil wrote:
> > Hi Svyatoslav, Mikko, Thierry,
> >=20
> > On 03/03/2026 09:42, Svyatoslav Ryhel wrote:
> > > Convert existing MIPI code to use operation function pointers, a nece=
ssary
> > > step for supporting Tegra20/Tegra30 SoCs. All common MIPI configurati=
on
> > > that is SoC-independent remains in mipi.c, while all SoC-specific cod=
e is
> > > moved to tegra114-mipi.c (The naming matches the first SoC generation=
 with
> > > a dedicated calibration block). Shared structures and function calls =
are
> > > placed into tegra-mipi-cal.h.
> > >=20
> > > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # tegra20, paral=
lel
> > > camera Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> >=20
> > I would like to merge this series, but in the v5 series there was a
> > discussion about this host1x split:
> >=20
> > https://lore.kernel.org/linux-media/CAPVz0n0fkMYV-O4xWTBELd6HtKR83wrs+D=
S1wTV
> > DOXdWuAK2OA@mail.gmail.com/
> >=20
> > Mikko Acked this patch, but Thierry objected. However, I saw no further
> > updates on this, and I do agree with Svyatoslav that this patch makes
> > sense.
> >=20
> > If there are no objections, then I plan to merge series this on Monday =
for
> > v7.1.
>=20
> Please do, I believe we ended up resolving that discussion offline.

I don't think we did. I never got any replies to my original objections,
only some vague complaints about the current state of the code being a
maintainer's hell (curious that I never felt it to be that way, being
the actual maintainer of this code...).

Anyway, the damage is done, you guys get to deal with it now.

Thierry

--np3tkwdvsekjytbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9U+IACgkQ3SOs138+
s6FOgg//Z/cV/ZRKd5kqx1IYrzzGUOyufl9uQekK34/hH/jdWeymR3UNOpOYtRS3
mJujOUhekO3g52OGRo3RIf4Q5qsShd2y4NNmD+Fea0fN0nK76QN5hBopc+2oLah7
IXMbzU6w/GWSIVYWWeHpYYIYZjP6Yb8CLOBMNegbqyeln5Ui1C6b4Xnyahn44Na/
zGA1IGxDWwZTAwQZNy+nXT08LvwWbwheqKUJa35DLzL46mYEqRlj4DZiCvWg04aG
+qirQPdYTbfq/yL9pWPViVxTQGcHIygftcNSR9isSVqYJpEMv43luSIxmNYXJ/7c
yveuUieZghIhrq/KMc6eB/fpF822ANABW17b0yiT/uSHdGa+1zlwXd7V0Yy7COpo
n9bqKNCQidPIwj64uKey0FrzLoYjbWHosgxu2zJVBZepc2VwJJv0qCXXaF+b2JMg
uvkJgt4IYk0kHevCbTi+XzbU2BWGgxAqvRb1EHgFuR82LKSLSzYgj7PbF8vaMcYo
xbW5CecN4Z73kvaWzXwePx/l1NsQr1GsBMyd0+gldTeU/xjQj7I/D0QDj/QMom2K
JSWxBFSERbN+akweX9qnTyu0pqOsC791Hfs4yodq1l6uGATqW1OQ6ACZAb19L8Yu
RG8V0i5a2iOFpOo2E58hioCF1rKYI4b4Jn4esF0nnhFbSaJ81l0=
=c+mj
-----END PGP SIGNATURE-----

--np3tkwdvsekjytbb--
