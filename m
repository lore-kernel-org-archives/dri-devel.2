Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71777CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8FC10E1EB;
	Mon, 15 Jun 2026 06:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MfA/RG5K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5757A10E1EB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:34:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 269B940DC8;
 Mon, 15 Jun 2026 06:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74C11F000E9;
 Mon, 15 Jun 2026 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781505249;
 bh=KJB66/+GRQlMBTLzxNiwr90NsdExgZU8pcK43avWcxQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MfA/RG5K2mvRg/RcNtiyNhlKqT5OeVBX1oQsQhKWQW0ZWQ/4ynMHEVqudVH3eSN63
 b29hK6yJ5Lh8lsSPN92JkQTWczecArgO4vHSDNXYsvjLqBEWA/+AWJUQoUO917s8Ps
 JkOcluRp1SpfPzAq+pCbhyWkEM9vJQGzBrFPYl0VxxXvNQ2vbSrVNFocMrSdzPnVJf
 6bqdVqYXnuvEm+6ncod2NNCvNPim7O1DATUD3/GV3MZoRExkcCSU/Dt9ENFcnIpO2d
 VrFc/8jcl/meEY4vDCdO6mhaRngQ0d7IOTlrxY8o9Vk1WvNIkVwA/Meh4W50CNw9ai
 Nn7S11h2zbR/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org
In-Reply-To: <20260615-rcar-du-dsc-v4-2-93096a1b56a3@ideasonboard.com>
References: <20260615-rcar-du-dsc-v4-2-93096a1b56a3@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:34:08 +0000
Message-Id: <20260615063408.B74C11F000E9@smtp.kernel.org>
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
- [Low] The DT binding example fails schema validation because its `compati=
ble` string array is incomplete and does not match the schema's requirement=
s.
--

commit 0c24ed90ba663d71759d36b46777595ba20ee9c3
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

dt-bindings: display: bridge: Document Renesas R-Car V4H DSC bindings

This commit adds device tree bindings for the VESA DSC Display Stream
Compression encoder embedded in the Renesas R-Car V4H SoC. It defines the
schema constraints, required properties, and provides an example node.

> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsc=
.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
> new file mode 100644
> index 0000000000000..4d2c2c6cb1f08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
[ ... ]
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r8a779g0-dsc
> +      - const: renesas,rcar-dsc
> +
[ ... ]
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a779g0-sysc.h>
> +
> +    bridge@feb8d000 {
> +        compatible =3D "renesas,r8a779g0-dsc";

[Severity: Low]
Does this example fail dt_binding_check validation? The schema requires the
compatible property to be an array containing exactly two items: the=20
SoC-specific string and the fallback constant (renesas,rcar-dsc). However,
the example only provides the SoC-specific string.=20

Should the example be updated to match the schema requirements?

> +        reg =3D <0xfeb8d000 0x400>;
> +        interrupts =3D <GIC_SPI 559 IRQ_TYPE_LEVEL_HIGH>;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-rcar-du-ds=
c-v4-0-93096a1b56a3@ideasonboard.com?part=3D2
