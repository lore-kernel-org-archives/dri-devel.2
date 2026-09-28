Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFF8C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C6710E917;
	Mon, 28 Sep 2026 10:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LRjkTP/0";
	dkim-atps=neutral
X-Greylist: delayed 2018 seconds by postgrey-1.36 at gabe;
 Mon, 28 Sep 2026 10:16:46 UTC
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D3610E917
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=4CuU+g3OS0jSsPnDL28a19vrBRSayq8z8NOABY2I9L0=; b=LRjkTP/07ZPNpeKypa4US1wvsw
 OtyA1Aw8+Z6Rg+8XIxA4YkjoMtTXEi5Ob68KcJgImG2kaPWDOlZlwmIjq3cfuSNoUa25OLFa2712v
 2DGk39CO7BJlWYrEdG/EbA+HpOJ5AhZYFtwJXsmtMtKzvJcEO6hS22X0/gnTaAib6dPdCO3kdLIak
 RxvNM0ch90QAbVZlYhgVbwInb12fS3r+cTDjt+fBvsDhcKRX3BYoccNkDNSrcBKpN4ZR2JqoWAwVD
 apeMddSF6FckTfjJl81A/bbAZflcGJTGXgA0WkclixC1qgDVGDmD/QOk5EGS4PO8xCRWWWFEcZPoD
 VwVHK/eA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xB7vo-000KOD-39; Mon, 28 Sep 2026 11:45:57 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xB7vo-000Jep-22; Mon, 28 Sep 2026 11:45:56 +0200
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
Subject: Re: [PATCH 6/8] arm64: dts: imx: remove unnecessary #address-cells and
 #size-cells
Date: Mon, 28 Sep 2026 11:45:54 +0200
Message-ID: <2280028.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260925-cleanup_dtb_warning-v1-6-f999fafbca60@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
 <20260925-cleanup_dtb_warning-v1-6-f999fafbca60@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Am Freitag, 25. September 2026, 18:37:55 CEST schrieb Frank.Li@oss.nxp.com:
> From: Frank Li <Frank.Li@nxp.com>
>=20
> Remove unnecessary #address-cells and #size-cells to fix the dtb W=3D1 wa=
rning:
>   Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@30a20000=
/gsc@20: unnecessary #address-cells/#size-cells without "ranges", "dma-rang=
es" or child "reg" or "ranges" property
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMLX2160A

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts       | 4 ----
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi | 4 ----
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts    | 2 --
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts    | 2 --
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts    | 2 --
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts    | 2 --
>  arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts    | 2 --
>  arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts         | 2 --
>  arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts      | 2 --
>  9 files changed, 22 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/a=
rm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> index f51508952d51c..b762ad555ad9e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> @@ -312,8 +312,6 @@ &qspi {
> =20
>  	en25s64: flash@0 {
>  		compatible =3D "jedec,spi-nor";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
>  		reg =3D <0>;
>  		spi-max-frequency =3D <20000000>;
>  		spi-rx-bus-width =3D <4>;
> @@ -363,8 +361,6 @@ partition@600000 {
> =20
>  	nand: flash@1 {
>  		compatible =3D "spi-nand";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
>  		reg =3D <1>;
>  		spi-max-frequency =3D <20000000>;
>  		spi-rx-bus-width =3D <4>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi b/=
arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
> index cc6b6427ec8a6..aac0ae0ad40c7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
> @@ -41,8 +41,6 @@ &fspi {
>  	flash0: flash@0 {
>  		compatible =3D "jedec,spi-nor";
>  		reg =3D <0>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
>  		spi-max-frequency =3D <10000000>;
>  		spi-rx-bus-width =3D <1>;
>  		spi-tx-bus-width =3D <1>;
> @@ -57,8 +55,6 @@ partitions {
>  	flash1: flash@1 {
>  		compatible =3D "jedec,spi-nor";
>  		reg =3D <1>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
>  		spi-max-frequency =3D <10000000>;
>  		spi-rx-bus-width =3D <1>;
>  		spi-tx-bus-width =3D <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> index 272c2b223d167..1bb42116fc0b8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> @@ -366,8 +366,6 @@ gsc: gsc@20 {
>  		interrupts =3D <16 IRQ_TYPE_EDGE_FALLING>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> =20
>  		adc {
>  			compatible =3D "gw,gsc-adc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> index 468c7e993c52b..f53718221ad5b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> @@ -317,8 +317,6 @@ gsc: gsc@20 {
>  		interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> =20
>  		adc {
>  			compatible =3D "gw,gsc-adc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
> index 636daa3d6ca20..3eafff879e8d5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
> @@ -282,8 +282,6 @@ gsc: gsc@20 {
>  		interrupts =3D <26 IRQ_TYPE_EDGE_FALLING>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> =20
>  		adc {
>  			compatible =3D "gw,gsc-adc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
> index 99572961d9e16..fcbb40597b12c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
> @@ -335,8 +335,6 @@ gsc: gsc@20 {
>  		interrupts =3D <26 IRQ_TYPE_EDGE_FALLING>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> =20
>  		adc {
>  			compatible =3D "gw,gsc-adc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arc=
h/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> index 5aa0e2cd155ec..ecc12645d7691 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> @@ -315,8 +315,6 @@ gsc: gsc@20 {
>  		interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> =20
>  		adc {
>  			compatible =3D "gw,gsc-adc";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm=
64/boot/dts/freescale/imx8mq-nitrogen.dts
> index b91509bfc9c00..1043bf074f8e4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> @@ -287,8 +287,6 @@ &lcdif {
>  };
> =20
>  &mipi_dsi {
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
>  	status =3D "okay";
> =20
>  	ports {
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts b/arch/=
arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts
> index c6019d76b9981..f3b647267c300 100644
> --- a/arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts
> @@ -202,8 +202,6 @@ &flexspi1 {
>  	flash@0 {
>  		compatible =3D "spi-nand";
>  		reg =3D <0>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
>  		spi-max-frequency =3D <104000000>;
>  		spi-rx-bus-width =3D <4>;
>  		spi-tx-bus-width =3D <4>;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


