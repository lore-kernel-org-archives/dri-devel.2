Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61B1CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BA010E144;
	Fri, 16 Oct 2026 16:34:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFE610E144
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:34:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A03E741483;
 Fri, 16 Oct 2026 16:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEFA1F000C4;
 Fri, 16 Oct 2026 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792168476;
 bh=nPZ1tobbugwxIkrvSON12T5qqG/QLDhvrRmZL9DUI0Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YMBW9HilrVcOJcifDBGmwtDX/r+jkfEQXICC2b5LH+DU9sC/vG9Xsi+0IIejn5jmC
 AdlZd6XBF8k3joH/BwD34NHCTFddi46XbIKEFuUd+seeYcjUOdhpBpnhobOK03dnRo
 nE8+42yeyoJC4JqYTKFiGyD9r+hbaf0Nv7XOES/VnRBj+wv+09UsfWkW6MuJAWiPVV
 plESLWV2cOnkS4u/3d775LSN5uVp0hTixoptFnJKeA4bMkjAgtRsdsOrTh5297QKhs
 61K9lqsYbBHxcy0x5MKu3661xI3Vz+l/A8cn/zyZxIc3jDjAmZdZ+5p7DpERpHYAlb
 y3wSmcdsSvjLQ==
Message-ID: <sashiko-outbox-174646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99703
 backlight
To: "Luka Panio" <lukapanio@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261016162912.64581-2-lukapanio@gmail.com>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-2-lukapanio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:34:35 +0000
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
- [Medium] dt-bindings: missing 'pwms' property for PWM input
- [Low] dt-bindings: missing power supply property
--

commit bdcbdabe3e1453e58fc8f39fabc82b20db81480c
Author: Luka Panio <lukapanio@gmail.com>

dt-bindings: leds: backlight: Add Awinic AW99703 backlight

The Awinic AW99703 is a 3-string WLED driver converter with an
integrated boost converter and 11-bit brightness control over I2C,
optionally combined with a PWM input.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/awinic,aw99=
703.yaml b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.=
yaml
> new file mode 100644
> index 0000000000000..62e8cc3118f2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/awinic,aw99703.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic AW99703 WLED Backlight Driver
> +
> +maintainers:
> +  - Luka Panio <lukapanio@gmail.com>
> +
> +description:
> +  The AW99703 is a 3-string WLED driver with an integrated boost convert=
er
> +  and 11-bit I2C (optionally PWM) brightness control.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: awinic,aw99703

[Severity: Low]
Is a power supply property needed for the boost converter?

The hardware has an integrated boost converter, which typically requires
a supply such as 'vin-supply' or 'vcc-supply'. Because the schema enforces
'unevaluatedProperties: false', boards with a controllable regulator poweri=
ng
the backlight will fail schema validation if they attempt to define it.

[ ... ]

> +  awinic,inductor-nanohenry:
> +    description: Boost inductor value.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [4700, 10000]
> +    default: 4700
> +
> +  awinic,pwm-input:
> +    description: Combine the PWM input pin with the I2C brightness.
> +    type: boolean

[Severity: Medium]
Should the standard 'pwms' property be defined alongside this property?

The schema defines 'awinic,pwm-input' to indicate the hardware uses a PWM
input pin, but it doesn't define the standard 'pwms' property. Since this
schema uses 'unevaluatedProperties: false', board device trees attempting
to properly link a PWM controller using 'pwms =3D <&pwm ...>;' will fail
schema validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016162912.6458=
1-1-lukapanio@gmail.com?part=3D1
