Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F00CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2FA10F322;
	Thu, 28 May 2026 15:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q9ocXmfN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5997110F320;
 Thu, 28 May 2026 15:06:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8023D6014B;
 Thu, 28 May 2026 15:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2811F000E9;
 Thu, 28 May 2026 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779980809;
 bh=c8uxKDeozKtw7HhpWHZre9JGy+bOINHNRMoLgA/eKYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q9ocXmfNTfoni/BH+FLS5BRReOswvnj9TI77F5FJoQ9tbi8N6PiXxVov73pQuR+zV
 Z2VNVEt3c+xDsDlT5YgyBpD0HZpGUS+w9eK+h4/K5/xrApsYRcEjL1MZXrz9fBk5Yq
 FZZK3nGAGQE6BCDUnpc352dkT6gMwXbO7opycSWfLW7cfXjVTDp4vagYpztci50YlB
 kOsl1OaNqcKYRG70JisL8un20vRx4Mh4hYic52t0ER+8Rhq9dtjZ9CffvH5V2dfMh0
 aBJwGtUxKrTErAvxEwkbU6KC36VF2okVU6EInLUERYanGkUSMGb7jbTKrH0HJqx6dc
 fANY3xEsIJrcQ==
Date: Thu, 28 May 2026 17:06:46 +0200
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
Subject: Re: [PATCH 1/4] gpu: host1x: Fix iommu_map_sgtable() return value
 check
Message-ID: <ahhZ_Enh2TAWFxDg@orome>
References: <20260421-iommu_map_sgtable-return-v1-0-fb484c07d2a1@nvidia.com>
 <20260421-iommu_map_sgtable-return-v1-1-fb484c07d2a1@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hqgt5icxz7r7yoip"
Content-Disposition: inline
In-Reply-To: <20260421-iommu_map_sgtable-return-v1-1-fb484c07d2a1@nvidia.com>
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


--hqgt5icxz7r7yoip
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] gpu: host1x: Fix iommu_map_sgtable() return value
 check
MIME-Version: 1.0

On Tue, Apr 21, 2026 at 01:02:36PM +0900, Mikko Perttunen wrote:
> Commit "iommu: return full error code from iommu_map_sg[_atomic]()"
> changed iommu_map_sgtable() to return an ssize_t and negative values
> in error cases, rather than a size_t and a zero.
>=20
> pin_job() also was incorrectly assigning to 'int', which could cause
> overflows into negative values.
>=20
> Update pin_job() to correctly check for errors from iommu_map_sgtable.
>=20
> Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_at=
omic]()")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/host1x/job.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--hqgt5icxz7r7yoip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYWgYACgkQ3SOs138+
s6GqTBAAwdxQxm9pX/VxKeekH9QcutZH2UVnE3Piqkgk4WWWPGo+OJe0eP8rYRz1
k24+EwaUd+TCg8hwLmi/ReXPiDEB5aIT1nbnCMi6a88ND9a+hnTydA27jSO4Gtip
Yahkuixea/PETVHJ1QgBx6ZZBVY227qbdDrrSFCDHkqXgquFYcEq/y1GcCPNI6v3
Q5pKK9anrZDdGSLmML3X1+djUHS1G16/H3AG3xoabDRrQkA/C1wwN7sa1eFRTdGy
CvAl1aTketmwRuw5nPn46fVBlTbsP/oVyr+KclRI8ctkMXFMq74f0fs4DyOlqdAy
AKkXXpppda3yiy1r10NAC03D7EdDKcIkO0Y98KxANFj5FQoa1FI4Tp3H5ikAh58I
hQuXi2WCoLe10G4jrJrGLstvUhgJVrP0WbCa1xGdDAe8AZfH/NUEadDFSkQ+Gl8X
7fGdUYkUrDnjTPUrvJWiOZj9fk3TQbsrGKIFeu0TJp2+rO22jocolSvSvLX1lL4t
XfYPcbsCu7xQQPNqDLTid+hoX/w7cRhPUSrQAhEM6OPtn1s+6pDRT0qkXb7hu6bn
7SyijlTJZ0l3a5XziROyiiIZ4T672pAeQmzI5i3+xBRTATutOuciF+UAcQfu4afo
CBmYMaAZDyDSCIPAvXaQ5OEE7nPap7sQdz9jNvw+w9ltQlSKfLw=
=uYsw
-----END PGP SIGNATURE-----

--hqgt5icxz7r7yoip--
