Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379F2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37EF10F242;
	Thu, 13 Aug 2026 09:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E6ikwu29";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACEC10F242
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:39:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7B25600DA;
 Thu, 13 Aug 2026 09:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133C91F000E9;
 Thu, 13 Aug 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786613940;
 bh=A6nYTQKAuW8Ug06FtQ7eQLKH92ijsXIk+6c5ah8IXAE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E6ikwu29wzZ8gMKYtr3qcUQErGyw/wvshGuk9yTfkrurp7flbXtmK5sY1XqUmcB1s
 lTuwYb/p2GRU/uzpofrPQBqaGIrt0wdTCKNDxZLJQXyuG6yAmXRSRpVX7mnaftzm1K
 3kr/k7/G6zqipl3JOFXAHmTZNY64I1eoKk+WacIVbVHerXXqhkW9F7biv6NXelrH2c
 JEfYs8z1dpUtIx4FbqAtr1okwAujZiG0hsIGpcJYhKAI9kZZLb5mhs9MGS0UfezPEV
 0ccf4YKy9uDO1UrJgs7Jo5AylB2dvXSx+czmDEBdW1/TsmXQoozKc4d+/K705vUpCU
 GNnBWMcA2Q8cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: lcdif: Add endpoint bus-width property
To: "Francesco Dolcini" <francesco@dolcini.it>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260813092836.38367-2-francesco@dolcini.it>
References: <20260813092836.38367-1-francesco@dolcini.it>
 <20260813092836.38367-2-francesco@dolcini.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:38:59 +0000
Message-Id: <20260813093900.133C91F000E9@smtp.kernel.org>
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
- [Medium] The newly added endpoint constraints (including `bus-width`, `vi=
deo-interfaces.yaml` inclusion, and `unevaluatedProperties: false`) are app=
lied using an exact string match for `endpoint`. This silently bypasses val=
idation for indexed nodes like `endpoint@1` or `endpoint@2`, which are acti=
vely used by multi-endpoint configurations.
--

--- Patch [1]: [PATCH v4 1/4] dt-bindings: lcdif: Add endpoint bus-width pr=
operty ---
commit e694f44914c3b2ddcaf755532413ffea7e676ef7
Author: Francesco Dolcini <francesco.dolcini@toradex.com>

dt-bindings: lcdif: Add endpoint bus-width property

The DPI output of the LCD interface can be configured with a bus width
of 16, 18, or 24 bits. This introduces a bus-width property to the output
endpoint to specify the number of parallel RGB bits connected.

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

[Severity: Medium]
Will this strict property match cause a regression in validation for indexed
endpoints?

By using an exact string match for endpoint under the properties block, this
schema appears to silently bypass validation for multi-endpoint configurati=
ons
that use indexed nodes like endpoint@1 or endpoint@2.

Because these indexed nodes are matched and evaluated by the
^endpoint(@[0-9a-f]+)?$ pattern from /schemas/graph.yaml#/$defs/port-base,
they will satisfy the parent port node's unevaluatedProperties: false check.
However, any invalid properties or incorrect bus-width values inside those
indexed endpoint nodes will be ignored by this new schema block.

Should this use patternProperties with "^endpoint(@[0-9a-f]+)?$" instead of
an exact properties match to ensure all endpoints are properly validated?

> +        $ref: /schemas/media/video-interfaces.yaml
> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-width:
> +            enum: [ 16, 18, 24 ]
> +
>    display:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: phandle to display panel

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813092836.3836=
7-1-francesco@dolcini.it?part=3D1
