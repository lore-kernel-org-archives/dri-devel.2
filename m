Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A460EC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A83A10E73E;
	Sat, 11 Jul 2026 06:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mqqFLwH8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5046410E73E
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:18:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D2044370B;
 Sat, 11 Jul 2026 06:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9293B1F000E9;
 Sat, 11 Jul 2026 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750717;
 bh=9dwp56lt+fOyVa6umsS7TouBkgrFNUMWOAoELkoOT3Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mqqFLwH8e/WlN61f6UHxaA15u6s+q3casiojLelrvmmqhuhCk7Te2JJeCnhNCPPGz
 y0GJq3/QjANXcFdEOIRpdAovVNAdq2pagWgtPsS2oUvX+LkQDKUcbrsyIcaqYTmQDg
 8cQnVT12LOSYr4GUHVcm3pDQfRbhoG1n7lVifWfhmNkJABsf6dNmKsq4KL3CHQkWGj
 c86YGtHi22JBMKjIm6UHoorYTaxLQsPQWcnyZg1fEfmkRnDKlN/Kj6ZmXLr1biFARH
 rnq4RDittLPOuPly6vaGgsan7s/cjgRQJjd2MeEyTL0faUUUSfJDT6iaFDdPsda2vF
 fl+zkGlZQ7HgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/16] arm: dts: twl4030: add twl4030-regen child
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 lee@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <ca467f11b708be8529de5e25b0863dce0d7edbb6.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <ca467f11b708be8529de5e25b0863dce0d7edbb6.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:18:36 +0000
Message-Id: <20260711061836.9293B1F000E9@smtp.kernel.org>
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
- [High] The YAML binding schema fails to allow 'startup-delay-us', causing=
 a conflict between driver probe requirements and dtbs_check validation.
- [Medium] Architectural flaw in Device Tree design: conflating a PMIC digi=
tal control signal with an external voltage regulator.
--

--- Patch [3]: [PATCH 03/16] arm: dts: twl4030: add twl4030-regen child ---
commit a39086d961abe1def74820ce0f67a5656f16f99d
Author: Grond <grond66@riseup.net>

arm: dts: twl4030: add twl4030-regen child
   =20
This is needed on some boards (for example, the Pandora), where REGEN is
used to drive external regulators.

> diff --git a/arch/arm/boot/dts/ti/omap/twl4030.dtsi b/arch/arm/boot/dts/t=
i/omap/twl4030.dtsi
> index 07b9ca942e78d..e6f80b8f0a731 100644
> --- a/arch/arm/boot/dts/ti/omap/twl4030.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/twl4030.dtsi
> @@ -112,6 +112,20 @@ vsim: regulator-vsim {
>  		regulator-max-microvolt =3D <3000000>;
>  	};
> =20
> +	regen: regulator-regen {
> +		compatible =3D "ti,twl4030-regen";
> +		/*
> +		 * Since REGEN is technically just a signal that actuates an
> +		 * external regulator, we do not know what voltage it will

[Severity: Medium]
Is there an architectural mismatch in how this external regulator is modele=
d?

The comment acknowledges that REGEN is just a control signal, but the driver
forces the PMIC's digital signal node to define the external component's
voltage parameters:

drivers/regulator/twl-regulator.c:twlreg_probe() {
        if (c->min_uV =3D=3D 0 || c->max_uV =3D=3D 0) {
                dev_err(&pdev->dev, "minimum or maximum regulator voltage z=
ero in DT\n");
                return -EINVAL;
        }
}

Would it be more aligned with Device Tree principles to model the PMIC's
REGEN pin as an enable-gpio or a voltage-less switch, and define a separate
regulator-fixed node for the external regulator that uses REGEN to enable i=
t?

> +		 * eventually have, or what it's on/off timing should be.
> +		 * Therefore, disable it here; boards that use it can override
> +		 * the status to "okay" once they have set the
> +		 * regulator-{min,max}-microvolt and startup-delay-us
> +		 * attributes.
> +		 */

[Severity: High]
Will this cause a conflict between driver probe requirements and the
dtbs_check validation?

Looking at twlreg_probe() in drivers/regulator/twl-regulator.c, the driver
explicitly requires the startup-delay-us property:

drivers/regulator/twl-regulator.c:twlreg_probe() {
        ret =3D of_property_read_u32(pdev->dev.of_node, "startup-delay-us",
                                   &info->desc.enable_time);
        if (ret) {
                dev_err(&pdev->dev, "no valid startup delay set in DT: %d\n=
", ret);
                return ret;
        }
}

However, the ti,twl.yaml binding schema introduces ti,twl4030-regen but fai=
ls
to add startup-delay-us to the allowed properties, leading to
unevaluatedProperties: false rejecting it during validation.

If board developers provide the property to satisfy the driver, they will
fail schema validation, but if they omit it to pass validation, the driver
will fail to probe at runtime. Can the schema be updated to allow this, or
is there a different expected behavior?

> +		status =3D "disabled";
> +	};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D3
