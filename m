Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C348BCDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1713010E208;
	Thu, 25 Jun 2026 16:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+Mif8Qp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069CF10E208;
 Thu, 25 Jun 2026 16:11:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A764040776;
 Thu, 25 Jun 2026 16:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D661F000E9;
 Thu, 25 Jun 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782403866;
 bh=d3tRZC2ZgRPZq0bKjzedKVRAqXUxgIuTst8YQOxOnZE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=I+Mif8QpcJu7H88kUiq5MJGoexqeh9AFuyaHK/laUyCJZVF746ymySFQ9MzbaWWcU
 ar13kGdm7J5Q9Zpivk7MkpaS3GGsJQfPybL0IwaaOZrJgkhZ8cxALB1+M9rdycm03A
 vVsSP6HulBO6FC95X6/00lTwDPNmDxHEmD6pNxlOz7ceGbWfG1vLvI5bO37QVsQ0VQ
 CDHiTVOHjSHB5QNWWvzih1djqBDlN2jsiRGFSoQ1sKFRfefgJFrcNe2GCxz8rggeX5
 Tb4HPcfie9P1AlKYTrhWrsXd/Urv6vLNCY8W9pWJ5/i7V4fq/0nKU+jxDWEShQeKD3
 q4MLFZ9p0oInA==
Date: Thu, 25 Jun 2026 17:11:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: imagination@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: gpu: img,powervr-*: Add maintainer
 entries
Message-ID: <20260625-pope-tassel-e18a30aa2b90@spud>
References: <20260625-maintainer-updates-v1-0-35112b2f038e@imgtec.com>
 <20260625-maintainer-updates-v1-3-35112b2f038e@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N1XFFjAdkRCPOk67"
Content-Disposition: inline
In-Reply-To: <20260625-maintainer-updates-v1-3-35112b2f038e@imgtec.com>
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


--N1XFFjAdkRCPOk67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 03:03:39PM +0100, Matt Coster wrote:
> These entries already exist in MAINTAINERS, add them here so downstream
> users of the bindings also see them.

They only "already exist" because of the patch before this. The commit
message should reflect that this is a functional change in
maintainership not a correction to match a longstanding thing.
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 4 +++-
>  Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml   | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index a1f54dbae3f3..91e4ff61b394 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -8,7 +8,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Imagination Technologies PowerVR and IMG Rogue GPUs
> =20
>  maintainers:
> -  - Frank Binns <frank.binns@imgtec.com>
> +  - Matt Coster <matt.coster@imgtec.com>
> +  - Alessio Belle <alessio.belle@imgtec.com>
> +  - Luigi Santivetti <luigi.santivetti@imgtec.com>
> =20
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml b=
/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
> index f5898b04381c..3e7df7344430 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
> @@ -9,7 +9,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Imagination Technologies PowerVR SGX GPUs
> =20
>  maintainers:
> -  - Frank Binns <frank.binns@imgtec.com>
> +  - Matt Coster <matt.coster@imgtec.com>
> +  - Alessio Belle <alessio.belle@imgtec.com>
> +  - Luigi Santivetti <luigi.santivetti@imgtec.com>
> =20
>  properties:
>    compatible:
>=20
> --=20
> 2.48.1
>=20
>=20

--N1XFFjAdkRCPOk67
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj1TFgAKCRB4tDGHoIJi
0mVaAQCX9s/y81M4FMSUEWkKFJSqoDARvNYfD25NEHpzGHUTPAD/bJrJdRpoxOA1
i8mKP1T5GEcbx/79IgJ0bzn4vtQHVAY=
=GeFp
-----END PGP SIGNATURE-----

--N1XFFjAdkRCPOk67--
