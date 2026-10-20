Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89345606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6ZLrLVg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FD310F825;
	Tue, 20 Oct 2026 22:50:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8959F10F824
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:50:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8FB1260A68;
 Tue, 20 Oct 2026 22:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D545A1F000C9;
 Tue, 20 Oct 2026 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792536644;
 bh=2GOH7mXarglmENabRvw20M2lBiWKpshFtyUnlHT7A6Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g6ZLrLVgEJ3IYOE1v/68J4dKPQAIz1E9KKAwh/I8P2uMS3roNIZqTTpg/5AJCN8S0
 +MI9Yq/hEr6kWFoxmG4OV4PQBQUOrCY65yRIP01eFDCC2RybHekbix1WLUapzhbKx4
 x/RVkrsLwNXFa9VKEMgfrMCnA/nqiJXJjj4HaarKo/wRRFl2AADzaRiApWCBuji2LG
 fCeIRz/+uBRR21klBvqQECWhGF+EtirxhKSIX+kGbObh78oTok1dK+FI73ywLqjGcL
 DXD6F+ddA5Y4f+na30rzSVC3zU9FKfEAg9anqjG8DecooJSJH3uuy1f9+GBEcjz+Jg
 /4HEjvXd0e/8A==
Message-ID: <sashiko-outbox-179581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] arm64: dts: imx8-ss-dma: Add lcdif support for
 i.MX8QXP and i.MX8DXL
To: Frank.Li@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261020-dxl_lcdif-v3-4-adc944659e14@nxp.com>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-4-adc944659e14@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:50:43 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: imx8: missing adma_lcdif and lcd_clk_lpcg deletion o=
n imx8qm
--

commit 90895a7ff82b0903e1aaa5301959b704913e49e1
Author: Frank Li <Frank.Li@nxp.com>

arm64: dts: imx8-ss-dma: Add lcdif support for i.MX8QXP and i.MX8DXL

This commit adds the adma_lcdif and lcd_clk_lpcg device tree nodes to
imx8-ss-dma.dtsi for i.MX8QXP and overrides the compatible string, clock
rates, and interrupt in imx8dxl-ss-adma.dtsi for i.MX8DXL.

> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/=
boot/dts/freescale/imx8-ss-dma.dtsi
> index 4de78f870c05c..87082c3fa9338 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -149,6 +149,24 @@ lpuart3: serial@5a090000 {
>  		status =3D "disabled";
>  	};
> =20
> +	adma_lcdif: lcdif@5a180000 {
> +		compatible =3D "fsl,imx8qxp-lcdif", "fsl,imx6sx-lcdif";
> +		reg =3D <0x5a180000 0x10000>;
> +		clocks =3D <&lcd_clk_lpcg IMX_LPCG_CLK_0>,
> +			 <&lcd_clk_lpcg IMX_LPCG_CLK_4>,
> +			 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>;
> +		clock-names =3D "pix", "axi", "disp_axi";
> +		assigned-clocks =3D <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
> +				  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
> +				  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
> +		assigned-clock-parents =3D <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL=
>,
> +					 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
> +		assigned-clock-rates =3D <0>, <24000000>, <804000000>;
> +		interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains =3D <&pd IMX_SC_R_LCD_0>;
> +		status =3D "disabled";
> +	};
> +
>  	adma_pwm: pwm@5a190000 {
>  		compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
>  		reg =3D <0x5a190000 0x1000>;
> @@ -298,6 +316,17 @@ uart3_lpcg: clock-controller@5a490000 {
>  		power-domains =3D <&pd IMX_SC_R_UART_3>;
>  	};
> =20
> +	lcd_clk_lpcg: clock-controller@5a580000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5a580000 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
> +			 <&dma_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "lcd_clk_lpcg", "lcd_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_LCD_0>;
> +	};

[Severity: Medium]
Should arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi also delete
&adma_lcdif and &lcd_clk_lpcg?

arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi is included by
arch/arm64/boot/dts/freescale/imx8qm.dtsi:

	#include "imx8-ss-img.dtsi"
	#include "imx8-ss-dma.dtsi"
	#include "imx8-ss-conn.dtsi"
	...
};

#include "imx8qm-ss-img.dtsi"
#include "imx8qm-ss-dma.dtsi"

i.MX8QM does not have the adma_lcdif peripheral or the IMX_SC_R_LCD_0 and
IMX_SC_R_ELCDIF_PLL resources (which are omitted from
imx8qm_clk_scu_rsrc_table[] in drivers/clk/imx/clk-imx8qm-rsrc.c).

For the companion adma_pwm and adma_pwm_lpcg nodes,
arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi explicitly removes them
(added in commit e07c4c0a5972 ("arm64: dts: imx8: delete pwm nodes in dma
subsys for imx8qm")):

/delete-node/ &adma_pwm;
/delete-node/ &adma_pwm_lpcg;

Without deleting &adma_lcdif and &lcd_clk_lpcg in imx8qm-ss-dma.dtsi, all
i.MX8QM and i.MX8QP device trees inherit both nodes, and lcd_clk_lpcg
(clock-controller@5a580000) is enabled by default.

On i.MX8QM, does this cause U-Boot resource partition ownership warnings
and cause Linux probing of 5a580000.clock-controller to fail power domain
attachment in imx_scu_add_pm_domain() -> imx_scu_pd_xlate() (-ENOENT) and
clock lookup in imx_clk_scu_alloc_dev() -> imx_scu_of_clk_src_get()
(-ENODEV) for IMX_SC_R_LCD_0?

> +
>  	adma_pwm_lpcg: clock-controller@5a590000 {
>  		compatible =3D "fsl,imx8qxp-lpcg";
>  		reg =3D <0x5a590000 0x10000>;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-dxl_lcdif-=
v3-0-adc944659e14@nxp.com?part=3D4
