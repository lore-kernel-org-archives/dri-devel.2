Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8C2C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A77310E583;
	Mon, 13 Jul 2026 08:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h7WiO77f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C914F10E583
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:36:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E47B16004E;
 Mon, 13 Jul 2026 08:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD721F00A3A;
 Mon, 13 Jul 2026 08:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783931789;
 bh=BSRASn7vjzEfYvMU2nqOAVwpp37cmtkWgS8j8lSwzlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h7WiO77fWQa3rBnHiQJ3SrcUJ2LVRqjNLiEQUMMEkClzKqRGPbVX99LTp5BOzN1UF
 2O0SfsngXJkrPd1T+lBarC1UA2jYl8nGr26pHcQSnHSbM2OSsPb0se/Qd7C37nxPFU
 b/8LF/gzZs5FJSrifQ+UccuV0v6qEogt+hMyuX0aVQ6pLgt5RfVR/yHbxcuVjJWn+P
 A5kY/B64TcsizPrbv5uT1SLxy4aHSKTYu33d3KbmsHINWz7vQL2q5RGeuOuAbqxIyU
 2/h+CziGj/RKS6TIBYMcegnNPv6eBwXs33ecrzNq6Dsf2ICAAmfX94NzY+M5XomYh+
 ToSIqo259RuYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: sn65dsi83: Add output
 data-lanes
To: "Wojciech Dubowik" <wojciech.dubowik@mt.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20260713082622.52985-2-wojciech.dubowik@mt.com>
References: <20260713082622.52985-1-wojciech.dubowik@mt.com>
 <20260713082622.52985-2-wojciech.dubowik@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:36:28 +0000
Message-Id: <20260713083629.3DD721F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The inline `unevaluatedProperties: false` on `endpoint` blocks val=
id LVDS-specific properties inherited from `#/$defs/lvds-port`.
- [Medium] The `data-lanes` schema implicitly forces exactly 4 elements, br=
eaking valid 3-lane LVDS configurations.
- [Low] Unnecessary duplication of the `data-lanes` schema block across `po=
rt@2` and `port@3`.
- [Low] Redundant `$ref` to `uint32-array` for a standard media property.
--

--- Patch [1]: [PATCH v4 1/2] dt-bindings: display: sn65dsi83: Add output d=
ata-lanes ---
commit 15be6ea27b74f8702a5daf407df624dc92403b9d
Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

dt-bindings: display: sn65dsi83: Add output data-lanes

Add an optional output lvds data lanes property with
two allowed values. The array <1 2 3 4> for standard
layout and <4 3 2 1> for reversed lvds output lanes.
The latter informs the driver that reverse lvds config
option has to be set in config register for the respective
output channel.

> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi8=
3.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> index e69b6343a8ebb..2693c0273f9ad 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> @@ -86,10 +86,62 @@ properties:
>          description: Video port for LVDS Channel-A output (panel or brid=
ge).
>          $ref: '#/$defs/lvds-port'
> =20
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false

[Severity: High]
Will this inline unevaluatedProperties block valid LVDS-specific properties
inherited from the shared lvds-port definition?

In JSON Schema 2019-09, unevaluatedProperties only considers properties
evaluated within its immediate schema object or its direct references. This
means it might incorrectly reject properties defined in
$defs/lvds-port/properties/endpoint.

> +
> +            properties:
> +              data-lanes:

[Severity: Low]
Could this entire data-lanes property definition be defined once centrally
inside $defs/lvds-port/properties/endpoint/properties instead of duplicating
it across both port@2 and port@3?

Placing it in the shared definition might also resolve the
unevaluatedProperties conflict.

> +                $ref: /schemas/types.yaml#/definitions/uint32-array

[Severity: Low]
Is this explicit type reference necessary?

The endpoint references /schemas/media/video-interfaces.yaml#, which already
enforces the uint32-array type for data-lanes globally.

> +                description: |
> +                  Array of physical LVDS data lane indexes
> +                oneOf:
> +                  - items:
> +                      - const: 1
> +                      - const: 2
> +                      - const: 3
> +                      - const: 4

[Severity: Medium]
Does this implicitly force exactly 4 elements and reject valid 3-lane LVDS
configurations?

Providing a YAML array for items without specifying minItems implicitly sets
both minItems and maxItems to the array's length (4). Since the SN65DSI83
hardware supports 18-bpp (3-lane) configurations, device trees using
data-lanes =3D <1 2 3> might fail validation.

> +                    description: |
> +                      This is the default layout
> +                  - items:
> +                      - const: 4
> +                      - const: 3
> +                      - const: 2
> +                      - const: 1
> +                    description: |
> +                      This is the reversed layout
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713082622.5298=
5-1-wojciech.dubowik@mt.com?part=3D1
