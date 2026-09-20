Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E54C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 23:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA5710E2CE;
	Sun, 20 Sep 2026 23:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfsUZSuO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5661710E2CE
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:04:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 263B941A81
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB9E1F000FF;
 Sun, 20 Sep 2026 23:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789945459;
 bh=y5HMVEXBVraEnCve9zqmIAmaWWudumnmk4J3ANN6sbw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gfsUZSuOviJEaHccNBOPM0nmvMCsLRFc/mW/v6HzDMXFsodwtPtIxpKLaOGYmA4Cr
 OlSd8qwpGYm6quN557xiZFnNq5RjLcU46z8b+0CmVEjfqS8mmtsT2nnuL714D5he1p
 MpolI9FRG423DeCFfc43LtCBBc/gL39DYQ1YKKqHfHWjhqeQHMEjZ3Wahu8n6EEeld
 u8HSimE1NQzeGvBpp/YQ+kd5Pb9L7WkLYhMY7+u1eopYbwkR+ioaVxO6d8SDiwQ1zf
 nmLyXy4ilbHRDrRDWXW0aCrVrREC9sFshpRr2P/FVuso25nrACCj126nuk1bAw11ub
 HpWJNeoQ4iLCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/18] ARM: dts: ux500: Add power domains
To: "Linus Walleij" <linusw@kernel.org>
Cc: vkoul@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 robh@kernel.org, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-11-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-11-9352be6b86b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 23:04:18 +0000
Message-Id: <20260920230418.ADB9E1F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: undocumented power-domains property causes schema vali=
dation failure
--

commit 043bcab3d2585239bd006e899482166025b03c26
Author: Linus Walleij <linusw@kernel.org>

ARM: dts: ux500: Add power domains

This commit adds power domain properties to CPUs and various SoC peripherals
in the DBX500 device tree. Both CPUs are updated to share DOMAIN_VARM, which
also supplies their PMU.

> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index 11fcae1904e20..0603244dc9e83 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
[ ... ]
> @@ -154,6 +156,7 @@ sram@40020000 {
>  			reg =3D <0x40020000 0x40000>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> +			power-domains =3D <&pm_domains DOMAIN_ESRAM_12>;

[Severity: Low]
Does this cause strict schema validation to fail during dtbs_check? The
mmio-sram binding strictly prohibits undocumented properties and does not l=
ist
power-domains.

[ ... ]
> @@ -314,11 +319,13 @@ intc: interrupt-controller@a0411000 {
>  			interrupt-controller;
>  			reg =3D <0xa0411000 0x1000>,
>  			      <0xa0410100 0x100>;
> +			power-domains =3D <&pm_domains DOMAIN_VARM>;
>  		};
> =20
>  		scu@a0410000 {
>  			compatible =3D "arm,cortex-a9-scu";
>  			reg =3D <0xa0410000 0x100>;
> +			power-domains =3D <&pm_domains DOMAIN_VARM>;

[Severity: Low]
Similarly, does the addition of power-domains here trigger a warning? The
arm,scu.yaml binding prohibits undocumented properties and does not define
power-domains for arm,cortex-a9-scu.

[ ... ]
> @@ -393,7 +415,7 @@ mtu@a03c6000 {
>  			compatible =3D "st,nomadik-mtu";
>  			reg =3D <0xa03c6000 0x1000>;
>  			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> -
> +			power-domains =3D <&pm_domains DOMAIN_VAPE>;

[Severity: Low]
Will this fail dtbs_check validation? The st,nomadik-mtu binding does not
list power-domains and typically prohibits undocumented properties.

[ ... ]
> @@ -435,6 +458,7 @@ gpio0: gpio@8012e000 {
>  			gpio-bank =3D <0>;
>  			gpio-ranges =3D <&pinctrl 0 0 32>;
>  			clocks =3D <&prcc_pclk 1 9>;
> +			power-domains =3D <&pm_domains DOMAIN_VAPE>;

[Severity: Low]
Does this property need to be added to the st,nomadik-gpio.yaml schema firs=
t?
The schema has unevaluatedProperties: false and currently does not define
power-domains.

[ ... ]
> @@ -613,9 +646,11 @@ dma: dma-controller@801C0000 {
>  			memcpy-channels =3D <56 57 58 59 60>;
> =20
>  			clocks =3D <&prcmu_clk PRCMU_DMACLK>;
> +			power-domains =3D <&pm_domains DOMAIN_VAPE>;

[Severity: Low]
Could this undocumented property in stericsson,dma40.yaml cause dtbs_check
to fail? That schema uses additionalProperties: false without listing
power-domains.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-ux500-powe=
r-domains-v7-1-v3-0-9352be6b86b1@kernel.org?part=3D11
