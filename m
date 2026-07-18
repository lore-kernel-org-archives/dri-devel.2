Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A33CC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0940892C1;
	Sat, 18 Jul 2026 22:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SzSanViu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301C5892C1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 22:04:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B97660008;
 Sat, 18 Jul 2026 22:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91301F000E9;
 Sat, 18 Jul 2026 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784412269;
 bh=t9fJdyKtbTjoZvZ4Qaab9SXbJza23w5VJsqQLQ/nc8U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SzSanViuseiziUGZFLn3q3TofU500fXUMvp9n4U1XzcTh1yZzBpPHQvndhAwY11Dq
 2DS8rWvhNRuwzwIc5h92Agq6VrxCXNDzX3/c0GYxaUy0qHhuYj+zpwnvPicxagWNzr
 +n72LZ1fXCyO4Vn63M8bBOUPPlg+mYwWKS9AdtcE5O6OrNWtAjbe8AN19+7j8h0esE
 AuDWOGN/RKZoteYvdsOFooC+xz+ILQxjVpqBpsvV77A+PwgWcYB7IZwSJZyflADfKs
 s15oaGYHo6FuTPG4zha1AkhOZGh4a77O0pkw8VkHxfyJ45v6wCsL6+dhe/iTsupWMe
 faizFYsp7mQyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217
 to DT schema
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org,
 linux-leds@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260718215632.3295049-4-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-4-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 22:04:28 +0000
Message-Id: <20260718220428.B91301F000E9@smtp.kernel.org>
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
- [Medium] Stale and conflicting regulator text binding not deleted during =
schema conversion.
- [Low] Missing `required` constraint for `reg` property in regulator child=
 nodes.
--

--- Patch [3]: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS6521=
7 to DT schema ---
commit 0671f0f93114029deaa2c3fee6b27ad8abd2cb2d
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: leds: backlight: Convert TPS65217 to DT schema

This commit converts the Texas Instruments TPS65217 backlight binding to YA=
ML
schema. It also documents missing child nodes, interrupt properties, and
updates regulator names to match what the boards use.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217=
.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> new file mode 100644
> index 0000000000000..9586e08f1b1fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ti,tps65217.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TPS65217 family of regulators

[Severity: Medium]
Should Documentation/devicetree/bindings/regulator/tps65217.txt also be
deleted in this patch?

The new YAML schema defines the full MFD device, but conflicts with the
undeleted regulator text binding. The old regulator text binding expects
regulator nodes to be named dcdc[1-3] and ldo[1-4], while the new schema
expects regulator@[0-6], which could cause validation inconsistencies.

[ ... ]

> +    patternProperties:
> +      "^regulator@[0-6]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          regulator-compatible:
> +            $ref: /schemas/types.yaml#/definitions/string

[Severity: Low]
Does this schema need to specify the reg property as required?

Since these regulator child nodes have a unit address in the pattern
(^regulator@[0-6]$), DT validation could incorrectly pass nodes that contai=
n a
unit address but lack the mandatory reg property without a required block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718215632.3295=
049-1-egbostina@gmail.com?part=3D3
