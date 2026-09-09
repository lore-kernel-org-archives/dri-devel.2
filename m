Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E54DC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C49E10E35F;
	Wed,  9 Sep 2026 14:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qz+4vPNk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D35610E348
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 14:13:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C85C4383B;
 Wed,  9 Sep 2026 14:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA3E1F00A3A;
 Wed,  9 Sep 2026 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788963238;
 bh=wtJUwmkneS78SkeaMlMZd/Famswtp8LstdVQj8FmaDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Qz+4vPNk6Jd7iPBq0qdG/dHEByUXKsFSGOPK67yDzkFsN7zDunRS/NBgzBNYKswau
 9N29PNJqyVeXAhAk4vWBOYuVc8OMZEKJBdnuEtt3w4t7pq7JsB5nA1O3P8cwUoujXj
 QALzMVT6FUMlVms56dmB/QMBdIDTigPUo8E0tYZNvK62LYyJE6U/9V4LOYNOT/lilv
 dPf7NqtFenhHa0POd4eoJwntl/KNFfbyxLT4Yi9KInTx1koc/puQJ08Zze6rWrgyqD
 y+dQniJoCfHiVZqzymMdfPFp15xeh2LZdT9ev1wvTz1YtVEOP7riJ/ue9qaq1iOFCF
 +Il2c/U0E5waA==
Date: Wed, 9 Sep 2026 16:13:55 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, conor+dt@kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, robh@kernel.org,
 media-ci@linuxtv.org, 
 devicetree@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/12] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Message-ID: <aqFpV1HHbZSU8bqq@orome>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-3-79042cfa8de5@nvidia.com>
 <20260904110359.799131F00A3F@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="obh3mo7oaagtja7c"
Content-Disposition: inline
In-Reply-To: <20260904110359.799131F00A3F@smtp.kernel.org>
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


--obh3mo7oaagtja7c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 03/12] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
MIME-Version: 1.0

On Fri, Sep 04, 2026 at 11:03:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The `memory-region` and `memory-region-names` properties for t=
he Video Protection Region (VPR) were added to the Tegra234 NVDEC binding b=
ut omitted from the older NVDEC binding (`nvidia,tegra210-nvdec.yaml`) whic=
h covers Tegra210, Tegra186, and Tegra194. Other hardware blocks on these o=
lder chips (such as VIC and DC) already document and use `memory-region` fo=
r the VPR, indicating that the hardware shares the same capability. Failing=
 to update the related YAML files in the same family causes schema validati=
on to fail for complete device trees.
> --
>=20
> commit c5ee297bfa8219c2a7d714b86f0738c220914705
> Author: Thierry Reding <treding@nvidia.com>
>=20
> dt-bindings: gpu: host1x: Document memory-regions for NVDEC
>=20
> The video protection region is a reserved memory region that can be used
> for secure video playback. NVDEC can access this region to decode images
> into securely.
>=20
> > diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra2=
34-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra23=
4-nvdec.yaml
> > index 4eb325cfd2961..bcaaabca945dc 100644
> > --- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvde=
c.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvde=
c.yaml
> > @@ -60,6 +60,14 @@ properties:
> >        - const: dma-mem
> >        - const: write
> > =20
> > +  memory-region:
> > +    items:
> > +      - description: reference to the video protection memory region
> > +
> > +  memory-region-names:
> > +    items:
> > +      - const: protected
>=20
> [Severity: Medium]
> Should these properties also be added to the older NVDEC binding
> (nvidia,tegra210-nvdec.yaml) which covers Tegra210, Tegra186, and Tegra19=
4?
>=20
> Other hardware blocks on these older chips (such as VIC and DC) already
> document and use memory-region for the Video Protection Region, indicating
> that the hardware shares the same capability.
>=20
> If a device tree for Tegra210, Tegra186, or Tegra194 correctly specifies
> the Video Protection Region for NVDEC, will it fail schema validation
> because the properties are undocumented and additionalProperties: false
> is set in the older binding?

For the record: we'll add this to the Tegra210 NVDEC bindings in due
time. It's currently only been tested on Tegra234, hence why only that
binding is updated.

Thierry

--obh3mo7oaagtja7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqhaaMACgkQ3SOs138+
s6HOBBAAixwmzfQHyM9WXL+DZjzt8AieUmwS4BbXjWP4un7OGI6d6VIup46Telx5
OOLTbeLvY1W5KDl0RPiZajCerlDvYI5f8lQXj+9e9QjWulPRyIMNGqkdXyHvSxKs
j+9SIIjV2c1w6/gz6K9mNpsLHhcum0C8NVhFOZfn3BWQQWWmLiL95l1nYje7EqHF
hVVMm09Z3QEKupRNbOrS351U0sTUS0EY3rg6WwY0Fy6FP1lMUfsJzBC6UoRYVlA/
D8uDMQRjfaZMqxwyWMBdYSUeJfBVNPqlNzmycAcfAUMOSOmNVB391pE3Eor7dS0M
UlBVR2a6mZoaVywgJWkbnl54Jh+GGor1C6tJfvCC57I2lvFR+o6FxNxx4cYNTUML
ZmU+rOO+2WZi5UTWSHM9IHLNnhCspFabPDGNGpQhLJMrn60wuJ7vAWoSiCdyQeRM
Hi9/7Y9g2GyBvvRtcMExJyduL2bzYmv0UGZ/hGD/8hjhYIRvem5lmGtkItfAiEfK
y832lyTZ+CoLbVkyo8zILFE8OgN4mgZuNjPQCGBV+z/fxI5yT7SzBsdIQQGm6i0O
hz2075LcLqdy2Ch6Jugi8qW6sNbBARfUn/46msoKrXWly9H566ElsUTKsTORwV+9
L04vi8Z1uuYnwVIDMo83mnSbNJPiUeycaG0jdfmRCbAnrZGnUIk=
=R8wl
-----END PGP SIGNATURE-----

--obh3mo7oaagtja7c--
