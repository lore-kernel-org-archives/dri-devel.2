Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A43606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=EpN4216W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EA910E935;
	Wed, 25 Nov 2026 16:48:04 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F0EC10E935
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:47:57 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261125164755euoutp01a5a5fab61dd9798e759be69e5b9e0235~rV6zDc7Lk0384803848euoutp01t;
 Wed, 25 Nov 2026 16:47:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261125164755euoutp01a5a5fab61dd9798e759be69e5b9e0235~rV6zDc7Lk0384803848euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795625276;
 bh=7TatMQsD+nKk2SlAoHDqVLWs4KiHkC+B/2mGwzcyZ3E=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=EpN4216Wld6F8bjjy70JLDrBUDUtE6rusAEz54jLTD3XLo2dUxl4yXXaT+DeXIusV
 jYQiUTmMqF955Qs375ei7zjQB+xf20y3Zoo9JdFKubXAw0PUTGsZet5P46/scw/Yfp
 E0IVKOHx3TmBqWcPJ4keVQVXch7GmomOtUXCwOe0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261125164755eucas1p24d5d6bb83e752fd082cddf5be8b0dfd1~rV6yfXVA43152031520eucas1p2P;
 Wed, 25 Nov 2026 16:47:55 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261125164753eusmtip18d3c6a9329085828572b3a1b4e8ce215~rV6wxHev50383403834eusmtip1t;
 Wed, 25 Nov 2026 16:47:53 +0000 (GMT)
Message-ID: <74cccd59-ef2c-4334-aa75-b187379e66a6@samsung.com>
Date: Wed, 25 Nov 2026 17:47:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/18] dt-bindings: display: starfive: Add
 starfive,jh7110-hdmi-subsystem
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
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
 <dmitry.baryshkov@oss.qualcomm.com>, Conor Dooley <conor@kernel.org>,
 William Qiu <william.qiu@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, Sandy Huang <hjc@rock-chips.com>, Manivannan
 Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, Marek Szyprowski
 <m.szyprowski@samsung.com>, Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>, Icenowy Zheng
 <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, Joshua
 Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Conor Dooley
 <conor.dooley@microchip.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20261125-tasteful-brown-galago-a6725e@quoll>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261125164755eucas1p24d5d6bb83e752fd082cddf5be8b0dfd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124155406eucas1p23a523deb496c21cbf3da3724812a8101
X-EPHeader: CA
X-CMS-RootMailID: 20261124155406eucas1p23a523deb496c21cbf3da3724812a8101
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155406eucas1p23a523deb496c21cbf3da3724812a8101@eucas1p2.samsung.com>
 <20261124-jh7110-clean-send-v8-4-de92635dd857@samsung.com>
 <20261125-tasteful-brown-galago-a6725e@quoll>
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/25/26 08:31, Krzysztof Kozlowski wrote:
> On Tue, Nov 24, 2026 at 04:52:40PM +0100, Michal Wilczynski wrote:
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
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  .../starfive/starfive,jh7110-hdmi-subsystem.yaml   | 95 ++++++++++++++++++++++
>>  1 file changed, 95 insertions(+)
>>
> 
> DT bot reports here a lot of failures. I don't see immediate problem,
> but something feels odd.
> 
> E.g. https://protect2.fireeye.com/v1/url?k=1f5c925f-40c75c3b-1f5d1910-000babda0201-32d14b792e1191ed&q=1&e=0335675f-d64b-42b3-b953-cd282e903fa2&u=https%3A%2F%2Fgitlab.com%2Frobherring%2Flinux-dt-review%2F-%2Fjobs%2F18332570769%2Fartifacts%2Fraw%2Fbuild-15017782.log
> (see rest on DT patchwork)
> 
> Best regards,
> Krzysztof
> 
> 

Hi,

Thanks for checking. For patches 4,6 same as in v6 [1], these come from
dependencies missing in the bot tree.

The dependency is in the cover b4 prerequisite trailers and Rob
mentioned in v6 that he would look at why the bot did not pick it up.

For Patch 3 a comment in its example points at the hdmi-subsystem
binding by path, and that file only comes in patch 4.
I'll fix that in v9, and also note the dependency in patches 4 and 6
themselves under ---.

[1] -  https://lore.kernel.org/all/20261029183041.GA4029917-robh@kernel.org/

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
