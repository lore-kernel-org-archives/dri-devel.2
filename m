Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB117606A334
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMWIIN+d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051F610E14E;
	Mon,  9 Nov 2026 20:04:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B04C10E14E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:04:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04E634158F;
 Mon,  9 Nov 2026 20:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DF91F0089F;
 Mon,  9 Nov 2026 20:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794254671;
 bh=E0GlRhDnLo/iOQKkl6haVCGh9Hkd4sWEaYoV7HwSoCA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WMWIIN+dL1J134sCPMRE6INceKfEldklelxGXCQgs9fW05jPGMZbXys0ZUzcrwghg
 20i6OtiqNo1xeqmLImUbSmlEyFVQoNxu+mpsdXNzOAT9HclznWxml853Fnnda1qnba
 z9LRsdXGll0yNLP7PVazkFHQflszD5CCcldBjJcplwBNS5/0rNr8VCORi9qa8uQR+v
 MyOXDOaPKOcDXI3J9ewg/GD/qhzqLcLQGavVMXIju1aP8+WQbVI/4CyUy/N5kclBOm
 AbzkZQKanp0ovYmDBfubUyTNrdHUNRjvnBYTHpnoD0E+NRkiETmy+2aoqxArf1ZcJD
 ss2g4BOvu8u0Q==
Message-ID: <sashiko-outbox-205531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
To: "Luo Liu" <Luo.Liu@cixtech.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261109092623.102291-2-Luo.Liu@cixtech.com>
References: <20261109092623.102291-1-Luo.Liu@cixtech.com>
 <20261109092623.102291-2-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:04:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] dt-bindings: display: custom vendor properties duplicate
  standard DT bindings
- [Medium] dt-bindings: display: incomplete OF graph ports and missing
  required phys/port
--

commit 7968e7b18915fdc94006fbc915ec20e0e3171502
Author: Luo Liu <Luo.Liu@cixtech.com>

dt-bindings: display: add CIX Sky1 DisplayPort transmitter

This commit adds the Device Tree binding schema for the CIX Sky1 Trilinear
DisplayPort transmitter controller and adds a corresponding MAINTAINERS ent=
ry.

> diff --git a/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml=
 b/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
> new file mode 100644
> index 0000000000000..9087b5edd9f02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
> @@ -0,0 +1,108 @@

[ ... ]

> +  phys:
> +    maxItems: 1
> +    description: DisplayPort PHY the controller transmits through.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Video input from the display pipeline that drives this controller.
> +
> +  cix,adapter-port:
> +    description:
> +      RCSU video adapter port of this transmitter. Sky1 numbers its five
> +      transmitters from 1 to 5. Port 3 is the native DP/eDP output.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 5
> +
> +  cix,dp-max-rate:
> +    description:
> +      Maximum link rate the board is wired for, in units of 10 kbit/s.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [162000, 270000, 540000, 810000]
> +    default: 810000
> +
> +  cix,stream-id:
> +    description:
> +      Index of the video stream this controller uses. Sky1 has two strea=
ms,
> +      numbered 0 and 1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1
> +    default: 0

[Severity: Medium]
Can standard Devicetree mechanisms replace cix,adapter-port, cix,dp-max-rat=
e,
and cix,stream-id instead of introducing custom vendor properties?

cix,adapter-port encodes a 1-to-5 instance index where port 3 is the native
DP/eDP output with a different RCSU register offset and bit layout from the
USB-C DP transmitters; per writing-bindings.rst, differing programming mode=
ls
should be distinguished by compatible strings rather than an instance index
property.

cix,dp-max-rate exposes Linux DRM internal software units of 10 kbit/s
without a standard unit suffix, duplicating the standard link-frequencies
property (in Hz) from video-interfaces.yaml on the output graph endpoint.

cix,stream-id hardcodes the input video stream index as a vendor property
instead of modeling the display pipeline to transmitter routing through OF
graph ports and endpoints.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - cix,adapter-port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    dp0: dp@14064000 {
> +        compatible =3D "cix,sky1-dptx";
> +        reg =3D <0x14064000 0x4000>,
> +              <0x14050000 0x400>;
> +        reg-names =3D "dp", "rcsu";
> +        interrupts =3D <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&clk 0>, <&clk 1>, <&clk 2>;
> +        clock-names =3D "apb", "vid0", "vid1";
> +        resets =3D <&rst 0>;
> +        cix,adapter-port =3D <1>;
> +    };

[Severity: Medium]
Should the binding define an output graph port and list phys and the OF gra=
ph
ports as required?

The schema only defines a single input port from the display pipeline and
omits the output port connecting this bridge to the downstream sink (such as
a dp-connector, usb-c-connector, or eDP panel), which prevents describing
board-level endpoint properties such as data-lanes and link-frequencies.

In addition, each transmitter sits between a display pipeline and a
DisplayPort PHY (and the driver unconditionally requires phys during probe),
so phys and the OF graph ports should be listed under required and included=
 in
the example.  The unreferenced dp0 label in the example should also be
dropped per writing-schema.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109092623.1022=
91-1-Luo.Liu@cixtech.com?part=3D1
