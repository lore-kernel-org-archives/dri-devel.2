Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1677ECA6004
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 12:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A3310E268;
	Sat, 10 Oct 2026 12:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="WBqwhh+v";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C1710E268
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 12:23:59 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261010122357euoutp02bf04a99341e5bbc43473ffce11d38391~dKpMJ5mLK1277212772euoutp02E;
 Sat, 10 Oct 2026 12:23:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261010122357euoutp02bf04a99341e5bbc43473ffce11d38391~dKpMJ5mLK1277212772euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791635037;
 bh=W/evXz/fk2nDwkRg/LgD/8BHntxXciqgyux6ksl533s=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=WBqwhh+vwDnb1ddbWTUFdAtvh6PQvDDQRRNk1HdcMIi3YL0IpQaH9EngEeVFTNiS2
 zAYBnlByApQHLgVml8kj8M6k9C1EeX0he4lF7JmuWaeUwc9WRCYjLFDgXMMFHKWIh+
 8uGWecAQfgqPR4OXwT5HvF14YaSXEiRzHLkPV2iY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261010122357eucas1p1892ef8aa961af3208f81f5356316372e~dKpL1ApHV2372723727eucas1p1W;
 Sat, 10 Oct 2026 12:23:57 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261010122355eusmtip2ad5884c70b787c8d696f7ac9805aa691~dKpKCi3Gt0696206962eusmtip2U;
 Sat, 10 Oct 2026 12:23:55 +0000 (GMT)
Message-ID: <e0c42946-ed2a-41cc-9f2a-1bb089e02085@samsung.com>
Date: Sat, 10 Oct 2026 14:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/20] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Emil
 Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <ac7b82e6-22ea-465c-8477-bbe0bd9c8c27@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261010122357eucas1p1892ef8aa961af3208f81f5356316372e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125
X-EPHeader: CA
X-CMS-RootMailID: 20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
 <20260917-mutant-chamois-of-competence-46ca77@quoll>
 <1a1a9b49-430b-4218-b27d-e133d488e8d9@samsung.com>
 <6cf9e611-bfc5-407b-8132-bd328f8b61fc@kernel.org>
 <eaba2fa9-a1ce-4dac-9bd6-e0b3a3dd01ef@samsung.com>
 <3ee91c92-4e3a-4bac-85cf-923f5d77ceff@kernel.org>
 <3c5c15d9-ea7e-49a2-adae-ec3e3c72594b@samsung.com>
 <ac7b82e6-22ea-465c-8477-bbe0bd9c8c27@kernel.org>
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



On 10/4/26 09:15, Krzysztof Kozlowski wrote:
> On 04/10/2026 00:35, Michal Wilczynski wrote:
>>
>>
>> On 10/3/26 22:45, Krzysztof Kozlowski wrote:
>>> On 03/10/2026 17:36, Michal Wilczynski wrote:
>>>>
>>>>
>>>> On 9/30/26 13:01, Krzysztof Kozlowski wrote:
>>>>> On 25/09/2026 23:05, Michal Wilczynski wrote:
>>>>>>>> +  clocks:
>>>>>>>> +    maxItems: 1
>>>>>>>> +    description: Reference oscillator.
>>>>>>>
>>>>>>> This barely counts as a resource, so usual question: no resources here?
>>>>>>> no MMIO? Even the user of this phy is the block itself.
>>>>>>>
>>>>>>> This makes me wonder if this should be a device node in the first place
>>>>>>> (instead folded into the parent).
>>>>>>
>>>>>> The PHY has no reg because the reg is shared with the controller and
>>>>>> owned by the parent - patch 9 lets the bridge take its regmap from
>>>>>> there.
>>>>>>
>>>>>> The user of the PHY is not only the block itself. It is the pixel clock
>>>>>> provider for the whole display subsystem, voutcrg takes hdmitx0_pixelclk
>>>>>> as the parent of its DC8200 pixel MUXes, and while HDMI output is active
>>>>>> it is the only intended source for that clock. The parent has to be
>>>>>> assigned explicitly so the general PLL does not end up driving the pixel
>>>>>> clock, and so a DSI user does not reach the HDMI PHY clock generator.
>>>>>>
>>>>>> So it has to be its own node. The HDMI block has two independent
>>>>>
>>>>> I do not see the logic which lead to this conclusion. Pixel clock
>>>>> provider, so a clock controller, cannot be a user of a phy. Clock
>>>>> controller does not have a physical layer.
>>>>
>>>> Sorry I think the wording was not perfect. I meant the PHY node is a
>>>> pixel clock provider. voutcrg consumes a clock not a PHY.
>>>>
>>>> voutcrg: clock-controller@295c0000 {
>>>>          clocks = <&syscrg ...>, <&hdmi_phy>;
>>>>          clock-names = ...,"hdmitx0_pixelclk";
>>>> };
>>>>
>>>> The consumer of the PHY is only the hdmi controller.
>>>>
>>>> What matters for the node layout is where that clock goes. voutcrg is the
>>>> SoC display clock controller - it is not part of the HDMI block:
>>>>
>>>> hdmi_phy -- pixel clock -> voutcrg
>>>>                               |
>>>>                               - pclk/mclk/bclk -> hdmi_controller
>>>>                               - pix0/pix1 -> dc8200
>>>>
>>>> hdmi_phy and hdmi_controller are the same register block with one reg
>>>> owned by the parent. So if that block is described as a single node:
>>>>
>>>> hdmi_node - pixel clock -> voutcrg
>>>>      ^                          |
>>>>      --- pclk/mclk/bclk --------
>>>>
>>>> the node provides a clock to voutcrg and consumes three clocks from
>>>> voutcrg. That is a cycle in the device tree description.
>>>
>>> There is no cycle. Internal signals to the block are not represented in DT.
>>>
>>> What you have is a driver problem and you create some sort of DT
>>> structure to solve that. DT purpose is NOT to solve your driver
>>> dependencies or circular connections.
>>
>> The structure is not something I added. The voutcrg binding has required
>> an input clock named hdmitx0_pixelclk since it was merged in 2023
>> a097a5ec14df ("dt-bindings: clock: Add StarFive JH7110 Video-Output
>> clock and reset generator") and this series does not touch that file:
>>
>> Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
>>        - const: hdmitx0_pixelclk
>>
>> Mainline satisfies it with a placeholder, because so far nothing provided the
>> real clock:
>>
>> hdmitx0_pixelclk: hdmitx0-pixel-clock {
>>             compatible = "fixed-clock";                                                                          
>>             clock-output-names = "hdmitx0_pixelclk";
>>             #clock-cells = <0>;
>> };
>>
>> All this series does is point that existing input at the device that actually
>> generates it.
>>
>> TRM [1] table 5-3  on page 529 lists the display CRG's input clocks. Most come from
>> dom_vout_top, but three come from IP blocks inside the subsystem:
>>
>> clk_hdmitx0_pixelclk        297 MHz   u0_hdmi_tx.clk_pix
>> clk_mipitx_dphy_rxesc        10 MHz   u0_mipitx_dphy.clk_rxesc
>> clk_mipitx_dphy_txbytehs    297 MHz   u0_mipitx_dphy.clk_txbytehs
>>
>> and on page 530 the CRG offers clk_hdmitx0_pixelclk as Source1 for:
>>
>> u0_dc8200.clk_pix0      Source0 clk_dc8200_pix0  Source1 clk_hdmitx0_pixelclk
>> u0_dc8200.clk_pix1      Source0 clk_dc8200_pix0  Source1 clk_hdmitx0_pixelclk
>> u0_cdns_dsiTx.clk_dpi   Source0 clk_dc8200_pix0  Source1 clk_hdmitx0_pixelclk
>>
>> The DC8200 and the DSI TX are separate devices, so the pixel clock
>> crosses two block boundaries to reach them.
>>
>> That is also why the DT has to be able to name it. Those MUXes have two
>> parents and the selection is made in DT:
>>
>> &dc8200 {
>>           assigned-clocks = <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>, ...;
>>           assigned-clock-parents = <&hdmi_phy>, <&hdmi_phy>;
>> };
>>
>> and voutcrg takes it as an input clock because that is what the hardware
>> does. If the PHY is folded into the HDMI node, that input phandle points at
>> a node which also consumes pclk/mclk/bclk from voutcrg. That is where the
>> cycle comes from - the hardware topology not the driver.
> 
> Which is perfectly "fine" - present in many other SoCs as well. This is
> not different and your arguments are insufficient to give here
> exceptions. Why? Because again you use as an argument a Linux driver
> problem (cyclic dependency). Basically to solve Linux problem you
> introduce new empty nodes.
> 
> Best regards,
> Krzysztof
> 

OK probe ordering is a Linux concern and can't be used it to justify the
binding.

We spoke briefly about this on Monday and I came away thinking the node
is acceptable as long as it is justified by what it describes rather
than by probe order. Is that the right reading of what you meant?

On that basis the PHY node:
- is a clock provider, and voutcrg consumes that clock and
  routes it on to the DC8200 pixel MUXes and the DSI TX
- is a phy provider for the controller
- takes a different input clock than the controller - xin24m, against
  pclk/mclk/bclk from voutcrg
- is separate IP - the same Innosilicon PHY that RK3328 instantiates at its
  own address (phy@ff430000), which here shares a register window with the
  controller

The reg is the only thing it does not have of its own, and that is shared
with the controller and owned by the parent.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
