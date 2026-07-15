Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446DEC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C80910E1E3;
	Wed, 15 Jul 2026 18:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CfAJvIgw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BAB10E1E3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:41:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7878B61838;
 Wed, 15 Jul 2026 18:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A2B1F000E9;
 Wed, 15 Jul 2026 18:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784140896;
 bh=x0pEQulyYR7FQvV6D3aEGp7u8u1THUnp3p3bfnB0OsY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CfAJvIgwkAsMFgFHbSAgx9iIcdIVc8sOdMhT8Fs/ykAGGZYj2ps2OXlS+y4hn/gtI
 ZolGsnvRunDGKrRMr/LVH57ZiURIoUJOzKjfMFs3Q+3JezHi3MMBEpfcF7l89Cyp7H
 gfUC/zrPyN6rSgY4CiP0D+H7NL9iVu6ZDrqMLYdW4QUiCby0b5t7MBCCVBz0lLoqVy
 cj7hyWnvs+nzhpL14HSMg7NKkyHtCaTv3pUjBUe1GeBOPf8wLm2xOFWOPnROT9PiPH
 noZQ35zFfPS+krNAY4AUlsYuAz5hxq3q77DGZ1rOY7ECfVTx1Jzw3VYMivufLvyS9B
 Nr+Yk5ylBl/Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: imx8dxl-evk: Move ACM MCLK pin to
 ACM pinctrl
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260715-dxl_lcdif-v2-6-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-6-da797562636e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:41:35 +0000
Message-Id: <20260715184135.C3A2B1F000E9@smtp.kernel.org>
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
- [Medium] Moving the MCLK pin to the `&acm` node does not prevent it from =
being unconditionally claimed, failing the stated goal of the patch.
--

--- Patch [6]: [PATCH v2 6/7] arm64: dts: imx8dxl-evk: Move ACM MCLK pin to=
 ACM pinctrl ---
commit fb6f6ae3a276dd7b713e3fe1ab6ebf914e293471
Author: Frank Li <Frank.Li@nxp.com>

arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM pinctrl

This commit moves the IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1 pin from the iomu=
xc
hog group to the ACM pinctrl state. The stated goal is to avoid uncondition=
ally
claiming the pin so that LCDIF can use it instead.

> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/b=
oot/dts/freescale/imx8dxl-evk.dts
> index 33941645641f5..3b96bab6aec80 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -347,6 +347,11 @@ sound-wm8960-3 {
>  	};
>  };
> =20
> +&acm {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_mclk>;
> +};

[Severity: Medium]
Does moving this to the &acm node actually prevent the pin from being
unconditionally claimed?

Because the &acm node (a core clock controller) lacks a status =3D "disable=
d"
property, it seems the driver core's pinctrl_bind_pins() function will still
unconditionally claim the default pinctrl state at boot. If a user enables
the LCDIF node, won't it still fail to probe with a pinctrl -EBUSY conflict?

Should these pinctrl properties be attached to the optional end-consumer of
the MCLK (like the sound card node) instead, so they are only claimed when
LCDIF is inactive?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-dxl_lcdif-=
v2-0-da797562636e@nxp.com?part=3D6
