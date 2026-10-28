Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=YD3seNv1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AE710E5E0;
	Wed, 28 Oct 2026 09:13:19 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE6010FACE
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:13:13 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261028091311euoutp024819ef823fab2c20689b5890d7ddf5ae~ippwwUXVb2349923499euoutp02J;
 Wed, 28 Oct 2026 09:13:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261028091311euoutp024819ef823fab2c20689b5890d7ddf5ae~ippwwUXVb2349923499euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793178791;
 bh=3W2zW/ASI3Ufo+rdp+J+HzrLBLxCU9YgEhL1tFo9JN8=;
 h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
 b=YD3seNv1lTl6lfYw3bfwIkC48J0uPe3B+5wKAZPK+XeWBwINFgBm5MPb9sVHecN7v
 XByNXwrD0JsSH1+jN75BcFsO8ELTz7OD2T7aTRqKuYUS05jwwSQTiJ5lwYNNLhOdCb
 QW+IPyyDcEgIBTrDIHHnlhBaaSr8YKqqFO/n8FO4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261028091310eucas1p1df77aa99909e0c12fcd259596f1f2163~ippv92h803159131591eucas1p1d;
 Wed, 28 Oct 2026 09:13:10 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261028091308eusmtip25984a31eb02ec800271e9985aaee42c8~ippuC0ldb0063200632eusmtip2x;
 Wed, 28 Oct 2026 09:13:08 +0000 (GMT)
Message-ID: <f6474690-adba-43ff-90f8-cdddf857286b@samsung.com>
Date: Wed, 28 Oct 2026 10:13:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/20] phy: Add common Innosilicon HDMI PHY helpers
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
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
In-Reply-To: <943aa2e7-3945-48f9-9a87-9c963f97099d@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261028091310eucas1p1df77aa99909e0c12fcd259596f1f2163
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8
X-EPHeader: CA
X-CMS-RootMailID: 20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-16-f0e4fd6f2cc8@samsung.com>
 <asEPmpQTwXYADwTk@parshuram>
 <943aa2e7-3945-48f9-9a87-9c963f97099d@samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/26/26 10:13, Michal Wilczynski wrote:
> Hi Vinod,
> 
> On 10/3/26 16:22, Vinod Koul wrote:
>> On 15-09-26, 17:32, Michal Wilczynski wrote:
>>> The Innosilicon HDMI PHY IP is used by several SoCs. They differ in
>>> where the PHY register block sits in the register space and in which
>>> pixel clocks they support, but the pre-PLL programming sequence and the
>>> layout of its registers are the same.
>>>
>>> Add a small library holding that shared part: the pre-PLL configuration
>>> table format, a lookup, clk_ops determine_rate and recalc_rate helpers,
>>> and the pre-PLL register programming. Callers pass a regmap, a register
>>> offset for the PHY block, and their own pixel clock table.
>>>
>>> No driver uses it yet; the users are converted separately.
>>
>> Is there anything in phy patches here that has dependency with rest? If
>> not consider splitting it up...
> 

On second thought, I agree it will be easier for maintainers to merge,
so I'll split it in v6. The PHY patches (the binding, the helpers, the
Rockchip conversion and the JH7110 PHY driver) will go as a separate
mini series.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

