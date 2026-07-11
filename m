Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2F9C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C0A10E73B;
	Sat, 11 Jul 2026 06:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CJxUY96D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF1E10E73B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:17:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8CDB41FE5;
 Sat, 11 Jul 2026 06:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532111F000E9;
 Sat, 11 Jul 2026 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750634;
 bh=w+iE2vRexzSCBn5NIVsY1K8+GsZWdqVLVoKdMNZk5wM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CJxUY96DmjVH0a4tmqrrhKcUyypVFsYzabF+kkY8VyHzdtE360gJdMYROSiT3Q+Gu
 9tKmo2hdRmQEhic3NRoMwEArW4PpNHqp7epPFE/OHHXyht/Gs5IgaTCkaOTZ2rhncV
 lneoOv8YkQrMmKjpcYU3IZsOLdYXDFql7RSjgv9hChn4kpBq87BI4RV3ob7nWP1Lqe
 xA3+JLwS/jwk17TB2YzH5kTc5bpcpasWBDqFAQCrw/K1VwsLVa5cpUwzjDM4FKpMj3
 8jm0iLY4i4Cz7Hp9/ap3KNWE6o9YLT8o9IOlfM5DpT8HY+zMcAtfre3g5s7xQK5mrh
 tvVTN2rJ1BETA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/16] ARM: dts: omap3-pandora-common: Enable audio
 in/out (mcbsp4/2)
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: mfd@lists.linux.dev, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org
In-Reply-To: <88d0a95b354b27aff5ba548d3829ae7c31838119.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <88d0a95b354b27aff5ba548d3829ae7c31838119.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:17:13 +0000
Message-Id: <20260711061714.532111F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing Sound Card devicetree node leaves audio broken.
- [Medium] Missing Pin Multiplexing for McBSP nodes.
--

--- Patch [11]: [PATCH 11/16] ARM: dts: omap3-pandora-common: Enable audio =
in/out (mcbsp4/2) ---
commit e4ecb9f743bc9100e161520f1482dafaecae52b7
Author: Stefan Leichter <sle85276@gmx.de>

ARM: dts: omap3-pandora-common: Enable audio in/out (mcbsp4/2)

This commit enables the mcbsp2 and mcbsp4 nodes in the omap3-pandora-common
device tree to support audio.

> diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/a=
rm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> index b4acab1625212..5907b2455f75b 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> @@ -716,6 +716,7 @@ &mcbsp1 {
> =20
>  /* audio DAC */
>  &mcbsp2 {
> +	status =3D "okay";

[Severity: High]
Is the audio hardware left non-functional because the sound card devicetree
node is missing?

While this enables the McBSP nodes, the machine sound driver itself is never
instantiated because its device node (matching openpandora,omap3pandora-sou=
nd)
is missing.

[Severity: Medium]
Are the required pinctrl configurations missing for this node?

It is a standard devicetree requirement on OMAP3 to define
pinctrl-names =3D "default"; and pinctrl-0 =3D <...>; properties for enabled
peripherals so that the kernel explicitly claims and configures the pins
independent of the bootloader state.

>  };
> =20
>  /* bluetooth */
> @@ -724,6 +725,7 @@ &mcbsp3 {
> =20
>  /* to twl4030*/
>  &mcbsp4 {
> +	status =3D "okay";

[Severity: Medium]
Should this node also include pinctrl configurations to ensure the kernel
explicitly configures the pins independent of the bootloader state?

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D11
