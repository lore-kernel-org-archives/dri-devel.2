Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BDFC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E193210E20A;
	Wed, 15 Jul 2026 18:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m7k/pHZE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18DE10E20A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:48:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25A2561836;
 Wed, 15 Jul 2026 18:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F91F000E9;
 Wed, 15 Jul 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784141309;
 bh=aZUp5fesUF+4hvRNUbQFNXrqlCbH4FNJFJImBwGf/uc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m7k/pHZEmgFcQBvZQQbdjgUpHcTSmjSuyegUVIXCskZPj+6IJTh9kYE5P+cmTEZCV
 UuecMLUnCThCP070edOjkHIqD0Eoc5/0gkR829sQYW3y3Kdjzc+KWFXYW1eq2UcF4a
 daP9K8F6u9C0ggwEWZsdvB3P1uL73F53hTfRtu6+FKNo+dfjXTDaNjgpAb3i1HW/1/
 5eXkttFCiGpdPWEQ0Co76mEHSbkv9Hs3EJmDIfghmyN+Gi5IGN4sZiq35tvy2jgLRp
 0YesnHEW8kWHGWuo2HZKlfnMtRwC2bwdvcjxgsOpHPzyQe9OW8+PjidMFm2PVKi5p8
 2agZoaX60L/2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] arm64: dts: imx8-ss-dma: Add lcdif support for
 i.MX8QXP and i.MX8DXL
To: Frank.Li@oss.nxp.com
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-dxl_lcdif-v2-4-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-4-da797562636e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:48:28 +0000
Message-Id: <20260715184829.6B1F91F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing required 'port' node in the adma_lcdif device tree definiti=
on.
--

--- Patch [4]: [PATCH v2 4/7] arm64: dts: imx8-ss-dma: Add lcdif support fo=
r i.MX8QXP and i.MX8DXL ---
commit 2f2508e8acf644f753c462595da01a137845e813
Author: Frank Li <Frank.Li@nxp.com>

arm64: dts: imx8-ss-dma: Add lcdif support for i.MX8QXP and i.MX8DXL

This commit adds LCD interface (lcdif) device tree support for the i.MX8QXP
and i.MX8DXL platforms.

> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/=
boot/dts/freescale/imx8-ss-dma.dtsi
> index 4de78f870c05c..87082c3fa9338 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi

[ ... ]

> @@ -149,6 +149,24 @@ lpuart3: serial@5a090000 {
>  		status =3D "disabled";
>  	};
> =20
> +	adma_lcdif: lcdif@5a180000 {
> +		compatible =3D "fsl,imx8qxp-lcdif", "fsl,imx6sx-lcdif";

[Severity: Low]
Does this adma_lcdif node need a port sub-node to be defined here?=20

The fsl,lcdif.yaml device tree binding schema explicitly requires a port no=
de
for all compatibles except fsl,imx28-lcdif. Omitting it will result in a
validation warning during make dtbs_check against any board configuration
that includes imx8-ss-dma.dtsi without adding the port node in the
board-specific file.

> +		reg =3D <0x5a180000 0x10000>;
> +		clocks =3D <&lcd_clk_lpcg IMX_LPCG_CLK_0>,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-dxl_lcdif-=
v2-0-da797562636e@nxp.com?part=3D4
