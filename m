Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B98606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=nWQGHyd3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501E810F3DD;
	Tue, 27 Oct 2026 11:02:19 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C838C10F3E0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:02:12 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261027110211euoutp02cbe365840510890b9fa3fbb50e26a3cf~iXfpITuJq1916619166euoutp02O;
 Tue, 27 Oct 2026 11:02:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261027110211euoutp02cbe365840510890b9fa3fbb50e26a3cf~iXfpITuJq1916619166euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793098931;
 bh=jgpI6S0BaFwhfvc2kywHp6Ib11nXJqnK3KboerxnZkI=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=nWQGHyd3uZO8npHAsI3x3z0bNTOciXEMk5qhW0TGGp6BSguiBE0ZHfqmHLqbvDF0H
 jAsgFMaUbTRuJ/IN+QVwxm1C8lUaP1wIQPSboyhdv4t1SqODkP1rSY8nYzjAcyepN4
 5vIolx8QDptEdhqq8Oq8lgHHH5v1igum0Z1fTOLc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261027110210eucas1p200692a459e47eae4b88f5f8620738cfd~iXfokDezE2283022830eucas1p2N;
 Tue, 27 Oct 2026 11:02:10 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261027110208eusmtip1bba8e474a6d53be6ac9f0bd553f1da2d~iXfm8DZVs2613526135eusmtip1G;
 Tue, 27 Oct 2026 11:02:08 +0000 (GMT)
Message-ID: <b9380a0a-49f1-4bb9-a6b7-ca233319b8ad@samsung.com>
Date: Tue, 27 Oct 2026 12:02:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/21] phy: rockchip: inno-hdmi: Use the common
 Innosilicon PHY helpers
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
In-Reply-To: <7069377.kQq0lBPeGt@diego>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261027110210eucas1p200692a459e47eae4b88f5f8620738cfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260929103243eucas1p25abf97a357cfae14640092e35fe479fc
X-EPHeader: CA
X-CMS-RootMailID: 20260929103243eucas1p25abf97a357cfae14640092e35fe479fc
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103243eucas1p25abf97a357cfae14640092e35fe479fc@eucas1p2.samsung.com>
 <20260929-jh7110-clean-send-v5-18-82b4d8e3c6c7@samsung.com>
 <7069377.kQq0lBPeGt@diego>
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



On 9/30/26 12:14, Heiko Stübner wrote:
> Am Dienstag, 29. September 2026, 12:31:15 Mitteleuropäische Sommerzeit schrieb Michal Wilczynski:
>> The RK3328 pre-PLL programming, its table lookup and its recalc_rate and
>> determine_rate implementations are the generic Innosilicon ones, so drop
>> the local copies and use the shared helpers instead.
>>
>> The RK3228 pre-PLL sits at different register addresses, so it keeps its
>> own register level code and only shares the table lookup.
>>
>> The now unused RK3328 pre-PLL register macros go with it, as does the
>> local pre-PLL config lookup wrapper; both call sites already have the
>> TMDS clock to hand and call inno_hdmi_phy_pre_pll_lookup() directly.
>>
>> The RK3328 recalc_rate used to log the pre-PLL output as "vco". The
>> shared helper logs it too, and reports the actual VCO frequency
>> alongside the rate, which is the value with the 1.4-3.2 GHz constraint.
>>
>> The register writes, their order and the values written are unchanged.
>> No functional change intended.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Only thing I cannot really make up my mind about, is if this and the
> previous patch should be merged ("move common code from rockchip
> variant to shared helper").
> 
> As I said, can't really decide what would be the better solution ;-) .

I split them deliberately as I don't have Rockchip hardware. It's easier
to verify this commit's correctness and the claims 'no functional change
intended' and 'the register writes, their order and the values written
are unchanged' when split, as the previous commit only adds the library
and this one only deletes the RK3328 copy and calls into it.

> 
> 
> Heiko
> 
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
