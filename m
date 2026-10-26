Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D04606A331
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=by8wIive
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C9410EE9A;
	Mon, 26 Oct 2026 11:51:56 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11BF10E035
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:51:49 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261026115147euoutp02fbdb3f86653841ec23ac907b4075263c~iEhrNO3qA1071610716euoutp02j;
 Mon, 26 Oct 2026 11:51:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261026115147euoutp02fbdb3f86653841ec23ac907b4075263c~iEhrNO3qA1071610716euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793015508;
 bh=YinZmgUxjrnzRHvPSk376pdEtqCxovYcrJWpuvmDrIU=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=by8wIivew9pTDGPoTkSG52zplLXz983sSizV/qELERWT5oVuqIgfot3/OW9BIxyJY
 zjI5cpv21ITFG69/U1uaImy/AyfYRmMZu4B7Mvz8fVXbcYDMm3KpeMYKk771I84KLW
 x3cAa4RB6ZuCbhrkCDU0HDDD8oZEU5jT9jLs0Ptk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261026115147eucas1p1d8e71671cd33ce5a03eea64ec83a33b8~iEhq8pjZd2047620476eucas1p1N;
 Mon, 26 Oct 2026 11:51:47 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261026115145eusmtip2e7bb4ae4c9084dd2b3cc1944364155c7~iEho0S8Av1075710757eusmtip2l;
 Mon, 26 Oct 2026 11:51:45 +0000 (GMT)
Message-ID: <1e4f872d-6b3c-4091-b570-0a9b0b501773@samsung.com>
Date: Mon, 26 Oct 2026 12:51:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] drm/bridge: inno-hdmi: Add .mode_valid
 platform operation
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Vinod Koul
 <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andy Yan <andy.yan@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing
 <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <6458508.5fSG56mABF@diego>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261026115147eucas1p1d8e71671cd33ce5a03eea64ec83a33b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260929103229eucas1p2e440f2ec00fdf7986eed7597674bf6a9
X-EPHeader: CA
X-CMS-RootMailID: 20260929103229eucas1p2e440f2ec00fdf7986eed7597674bf6a9
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103229eucas1p2e440f2ec00fdf7986eed7597674bf6a9@eucas1p2.samsung.com>
 <20260929-jh7110-clean-send-v5-11-82b4d8e3c6c7@samsung.com>
 <6458508.5fSG56mABF@diego>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/30/26 12:19, Heiko Stübner wrote:
> Am Dienstag, 29. September 2026, 12:31:08 Mitteleuropäische Sommerzeit schrieb Michal Wilczynski:
>> inno_hdmi_bridge_mode_valid() validates the pixel clock against
>> hdmi->refclk, but that clock is optional and is only present on
>> platforms that describe a "ref" clock. Platforms where the pixel clock
>> is produced by a separate device - such as the StarFive JH7110, whose
>> PHY is both the clock and the PHY provider - have no "ref" clock, so
>> the check is skipped entirely and every mode is reported as valid.
>>
>> A mode the platform cannot generate is then advertised to userspace.
>> The subsequent modeset appears to succeed, since the atomic enable path
>> cannot fail, and the display silently stays blank.
>>
>> Add a .mode_valid platform operation so platforms can reject modes they
>> are unable to drive. Platforms that do not implement it are unaffected.
>>
>> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> 
> In patch 19 you add the jh7110-inno-hdmi-phy variant of the phy which
> registers a clock provider for the pixel clock. Isn't that the refclk you're
> missing?

It's the same clock the controller already consumes, except it is not
the ref clock it is the pixel clock and on the JH7110 those are two
separate clocks.

From TRM [1] table 5-3 page 530 for the HDMI block:

u0_hdmi_tx.clk_mclk   <- clk_hdmitx0_mclk     51.2 MHz
u0_hdmi_tx.clk_bclk   <- clk_hdmitx0_sck      12.8 MHz
u0_hdmi_tx.clk_sys    <- clk_disp_apb         51.2 MHz
u0_hdmi_tx.clk_ref    <- clk_hdmi_phy_ref     24 MHz, fixed

and in the Source section of the same table:

clk_hdmitx0_pixelclk  <- u0_hdmi_tx.clk_pix   max 297 MHz

So clk_ref is a fixed 24 MHz input, while the pixel clock is an output
from the same block, which voutcrg then routes to the DC8200 pix0/pix1
MUXes and the DSI TX clk_dpi. Calling it "ref" would be wrong.

There is other reason as well. hdmi->refclk is fetched with
devm_clk_get_optional_enabled() so it stays enabled for the lifetime
of the controller, and init_hw() passes clk_get_rate(refclk) to
inno_hdmi_i2c_init() for the DDC divider.
Applied to a clock that moves between 25 and 297 MHz per
mode and reads back 0 before the first modeset they would enable the
pre PLL at probe and compute the DDC divider from a meaningless rate.

[1] - https://doc-en.rvspace.org/JH7110/PDF/JH7110_TRM_StarFive_Preliminary_V2.pdf


> 
> Thanks
> Heiko
> 
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
