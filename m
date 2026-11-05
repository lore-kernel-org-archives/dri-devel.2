Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D430606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Xr6t4hLT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4F011230A;
	Thu,  5 Nov 2026 10:14:56 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8D71122FE
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:14:49 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261105101447euoutp026d2837d28c67271ae26c59370de1ce6d~lHp1gay492140621406euoutp027;
 Thu,  5 Nov 2026 10:14:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261105101447euoutp026d2837d28c67271ae26c59370de1ce6d~lHp1gay492140621406euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793873687;
 bh=uvp6buPqQ+9eJjpFgvz/pyRHfAKlcp4kxy7ey2RpwfE=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=Xr6t4hLTbqTMbZ8PN1OE6SDstUWmsOEmpPSjX60geGvAGrv/LRouLb1HbkwZn83V5
 az6v0tEb4gaMAks1j4H41rjIdh03Nzty5faC5k62RJ80KH4iCvZbm88R7/1oxrUbKa
 FKtfbACftVQnRTRtDHQlCXTf2X6v/rKbHLx4ahDg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261105101447eucas1p2079230483e67ab1c1aa521c508ccc3e2~lHp1LlepI0033600336eucas1p2k;
 Thu,  5 Nov 2026 10:14:47 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261105101445eusmtip1619d691fa0ae0794db0ed24c9422d032~lHpzWgfYP0678006780eusmtip1M;
 Thu,  5 Nov 2026 10:14:45 +0000 (GMT)
Message-ID: <8638d230-1a12-491c-9608-3e94805addeb@samsung.com>
Date: Thu, 5 Nov 2026 11:14:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/18] dt-bindings: soc: starfive: Add
 starfive,jh7110-hdmi-subsystem
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel
 <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Yakir Yang
 <kuankuan.y@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, William Qiu
 <william.qiu@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20261029-flinch-header-bad94288c71b@spud>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261105101447eucas1p2079230483e67ab1c1aa521c508ccc3e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075358eucas1p111293c602fc3aac9c6a044fc41488919
X-EPHeader: CA
X-CMS-RootMailID: 20261029075358eucas1p111293c602fc3aac9c6a044fc41488919
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075358eucas1p111293c602fc3aac9c6a044fc41488919@eucas1p1.samsung.com>
 <20261029-jh7110-clean-send-v6-4-759594e43acf@samsung.com>
 <20261029-flinch-header-bad94288c71b@spud>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/26 00:06, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 08:53:38AM +0100, Michal Wilczynski wrote:
>> Add the dt-binding for the StarFive JH7110 HDMI subsystem.
>>
>> The JH7110 HDMI IP is a monolithic block containing both the digital
>> controller and analog PHY in a single register space. This binding
>> defines the parent device, which holds the shared register map, and its
>> two children: the PHY and the controller.
>>
>> The two have separate resources. The PHY takes the 24 MHz reference
>> clock and provides both the pixel clock, which the VOUT clock generator
>> routes on to the display controller, and the phy the controller uses.
>> The controller takes its clocks from the VOUT clock generator. What
>> they share is the register space, which the parent maps.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  .../starfive/starfive,jh7110-hdmi-subsystem.yaml   | 95 ++++++++++++++++++++++
>>  1 file changed, 95 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..2ff8b0b920aec41a83f0aeaa0ed9c4249fe87f46
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml
> 
> Why is this in bindings/soc? I feel like it should be in
> bindings/display or something along those lines, since it's the display
> subsystem of the device?
> 
> Cheers,
> Conor.

Fair point - soc/ is mirroring where the drivers sit. I can relocate it
to bindings/display/starfive/ in v7, together with
starfive,jh7110-vout-subsystem.yaml, which also belongs to the display
subsystem.


Best regards,    
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

