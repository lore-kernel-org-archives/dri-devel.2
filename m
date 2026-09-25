Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFC4C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AC010E10B;
	Fri, 25 Sep 2026 21:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="q5pcUiQt";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08EE10E10B
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 21:27:18 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260925212716euoutp01b383dcf07bf8160d2a3a69967b8bc633~YrYRx8Ka90791007910euoutp01E;
 Fri, 25 Sep 2026 21:27:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260925212716euoutp01b383dcf07bf8160d2a3a69967b8bc633~YrYRx8Ka90791007910euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790371636;
 bh=NsFrcStNS+TX7bCXsmgniOEglOFn1G3AomEV8/XqEv8=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=q5pcUiQtDlMr1uaRyXlmJt7ZsCDzRcfzR5pcT1Yf1GTjSjYFFWiFj00hyPBN9yLXz
 k8+kWYGtr2NpC0w5KCvzEBcv7TVwkprzIGWiaPS19V3x9Qb1O0ppehmCMlpPnVJfFs
 ATB0NEVBbVWKsf67GBBo3EbW4lOwtT7SEykBpmw4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260925212715eucas1p285f7c5d39c92c121008275ccebab4ec2~YrYQoaKyD2482224822eucas1p2E;
 Fri, 25 Sep 2026 21:27:15 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260925212713eusmtip176927563c0f94e00bf31fa297fa80ca0~YrYO_Esaa1753917539eusmtip1D;
 Fri, 25 Sep 2026 21:27:13 +0000 (GMT)
Message-ID: <b5548b50-20d4-4b5d-b38d-5069c2b03f38@samsung.com>
Date: Fri, 25 Sep 2026 23:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/20] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
To: Krzysztof Kozlowski <krzk@kernel.org>, Joshua Peisach <jpeisach@ubuntu.com>
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
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260918-futuristic-mindful-waxbill-21fa2d@quoll>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260925212715eucas1p285f7c5d39c92c121008275ccebab4ec2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125
X-EPHeader: CA
X-CMS-RootMailID: 20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
 <20260917-mutant-chamois-of-competence-46ca77@quoll>
 <DLI0QTP0NUHS.DAFYGACKWKWO@ubuntu.com>
 <20260918-futuristic-mindful-waxbill-21fa2d@quoll>
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



On 9/18/26 08:16, Krzysztof Kozlowski wrote:
> On Thu, Sep 17, 2026 at 08:34:18PM -0400, Joshua Peisach wrote:
>> On Thu Sep 17, 2026 at 2:51 AM EDT, Krzysztof Kozlowski wrote:
>>> On Tue, Sep 15, 2026 at 05:32:09PM +0200, Michal Wilczynski wrote:
>>>> Add the dt-binding for the StarFive JH7110 Innosilicon HDMI PHY.
>>>>
>>>> This device is a child of the starfive,jh7110-hdmi-subsystem node. It
>>>> functions as both a PHY provider for the controller and as a clock
>>>> provider for the variable pixel clock (hdmi_pclk), which it generates
>>>> from its refoclk.
>>>>
>>>> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
>>>
>>> While I appreciate other people looking at this, I don't think review
>>> here applies. It was a blanket tag, given to the entire series, with
>>> exception that it is from newbie, thus I want to ask: was this binding
>>> REALLY reviewed by Joshua?
>>>
>>> Are the rest of the patches actually reviewed or just "looks good to
>>> me"? I see no comments from Joshua on v3, v2 and v1, which is usual sign
>>> of doing review.
>>>
>>>
>> I commented on v3 saying that I would test if I could. I don't just
> 
> Testing has nothing to do with reviewing.
> 
>> throw "Reviewed-by" on everything I look at.
>>
>> If anything, I've been trying to be more honest in reviews, and only
>> review ones that I actually care about[1].
> 
> You gave blanket tag for entire series, so I do not get this argument.
> 
>>
>> If reviewing patches isn't a good way for newbies to start getting
>> familiar with the kernel code (especially a NEW driver), then I don't
>> know what is.
> 
> Writing code and receiving review is something for newbies to start
> with. If you do not know kernel code or bindings, why do you think
> your review is applicable? If I try to review design of a post-tension
> concrete bridge, I would probably learn something. Would my
> review apply? No.
> 
> Best regards,
> Krzysztof
> 
> 

Well I do feel like this is at least partially my fault. I took the
Reviewed-by on the cover letter and automatically applied it using b4
without asking Joshua any more clarifying questions.

In v5 I will drop it from the binding patches and keep it on the driver
patches.

Joshua - please feel free to continue reviewing and testing this
patchset. Your help is very welcome.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
