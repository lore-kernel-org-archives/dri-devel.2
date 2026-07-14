Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20068C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7E110EC12;
	Tue, 14 Jul 2026 06:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZmtZg0bT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FD910E051
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:58:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69CA940A73;
 Tue, 14 Jul 2026 06:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0950F1F000E9;
 Tue, 14 Jul 2026 06:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784012301;
 bh=c4I7kI5vpAvxeyD88BxdS1RYbNknMhbsa2v6YzR41cA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZmtZg0bTtrYCqE++gD/XQPRAJSvZVZuYgt/Y1RzxjWzoPTouJxcMj957O8KZiLVMZ
 uqg+wOkpTWKNRVJlaQ2RiemiXecng3ZKCtAew2P4zYWz1zwR6BBiapsSmGMqCio03q
 /ryymQIdjFpxo3IpHEsy/UcZ5h+JDJoWLmSjgIJF1y78YhVDbCvL0LKw5jY+a9dBeN
 6eGJp2iTPbEACdW1MICfb6gBJYft0xSD6/RSPUNLm/KOEyxBPR9ptN0GTcvIh9o1rB
 +c4K4uNvGYgX2ufK5Yxezwj4H4e8I1CpXcJdHOyB0oT58ZP0abV/Athl6g3POwm7+f
 lfyVujkBpgKEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/2] dt-bindings: bridge: Add Lontium LT7911EXC eDP
 to MIPI DSI bridge
To: syyang@lontium.com
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260714064822.2753289-2-syyang@lontium.com>
References: <20260714064822.2753289-1-syyang@lontium.com>
 <20260714064822.2753289-2-syyang@lontium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 06:58:20 +0000
Message-Id: <20260714065821.0950F1F000E9@smtp.kernel.org>
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
- [Low] Non-standard generic node name used in the device tree example. The=
 Devicetree specification recommends using standard generic names for devic=
e nodes to represent the class of the device rather than the specific model=
 or bus type (e.g., `bridge@` instead of `mipi-bridge@`).
--

--- Patch [1]: [PATCH v15 1/2] dt-bindings: bridge: Add Lontium LT7911EXC e=
DP to MIPI DSI bridge ---
commit 5c0643686f137815285d63f46eecfcaaaad55330
Author: Sunyun Yang <syyang@lontium.com>

dt-bindings: bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge

This commit adds the device tree binding schema for the Lontium LT7911EXC.
It documents an I2C-controlled bridge that converts eDP 1.4 input to MIPI
DSI output.

> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt7=
911exc.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt79=
11exc.yaml
> new file mode 100644
> index 0000000000000..3290b10ce8835
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.=
yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        mipi-bridge@41 {

[Severity: Low]
This isn't a bug, but should this node name use a standard generic name like
bridge@41 instead of mipi-bridge@41? The Devicetree specification recommends
using standard generic names to represent the class of the device rather
than the specific bus type, which helps avoid dt-schema warnings.

> +            compatible =3D "lontium,lt7911exc";
> +            reg =3D <0x41>;
> +            reset-gpios =3D <&gpy8 8 GPIO_ACTIVE_LOW>;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714064822.2753=
289-1-syyang@lontium.com?part=3D1
