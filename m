Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3A7C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A3110E583;
	Sun,  9 Aug 2026 13:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DmBHf/re";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E513810E57A
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:25:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D32B60008;
 Sun,  9 Aug 2026 13:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C9B1F000E9;
 Sun,  9 Aug 2026 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786281912;
 bh=kYhbp28F7+UBM4KevzI4kFU74uU33VbXDdO7XLaaMWQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DmBHf/re5PKZIi5O6lnCrGXT6c9u9WVHL/A+16nMIqXjKt5/SCvnBnSjLa9P5oM/i
 p6Y4ZSLz3J8+Zx/ofWV3K3VH+RTZtewLRpdJvcgMRHrxeRX+9EWCJMjRtestqZ1xhC
 KyTawhfI1iAYzE8RSNcv+ntwNXUTvbiE+c7InMqBgG2naLxw0xT0MO31LaS5slOefp
 u/NJchwGXa2R1/gQt9dlIocTgMzLm1lRjrLY9kE0ZGFDcmb7RHnzLxMRE8JuzUbnQy
 ENuojS418jGhBRuulTepSxI2jYhBTIWu9zPHnSsWRjx6xztnOXiXyxsBTpY1nZkJKb
 V6lw5JqmrlYsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/17] dt-bindings: display: spacemit: add K3
 Innosilicon DP/eDP controller
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org, olteanv@gmail.com,
 robh@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260809-k3-display-v2-3-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-3-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:25:10 +0000
Message-Id: <20260809132511.44C9B1F000E9@smtp.kernel.org>
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
- [High] Probe deadlock and circular dependency due to the parent DP contro=
ller consuming a clock and PHY provided by its own child node.
--

--- Patch [3]: [PATCH v2 03/17] dt-bindings: display: spacemit: add K3 Inno=
silicon DP/eDP controller ---
commit ead86f1749dc824cd3f2b3c8dc8d28611bfc6866
Author: Cody Kang <codykang.hk@gmail.com>

dt-bindings: display: spacemit: add K3 Innosilicon DP/eDP controller
   =20
This commit adds the device tree binding schema for the Innosilicon
DisplayPort transmit controller on the SpacemiT K3 SoC. It includes
definitions for the DP PHY child node which provides clocks and PHY
resources to the parent DP controller.

> diff --git a/Documentation/devicetree/bindings/display/spacemit/spacemit,=
k3-inno-dp.yaml b/Documentation/devicetree/bindings/display/spacemit/spacem=
it,k3-inno-dp.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno=
-dp.yaml
[ ... ]
> +examples:
> +  - |
[ ... ]
> +        edp@cac84000 {
> +            compatible =3D "spacemit,k3-inno-dp";
> +            reg =3D <0x0 0xcac84000 0x0 0x4000>;
> +            interrupts =3D <132 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks =3D <&syscon_apmu CLK_APMU_EDP0_PXCLK>, <&edp0_phy>;
> +            clock-names =3D "pxclk", "pll";
> +            resets =3D <&syscon_apmu RESET_APMU_EDP0>;
> +            phys =3D <&edp0_phy>;
> +            phy-names =3D "dp";
> +
> +            edp0_phy: phy {
> +                compatible =3D "spacemit,k3-inno-dp-phy";
> +                #phy-cells =3D <0>;
> +                #clock-cells =3D <0>;

[Severity: High]
Does modeling the PHY and clock resources this way create a circular probe
dependency?

The parent node references its own child node (edp0_phy) for both clocks
and phys. If the parent requests these resources via standard APIs during
its probe function, it will likely receive an indefinite -EPROBE_DEFER.

The child cannot probe and register its resources until the parent completes
enough of its own probe to populate its children.

Is there a specific driver sequence expected here to avoid this deadlock,
or should the hardware abstraction be represented differently to avoid the
self-referential phandles?

> +                clock-output-names =3D "edp0_pll_pxclk";
> +            };
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D3
