Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2079C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D2D10E2E4;
	Sat, 11 Jul 2026 06:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z/4kge4Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58EB510E2E4
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:10:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 394FA40AE5;
 Sat, 11 Jul 2026 06:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35D1F00A3A;
 Sat, 11 Jul 2026 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750211;
 bh=z4HPMfp/dbJBvNgR4Y04O1a4tKA+tPNLRETTTi0oPds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z/4kge4QcUNFgBQN7Doa2Dgzta8FqOBfpAhNAEbilIGrlKyGu7UdYpOH1N+3InI9n
 IE22HbAIhoT3xliFfRTaiwvM/o6oF1K6Kt6wBKxlUG6LtYt6ApyRQpFB383mDlzwiC
 6CeBw0v+TIDfTTbBW6UXuR3q8h5zPDwNPFmojKy/G/0dRnCPWFw3iHjOhjF+RP8xn2
 1GVrMG1TCGPGveqZzOGbmpcmqwd1fLhnIhIVS4rnVxvATD0+p12PdaF+DB/g/4xWp5
 CNCQUaX+ObUFjyPIx+TQJ2yNTbwMqjbR/dvSkXLl/6iOMTgb3mENk1XIySHcSmlQDW
 8/1NloFLI2R/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/16] dt-bindings: twl-regulator: Add bindings for
 exposing ti, twl4030-regen
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: lee@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev
In-Reply-To: <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:10:10 +0000
Message-Id: <20260711061010.AB35D1F00A3A@smtp.kernel.org>
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
- [Medium] The binding schema fails to enforce the required properties for =
the `ti,twl4030-regen` compatible string and rejects the `startup-delay-us`=
 property.
- [Low] The commit message contains misspellings and an incorrect hardware =
model number.
--

--- Patch [1]: [PATCH 01/16] dt-bindings: twl-regulator: Add bindings for e=
xposing ti,twl4030-regen ---
commit 47a2b827603c26c697c09f74aba57400724a478c
Author: Grond <grond66@riseup.net>

dt-bindings: twl-regulator: Add bindings for exposing ti,twl4030-regen

This commit adds the ti,twl4030-regen compatible string to the bindings. It
also updates the commit message to document its newly required regulator
properties.

>     +Reguired properties:
>     +For twl3040 REGEN signal:

[Severity: Low]
This isn't a bug, but should "Reguired" be "Required" and "twl3040" be
"twl4030"?

> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Document=
ation/devicetree/bindings/mfd/ti,twl.yaml
> index 9cc3e4721612e..183fc015e40ad 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -46,6 +46,7 @@ allOf:
>                  - ti,twl4030-vusb1v5
>                  - ti,twl4030-vusb1v8
>                  - ti,twl4030-vusb3v1
> +                - ti,twl4030-regen
>              ti,retain-on-reset: false
> =20
>        properties:

[Severity: Medium]
Will this schema allow validation to pass without the properties described =
in
the commit message?

Since there is no corresponding if-then block added to enforce
regulator-min-microvolt and regulator-max-microvolt, they won't be required
for ti,twl4030-regen.

Also, does this cause validation to fail when startup-delay-us is used?=20

Because startup-delay-us is not defined in the base regulator schema and
unevaluatedProperties is set to false for the regulator pattern block, any
device tree attempting to use startup-delay-us as instructed will likely be
rejected during dt_binding_check and dtbs_check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D1
