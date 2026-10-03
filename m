Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD4ECA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF50210E0FE;
	Sat,  3 Oct 2026 15:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="iyRdI8uv";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8648010E0FE
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 15:36:31 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261003153628euoutp012ff25533234c428be9ff26b1fae8bcaf~bDwR0T6ER1714317143euoutp01W;
 Sat,  3 Oct 2026 15:36:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261003153628euoutp012ff25533234c428be9ff26b1fae8bcaf~bDwR0T6ER1714317143euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791041788;
 bh=cezTBuZnRU09BC5t/TXbbnr/2mOgRJXIrT1bA9nKYfk=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=iyRdI8uvT1VnyJT6tqgggenZI6nITXILkxQtf0XryX352UU+lQidWIGBUPATnmApl
 NqErh1NgfRSaacsdX3dVtsHcj+ObkGldlks/K3Pp/ACh4wuzlI3nw9I71uwYTuobcz
 MAqgn33qV3D/4uufZns8VtPAgjSZZJfnfsm8yK1Y=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261003153627eucas1p1f4cc5dc15e7a5dbebdfb26617afe1f56~bDwQpLxK00845508455eucas1p1j;
 Sat,  3 Oct 2026 15:36:27 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261003153625eusmtip1ba5f07ce91f2ac9a6e0ffa2ce26ac1cb~bDwPATbZ22801128011eusmtip1E;
 Sat,  3 Oct 2026 15:36:25 +0000 (GMT)
Message-ID: <eaba2fa9-a1ce-4dac-9bd6-e0b3a3dd01ef@samsung.com>
Date: Sat, 3 Oct 2026 17:36:25 +0200
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
In-Reply-To: <6cf9e611-bfc5-407b-8132-bd328f8b61fc@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261003153627eucas1p1f4cc5dc15e7a5dbebdfb26617afe1f56
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



On 9/30/26 13:01, Krzysztof Kozlowski wrote:
> On 25/09/2026 23:05, Michal Wilczynski wrote:
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +    description: Reference oscillator.
>>>
>>> This barely counts as a resource, so usual question: no resources here?
>>> no MMIO? Even the user of this phy is the block itself.
>>>
>>> This makes me wonder if this should be a device node in the first place
>>> (instead folded into the parent).
>>
>> The PHY has no reg because the reg is shared with the controller and
>> owned by the parent - patch 9 lets the bridge take its regmap from
>> there.
>>
>> The user of the PHY is not only the block itself. It is the pixel clock
>> provider for the whole display subsystem, voutcrg takes hdmitx0_pixelclk
>> as the parent of its DC8200 pixel MUXes, and while HDMI output is active
>> it is the only intended source for that clock. The parent has to be
>> assigned explicitly so the general PLL does not end up driving the pixel
>> clock, and so a DSI user does not reach the HDMI PHY clock generator.
>>
>> So it has to be its own node. The HDMI block has two independent
> 
> I do not see the logic which lead to this conclusion. Pixel clock
> provider, so a clock controller, cannot be a user of a phy. Clock
> controller does not have a physical layer.

Sorry I think the wording was not perfect. I meant the PHY node is a
pixel clock provider. voutcrg consumes a clock not a PHY.

voutcrg: clock-controller@295c0000 {
         clocks = <&syscrg ...>, <&hdmi_phy>;
         clock-names = ...,"hdmitx0_pixelclk";
};

The consumer of the PHY is only the hdmi controller.

What matters for the node layout is where that clock goes. voutcrg is the
SoC display clock controller - it is not part of the HDMI block:

hdmi_phy -- pixel clock -> voutcrg
                              |
                              - pclk/mclk/bclk -> hdmi_controller
                              - pix0/pix1 -> dc8200

hdmi_phy and hdmi_controller are the same register block with one reg
owned by the parent. So if that block is described as a single node:

hdmi_node - pixel clock -> voutcrg
     ^                          |
     --- pclk/mclk/bclk --------

the node provides a clock to voutcrg and consumes three clocks from
voutcrg. That is a cycle in the device tree description.

Split in two there is no cycle: the PHY's only input is xin24m - the 24 MHz
oscillator which gives a linear order - hdmi_phy, voutcrg, hdmi_controller.

> 
> And really, I have no clue what hdmitx0_pixelclk and voutcrg are. I
> could probably study the patches a lot to figure that out, but my review
> queue has still 200 more, so I'll skip.
> 
> But nevertheless assigning clock parent of HDMI clock to PHY is
> standard, most of the platforms have it, thus it is not a justification
> for odd design.

Agreed and that is what this is - I followed RK3328, which uses the same
Innosilicon IP and also describes it as two nodes:

hdmi:    hdmi@ff3c0000   clocks = <&cru PCLK_HDMI>, ...
hdmiphy: phy@ff430000    clocks = <&cru PCLK_HDMIPHY>, <&xin24m>,
                                  <&cru DCLK_HDMIPHY>
                         clock-output-names = "hdmi_phy";
                         #clock-cells = <0>;
                         #phy-cells = <0>;

The only difference is reg: RK3328 has two register ranges, the JH7110 has
one, so the parent owns it and the children have none.

> 
>> functions with different clock inputs and one of them feeds back into
>> the SoC clock tree. The PHY generates hdmitx0_pixelclk which voutcrg
>> consumes the controller consumes pclk/mclk/bclk from voutcrg. Folded
>> into one node that node is both a provider to and a consumer of
>> voutcrg which is a cycle in the hardware description, not just in Linux.
> 
> 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
