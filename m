Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35322CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 07:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED44C10E034;
	Sun,  4 Oct 2026 07:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kn0TAw1q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5D710E034
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 07:15:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4487660052;
 Sun,  4 Oct 2026 07:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBF51F000FF;
 Sun,  4 Oct 2026 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791098124;
 bh=1YLqc6z8LyeKl0+KHcGgxZtXD3B6g5rBKBLuGBPQUYU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kn0TAw1qOPg5KYhpCD5VwxN5UsLsVZecc5X1+BlRO+/o/J0KyyUVCwJWD/DeTKK/E
 RYh5KVemaOG0bO5S4ZTiYG/rO+u7yoB1LVNJ2PrMNN87Sh+fHO+Hq2NFic5LVZSdNR
 StXIBQEf4ikYEcKOKN7jweHKB/e76NgzG1YzjtfmJvW5Ja9QS/+fdpD3Cv7OiopjY9
 snCT50OgtZ/e6e1g0T+tyndQn8GOvnTkD0WDMzLqDdlp3pU/mFxN5S9WqNFfz2OnG3
 gO2r9kpPI+glHqLVWBRh4vYaKeLHwwi5f/RIs3BogGDhK+P8plcxCS4Zt7KsoAs2O7
 btLDUv5erfrhA==
Message-ID: <ac7b82e6-22ea-465c-8477-bbe0bd9c8c27@kernel.org>
Date: Sun, 4 Oct 2026 09:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/20] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lee Jones <lee@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
 <20260917-mutant-chamois-of-competence-46ca77@quoll>
 <1a1a9b49-430b-4218-b27d-e133d488e8d9@samsung.com>
 <6cf9e611-bfc5-407b-8132-bd328f8b61fc@kernel.org>
 <eaba2fa9-a1ce-4dac-9bd6-e0b3a3dd01ef@samsung.com>
 <3ee91c92-4e3a-4bac-85cf-923f5d77ceff@kernel.org>
 <3c5c15d9-ea7e-49a2-adae-ec3e3c72594b@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <3c5c15d9-ea7e-49a2-adae-ec3e3c72594b@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 04/10/2026 00:35, Michal Wilczynski wrote:
> 
> 
> On 10/3/26 22:45, Krzysztof Kozlowski wrote:
>> On 03/10/2026 17:36, Michal Wilczynski wrote:
>>>
>>>
>>> On 9/30/26 13:01, Krzysztof Kozlowski wrote:
>>>> On 25/09/2026 23:05, Michal Wilczynski wrote:
>>>>>>> +  clocks:
>>>>>>> +    maxItems: 1
>>>>>>> +    description: Reference oscillator.
>>>>>>
>>>>>> This barely counts as a resource, so usual question: no resources here?
>>>>>> no MMIO? Even the user of this phy is the block itself.
>>>>>>
>>>>>> This makes me wonder if this should be a device node in the first place
>>>>>> (instead folded into the parent).
>>>>>
>>>>> The PHY has no reg because the reg is shared with the controller and
>>>>> owned by the parent - patch 9 lets the bridge take its regmap from
>>>>> there.
>>>>>
>>>>> The user of the PHY is not only the block itself. It is the pixel clock
>>>>> provider for the whole display subsystem, voutcrg takes hdmitx0_pixelclk
>>>>> as the parent of its DC8200 pixel MUXes, and while HDMI output is active
>>>>> it is the only intended source for that clock. The parent has to be
>>>>> assigned explicitly so the general PLL does not end up driving the pixel
>>>>> clock, and so a DSI user does not reach the HDMI PHY clock generator.
>>>>>
>>>>> So it has to be its own node. The HDMI block has two independent
>>>>
>>>> I do not see the logic which lead to this conclusion. Pixel clock
>>>> provider, so a clock controller, cannot be a user of a phy. Clock
>>>> controller does not have a physical layer.
>>>
>>> Sorry I think the wording was not perfect. I meant the PHY node is a
>>> pixel clock provider. voutcrg consumes a clock not a PHY.
>>>
>>> voutcrg: clock-controller@295c0000 {
>>>          clocks = <&syscrg ...>, <&hdmi_phy>;
>>>          clock-names = ...,"hdmitx0_pixelclk";
>>> };
>>>
>>> The consumer of the PHY is only the hdmi controller.
>>>
>>> What matters for the node layout is where that clock goes. voutcrg is the
>>> SoC display clock controller - it is not part of the HDMI block:
>>>
>>> hdmi_phy -- pixel clock -> voutcrg
>>>                               |
>>>                               - pclk/mclk/bclk -> hdmi_controller
>>>                               - pix0/pix1 -> dc8200
>>>
>>> hdmi_phy and hdmi_controller are the same register block with one reg
>>> owned by the parent. So if that block is described as a single node:
>>>
>>> hdmi_node - pixel clock -> voutcrg
>>>      ^                          |
>>>      --- pclk/mclk/bclk --------
>>>
>>> the node provides a clock to voutcrg and consumes three clocks from
>>> voutcrg. That is a cycle in the device tree description.
>>
>> There is no cycle. Internal signals to the block are not represented in DT.
>>
>> What you have is a driver problem and you create some sort of DT
>> structure to solve that. DT purpose is NOT to solve your driver
>> dependencies or circular connections.
> 
> The structure is not something I added. The voutcrg binding has required
> an input clock named hdmitx0_pixelclk since it was merged in 2023
> a097a5ec14df ("dt-bindings: clock: Add StarFive JH7110 Video-Output
> clock and reset generator") and this series does not touch that file:
> 
> Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
>        - const: hdmitx0_pixelclk
> 
> Mainline satisfies it with a placeholder, because so far nothing provided the
> real clock:
> 
> hdmitx0_pixelclk: hdmitx0-pixel-clock {
>             compatible = "fixed-clock";                                                                          
>             clock-output-names = "hdmitx0_pixelclk";
>             #clock-cells = <0>;
> };
> 
> All this series does is point that existing input at the device that actually
> generates it.
> 
> TRM [1] table 5-3  on page 529 lists the display CRG's input clocks. Most come from
> dom_vout_top, but three come from IP blocks inside the subsystem:
> 
> clk_hdmitx0_pixelclk        297 MHz   u0_hdmi_tx.clk_pix
> clk_mipitx_dphy_rxesc        10 MHz   u0_mipitx_dphy.clk_rxesc
> clk_mipitx_dphy_txbytehs    297 MHz   u0_mipitx_dphy.clk_txbytehs
> 
> and on page 530 the CRG offers clk_hdmitx0_pixelclk as Source1 for:
> 
> u0_dc8200.clk_pix0      Source0 clk_dc8200_pix0  Source1 clk_hdmitx0_pixelclk
> u0_dc8200.clk_pix1      Source0 clk_dc8200_pix0  Source1 clk_hdmitx0_pixelclk
> u0_cdns_dsiTx.clk_dpi   Source0 clk_dc8200_pix0  Source1 clk_hdmitx0_pixelclk
> 
> The DC8200 and the DSI TX are separate devices, so the pixel clock
> crosses two block boundaries to reach them.
> 
> That is also why the DT has to be able to name it. Those MUXes have two
> parents and the selection is made in DT:
> 
> &dc8200 {
>           assigned-clocks = <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>, ...;
>           assigned-clock-parents = <&hdmi_phy>, <&hdmi_phy>;
> };
> 
> and voutcrg takes it as an input clock because that is what the hardware
> does. If the PHY is folded into the HDMI node, that input phandle points at
> a node which also consumes pclk/mclk/bclk from voutcrg. That is where the
> cycle comes from - the hardware topology not the driver.

Which is perfectly "fine" - present in many other SoCs as well. This is
not different and your arguments are insufficient to give here
exceptions. Why? Because again you use as an argument a Linux driver
problem (cyclic dependency). Basically to solve Linux problem you
introduce new empty nodes.

Best regards,
Krzysztof
