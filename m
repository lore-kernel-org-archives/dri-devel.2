Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA596CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B1110E933;
	Mon, 28 Sep 2026 10:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KwLpC7ol";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8C010E92D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=olO/hKKz89FHOaCKAaEXvx3zuxFgTV/VqCrzUGnPZ58=; b=KwLpC7olA7U1aRI29Mazglzkb7
 a4K1/lsxm7GC55jLe1FYnqkJWuxGa7N3JT8J2ZNjXU+amYl0IR+zZadwhsAZA9vtdUVivYhf0JdGX
 QDK2sJA9t2qzpna+JUGDDLsrVdBuRhyS0WJwyLZmkQ3VrGIs/2hp0TRz+CMsDQcSXqhL1wuKm4EIf
 i1I5TJs/yCZ95vmR+ntlx9p6XdNqrVPuDbmJxEWLvxZ5eYSX7Xb/6Z9TJQq3Tah/IzOBJidDnKYxA
 YqD0TvUkHgiQsovy2EteiM5OAMvbEyYMFIMjUNkS5ZYmyZCW/3RjLO7//3rtIciEOeH+AWpb01GAZ
 78fNnhiQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xB7sz-000JlS-1x; Mon, 28 Sep 2026 11:43:01 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xB7sz-000BEL-0v; Mon, 28 Sep 2026 11:43:00 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Guido =?ISO-8859-1?Q?G=FAnther?= <agx@sigxcpu.org>,
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Frank.Li@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 4/8] arm64: dts: imx8mq: remove #address-cells and
 #size-cells in dsi@30a00000
Date: Mon, 28 Sep 2026 11:42:58 +0200
Message-ID: <2427808.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260925-cleanup_dtb_warning-v1-4-f999fafbca60@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
 <20260925-cleanup_dtb_warning-v1-4-f999fafbca60@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5106211.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28137/Mon Sep 28 08:24:12 2026)
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

--nextPart5106211.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Mon, 28 Sep 2026 11:42:58 +0200
Message-ID: <2427808.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260925-cleanup_dtb_warning-v1-4-f999fafbca60@nxp.com>
MIME-Version: 1.0

Am Freitag, 25. September 2026, 18:37:53 CEST schrieb Frank.Li@oss.nxp.com:
> From: Frank Li <Frank.Li@nxp.com>
>=20
> No children nodes under dsi@30a00000, so remove '#address-cells' and
> '#size-cells' to fix warning with (W=3D1):
>=20
> arch/arm64/boot/dts/freescale/imx8mq.dtsi:1247.27-1297.6: Warning (avoid_=
unnecessary_addr_size): /soc@0/bus@30800000/dsi@30a00000: unnecessary #addr=
ess-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ran=
ges" property
>   DTC [C] arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi
> index 5545b5b20ab2e..8d53df2be2280 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1247,8 +1247,6 @@ sec_jr2: jr@3000 {
>  			mipi_dsi: dsi@30a00000 {
>  				compatible =3D "fsl,imx8mq-nwl-dsi";
>  				reg =3D <0x30a00000 0x300>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
>  				clocks =3D <&clk IMX8MQ_CLK_DSI_CORE>,
>  					 <&clk IMX8MQ_CLK_DSI_AHB>,
>  					 <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/
--nextPart5106211.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEByESxqszIvkmWRwbaS+g2M0Z/iUFAmq6NqIACgkQaS+g2M0Z
/iWtAwgAw15FHfti/QRK+BceI+JbLmo2ap+ZhC7g7WR4VoJdRdbn1hpE0FnZS7b6
wrRfOlVB3IlXx2h+O70oTDLN9qOIUslWX9dZW9Pz7ng7Ypps/PvzybgXpPINblUg
lmQK+gJ241/D8QVKv5aW9ps6obTjElmlDa6FFMoG3lXr/t5m6RYrxHC1hP6s+N2p
8/8zMFTKK1vWCEaJlyTEbhxcGZKoXbwmFal4ZM6sr8ZlgfOXj7mNmKvqXZGLSytr
lYClZ6YdWvj6qI6nJgtTbp2aJg4lQ7d914y646Kwlqx9UKMOHaRM49MFLepw4Sy1
cdtbyGbU7UU9IOezebLj77RrgMw1qg==
=uz4y
-----END PGP SIGNATURE-----

--nextPart5106211.GXAFRqVoOG--



