Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A332C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5A810EFE1;
	Wed, 12 Aug 2026 13:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FXmHoAge";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E9110EFE1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:39:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEAE960A85;
 Wed, 12 Aug 2026 13:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF9A1F000E9;
 Wed, 12 Aug 2026 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786541981;
 bh=3ibm8bfQyR2d8UOaedwkCOqtnngF6Dqwc3ieAXLx8Wg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FXmHoAges9gNUhhGbbq4ohLZoieZPJ9Y/s992n8mtyT3yqzr1bRy0xTQiiu/bjAhZ
 TjmZPvzPo8jm4b8IqRqJ0of13cqWN5uXUZc2/GawLvXCbzj265R0cHxeJZ34Prn5RJ
 /XsYpSK3S6LocEAJW9m1KOZ4ppkRU37WXVXdV9r5DpioQ+LdfpnMTMWodUi5P+kS3P
 B07TzFh+X3nNUQ9iWfDuRQTN6Zt/UehQnOFqU/kKmGJs4WmBRJC7ZEnzQtsRNI059C
 xdIGiAXdd0B9uJZs7n4irEtz9XtQJx5KDY7fgutR9qj5Fm6+/bI2O6OwGSKBGW7oN6
 LBIH2hnG+PA1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: lcdif: Add endpoint bus-width property
To: "Francesco Dolcini" <francesco@dolcini.it>
Cc: robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260812132954.148571-2-francesco@dolcini.it>
References: <20260812132954.148571-1-francesco@dolcini.it>
 <20260812132954.148571-2-francesco@dolcini.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:39:40 +0000
Message-Id: <20260812133941.1AF9A1F000E9@smtp.kernel.org>
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
- [Medium] The device tree schema uses exact string matching (`properties: =
endpoint`) instead of pattern matching (`patternProperties`), failing to va=
lidate indexed endpoints with unit addresses (e.g., `endpoint@0`) and silen=
tly bypassing constraints for `bus-width`.
--

--- Patch [1]: [PATCH v3 1/4] dt-bindings: lcdif: Add endpoint bus-width pr=
operty ---
commit 875819bc127ee9201c1b4dcfb35262deed8eb282
Author: Francesco Dolcini <francesco.dolcini@toradex.com>

dt-bindings: lcdif: Add endpoint bus-width property

This commit introduces a bus-width property to the output endpoint of the
LCDIF display binding. It allows configuring the DPI output with a bus
width of 16, 18, or 24 bits.

> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/D=
ocumentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec6516..1f3daf0027075 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -71,6 +71,15 @@ properties:
>      $ref: /schemas/graph.yaml#/properties/port
>      description: The LCDIF output port
> =20
> +    properties:
> +      endpoint:

[Severity: Medium]
Will this exact string match cause validation to be skipped for indexed
endpoints?

If a device tree defines an endpoint with a unit address under the port nod=
e,
such as endpoint@0 or endpoint@1, the exact match on endpoint bypasses
validation of the constraints inside this block. As a result, incorrect
bus-width values on indexed endpoints would silently pass validation.

Does this need to use patternProperties to correctly match both standard and
indexed endpoints?

> +        $ref: /schemas/media/video-interfaces.yaml
> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-width:
> +            enum: [ 16, 18, 24 ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812132954.1485=
71-1-francesco@dolcini.it?part=3D1
