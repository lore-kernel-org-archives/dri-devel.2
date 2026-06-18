Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA0BCD98DE
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF6D10EC87;
	Thu, 18 Jun 2026 05:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GvjZvsAD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503D510EC87
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:14:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1B134032D
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0AA1F000E9;
 Thu, 18 Jun 2026 05:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781759691;
 bh=RoglodZMn4outYdAyCSJRFXV2SdQJ5MaOF7RpmfT594=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GvjZvsAD44HiM0MAaF1pe3unCaNdl+z9HpzHswHROeHDqk/qYghdpIuRHiQ/V4VH0
 sm059PvV4FrTyHn1UqtKe4UGQG8BFJN9oh9BHqjrsFx2oCHcIOHwRqJcM8y+uXZcIU
 PVKl2Q6HYSlUpfxlHABDSAYJfncG0jJy+DwOBYcJhXtFqZKfYnr+eojh5TjKKdPknT
 B0DXNEYYzipcSxx6Ug2n3HR0JU8WctUbIRUkWk5aaXJIm36f64iPWm/yCG2XtitPAH
 OSMemanmNJkZmjjV6fEEUzktA24T4ACWx+SJldq3zKlxxsi6g7lmZ6uc7LfRvYnJCe
 mOf+m2MFuf8HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] ARM: dts: ux500: Add power domains
To: "Linus Walleij" <linusw@kernel.org>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org,
 dmaengine@vger.kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-5-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-5-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:14:51 +0000
Message-Id: <20260618051451.6F0AA1F000E9@smtp.kernel.org>
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
- [High] The `clocks` node is incorrectly assigned to `DOMAIN_VPLL` instead=
 of `DOMAIN_VAPE` and includes an unresolved `CHECKME` comment.
- [Medium] Adding `power-domains` to nodes whose binding schemas do not all=
ow it will cause `dtbs_check` validation errors.
--

commit 57cdb12b349af07637860b10a8f8232b9e2930bc
Author: Linus Walleij <linusw@kernel.org>

ARM: dts: ux500: Add power domains

Add the actual power domains to all the SoC peripherals.

> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index d76a65da70111..a6fef302c994e 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi

[ ... ]

> @@ -334,6 +340,7 @@ L2: cache-controller {
>  			compatible =3D "arm,pl310-cache";
>  			reg =3D <0xa0412000 0x1000>;
>  			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			power-domains =3D <&pm_domains DOMAIN_VARM>;

[Severity: Medium]
Will adding power-domains here cause dtbs_check validation errors?

The l2c2x0.yaml binding schema (along with others modified in this patch li=
ke
arm/pmu.yaml, stericsson,u8500-clks.yaml, arm,twd-timer.yaml,
arm,twd-wdt.yaml, and ste,mcde.yaml) does not include power-domains in its
list of allowed properties.

Do these bindings need to be updated to document the power-domains capabili=
ty
before it can be used?

>  			cache-unified;
>  			cache-level =3D <2>;
>  		};

[ ... ]

> @@ -357,6 +365,7 @@ clocks {
>  			reg =3D <0x8012f000 0x1000>, <0x8011f000 0x1000>,
>  			    <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
>  			    <0xa03cf000 0x1000>;
> +			power-domains =3D <&pm_domains DOMAIN_VPLL>; /* CHECKME: correct doma=
in? */

[Severity: High]
Should this be DOMAIN_VAPE instead of DOMAIN_VPLL?

The PRCC registers mapped here for peripheral groups 1, 2, 3, 5, and 6 resi=
de
in the VAPE power domain alongside the peripherals they clock.

If the clock controller is assigned to DOMAIN_VPLL, the power domain framew=
ork
won't guarantee DOMAIN_VAPE is powered on when accessing these registers,
which could cause a synchronous external abort.

Also, is the CHECKME comment intended to be resolved before merging?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D5
