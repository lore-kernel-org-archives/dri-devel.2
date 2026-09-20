Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6D6C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 23:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71CD810E2D0;
	Sun, 20 Sep 2026 23:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SK3DGT/a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3572F10E2D0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:05:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9AB9B601F7
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E331F000FF;
 Sun, 20 Sep 2026 23:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789945527;
 bh=hCUaowriA3hZMRn59DPhhzIYIgSKcMxauQD9+dQvkEs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SK3DGT/aVfNNXUV+/ir/glJcAxY0ja+/uo7yIo92EX+2AKUx0qFotvrspq4otovjF
 qvGLP+XZE6bA+8TPhuYHHsxKsqiGIlx406IArr41WoMZA+JnLbLlcpi2RWsk7UPyF6
 IA1BoN0bhaT9HC5Ad+Quza2oSaF9n2jWdQSy0GMIu0efZavAHjCbL9dmAqwX4UmMCH
 h+wdnDAGT+3JJImQPW6NOsi6A0bTFbPLXzRQR6UBO/7rSQl0rERZZuYHNe1TvwtU/k
 nQEAIleTC+xbkeZSdVJlphXwiXgZpSWAdjHN7hNK+5tGfMOPhfrB3B103FL0Ptba3A
 Mvcy+y9Scu1Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/18] ARM: dts: ux500: Remove DB8500 EPOD regulators
To: "Linus Walleij" <linusw@kernel.org>
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-18-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-18-9352be6b86b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 23:05:26 +0000
Message-Id: <20260920230526.D9E331F000FF@smtp.kernel.org>
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
- [Medium] soc: ux500: missing v-ape-supply causes dummy regulator warning =
or probe failure
--

commit 3a86fcf38f93ed2dd8837f7b5a7e6f474011a07f
Author: Linus Walleij <linusw@kernel.org>

ARM: dts: ux500: Remove DB8500 EPOD regulators

Delete the deprecated db8500-prcmu-regulators node and all its EPOD
regulators, including VAPE and VSMPS2. Their external consumers now use
the AB8500 or AB8505 buck regulators, so no compatibility regulators
are needed.

> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index 0603244dc9e83..efc84e018c44a 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
[ ... ]
> @@ -1122,8 +1031,6 @@ msp0: msp@80123000 {
>  			compatible =3D "stericsson,ux500-msp-i2s";
>  			reg =3D <0x80123000 0x1000>;
>  			interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -			/* TODO: delete and replace with power-domain handling */
> -			v-ape-supply =3D <&db8500_vape_reg>;
>  			power-domains =3D <&pm_domains DOMAIN_VAPE>;
> =20
>  			dmas =3D <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */

[Severity: Medium]
Will removing the v-ape-supply property cause regressions in the
ux500-msp-i2s driver?

Looking at sound/soc/ux500/ux500_msp_dai.c:ux500_msp_drv_probe(), it
unconditionally requests this regulator:

	drvdata->reg_vape =3D devm_regulator_get(&pdev->dev, "v-ape");
	if (IS_ERR(drvdata->reg_vape)) {

Will this missing supply cause the regulator framework to fall back to a
dummy regulator (emitting a warning) or return an error and break the
driver probe entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-ux500-powe=
r-domains-v7-1-v3-0-9352be6b86b1@kernel.org?part=3D18
