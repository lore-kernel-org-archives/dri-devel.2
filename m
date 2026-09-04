Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF4FC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1877B10F972;
	Fri,  4 Sep 2026 13:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kAI69UoH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED27310F972
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:37:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70835600C8;
 Fri,  4 Sep 2026 13:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9951F00A3D;
 Fri,  4 Sep 2026 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529026;
 bh=lPcPWeNiR60w6PRpRVSzZh19bI6xsSZFuwWiQzjnQCc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kAI69UoHGQ+85bcPOOUGBKqRfBUgF0a+G4Zpj7/Jz79VevgMt3tfV7sLGbIqi/q9d
 EN/rZL1VIxFfsfKlVRvZ44bUwsmmvJkWz7u+DSTA+xv6XYMfuDSFRFAaWQXaagyBpo
 Zqqgp4jLNVGIgbWB+ypQHaJRtanxUU9h0XPqVrzYH8Uwkrhk0LuGqNgpE3nKgrA/eu
 +MagACyOdjY645oUPEzbGxftmjoIlauxhvwi4QbhcZTU8/FEGiXcHVASNJvBxGTxVd
 J1R2C0c5XkgvYY6Hq3bXXwwXaM4mGekmGKNDp7IezlM6Hym0E/DAx+yT/ZAp/fMTBB
 Vsvx3hB+nVdHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/19] dt-bindings: mfd: Add
 starfive,jh7110-hdmi-subsystem
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org,
 olteanv@gmail.com, robh@kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-clk@vger.kernel.org, mfd@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-3-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132714eucas1p1ddf12edea05cdeda7969f229ca90bd26@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-3-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:37:05 +0000
Message-Id: <20260904133705.7D9951F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Shared bus clocks and resets are incorrectly assigned to the child=
 controller instead of the parent, which will cause a system bus fault when=
 the PHY child accesses the shared registers.
- [Medium] Splitting a monolithic hardware block into an MFD purely to reso=
lve a software probe ordering issue violates core Device Tree design princi=
ples.
- [Medium] The binding requires a bespoke MFD driver for a simple shared re=
gister space by omitting standard fallback compatible strings.
--

commit c934e468899df3820b545d81d3b4b4a9ae4b2097
Author: Michal Wilczynski <m.wilczynski@samsung.com>

dt-bindings: mfd: Add starfive,jh7110-hdmi-subsystem

Adds a device tree binding for the StarFive JH7110 HDMI subsystem.
The binding creates a multi-function device parent with phy and controller
children to resolve a circular clock dependency.

> diff --git a/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-s=
ubsystem.yaml b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-=
subsystem.yaml
> new file mode 100644
> index 0000000000000..bd35f191835a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsyste=
m.yaml
> @@ -0,0 +1,95 @@
[ ... ]
> +description:
> +  The StarFive JH7110 HDMI block is a monolithic IP containing both
> +  the digital controller logic and the analog PHY logic in a single
> +  register space. It sits inside the video output subsystem, which owns

[Severity: Medium]
Since the hardware is a single monolithic IP block in a single register
space, does splitting it into a multi-function device parent and child nodes
conflict with the core device tree principle of describing hardware topology
rather than software abstraction limitations?

> +  the NoC bus clock and reset gating this region and the power domain it
> +  belongs to.
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-hdmi-subsystem

[Severity: Medium]
Does limiting the compatible property strictly to this string without allow=
ing
standard fallbacks like "simple-mfd" force the creation of a bespoke driver
for a simple shared register space?

> +
> +  reg:
> +    maxItems: 1
[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - phy
> +  - controller
> +
> +additionalProperties: false

[Severity: High]
With this property set to false, it is impossible for the parent node to
request clocks or resets. In the example below, the module system clock
(JH7110_VOUTCLK_HDMI_TX_SYS) is assigned to the controller child node.

Because the controller depends on the phy child for its pixel clock, the phy
must probe first. When the phy probes and attempts read-modify-write
operations on the shared regmap, will this cause a system bus fault and hard
CPU lockup because the module system clock is not yet enabled by the
controller?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +    soc {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        hdmi@29590000 {
> +            compatible =3D "starfive,jh7110-hdmi-subsystem";
> +            reg =3D <0x29590000 0x4000>;
> +
> +            controller {
> +                compatible =3D "starfive,jh7110-inno-hdmi-controller";
> +                clocks =3D <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,

[Severity: High]
Can this clock assignment lead to the system bus fault mentioned above? It
seems the parent node should be responsible for enabling the bus clock befo=
re
the children probe.

> +                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
> +                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
> +                         <&hdmi_phy>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D3
