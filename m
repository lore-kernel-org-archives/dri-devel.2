Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A926C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7BB10E02D;
	Fri, 14 Aug 2026 18:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nz/BxkPA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341FA10E02D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 18:25:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0B3C40105;
 Fri, 14 Aug 2026 18:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778FD1F000E9;
 Fri, 14 Aug 2026 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786731916;
 bh=E1M8VOdf4MxxVTVNs74J9EZwhzotWGu/9Mn61bcrb98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nz/BxkPANCEnTgwZPYn+xuH04e+SYd3LRwevu5pGaT4DGOrvT017pro+HBSns+V34
 JnrvCUoM782x5GrAWJBYhBK7XW7ERnfs5t+9ycegKu/YmDJn7eQm4nMYZZtaJMWZSs
 MTXHpG99JSOSKdXoyOKMqCzqmcE8x3WFltIZ6eFPReSV2U1qE2vpHJVYHcNeqXlP+A
 x68+a21M26zO2VMD/CCEfJuJj5JN2X4+wTAmuEOHNq2j858KV7BhSHTAJtTOaaONjF
 vse0wBhuCZEIKU8Lm4rTh0TaJMLY3NZFnudiFK196ARU2F6n3cixaGLL7yi6gDQSQW
 CVc00Cl74bY8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: visionox,vtdr6130: Add
 Retroid Pocket 6 panel
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260814-rp6-panel-v1-1-111c1aeccf0f@gmail.com>
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-1-111c1aeccf0f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:25:16 +0000
Message-Id: <20260814182516.778FD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The display driver unconditionally requests the `vdd` supply, ca=
using probe warnings and unnecessary reliance on dummy regulators when `vdd=
-supply` is omitted in the device tree.
- [Low] Relaxation of schema constraints for the original `visionox,vtdr613=
0` compatible string by dropping `vdd-supply` globally instead of using a c=
onditional block.
- [Low] The new vendor prefix `retroidpocket` is undocumented.
--

--- Patch [1]: [PATCH 1/4] dt-bindings: display: visionox,vtdr6130: Add Ret=
roid Pocket 6 panel ---
commit f69298db59942a4fe08895f95f545561dd02eb42
Author: Aaron Kling <webgeek1234@gmail.com>

dt-bindings: display: visionox,vtdr6130: Add Retroid Pocket 6 panel

The vtdr6130 is a display driver integrated circuit, a common chip used
for various panels. One such panel is used in the Retroid Pocket 6. The
RP6 panel only lists the regulators vddio and vci, so drop vdd as a
required property.

> diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtd=
r6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6=
130.yaml
> index c99f4146f1bb0..682f30dc9ee43 100644
> --- a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.y=
aml
> +++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.y=
aml
> @@ -14,7 +14,11 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: visionox,vtdr6130
> +    oneOf:
> +      - const: visionox,vtdr6130
> +      - items:
> +          - const: retroidpocket,rp6-panel
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Low]
Is the retroidpocket vendor prefix documented in the vendor-prefixes schema?
If it is not recognized, dt_binding_check will output a warning or error.

> +          - const: visionox,vtdr6130
> =20
>    reg:
>      maxItems: 1
[ ... ]
> @@ -25,13 +29,13 @@ properties:
>    vdd-supply: true
>    port: true
>    reset-gpios: true
> +  rotation: true
> =20
>  required:
>    - compatible
>    - reg
>    - vddio-supply
>    - vci-supply
> -  - vdd-supply
    ^^^^^^^^^^^^
[Severity: Low]
Does dropping vdd-supply globally allow invalid device trees for the origin=
al
visionox,vtdr6130 compatible to pass validation if they omit this property?

Could this be handled using an allOf if/then conditional block that keeps
vdd-supply required for visionox,vtdr6130 but optional for the new variant?

[Severity: Medium]
Will the driver unconditionally request the vdd supply, even when it is omi=
tted
for the retroidpocket,rp6-panel variant?

Looking at visionox_vtdr6130_probe() in panel-visionox-vtdr6130.c:

	ret =3D devm_regulator_bulk_get_const(&dsi->dev,
					    ARRAY_SIZE(visionox_vtdr6130_supplies),
					    visionox_vtdr6130_supplies,
					    &ctx->supplies);

Since visionox_vtdr6130_supplies includes vdd, might this cause the driver =
to
trigger a kernel warning during boot and unnecessarily rely on the regulator
framework dummy fallback when the supply is missing?

>    - reset-gpios
>    - port

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-rp6-panel-=
v1-0-111c1aeccf0f@gmail.com?part=3D1
