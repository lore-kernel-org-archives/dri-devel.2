Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC5AC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6DB10E25E;
	Tue, 21 Jul 2026 11:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dyr1wqhS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEC910E25E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:29:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06B7F41F95;
 Tue, 21 Jul 2026 11:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB511F00A3A;
 Tue, 21 Jul 2026 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784633381;
 bh=t6xHG5vDB/uOSrEsDNOgnHVxiTWU3BpUyvABOs9c/mM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dyr1wqhSojRwQXeexjnLHDOJ8FEwXLymYq6jBZbw8vzhyhupSXc3tXMp09qEtSHPi
 Py8O6IG8aRCamhGyMj8EU4Ct85b5RKf1jBzUse2MVvQnmaZ9ANSzek+A1opEThaLjv
 apSzZ7YdIakYnDO/V55teA1ta/WFywucbwQH7wKQt6cTTTWK833E2H9kYc5IbnzJ3G
 Y4gPy/ycdL9TPo6rjsRMA92cyME3GsM5toThrwRqgsDQEWcU+P3znQRKlW0BPNbKhi
 aDBHtEUjtYIjEisb+eQvUW38uO/vqkeF57rv3LfmpNIEVBIQvX80rnMkqfB4RWexSP
 w1Xj4zp4jzquw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS65217
 to DT schema
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: linux-leds@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, lee@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20260721112133.70382-5-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-5-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:29:40 +0000
Message-Id: <20260721112940.8DB511F00A3A@smtp.kernel.org>
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
- [Medium] The patch converts the TPS65217 backlight binding to a comprehen=
sive PMIC schema but fails to delete the existing `regulator/tps65217.txt` =
binding, resulting in duplicate bindings.
- [Medium] The binding adds interrupt controller capabilities but omits `in=
terrupt-controller` and `#interrupt-cells` from the `required` list.
--

--- Patch [4]: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS6521=
7 to DT schema ---
commit 280c44c9d977e107c7e28a27785e5c9c3dbde99e
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: leds: backlight: Convert TPS65217 to DT schema

This commit converts the Texas Instruments TPS65217 backlight binding to
DT schema, adding child nodes for regulators, charger, and pwrbutton,
as well as documenting interrupt and shutdown controller properties.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217=
.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> new file mode 100644
> index 0000000000000..4d2f4dbd2d52e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ti,tps65217.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TPS65217 family of regulators

[Severity: Medium]
This schema defines a comprehensive PMIC with regulators and chargers
rather than just a backlight, but it is placed in the leds/backlight
directory. Should this be moved to a more central MFD or regulator schema
location?

Additionally, it appears the existing regulator binding documentation at
Documentation/devicetree/bindings/regulator/tps65217.txt was not deleted
in this patch, leaving duplicate bindings for the ti,tps65217 compatible
string. Should that file be removed as part of this conversion so schema
validation is not split and inconsistent?

[ ... ]

> +  pwrbutton:
> +    $ref: /schemas/input/ti,tps65217-pwrbutton.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Because this binding allows the device to act as an interrupt controller,
do interrupt-controller and #interrupt-cells need to be included in this
required list?

The device tree binding guidelines indicate that when hardware provides
these capabilities, the corresponding properties must be required so
incomplete device tree nodes don't silently pass validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721112133.7038=
2-1-egbostina@gmail.com?part=3D4
