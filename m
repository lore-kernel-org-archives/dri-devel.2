Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA27DC531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270DA10E16A;
	Thu, 23 Jul 2026 10:34:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3772010E16A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:34:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 021F443D14;
 Thu, 23 Jul 2026 10:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A11F000E9;
 Thu, 23 Jul 2026 10:34:27 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: leds: backlight: Convert TPS65217
 to DT schema
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260723100605.628882-5-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-5-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:34:26 +0000
Message-Id: <20260723103427.510A11F000E9@smtp.kernel.org>
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
- [Medium] The converted MFD (Multifunction Device) core binding is incorre=
ctly placed in the `leds/backlight/` directory.
- [Low] The commit message uses an incorrect subsystem prefix for a Multifu=
nction Device (PMIC).
--

--- Patch [4]: [PATCH v4 4/4] dt-bindings: leds: backlight: Convert TPS6521=
7 to DT schema ---
commit 1f4c2bf543a28045151b5cf16c5be1f7c2cee8e1
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: leds: backlight: Convert TPS65217 to DT schema

This commit converts the Texas Instruments TPS65217 bindings to DT schema.
It consolidates the old regulator and backlight bindings into a single
schema file while documenting additional child nodes and properties.

> dt-bindings: leds: backlight: Convert TPS65217 to DT schema

[Severity: Low]
Is the subsystem prefix correct for this device? The TPS65217 is a PMIC=20
and its core driver resides in drivers/mfd/tps65217.c. Since this patch=20
consolidates the bindings for a Multifunction Device into a single unified=
=20
schema, should the prefix reflect the MFD subsystem instead, such as
dt-bindings: mfd: ti,tps65217:?

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

[Severity: Medium]
Since this schema consolidates the regulator, backlight, and other PMIC
functions into a single file, should this be placed in the mfd/ directory=20
rather than leds/backlight/? Placing it in leds/backlight/ seems to=20
categorize the device's primary role as a dedicated backlight rather than=20
an MFD. If moved, the id and file path would become=20
http://devicetree.org/schemas/mfd/ti,tps65217.yaml#.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D4
