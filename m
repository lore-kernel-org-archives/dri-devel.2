Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DC0C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6159510F18C;
	Wed, 23 Sep 2026 20:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DQCRztvm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AE310F18C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:17:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 593CD43E8A;
 Wed, 23 Sep 2026 20:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31861F000FF;
 Wed, 23 Sep 2026 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790194622;
 bh=eRtaiRywiqhMpU9LfGbTexUxo0FrkcHmVxIS3Wgete8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DQCRztvmQWj49f9WN7U57ZRRBYY2FWF5J6w1eTc5qxrQOgAB7443gGx8/UfHCT88W
 wd52GHuubauUirMyd6O6Gdli2V0u113s3+VINgPfTMq7BLMKzRLqc6Cx1sjzgfx8iL
 yNDSq/Mu567HfbqA9H4PRWCZqUwU9GIfpEYcSP4fCgTWtyZ7+svt8OFR0r74MVpFN4
 Q4i2xnMSicCuiEg6NZWPktuwR8cRzufKBwxDh1V7a5VB0k9P4V20imSflwwkkfBnDi
 djObuzbabUm2c9jrtCS5mGBlfCCrrgj+xcvDaAonvVauyHr52wC14eHyerSgkqR6pV
 IZO5v/i5srlZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: display: add a device tree supplied
 boot logo
To: "Max Pedraza" <maximpedraza@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260923201035.51007-3-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <20260923201035.51007-3-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:17:01 +0000
Message-Id: <20260923201701.E31861F000FF@smtp.kernel.org>
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
- [Medium] dt-bindings: embedding raw image payloads in DT violates design =
principles
- [Low] dt-bindings: logo-rotation uses non-standard string enum instead of=
 integer
--

commit 7c49827223c484baa96e766e2d19b7e319290579
Author: Max Pedraza <maximpedraza@gmail.com>

dt-bindings: display: add a device tree supplied boot logo

This commit introduces a device tree binding for providing a boot logo from
firmware, placing a "boot-logo-clut224" node under /chosen. It defines
properties for dimensions, color lookup table, image data, positioning, and
rotation.

> diff --git a/Documentation/devicetree/bindings/display/boot-logo-clut224.=
yaml b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
> new file mode 100644
> index 0000000000000..9dc34717639e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
> @@ -0,0 +1,135 @@
[ ... ]
> +  clut:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description:
> +      Colour lookup table, as consecutive red, green and blue bytes per =
entry.
> +      The number of entries is derived from the property length and must=
 not
> +      exceed 224.
> +    minItems: 3
> +    maxItems: 672
> +
> +  data:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description:
> +      One byte per pixel, left to right and top to bottom, each byte bei=
ng an
> +      index into the colour lookup table. The property length must be eq=
ual to
> +      width multiplied by height.

[Severity: Medium]
Does this code introduce a regression by allowing large binary payloads to =
be
embedded directly in the device tree?

The Device Tree is intended for hardware description and minimal configurat=
ion,
not for delivering large binary files. Embedding an uncompressed image dire=
ctly
via the 'data' property can permanently waste un-reclaimable kernel memory,=
 as
the unflattened DT remains in memory indefinitely. It also risks exceeding
bootloader DTB size limits.

While follow-up work might provide a 'memory-region' alternative, the schema
still explicitly permits and supports embedding the binary payload directly=
 via
this property.

[ ... ]
> +  logo-offset:
> +    $ref: /schemas/types.yaml#/definitions/int32-array
> +    description:
> +      X and Y displacement, in screen pixels, applied after the logo has=
 been
> +      placed.
> +      Mostly useful together with a centred axis, to land the logo somew=
here
> +      other than the middle of a panel whose usable area is not its cent=
re.
> +    items:
> +      - description: X displacement
> +        minimum: -65535
> +        maximum: 65535
> +      - description: Y displacement
> +        minimum: -65535
> +        maximum: 65535
> +
> +  logo-rotation:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Rotation applied to the logo before it is drawn. It turns the logo=
 and
> +      not the screen, so a quarter turn swaps how much room the logo tak=
es
> +      up, but logo-position and logo-offset stay in screen pixels either
> +      way.
> +    enum: [none, cw, ccw, ud]
> +    default: none

[Severity: Low]
Is this non-standard string enum a regression from established device tree
conventions?

Using a custom string enum ('none', 'cw', 'ccw', 'ud') violates the establi=
shed
convention for rotation. Existing bindings like panel-common.yaml and
video-interface-devices.yaml dictate using a standard integer 'rotation'
property with degree values (0, 90, 180, 270). This custom format fragments
parsing logic in drivers.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923201035.5100=
7-1-maximpedraza@gmail.com?part=3D2
