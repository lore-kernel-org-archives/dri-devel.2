Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49A0CA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C80112059;
	Fri,  9 Oct 2026 11:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H4mPPC8p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADC9112059
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:05:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B20060534;
 Fri,  9 Oct 2026 11:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129121F000FF;
 Fri,  9 Oct 2026 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791543914;
 bh=x65TjIpWN8ajfaY2CqtSSYJd3oa+IIXjQW8wYvciUKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H4mPPC8pMeNNf+VY1grDP+sP6XIPjjPBEuHTYTHkDrvRz9VXeUTgA4M5mr1e3R+AI
 ub5ypwD+PXiMExp9uK07I2iH9ahJivyibary/PkGlnLZFIXYWkxxrRKLAJpPsuOx4K
 vhOyB10xyBii1qmUbXU0WN/haYOOqUfwdn9FbWrSFyBWwXTQo8ufOv8VpSsV0Flzwf
 GQbS4B3hTAnoynmnW9XCA2sxe5BGaFFp5sz5ScYXlJedTYHWUCgZSy+acE0a3+oTfG
 4Ws3jCxHOY1KAW6fRof3qVtrjEIpLZwjoXihyedJHaqdu1Vvyy4E6HtigwWuA9UE9u
 4ENRiO4/J77xg==
Message-ID: <sashiko-outbox-165310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
To: Quchaosheng <quchaosheng000406@163.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261009105412.300338-2-quchaosheng000406@163.com>
References: <20261009105412.300338-1-quchaosheng000406@163.com>
 <20261009105412.300338-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:05:13 +0000
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
- [Low] dt-bindings: ti,tpd12s015: missing minItems: 3 constraint for gpios=
 property
--

commit 93e133f1119a3271ab3e48f347188c3580055f0b
Author: Chaosheng Qu <quchaosheng000406@163.com>

dt-bindings: display: ti,tpd12s015: Convert to DT schema

Convert the TPD12S015 HDMI level shifter binding to DT schema. Document the
two ports it exposes between the HDMI transmitter and the connector, and
add the tpd12s016 as a fallback compatible.

> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 0000000000000..1927da3bd7361
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---

[ ... ]

> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,tpd12s015
> +      - items:
> +          - const: ti,tpd12s016
> +          - const: ti,tpd12s015
> +
> +  gpios:
> +    description:
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first contr=
ols
> +      the level shifter, the second enables the level shifter outputs and
> +      the third reads the hot-plug detect line.
> +    maxItems: 3

[Severity: Low]
Does this gpios property also need a minItems: 3 constraint to prevent
incomplete device trees from passing schema validation?

Since maxItems is 3 and minItems is omitted, the schema compiler defaults
minItems to 1.

The driver ti-tpd12s015.c unconditionally attempts to retrieve the third
pin by its explicit index:

    devm_gpiod_get_index(&pdev->dev, NULL, 2, GPIOD_IN)

If a device tree provides 1 or 2 GPIOs, it will pass schema validation but
the driver probe will fail at runtime with -ENOENT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009105412.3003=
38-1-quchaosheng000406@163.com?part=3D1
