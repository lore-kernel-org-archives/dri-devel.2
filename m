Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA2CC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1C510EED9;
	Thu, 17 Sep 2026 14:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FWimDGj3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B1A10EED9
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:14:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 983A960204;
 Thu, 17 Sep 2026 14:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97B01F000FF;
 Thu, 17 Sep 2026 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789654447;
 bh=cpwZ9carUYtl87VKALOi7gLN5i+7uaZp55JKc1ylHqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FWimDGj3Mx5W9TD/hfp/qATVSfi72A/d+7Xkxxo/Cwu+q+JfXjXa2MPgGS3hflzEb
 6iyIQ/YF36036EhgWODUTrqudd6whdOjnwlzDLuCcAau3332JNSbmZB8KefIvuON2L
 ZeAKJdCv0JVeTHWLHoe4n2cty5U5IvBrn+mtfFeITSBBWzjKUl74CRtHcs8kyt0U1e
 /0YmInYBoZe+T3sUVGM/ZNKo8U3WrSwxj0wDEgyOy2A90IOd1fIBToVPvXFqM6Y1sf
 I40iNqF0s4IjAJwjamVXHxEHWyR5eNKIZtLKpUfp/koF90ItWFR3kk/X9e3zDSpbPE
 snxWJKWCVz5hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: lcdif: Add endpoint bus-width property
To: "Francesco Dolcini" <francesco@dolcini.it>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, robh@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260917140042.118181-2-francesco@dolcini.it>
References: <20260917140042.118181-1-francesco@dolcini.it>
 <20260917140042.118181-2-francesco@dolcini.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:14:06 +0000
Message-Id: <20260917141406.E97B01F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: fsl,lcdif: endpoint constraints bypassed for unit-addr=
essed endpoints
--

commit fb72496bb41dc4492a1048af127118bf41d36a4a
Author: Francesco Dolcini <francesco.dolcini@toradex.com>

dt-bindings: lcdif: Add endpoint bus-width property

The DPI output of the LCD interface can be configured with a bus width
of 16, 18, or 24 bits. Introduce a bus-width property to the output
endpoint, specifying the number of parallel RGB bits connected.

> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/D=
ocumentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec6516..89cea0c14cf1d 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -68,9 +68,19 @@ properties:
>      maxItems: 1
> =20
>    port:
> -    $ref: /schemas/graph.yaml#/properties/port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
>      description: The LCDIF output port
> =20
> +    properties:
> +      endpoint:

[Severity: Low]
Does restricting this to the literal 'endpoint' key bypass validation for
unit-addressed endpoints?

Existing in-tree device trees, such as arch/arm64/boot/dts/freescale/imx93.=
dtsi,
define unit-addressed endpoints under the lcdif port:

		lcdif_to_ldb: endpoint@1 {
			reg =3D <1>;

Because this uses the literal 'endpoint' key rather than a pattern property
like "^endpoint(@[0-9a-f]+)?$", multi-endpoint configurations will fail
to match this rule.

This causes device tree validation to silently bypass the bus-width enum
constraints and other video-interfaces.yaml rules for those configurations.

> +        $ref: /schemas/media/video-interfaces.yaml
> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-width:
> +            enum: [ 16, 18, 24 ]
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917140042.1181=
81-1-francesco@dolcini.it?part=3D1
