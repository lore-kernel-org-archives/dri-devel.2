Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E7EC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFCA10F589;
	Thu,  3 Sep 2026 12:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="A84uFu5v";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3675310F5AD
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:49:18 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260903124916euoutp01c70c3377e9531d0b4effba39237e9f0d~R0Humhg0D2837828378euoutp01a;
 Thu,  3 Sep 2026 12:49:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260903124916euoutp01c70c3377e9531d0b4effba39237e9f0d~R0Humhg0D2837828378euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1788439756;
 bh=21XK8ouXwSbTKoSgpNp9PTnpZIppeDeeNUFwSv6ef0I=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=A84uFu5vC7oRa7UYvp4kb1qaFuO04d7y8EFyNaPGxT8vRYtNhTEAf1v8qbCTK1g9c
 ErZ7MNjb63emnIqANJbVFtycOFms2nxzltkpKWI+k2FVQDNvhQLzokz+RsiTTZD/sZ
 tbFgIVRs1iU0Hx2ZDAjgQWZBvVwu/E+5h3lOiTJE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260903124916eucas1p2046caac892ee377927f97ac1ed022764~R0HuWwHQ41235012350eucas1p2O;
 Thu,  3 Sep 2026 12:49:16 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260903124914eusmtip1c88b35a3579efd350fc5d28e52aac15c~R0HsrL5_S2573525735eusmtip1u;
 Thu,  3 Sep 2026 12:49:14 +0000 (GMT)
Message-ID: <113c3906-56c1-4940-9857-d611edc64361@samsung.com>
Date: Thu, 3 Sep 2026 14:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] dt-bindings: display: bridge: Add
 starfive,jh7110-inno-hdmi-controller
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lee Jones <lee@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Hal
 Feng <hal.feng@starfivetech.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Heiko Stuebner <heiko@sntech.de>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Icenowy
 Zheng <uwu@icenowy.me>, Andy Yan <andyshrk@163.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Maud Spierings <maudspierings@gocontroll.com>,
 Graham Markall <hello@big-grey.co.uk>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260828-stylus-bonfire-b71cbfe8b983@spud>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260903124916eucas1p2046caac892ee377927f97ac1ed022764
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134817eucas1p2e2756deff8871be4ea8bb5c65f9c179d
X-EPHeader: CA
X-CMS-RootMailID: 20260828134817eucas1p2e2756deff8871be4ea8bb5c65f9c179d
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134817eucas1p2e2756deff8871be4ea8bb5c65f9c179d@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-2-331680c8b9d1@samsung.com>
 <20260828-stylus-bonfire-b71cbfe8b983@spud>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 8/28/26 18:47, Conor Dooley wrote:
> On Fri, Aug 28, 2026 at 03:47:26PM +0200, Michal Wilczynski wrote:
>> Add the dt-binding for the StarFive JH7110 Innosilicon HDMI controller
>> (DRM bridge).
>>
>> This device is the second child of the starfive,jh7110-hdmi-subsystem node.
>> It consumes register access clocks (sys, mclk, bclk) from the voutcrg and
>> both the pixel clock (pclk) and the PHY from its hdmi_phy sibling.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  .../starfive,jh7110-inno-hdmi-controller.yaml      | 109 +++++++++++++++++++++
>>  1 file changed, 109 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..0e584e7b756e24e2f99a62daab3117bbf4b472b6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
>> @@ -0,0 +1,109 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/v1/url?k=af8ec5c4-ce05d0f2-af8f4e8b-74fe485cbff1-93a4f693847d5818&q=1&e=48120ebb-9eda-4ddc-b580-e20f8c69d005&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fdisplay%2Fbridge%2Fstarfive%2Cjh7110-inno-hdmi-controller.yaml%23
>> +$schema: https://protect2.fireeye.com/v1/url?k=4b8c4737-2a075201-4b8dcc78-74fe485cbff1-8caced678494fd92&q=1&e=48120ebb-9eda-4ddc-b580-e20f8c69d005&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: StarFive JH7110 Innosilicon HDMI Controller
>> +
>> +maintainers:
>> +  - Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +description:
>> +  The controller portion of the StarFive JH7110 INNO HDMI IP.
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-inno-hdmi-controller
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: System clock for register access
>> +      - description: Module clock
>> +      - description: Bus clock
>> +      - description: Pixel clock from PHY
>> +
>> +  clock-names:
>> +    items:
>> +      - const: sys
>> +      - const: mclk
>> +      - const: bclk
>> +      - const: pclk
> 
> "module" "bus" "pixel" would be more informative than spending most of
> your characters regurgitating what these are by definition?

So I've reread the TRM and mclk and bclk are named as such there and they
are audio clocks: section 5.3 lists a "four channel I2S transmitter bit
clock" among the display subsystem's clock sources, and that is this bclk.
The already merged starfive,jh7110-voutcrg.yaml names the same input
"i2stx0_bclk". So I've kept the names and put the information in the
descriptions instead:

 - description: The HDMI controller main clock
 - description: Audio master clock
 - description: Audio bit clock, from the I2S transmitter
 - description: The pixel clock, generated by the PHY

pclk was wrong. In this binding pclk is the register clock, as in
rockchip,inno-hdmi.yaml, and the generic inno-hdmi driver looks it up by
that name, holds it enabled for its lifetime and derives the DDC divider
from its rate. We had it bound to the pixel clock so the pre-PLL stayed
powered from probe and the divider was sized from 297 MHz instead of
49.5 MHz, putting the DDC bus at 17 kHz. Slow but not broken which
is why it went unnoticed.

So in v3 the register clock takes "pclk" and the PHY clock is named
"pixel".

> 
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    const: hdmi_tx
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: hdmi-phy
> 
> With the trend of ?pointless? -names properties, I'm surprised you don't
> have interrupt-names? I'd ditch 'em all where there's only a single
> clock. The _ rather than - in the reset name triggers my OCD.
> pw-bot: changes-requested

Will do. reset-names and phy-names will be gone which takes the
underscore in hdmi_tx with them.

Note that in v3 the vout subsystem parent node will be back on Icenowy's
review, so there will be three new DT patches: bindings for
starfive,jh7110-vout-subsystem and starfive,jh7110-vout-syscon, and
starfive,jh7110-dc8200 added to verisilicon,dc.yaml

> 
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description:
>> +      A graph node with one input port and one output port.
>> +
>> +required:
>> +  - compatible
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - phys
>> +  - phy-names
>> +  - ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # Shown as a child of the HDMI subsystem node; see
>> +  # Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
>> +  # for the full node.
>> +  - |
>> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
>> +
>> +    controller {
> 
> "controller" seems over generic for a node, but I guess if the parent is
> "hdmi-subsystem" or something it makes sense in that context.
> 
> Cheers,
> Conor.
> 
> 
>> +        compatible = "starfive,jh7110-inno-hdmi-controller";
>> +        clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
>> +                 <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
>> +                 <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
>> +                 <&hdmi_phy>;
>> +        clock-names = "sys", "mclk", "bclk", "pclk";
>> +        interrupts = <99>;
>> +        phys = <&hdmi_phy>;
>> +        phy-names = "hdmi-phy";
>> +        resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
>> +        reset-names = "hdmi_tx";
>> +
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            port@0 {
>> +                reg = <0>;
>> +
>> +                endpoint {
>> +                    remote-endpoint = <&dpu_out_dpi0>;
>> +                };
>> +            };
>> +
>> +            port@1 {
>> +                reg = <1>;
>> +
>> +                endpoint {
>> +                    remote-endpoint = <&hdmi_con_in>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +...
>>
>> -- 
>> 2.34.1
>>

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
