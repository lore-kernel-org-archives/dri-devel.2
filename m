Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75767C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA80310E105;
	Tue, 30 Jun 2026 02:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aB0n2HYR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9EDD10E105
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 02:45:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E002E60008;
 Tue, 30 Jun 2026 02:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D4B1F000E9;
 Tue, 30 Jun 2026 02:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782787531;
 bh=76a2gudT2/KZF+u6Zt/ZM3n3NhPJLhlcAW9l6/6T0gM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aB0n2HYR1AXsc88ffGojEHPDGkok0G9eeU4on7JVIKs+1acyKRHo7y9viLMXisnCt
 1LT4x74qHX/sfH8o5Nwg7Nsreb49AbZeM04cPghtixgC2Ldc71MyfoTokjUdIpeqbs
 CX4lF91dImZFnNrcYfr7F1rs63iY93srCZioowgiGkj9fbnYt3gSVRyLQZrm/Ksn1b
 4yD529o9ncytBQwtC2Ha44Azhg9IaTAYXMrQ+Qv92eeiurjPGU60E5Hf5caQl2+6x/
 ACwPSRBnpOK7DJhWOGu2jlpqam5ZALcC8791eyI1eIkhOAgZ2HKihltqaXyrLmVXk8
 MkO0YXaKKraoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36536
To: "Pengyu Luo" <mitltlatltl@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260630023439.248861-2-mitltlatltl@gmail.com>
References: <20260630023439.248861-1-mitltlatltl@gmail.com>
 <20260630023439.248861-2-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 02:45:30 +0000
Message-Id: <20260630024531.47D4B1F000E9@smtp.kernel.org>
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
- [Low] Use of `additionalProperties: false` breaks inheritance of common p=
anel properties.
- [Low] Missing space before brace in the device tree example.
--

commit a15a27453070f4b1a8c8e896b7b599f3e42a0e6c
Author: Pengyu Luo <mitltlatltl@gmail.com>

dt-bindings: display: panel: Add Novatek NT36536

This commit adds a new device tree binding for the Novatek NT36536 DSI
display panel used in the LENOVO Legion Y700 Gen4.

> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36=
536.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.=
yaml
> new file mode 100644
> index 0000000000000..06f4d1e0ee4a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36536.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT36536 based DSI display Panels

[ ... ]

> +allOf:
> +  - $ref: panel-common-dual.yaml#
> +
> +properties:

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply
> +  - reset-gpios
> +  - ports
> +
> +additionalProperties: false

[Severity: Low]
Does using additionalProperties: false here break the inheritance of proper=
ties
from panel-common-dual.yaml#?=20

The schema validator might reject standard panel properties since
additionalProperties: false only considers properties explicitly defined in=
 the
local file's properties block. Should this be unevaluatedProperties: false
instead?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {

[ ... ]

> +            ports {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                port@0 {
> +                    reg =3D <0>;
> +                    panel_in_0: endpoint {
> +                        remote-endpoint =3D <&dsi0_out>;
> +                    };
> +                };
> +
> +                port@1{

[Severity: Low]
This isn't a bug, but there is a missing space before the brace here.

> +                    reg =3D <1>;
> +                    panel_in_1: endpoint {
> +                        remote-endpoint =3D <&dsi1_out>;
> +                    };
> +                };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630023439.2488=
61-1-mitltlatltl@gmail.com?part=3D1
