Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18F606D802
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=J987gDQp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DB110FBC9;
	Wed,  4 Nov 2026 12:56:25 +0000 (UTC)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCB210E75B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=WPFV
 DhDki1CZ9MBThbVi68MgMjOiFRfNBMjVL4sxVnA=; b=J987gDQpgu3JJYvLTekS
 IAQaQvz050/iGPqFKLlZjAYHb+zSppMq41f1Q69KZeNdMPsFObXAdz2oUOQAkgQD
 WugXA+/hlC0IgAr7zo8pcUYoOIPJ9UVXZ80x08FPFFifl/bIOYq196iIXRwdN5wG
 55UE5TjaNa8fNACJ+iXxTm1ROOQAqt1VKd8Bi9iyY9Zr4dzDUq33MwEA0P25ta9w
 KMsPzsKaJE4x99YK7a5GJMypYgt75p+FmvGGKYroSj4Gnta9zvdWpE8YqhTGCpSV
 n67kBqF+5JJmE2uamSHtw4u5QTqjH5JRkzN/22PvlcLAePKB+jtoBrr2waghyqCb
 SA==
Received: (qmail 728268 invoked from network); 4 Nov 2026 13:56:16 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 Nov 2026 13:56:16 +0100
X-UD-Smtp-Session: l3s3148p1@Ko+B53JfONLAwtcC
Date: Wed, 4 Nov 2026 14:56:14 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Frank.Li@oss.nxp.com
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 "open list:RENESAS R-CAR I2C DRIVERS" <linux-renesas-soc@vger.kernel.org>,
 "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linux-media@vger.kernel.org>, 
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <dri-devel@lists.freedesktop.org>, 
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linaro-mm-sig@lists.linaro.org>, 
 imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] i2c: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <ausraZs-y811IzYi@shikoro>
References: <20261103212655.1774644-1-Frank.Li@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aloAu6dyzoHKdfGs"
Content-Disposition: inline
In-Reply-To: <20261103212655.1774644-1-Frank.Li@oss.nxp.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--aloAu6dyzoHKdfGs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Tue, Nov 03, 2026 at 04:26:54PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() for consumer API.
>=20
> chan->device->dev is not always the device used for DMA mapping.  Some DMA
> engines support per-channel IOMMU mappings, so different channels may use
> different DMA devices.  dmaengine_get_dma_device() returns the correct
> device for each channel.
>=20
> This also prepares for making the DMA engine provider data structures
> private.  DMA consumers should not access DMA engine internals directly.

Thanks for this, looks useful.

> -	dma_addr =3D dma_map_single(chan->device->dev, buf, len, dir);
> -	if (dma_mapping_error(chan->device->dev, dma_addr)) {
> +	dma_addr =3D dma_map_single(dmaengine_get_dma_device(chan), buf, len, d=
ir);
> +	if (dma_mapping_error(dmaengine_get_dma_device(chan), dma_addr)) {
>  		dev_dbg(dev, "dma map failed, using PIO\n");

I think we should populate a dma_dev-variable here and reuse it instead
of calling dmaengine_get_dma_device() twice.

Happy hacking,

   Wolfram


--aloAu6dyzoHKdfGs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrrK2kACgkQFA3kzBSg
KbbJkw/+KALNP+8RejO8KJPzQd6OWD7TMRhgH2+HxmyTJ1AVqOnGYuXP3m53IiNo
C53q1AgBUCbn3daNJxDIjy1zDR1CnXZWtOX8qMtD+2RSI1/LOj1L3R2bkbtsECeW
4yichs5kH6x9H9acHy08a5ogo4WDnO34sAHpkvUFp1XFTCRbA5DNGlacr/IgwI/0
j8ZM9QpzVpivV6dXun0x+uO9vjAF6QUboYWWfmuRi7B26QGe1ySimvNZMg4hXLkU
dt8mwJw5D4D/PJtrvIqhrggeA1HZ95Dbs3I7WqW/gWtEV2wmX09SBP+C8IDmgGBv
Hur62uN8+FkPiEOySHVP0Hz8gYN8rZiJw6C9fyymbLRaGpSnuHF132zNCWmlixLs
U8IfNCO7YQ+Lpu5sFy2cMQEqG39WtL0kVbEYy2o4KTtWmJoDIzBh83xHpIm/ty2v
oAEcfLLJaK/DaAGN+B4fUUwYLBJfuz1dvIaF1FCNsnJhdxi7rCJZ4Fl9s3s4ccjy
AeiAw9Ou+7ViHnrLV1YBIak+REikYlOxK6L0enCXgojJbER6j5TTx6zdMIYiF3GN
Cvbisbho469h59MaRPwQWS4jRIGp3/02j9NrH61WfVRQfHIB8LgVj9tMhJUzuKa7
8UOeDsLDX5osLe5IsCnKoGO1ZNg4KZ5I6tjfgX1FSpu5wmrbgIs=
=Kk23
-----END PGP SIGNATURE-----

--aloAu6dyzoHKdfGs--
