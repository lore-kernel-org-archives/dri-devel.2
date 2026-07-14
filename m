Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE36FC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6482110ED7D;
	Tue, 14 Jul 2026 14:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D/ZYIeaW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFD810ED81
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:16:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C986414F5;
 Tue, 14 Jul 2026 14:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83751F000E9;
 Tue, 14 Jul 2026 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784038580;
 bh=lLVrfoXMGq8pQDepO4QNRhRo81VpqIrrZ3kRASH402U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D/ZYIeaWRZWR4oAvKCnt02vHGBIjNcsyER1J6y938lEN+U3kd1U2L7WRvtfYpIkqZ
 Qk7tg+7us4IIe7oC/teKqx9equ+SFw7sbblwdlwQDQmfbKsi2qZsYb5h4bYMws5fyo
 Q7u2uNbjCjghHyFoQTFM2WQY2WPyaSEDvLF1FO3qmML8WL8lqh0wxOPK/nFRzDhzEv
 Vjn9EJWvYXAI39LvWeaVuTMVna8X6y7Dtb4qu30h7q/qZ52dydtv20r8l/ROiTwtMR
 PySGrs/+qyi8a+EC/cBoRzNjidkbBsYn+SZyMLUxm0rAQ5lJ/nN8DdP6nVX0WJaz3p
 qMsjdCYvVQnDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: imx8dxl-evk: add lcdif overlay
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260714-dxl_lcdif-v1-6-6761a8a6592b@nxp.com>
References: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
 <20260714-dxl_lcdif-v1-6-6761a8a6592b@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:16:19 +0000
Message-Id: <20260714141619.B83751F000E9@smtp.kernel.org>
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
- [High] Overwriting `fsl,pins` in `pinctrl_hog` drops required system pin =
configurations, breaking GPIO expander interrupts.
--

--- Patch [6]: [PATCH 6/6] arm64: dts: imx8dxl-evk: add lcdif overlay ---
commit 85ecae823587c53fd00cdb23710f7c3efd6f900e
Author: Frank Li <Frank.Li@nxp.com>

arm64: dts: imx8dxl-evk: add lcdif overlay

This commit adds device tree overlay support for the waiken,101wx001 LCD
panel on the imx8dxl-evk. It adds the overlay to the Makefile and
introduces the new .dtso file that disables conflicting peripherals and
reconfigures pinmuxes for LCDIF.

> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso b/arch/=
arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso
> new file mode 100644
> index 0000000000000..c0e573fb5f915
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso
[ ... ]
> +&iomuxc {
> +	pinctrl_hog: hoggrp {
> +		fsl,pins =3D <
> +			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD  0x000514a0
> +		>;
> +	};
> +};

[Severity: High]
Does this unintentionally overwrite the base device tree's fsl,pins array f=
or
pinctrl_hog?

Because device tree overlays replace array properties instead of merging
them, redefining fsl,pins in pinctrl_hog to resolve a pin conflict will drop
the other pins defined in the base tree's 4-pin array.

Specifically, this deletes the mux configurations for
IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD and
IMX8DXL_SNVS_TAMPER_OUT1_LSIO_GPIO2_IO05_IN.

Since LSIO_GPIO2_IO05 serves as the interrupt line for the pca6416_3 I2C GP=
IO
expander, will dropping this configuration break all interrupts routed thro=
ugh
the expander?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-dxl_lcdif-=
v1-0-6761a8a6592b@nxp.com?part=3D6
