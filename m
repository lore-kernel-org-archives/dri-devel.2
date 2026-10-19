Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941E4CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E7310E14F;
	Mon, 19 Oct 2026 10:09:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE52410E97F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:09:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40B2242E92;
 Mon, 19 Oct 2026 10:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8F91F000C5;
 Mon, 19 Oct 2026 10:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792404575;
 bh=6qhlZETrCNOqp1EFQZlNMxamwJm5Ij+mQnBmyzyQ4vg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EKfocuGqCon2UFslZrrQJyqhyOCCzHTEiNuTXDrzftRID8JRPJdJOTebnD5QGBNQn
 iiZNekCJU7azUurCiAZPJL6N/JB2YTOulY6ClYN5v8V2H+yScOqNz0vxCL/q7Dj1yv
 ybkWhqaF00nG/7bnk3gS78r53p4/WthXhXOwHX0/u3lwgqKUc6XV8aZMwZ7rMbjvAE
 F4YWlRqFTboQdp7XXFK75B+bbOR0wqhJz73TOWCPZPU7HWObnDY10NFPeeUhe3h24Y
 voWAZkoqUX8YTD0wvby1KxYjoVQ1/U0DZ26LM8W/IH6E6j1kg8L4pUmCYZFk7fqfQC
 6Z/4Js+zkeBfg==
Message-ID: <sashiko-outbox-176954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019095705.91062-4-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
 <20261019095705.91062-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:09:34 +0000
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
- [Low] dt-bindings: display: tegra: unvalidated dbi example and missing $n=
odename
--

commit 8ceaec80ccd97a96cf07da8add147a083a0f5944
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: display: tegra: Document 8-bit CPU parallel interface

This commit adds a devicetree binding schema for the 8-bit CPU parallel
MIPI DBI Type B interface on Tegra20 and Tegra30 display controllers, and
references it from the Tegra20 display controller binding.

> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
-dbi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-db=
i.yaml
> new file mode 100644
> index 0000000000000..ada7b35778933
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.ya=
ml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-dbi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra DC based MIPI DBI Type B interface
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description: The display controller in Tegra20/30 SoCs features an
> +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> +  protocol and is referred to as '8-bit CPU'. Each display controller
> +  provides two such interfaces, which can be used to send MIPI DCS
> +  commands to initialize and control the panel while image data is
> +  transmitted via 16/18/24-line RGB.
> +
> +properties:
> +  dc-gpios:
> +    description: Data/command selection pin.
> +    maxItems: 1
> +
> +  rw-gpios:
> +    description: Read/write pin.
> +    maxItems: 1
> +
> +  cs-gpios:
> +    description: Chip select pin.
> +    maxItems: 1
> +
> +  data-gpios:
> +    description: Specifies a set of 8 gpio pins used to transfer data.
> +    minItems: 8
> +    maxItems: 8
> +
> +  nvidia,init-sequence:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Device specific set of values used in DC DISP_SPI_INIT_SEQ registe=
rs.
> +    minItems: 4
> +    maxItems: 4
> +
> +  panel:
> +    type: object
> +    description: Node of supported panel driven by the bridge.

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dbi {
> +        dc-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> +        rw-gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> +        cs-gpios =3D <&gpio 108 GPIO_ACTIVE_HIGH>;
> +
> +        data-gpios =3D <&gpio 32 GPIO_ACTIVE_HIGH>, <&gpio 33 GPIO_ACTIV=
E_HIGH>,
> +                     <&gpio 34 GPIO_ACTIVE_HIGH>, <&gpio 35 GPIO_ACTIVE_=
HIGH>,
> +                     <&gpio 36 GPIO_ACTIVE_HIGH>, <&gpio 37 GPIO_ACTIVE_=
HIGH>,
> +                     <&gpio 38 GPIO_ACTIVE_HIGH>, <&gpio 39 GPIO_ACTIVE_=
HIGH>;
> +
> +        nvidia,init-sequence =3D <0x0000002c 0x0 0x0 0x00005000>;
> +
> +        panel {
> +            compatible =3D "hit,tx10d07vm0baa";
> +
> +            reset-gpios =3D <&gpio 175 GPIO_ACTIVE_LOW>;
> +
> +            avci-supply =3D <&vcc_2v8_lcd>;
> +            iovcc-supply =3D <&iovcc_1v8_lcd>;
> +
> +            backlight =3D <&backlight>;
> +
> +            port {
> +                panel_input: endpoint {
> +                    remote-endpoint =3D <&bridge_output>;
> +                };
> +            };
> +        };
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
> +
> +                bridge_input: endpoint {
> +                    remote-endpoint =3D <&dpi_output>;
> +                    bus-width =3D <24>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +
> +                bridge_output: endpoint {
> +                    remote-endpoint =3D <&panel_input>;
> +                };
> +            };
> +        };
> +    };

[Severity: Low]
Because Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.ya=
ml
defines neither compatible, $nodename (for example, $nodename: const: dbi),
nor a select block, dt-mk-schema generates select: false for this schema. As
a result, the schema is only evaluated when referenced via $ref from the dbi
property of nvidia,tegra20-dc.yaml, and the standalone dbi node in examples
is never selected or validated by dt-validate against nvidia,tegra-dbi.yaml.

In addition, at this point in the series, the panel node in the example uses
compatible =3D "hit,tx10d07vm0baa" and avci-supply =3D <&vcc_2v8_lcd>, whic=
h are
not documented until commit 5002ce93d3d5 ("dt-bindings: display: panel:
Document Hitachi TX10D07VM0BAA and LG LH400WV3 panels"), causing make
dt_binding_check to fail during bisection.

Also, the panel property is only defined as type: object without referencing
/schemas/display/panel/panel-common.yaml# or specifying additionalProperties
or unevaluatedProperties, and the bridge_input label on the port@0 endpoint
is unused.

Should properties in nvidia,tegra-dbi.yaml include $nodename: const: dbi (or
place the example inside a nvidia,tegra20-dc node) and reference
panel-common.yaml# for panel, with the panel binding ordered before this
patch so make dt_binding_check validates the example cleanly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019095705.9106=
2-1-clamor95@gmail.com?part=3D3
