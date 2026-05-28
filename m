Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3533BCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5752010F32E;
	Thu, 28 May 2026 15:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q0ZC1e84";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A57A10F328;
 Thu, 28 May 2026 15:07:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2698F434CB;
 Thu, 28 May 2026 15:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABD91F00A3D;
 Thu, 28 May 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779980826;
 bh=h500BwDEUT+p3Ty+F27njgVX/ebHmMvwaBgrjJow7tM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q0ZC1e84yQQqiIr7YM9N/gNMxDmiGZfgXgeOY1/M/JJ7a3KBUohJbDPgjbRPqQUjf
 3aCIXa/2Qt0ot5ExXV1YcB12RVugO0WJ6GQJ+XICmC3F2W5OquFPnByALZHvrdkLcd
 /jvstIEpGCibe2d4e72ejEAEDENL5lq1c5meyciPpdyhXo9qzSPVOf4tZc6Uw/u989
 dQZ4P6pcdPCaYCeh0tCN6QwiigI0WCyUhQLoEW4i+SWSLx5odt2e6lrh6dfTz2osqW
 vuO+sJU7uqb0IiYBsp0NqdGmrnSXlh8blFILigUbczkPOmaHEOVpwrDkOKrN999Pho
 ZVht9o0IDT75g==
Date: Thu, 28 May 2026 17:07:03 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/4] drm/tegra: Fix iommu_map_sgtable() return value check
Message-ID: <ahhaC4bILxrnE1l3@orome>
References: <20260421-iommu_map_sgtable-return-v1-0-fb484c07d2a1@nvidia.com>
 <20260421-iommu_map_sgtable-return-v1-2-fb484c07d2a1@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="luqt5i2skuahmce6"
Content-Disposition: inline
In-Reply-To: <20260421-iommu_map_sgtable-return-v1-2-fb484c07d2a1@nvidia.com>
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


--luqt5i2skuahmce6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] drm/tegra: Fix iommu_map_sgtable() return value check
MIME-Version: 1.0

On Tue, Apr 21, 2026 at 01:02:37PM +0900, Mikko Perttunen wrote:
> Commit "iommu: return full error code from iommu_map_sg[_atomic]()"
> changed iommu_map_sgtable() to return an ssize_t and negative values
> in error cases, rather than a size_t and a zero.
>=20
> Update tegra_bo_iommu_map() to correctly check for errors from
> iommu_map_sgtable.
>=20
> Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_at=
omic]()")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/drm/tegra/gem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--luqt5i2skuahmce6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYWhcACgkQ3SOs138+
s6ElFRAAkeWsm6H131lpF3ZXxxy+dw9NzX5hV718YdAxoduSvNCiSo6TtMd/VThL
Zv87c8tYmxdXjrz3HwXLrfWRQsO56d3nFbZH2brMMV4SDixycgKAAaPMH13UH5xF
WplQjm2az0ToTLlCnqca/u8u2uDCm7U5qpuydMFwv4R6T1fXkXP1bddperSuZQCu
Q9VyNz3B3IMcb4Se41KO180poWwNk2wdRIjbmznYZjjtfWJF3fDwcz8eNtgd5Uzv
J+87GApeZu2p0gusVCJAauD57SdA1xABSNZXKAqXpe30XYIkPN1f4fuJvqcocyxd
WlCn9s2xMEcegm+gZQOQFSLiOjKF4Efn5NwS/ZF6wp5Q5mPzRCg/zPSQo5FC6TPP
R9Yinz26rb/H3DnAEpHiUs7Mo6ovjxAJH1BVlEYWPlIZxk9T1keJt8jHeey9X/NF
noHtBcQCGfPfPsdaI6VFu+fOEgB+ziW+XDZjqVZ5CDXtFJ1U/j/eGGva3g2m2aP6
MBbT2y5frc2EeIcCN2tu0Pjsl32kIkdxS9agJ8CosenTrWlhRtAZK6yiOAUxuDQk
O3miB1VVzujulsZI+cpiAMzpVRtHxuNI+dcugypcES+yqR2uUbmhyG1mZ+oFXe16
DMqdt2tLo6w3wW5MkjWXZhBQ8CvPzFYOq/htE1dAmjwS/N56gBM=
=ZyOE
-----END PGP SIGNATURE-----

--luqt5i2skuahmce6--
