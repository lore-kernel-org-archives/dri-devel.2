Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA854C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E318D10F1AF;
	Mon, 14 Sep 2026 19:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="TZKarI6F";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF6E10F1AF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 19:37:56 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260914193754euoutp02981281706c8e3139fb5b93cfbd25526a~VRyqJA0Bb0156301563euoutp02C;
 Mon, 14 Sep 2026 19:37:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260914193754euoutp02981281706c8e3139fb5b93cfbd25526a~VRyqJA0Bb0156301563euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789414675;
 bh=5quPaYobLEbeMOu5MqGjHlx1gGO6GYM4Ci77INCJQLA=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=TZKarI6Fzswot9c4aVXuInO0XRxf9GfzbOMlt7onjkVzeL1ZbqAInBvs4atJ/oDi0
 AUtj/OANEEt5ewm+9Sk6Wb7zy4Ml9/IM+VLkFU4eqSkZba+0uuGUKYDcVqnkJKj0Lt
 oxPYASnd7d7htQ9OwYLZimxgp4UXzR/izU9JOwv4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260914193754eucas1p1c5e933b8753ce6d75f7c5f34e3bb72d6~VRypvtokG2298422984eucas1p1x;
 Mon, 14 Sep 2026 19:37:54 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260914193752eusmtip20be6a60002305f9f5bc9e993970a2799~VRynuwkCl0478104781eusmtip2P;
 Mon, 14 Sep 2026 19:37:52 +0000 (GMT)
Message-ID: <782506ab-70b8-40a0-98f6-239e74351c1e@samsung.com>
Date: Mon, 14 Sep 2026 21:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/19] dt-bindings: display: verisilicon: Add
 starfive,jh7110-dc8200
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 <bmasney@redhat.com>, Heiko Stuebner <heiko@sntech.de>, Conor Dooley
 <conor@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260910-amorphous-vigilant-jaybird-d65c4f@quoll>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260914193754eucas1p1c5e933b8753ce6d75f7c5f34e3bb72d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904132719eucas1p1c900149ffa1b8771aca238e6441482ee
X-EPHeader: CA
X-CMS-RootMailID: 20260904132719eucas1p1c900149ffa1b8771aca238e6441482ee
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132719eucas1p1c900149ffa1b8771aca238e6441482ee@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-6-484f9ae72715@samsung.com>
 <20260910-amorphous-vigilant-jaybird-d65c4f@quoll>
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



On 9/10/26 10:34, Krzysztof Kozlowski wrote:
> On Fri, Sep 04, 2026 at 03:27:07PM +0200, Michal Wilczynski wrote:
>> The JH7110 embeds a DC8200. The binding requires an SoC specific
>> compatible ahead of the generic one, so add the JH7110 to the enum.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/display/verisilicon,dc.yaml | 1 +
>>  1 file changed, 1 insertion(+)
> 
> And this one must be before patch #5 or switch in your patch #5 to
> compatibles-style for children, instead of $ref (see some recent
> display/msm/*mdss* bindings like sm8750).
> 
> Best regards,
> Krzysztof

Thanks, I think I can do both for the v4.

> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
