Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D53606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bCe0DApS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6403A10E441;
	Tue, 27 Oct 2026 18:25:49 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3EC10E441
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:25:42 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261027182540euoutp01808e2a0784b22e974d6c8ffe88c8195c~idi3U5q2O1070810708euoutp01J;
 Tue, 27 Oct 2026 18:25:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261027182540euoutp01808e2a0784b22e974d6c8ffe88c8195c~idi3U5q2O1070810708euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793125540;
 bh=yYVnZVngw4wIyvUedHrp/RCi4DEk87r28LIRWXpCLH0=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=bCe0DApSTMa5hEEGgVvneqzfJYakD7qrG9r1rRA787dJcmFkxZeM041kJvQzf1sWi
 mFAb6eOSUU0Yw/Y6KAUriZpeXdgumQlCNkdGsLLdF/sfW7mYHnWBx2d7wOenrOEkLR
 zJJaDP1dZxSCFavYWwIcrbMKnu0ZvjvRL33YUuUE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261027182539eucas1p2af97fa5bad6b7de6ca761cb86172737b~idi2gJHhp1120011200eucas1p2b;
 Tue, 27 Oct 2026 18:25:39 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261027182538eusmtip2789b0e5587293524b9c364f453c89396~idi03PmTX1528615286eusmtip2f;
 Tue, 27 Oct 2026 18:25:38 +0000 (GMT)
Message-ID: <5fec923f-36bb-4dcc-bf3a-13be3eaa8f83@samsung.com>
Date: Tue, 27 Oct 2026 19:25:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/20] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
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
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, Marek Szyprowski
 <m.szyprowski@samsung.com>, Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>, Chaoyi Chen
 <chaoyi.chen@rock-chips.com>, Joshua Peisach <jpeisach@ubuntu.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <b5eb69f3f41a98b5a98694435df25a632babf05a.camel@iscas.ac.cn>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261027182539eucas1p2af97fa5bad6b7de6ca761cb86172737b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153248eucas1p27d8d2c9fa536bbd951e0102b04416dad
X-EPHeader: CA
X-CMS-RootMailID: 20260915153248eucas1p27d8d2c9fa536bbd951e0102b04416dad
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153248eucas1p27d8d2c9fa536bbd951e0102b04416dad@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-19-f0e4fd6f2cc8@samsung.com>
 <b5eb69f3f41a98b5a98694435df25a632babf05a.camel@iscas.ac.cn>
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/29/26 17:06, Icenowy Zheng wrote:
> 在 2026-09-15二的 17:32 +0200，Michal Wilczynski写道：
>> Activate the display subsystem by describing the video output
>> subsystem,
>> which the documentation calls dom_vout_top, as a bus node covering
>> the
>> whole 0x29400000 region, with dc8200, the HDMI block, the video
>> output
>> system controller and voutcrg as its children.
>>
>> The subsystem node owns the resources its children share: the NoC
>> display
>> bus clock and reset that gate access to every register in the region,
>> and
>> the PD_VOUT power domain. Modelling it this way keeps a shared gate
>> owned
>> by the block that shares it rather than by whichever consumer happens
>> to
>> probe first, and lets dc8200 inherit dma-noncoherent for framebuffer
>> DMA
>> from the bus it sits on.
>>
>> The monolithic hdmi node is in turn modelled as a container with
>> hdmi_phy
>> and hdmi_controller children. This lets the PHY (clock provider,
>> depending only on xin24m) and the controller (clock consumer) probe
>> independently, breaking the circular clock dependency with voutcrg.
>>
>> voutcrg consumes the pixel clock from the &hdmi_phy node instead of
>> the
>> old fixed-clock, and dc8200 gets its pixel clocks from voutcrg's
>> MUXes.
>> The old, incorrect hdmitx0-pixel-clock fixed-clock node is removed.
>>
>> The HDMI controller gets a phandle to the video output system
>> controller,
>> which holds the mux selecting the DC8200 output that drives the HDMI
>> transmitter.
>>
>> CMA is enlarged and constrained to memory the display controller can
>> address, because the default pool is too small for its framebuffers.
>>
>> Co-developed-by: Dominique Belhachemi <db@domibel.de>
>> Signed-off-by: Dominique Belhachemi <db@domibel.de>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> 
> ```
> Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ```
> 
> But,
> 
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 121
>> +++++++++++++++++++++++-
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi        | 105
>> ++++++++++++++++----
>>  2 files changed, 203 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> index
>> a7a1c09a2c9075711f3a214a49618911fdc7b421..a4c3daf712a63b177f744e8c613
>> 416d22e0c9dbd 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> @@ -33,6 +33,27 @@ memory@40000000 {
>>  		bootph-pre-ram;
>>  	};
>>  
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		/*
>> +		 * The display controller allocates its framebuffers
>> from CMA,
>> +		 * and the default pool is too small for them. Keep
>> the pool
>> +		 * inside the range the controller can address; it
>> fits in the
>> +		 * memory every VisionFive 2 variant has.
>> +		 */
>> +		linux,cma {
>> +			compatible = "shared-dma-pool";
>> +			reusable;
>> +			size = <0x0 0x20000000>;
>> +			alignment = <0x0 0x1000>;
>> +			alloc-ranges = <0x0 0x70000000 0x0
>> 0x20000000>;
>> +			linux,cma-default;
>> +		};
>> +	};
>> +
> 
> I don't know whether constraining the CMA pool in the DT is a good
> idea.
> 
> Thanks,
> Icenowy
>

So I've tested the version without alloc-ranges and some of the modetest
runs failed especially the higher resolutions. It seems this is because
without alloc-ranges __reserved_mem_alloc_size() allocates top down with
MEMBLOCK_ALLOC_ANYWHERE so the pool lands above 4 GB, which the DC8200
cannot reach - vs_dc.c sets a 32-bit DMA mask.

25 of the 42 advertised modes failed with "failed to create dumb buffer:
Cannot allocate memory" - every 4K and 1080p mode, down to 1360x768.
Only 1280x800 and below survive.

So the range seems to be a hardware limit which is why I think it
belongs in the DT. I'd like to keep it in v6.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

